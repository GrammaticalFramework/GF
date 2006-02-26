----------------------------------------------------------------------
-- |
-- Module      : Linear
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/14 16:03:41 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.19 $
--
-- Linearization for canonical GF. AR 7\/6\/2003
-----------------------------------------------------------------------------

module GF.UseGrammar.Linear where

import GF.Canon.GFC
import GF.Canon.AbsGFC
import qualified GF.Grammar.Abstract as A
import GF.Canon.MkGFC (rtQIdent) ----
import GF.Infra.Ident
import GF.Grammar.PrGrammar
import GF.Canon.CMacros
import GF.Canon.Look
import GF.Grammar.LookAbs
import GF.Grammar.MMacros
import GF.Grammar.TypeCheck (annotate) ----
import GF.Data.Str
import GF.Text.Text
----import TypeCheck -- to annotate

import GF.Data.Operations
import GF.Data.Zipper
import qualified GF.Infra.Modules as M

import Control.Monad
import Data.List (intersperse)

-- Linearization for canonical GF. AR 7/6/2003

-- | The worker function: linearize a Tree, return
-- a record. Possibly mark subtrees.
--
-- NB. Constants in trees are annotated by the name of the abstract module.
-- A concrete module name must be given to find (and choose) linearization rules.
--
--  - If no marking is wanted, 'noMark'  :: 'Marker'.
--
--  - For xml marking, use     'markXML' :: 'Marker'
linearizeToRecord :: CanonGrammar -> Marker -> Ident -> A.Tree -> Err Term
linearizeToRecord gr mk m = lin [] where

  lin ts t@(Tr (n,xs)) = errIn ("linearization of" +++ prt t) $ do

    let binds = A.bindsNode n
        at    = A.atomNode n
        fmk   = markSubtree mk n ts (A.isFocusNode n)
    c   <- A.val2cat $ A.valNode n
    xs' <- mapM (\ (i,x) -> lin (i:ts) x) $ zip [0..] xs

    r <- case at of
      A.AtC f -> lookf c t f >>= comp xs'
      A.AtL s -> return $ recS $ tK $ prt at
      A.AtI i -> return $ recS $ tK $ prt at
      A.AtF i -> return $ recS $ tK $ prt at
      A.AtV x -> lookCat c >>= comp [tK (prt_ at)]
      A.AtM m -> lookCat c >>= comp [tK (prt_ at)] 

    r' <- case r of     -- to see stg in case the result is variants {}
      FV [] -> lookCat c >>= comp [tK (prt_ t)]
      _ -> return r

    return $ fmk $ mkBinds binds r'

  look = lookupLin gr . redirectIdent m . rtQIdent
  comp = ccompute gr
  mkBinds bs bdy = case bdy of
    R fs -> R $ [Ass (LV i) (tK (prt t)) | (i,(t,_)) <- zip [0..] bs] ++ fs

  recS t = R [Ass (L (identC "s")) t] ----

  lookCat = return . errVal defLindef . look 
         ---- should always be given in the module

  -- to show missing linearization as term
  lookf c t f = case look f of
    Ok h -> return h
    _ -> lookCat c >>= comp [tK (prt_ t)]


-- | thus the special case:
linearizeNoMark :: CanonGrammar -> Ident -> A.Tree -> Err Term
linearizeNoMark gr = linearizeToRecord gr noMark

-- | expand tables in linearized term to full, normal-order tables
--
-- NB expand from inside-out so that values are not looked up in copies of branches

expandLinTables :: CanonGrammar -> Term -> Err Term
expandLinTables gr t = case t of
  R rs -> liftM (R . map (uncurry Ass)) $ mapPairsM exp [(l,r) | Ass l r <- rs]
  T ty rs -> do
    rs' <- mapPairsM exp [(l,r) | Cas l r <- rs] -- expand from inside-out
    let t' = T ty $ map (uncurry Cas) rs'
    vs  <- alls ty
    ps  <- mapM term2patt vs
    ts' <- mapM (comp . S t') $ vs
    return $ T ty [Cas [p] t | (p,t) <- zip ps ts']
  V ty ts0 -> do
    ts  <- mapM exp ts0 -- expand from inside-out
    vs  <- alls ty
    ps  <- mapM term2patt vs
    return $ T ty [Cas [p] t | (p,t) <- zip ps ts]
  FV ts -> liftM FV $ mapM exp ts
  _ -> composOp exp t
 where
   alls = allParamValues gr
   exp  = expandLinTables gr
   comp = ccompute gr []

-- Do this for an entire grammar:

unoptimizeCanon :: CanonGrammar -> CanonGrammar
unoptimizeCanon g@(M.MGrammar ms) = M.MGrammar $ map (unoptimizeCanonMod g) ms 

unoptimizeCanonMod :: CanonGrammar -> CanonModule -> CanonModule
unoptimizeCanonMod g = convMod where
  convMod (m, M.ModMod (M.Module (M.MTConcrete a) x flags me os defs)) = 
    (m, M.ModMod (M.Module (M.MTConcrete a) x flags me os (mapTree convDef defs)))
  convMod mm = mm
  convDef (c,CncCat ty df pr) = (c,CncCat ty (convT df) (convT pr))
  convDef (f,CncFun c xs li pr) = (f,CncFun c xs (convT li) (convT pr))
  convDef cd = cd
  convT = err error id . exp
  -- a version of expandLinTables that does not destroy share optimization
  exp t = case t of
    R rs -> liftM (R . map (uncurry Ass)) $ mapPairsM exp [(l,r) | Ass l r <- rs]
    T ty rs@[Cas [_] _] -> do
      rs' <- mapPairsM exp [(l,r) | Cas l r <- rs] -- expand from inside-out
      let t' = T ty $ map (uncurry Cas) rs'
      vs  <- alls ty
      ps  <- mapM term2patt vs
      ts' <- mapM (comp . S t') $ vs
      return $ T ty [Cas [p] t | (p,t) <- zip ps ts']
    V ty ts0 -> do
      ts  <- mapM exp ts0 -- expand from inside-out
      vs  <- alls ty
      ps  <- mapM term2patt vs
      return $ T ty [Cas [p] t | (p,t) <- zip ps ts]
    FV ts -> liftM FV $ mapM exp ts
    _ -> composOp exp t
   where
     alls = allParamValues g
     comp = ccompute g []


-- | from records, one can get to records of tables of strings
rec2strTables :: Term -> Err [[(Label,[([Patt],[Str])])]]
rec2strTables r = do
  vs <- allLinValues r
  mapM (mapPairsM (mapPairsM strsFromTerm)) vs

-- | from these tables, one may want to extract the ones for the "s" label
strTables2sTables :: [[(Label,[([Patt],[Str])])]] -> [[([Patt],[Str])]]
strTables2sTables ts = [t | r <- ts, (l,t) <- r, l == linLab0]

linLab0 :: Label
linLab0 = L (identC "s")

-- | to get lists of token lists is easy
sTables2strs :: [[([Patt],[Str])]] -> [[Str]]
sTables2strs = map snd . concat

-- | from this, to get a list of strings
strs2strings :: [[Str]] -> [String]
strs2strings = map unlex

-- | this is just unwords; use an unlexer from Text to postprocess
unlex :: [Str] -> String
unlex = concat . map sstr . take 1 ----

-- | finally, a top-level function to get a string from an expression
linTree2string :: Marker -> CanonGrammar -> Ident -> A.Tree -> String
linTree2string mk gr m e = head $ linTree2strings mk gr m e -- never empty

-- | you can also get many strings
linTree2strings :: Marker -> CanonGrammar -> Ident -> A.Tree -> [String]
linTree2strings mk gr m e = err return id $ do
  t  <- linearizeToRecord gr mk m e
  r  <- expandLinTables gr t
  ts <- rec2strTables r
  let ss = strs2strings $ sTables2strs $ strTables2sTables ts
  ifNull (prtBad "empty linearization of" e) return ss   -- thus never empty

-- | argument is a Tree, value is a list of strs; needed in Parsing
allLinsOfTree :: CanonGrammar -> Ident -> A.Tree -> [Str]
allLinsOfTree gr a e = err (singleton . str) id $ do
  e' <- return e ---- annotateExp gr e
  r  <- linearizeNoMark gr a e'
  r' <- expandLinTables gr r
  ts <- rec2strTables r'
  return $ concat $ sTables2strs $ strTables2sTables ts

-- | the value is a list of structures arranged as records of tables of terms
allLinsAsRec :: CanonGrammar -> Ident -> A.Tree -> Err [[(Label,[([Patt],Term)])]]
allLinsAsRec gr c t = linearizeNoMark gr c t >>= expandLinTables gr >>= allLinValues

-- | the value is a list of structures arranged as records of tables of strings
-- only taking into account string fields
allLinTables :: CanonGrammar ->Ident ->A.Tree ->Err [[(Label,[([Patt],[String])])]]
allLinTables gr c t = do
  r' <- allLinsAsRec gr c t
  mapM (mapM getS) r'
 where 
   getS (lab,pss) = liftM (curry id lab) $ mapM gets pss
   gets (ps,t) = liftM (curry id ps . cc . map str2strings) $ strsFromTerm t
   cc = concat . intersperse ["/"]

-- | the value is a list of strings gathered from all fields

allLinBranchFields :: CanonGrammar -> Ident -> A.Tree -> Err [String]
allLinBranchFields gr c trm = do
  r <- linearizeNoMark gr c trm >>= expandLinTables gr
  return [s | (_,t) <- allLinBranches r, s <- gets t]
 where 
   gets t = concat [cc (map str2strings s) | Ok s <- [strsFromTerm t]]
   cc = concat . intersperse ["/"]

prLinTable :: Bool -> [[(Label,[([Patt],[String])])]] -> [String]
prLinTable pars = concatMap prOne . concat where
  prOne (lab,pss) = (if pars then ((prt lab) :) else id) (map pr pss) ----
  pr (ps,ss) = (if pars then ((unwords (map prt_ ps) +++ ":") +++)
                             else id) (unwords ss)

{-
-- the value is a list of strs
allLinStrings :: CanonGrammar -> Tree -> [Str]
allLinStrings gr ft = case allLinsAsStrs gr ft of
  Ok ts -> map snd $ concat $ map snd $ concat ts
  Bad s -> [str s]

-- the value is a list of strs, not forgetting their arguments
allLinsAsStrs :: CanonGrammar -> Tree -> Err [[(Label,[([Patt],Str)])]]
allLinsAsStrs gr ft = do
  lpts <- allLinearizations gr ft
  return $ concat $ mapM (mapPairsM (mapPairsM strsFromTerm)) lpts


-- to a list of strings
linearizeToStrings :: CanonGrammar -> ([Int] ->Term -> Term) -> Tree -> Err [String]
linearizeToStrings gr mk = liftM (map unlex) . linearizeToStrss gr mk

-- to a list of token lists
linearizeToStrss :: CanonGrammar -> ([Int] -> Term -> Term) -> Tree -> Err [[Str]]
linearizeToStrss gr mk e = do
  R rs <- linearizeToRecord gr mk e ----
  t <- lookupErr linLab0 [(r,s) | Ass r s <- rs]
  return $ map strsFromTerm $ allInTable t 
-}

-- | the value is a list of strings, not forgetting their arguments
allLinsOfFun :: CanonGrammar -> CIdent -> Err [[(Label,[([Patt],Term)])]]
allLinsOfFun gr f = do
  t <- lookupLin gr f 
  allAllLinValues t --- all fields, not only s. 11/12/2005


-- | returns printname if one exists; otherwise linearizes with metas
printOrLinearize :: CanonGrammar -> Ident -> A.Fun -> String
printOrLinearize gr c f@(m, d) = errVal (prt fq) $ 
  case lookupPrintname gr (CIQ c d) of
    Ok t -> do
      ss <- strsFromTerm t
      let s = strs2strings [ss]
      return $ ifNull (prt fq) head s
    _ -> do
      ty  <- lookupFunType gr m d
      f'  <- ref2exp [] ty (A.QC m d)
      tr  <- annotate gr f' 
      return $ linTree2string noMark gr c tr
   where
     fq = CIQ m d  
