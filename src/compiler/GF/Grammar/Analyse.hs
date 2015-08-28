module GF.Grammar.Analyse (
        stripSourceGrammar,
        constantDepsTerm,
        sizeTerm,
        sizeConstant,
        sizesModule,
        sizesGrammar,
        printSizesGrammar
        ) where

import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Text.Pretty(render)
--import GF.Infra.Option ---
import GF.Grammar.Macros
import GF.Grammar.Lookup

import GF.Data.Operations

import qualified Data.Map as Map
import Data.List (nub)
--import Debug.Trace

stripSourceGrammar :: Grammar -> Grammar
stripSourceGrammar sgr = mGrammar [(i, m{jments = Map.map stripInfo (jments m)}) | (i,m) <- modules sgr]

stripInfo :: Info -> Info
stripInfo i = case i of
  AbsCat _ -> i
  AbsFun mt mi me mb -> AbsFun mt mi Nothing mb
  ResParam mp mt -> ResParam mp Nothing
  ResValue lt -> i ----
  ResOper mt md -> ResOper mt Nothing
  ResOverload is fs -> ResOverload is [(lty, L loc (EInt 0)) | (lty,L loc _) <- fs]
  CncCat mty mte _ mtf mpmcfg -> CncCat mty Nothing Nothing Nothing Nothing
  CncFun mict mte mtf mpmcfg -> CncFun mict Nothing Nothing Nothing
  AnyInd b f -> i

constantsInTerm :: Term -> [QIdent]
constantsInTerm = nub . consts where
  consts t = case t of
    Q c  -> [c]
    QC c -> [c]
    _ -> collectOp consts t

constantDeps :: Grammar -> QIdent -> Err [QIdent]
constantDeps sgr f = return $ nub $ iterFix more start where
  start = constants f
  more  = concatMap constants
  constants c = (c :) $ fromErr [] $ do
    ts  <- termsOfConstant sgr c
    return $ concatMap constantsInTerm ts

getIdTerm :: Term -> Err QIdent
getIdTerm t = case t of
  Q i  -> return i
  QC i -> return i
  P (Vr r) l -> return (MN r,label2ident l) --- needed if term is received from parser
  _ -> Bad ("expected qualified constant, not " ++ show t)

constantDepsTerm :: Grammar -> Term -> Err [Term]
constantDepsTerm sgr t = do
  i <- getIdTerm t
  cs <- constantDeps sgr i
  return $ map Q cs  --- losing distinction Q/QC

termsOfConstant :: Grammar -> QIdent -> Err [Term]
termsOfConstant sgr c = case lookupOverload sgr c of
  Ok tts -> return $ concat [[ty,tr] | (_,(ty,tr)) <- tts]
  _ -> return $
         [ty | Ok ty <- [lookupResType sgr c]] ++  -- type sig may be missing
         [ty | Ok ty <- [lookupResDef sgr c]]

sizeConstant :: Grammar -> Term -> Int
sizeConstant sgr t = err (const 0) id $ do
  c  <- getIdTerm t
  fmap (sum . map sizeTerm) $ termsOfConstant sgr c

-- the number of constructors in a term, ignoring position information and unnecessary types
-- ground terms count as 1, i.e. as "one work" each
sizeTerm :: Term -> Int
sizeTerm t = case t of
  App c a      -> sizeTerm c + sizeTerm a  -- app nodes don't count 
  Abs _ _ b    -> 2 + sizeTerm b
  Prod _ _ a b -> 2 + sizeTerm a + sizeTerm b 
  S c a        -> 1 + sizeTerm c + sizeTerm a
  Table a c    -> 1 + sizeTerm a + sizeTerm c
  ExtR a c     -> 1 + sizeTerm a + sizeTerm c
  R r          -> 1 + sum [1 + sizeTerm a | (_,(_,a)) <- r]  -- label counts as 1, type ignored
  RecType r    -> 1 + sum [1 + sizeTerm a | (_,a)     <- r]  -- label counts as 1
  P t i        -> 2 + sizeTerm t
  T _ cc       -> 1 + sum [1 + sizeTerm (patt2term p) + sizeTerm v | (p,v) <- cc]
  V ty cc      -> 1 + sizeTerm ty + sum [1 + sizeTerm v | v <- cc]
  Let (x,(mt,a)) b -> 2 + maybe 0 sizeTerm mt + sizeTerm a + sizeTerm b
  C s1 s2      -> 1 + sizeTerm s1 + sizeTerm s2 
  Glue s1 s2   -> 1 + sizeTerm s1 + sizeTerm s2 
  Alts t aa    -> 1 + sizeTerm t + sum [sizeTerm p + sizeTerm v | (p,v) <- aa]
  FV ts        -> 1 + sum (map sizeTerm ts)
  Strs tt      -> 1 + sum (map sizeTerm tt)
  _            -> 1


-- the size of a judgement
sizeInfo :: Info -> Int
sizeInfo i = case i of
  AbsCat (Just (L _ co)) -> 1 + sum [1 + sizeTerm ty | (_,_,ty) <- co]
  AbsFun mt mi me mb -> 1 + msize mt + 
    sum [sum (map (sizeTerm . patt2term) ps) + sizeTerm t | Just es <- [me], L _ (ps,t) <- es]
  ResParam mp mt -> 
    1 + sum [1 + sum [1 + sizeTerm ty | (_,_,ty) <- co] | Just (L _ ps) <- [mp], (_,co) <- ps]
  ResValue lt -> 0
  ResOper mt md -> 1 + msize mt + msize md
  ResOverload is fs -> 1 + sum [sizeTerm ty + sizeTerm tr | (L _ ty, L _ tr) <- fs]
  CncCat mty _ _ _ _ -> 1 + msize mty   -- ignoring lindef, linref and printname
  CncFun mict mte mtf _ -> 1 + msize mte  -- ignoring type and printname
  AnyInd b f -> -1  -- just to ignore these in the size
  _ -> 0
 where 
  msize mt = case mt of
    Just (L _ t) -> sizeTerm t
    _ -> 0
{-
-- the size of a module
sizeModule :: SourceModule -> Int
sizeModule = fst . sizesModule
-}
sizesModule :: SourceModule -> (Int, [(Ident,Int)])
sizesModule (_,m) = 
  let 
    js = Map.toList (jments m) 
    tb = [(i,k) | (i,j) <- js, let k = sizeInfo j, k >= 0]
  in (length tb + sum (map snd tb),tb)
{-
-- the size of a grammar
sizeGrammar :: Grammar -> Int
sizeGrammar = fst . sizesGrammar
-}
sizesGrammar :: Grammar -> (Int,[(ModuleName,(Int,[(Ident,Int)]))])
sizesGrammar g = 
  let 
    ms = modules g 
    mz = [(i,sizesModule m) | m@(i,j) <- ms]
  in (length mz + sum (map (fst . snd) mz), mz)

printSizesGrammar :: Grammar -> String
printSizesGrammar g = unlines $ 
  ("total" +++ show s):
  [render m +++ "total" +++ show i ++++ 
   unlines [indent 2 (showIdent j +++ show k) | (j,k) <- js]
     | (m,(i,js)) <- sg
  ]
 where
   (s,sg) = sizesGrammar g


