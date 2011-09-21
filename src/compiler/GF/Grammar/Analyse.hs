module GF.Grammar.Analyse (
        stripSourceGrammar,
        constantDepsTerm,
        sizeTerm,
        sizesModule,
        sizesGrammar,
        printSizesGrammar
        ) where

import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Infra.Option ---
import GF.Infra.Modules
import GF.Grammar.Macros
import GF.Grammar.Lookup

import GF.Data.Operations

import qualified Data.Map as Map
import Data.List (nub)
import Debug.Trace

stripSourceGrammar :: SourceGrammar -> SourceGrammar
stripSourceGrammar sgr = mGrammar [(i, m{jments = Map.map stripInfo (jments m)}) | (i,m) <- modules sgr]

stripInfo :: Info -> Info
stripInfo i = case i of
  AbsCat _ -> i
  AbsFun mt mi me mb -> AbsFun mt mi Nothing mb
  ResParam mp mt -> ResParam mp Nothing
  ResValue lt -> i ----
  ResOper mt md -> ResOper mt Nothing
  ResOverload is fs -> ResOverload is [(lty, L loc (EInt 0)) | (lty,L loc _) <- fs]
  CncCat mty mte mtf -> CncCat mty Nothing Nothing
  CncFun mict mte mtf -> CncFun mict Nothing Nothing
  AnyInd b f -> i

constantsInTerm :: Term -> [Term]
constantsInTerm = nub . consts where
  consts t = case t of
    Q _  -> [t]
    QC _ -> [t]
    _ -> collectOp consts t

constantDeps :: SourceGrammar -> QIdent -> Err [Term]
constantDeps sgr f = do
  ts <- deps f
  let cs = [i | t <- ts, i <- getId t]
  ds <- mapM deps cs
  return $ nub $ concat $ ts:ds
 where
  deps c = case lookupOverload sgr c of
    Ok tts -> 
      return $ concat [constantsInTerm ty ++ constantsInTerm tr | (_,(ty,tr)) <- tts]
    _ -> do  
      ty <- lookupResType sgr c
      tr <- lookupResDef sgr c
      return $ constantsInTerm ty ++ constantsInTerm tr
  getId t = case t of
    Q i -> [i] 
    QC i -> [i] 
    _ -> [] 

constantDepsTerm :: SourceGrammar -> Term -> Err [Term]
constantDepsTerm sgr t = case t of
  Q  i -> constantDeps sgr i
  QC i -> constantDeps sgr i
  P (Vr r) l -> constantDeps sgr $ (r,label2ident l) ---
  _ -> Bad ("expected qualified constant, not " ++ show t)


-- the number of constructors in a term, ignoring position information and unnecessary types
-- ground terms count as 1, i.e. as "one work" each
sizeTerm :: Term -> Int
sizeTerm t = case t of
  App c a      -> 1 + sizeTerm c + sizeTerm a 
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
    1 + sum [1 + sum [1 + sizeTerm ty | (_,_,ty) <- co] | Just ps <- [mp], L _ (_,co) <- ps]
  ResValue lt -> 0
  ResOper mt md -> 1 + msize mt + msize md
  ResOverload is fs -> 1 + sum [sizeTerm ty + sizeTerm tr | (L _ ty, L _ tr) <- fs]
  CncCat mty mte mtf -> 1 + msize mty   -- ignoring lindef and printname
  CncFun mict mte mtf -> 1 + msize mte  -- ignoring type and printname
  AnyInd b f -> 0
  _ -> 0
 where 
  msize mt = case mt of
    Just (L _ t) -> sizeTerm t
    _ -> 0

-- the size of a module
sizeModule :: SourceModule -> Int
sizeModule = fst . sizesModule

sizesModule :: SourceModule -> (Int, [(Ident,Int)])
sizesModule (_,m) = 
  let 
    js = Map.toList (jments m) 
    tb = [(i,sizeInfo j) | (i,j) <- js]
  in (length tb + sum (map snd tb),tb)

-- the size of a grammar
sizeGrammar :: SourceGrammar -> Int
sizeGrammar = fst . sizesGrammar

sizesGrammar :: SourceGrammar -> (Int,[(Ident,(Int,[(Ident,Int)]))])
sizesGrammar g = 
  let 
    ms = modules g 
    mz = [(i,sizesModule m) | m@(i,j) <- ms]
  in (length mz + sum (map (fst . snd) mz), mz)

printSizesGrammar :: SourceGrammar -> String
printSizesGrammar g = unlines $ 
  ("total" +++ show s):
  [showIdent m +++ "total" +++ show i ++++ 
   unlines [indent 2 (showIdent j +++ show k) | (j,k) <- js]
     | (m,(i,js)) <- sg
  ]
 where
   (s,sg) = sizesGrammar g


