----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module Generate where

import GFC
import LookAbs
import PrGrammar
import Macros
import Values

import Operations
import Zipper

import List

-- Generate all trees of given category and depth. AR 30/4/2004
-- (c) Aarne Ranta 2004 under GNU GPL
--
-- Purpose: to generate corpora. We use simple types and don't
-- guarantee the correctness of bindings/dependences.


-- the main function takes an abstract syntax and returns a list of trees

--- if type were shown more modules should be imported
-- generateTrees :: 
-- GFCGrammar -> Bool -> Cat -> Int -> Maybe Int -> Maybe Tree -> [Exp]
generateTrees gr ifm cat n mn mt = map str2tr $ generate gr' ifm cat' n mn mt'
  where
    gr' = gr2sgr gr
    cat' = prt $ snd cat
    mt' = maybe Nothing (return . tr2str) mt

------------------------------------------
-- translate grammar to simpler form and generated trees back

gr2sgr :: GFCGrammar -> SGrammar
gr2sgr gr = [(trId f, ty') | (f,ty) <- funRulesOf gr, ty' <- trTy ty] where
  trId = prt . snd
  trTy ty = case catSkeleton ty of
    Ok (mcs,mc) -> [(map trCat mcs, trCat mc)]
    _ -> []
  trCat (m,c) = prt c ---

-- str2tr :: STree -> Exp
str2tr t = case t of
  SApp (f,ts) -> mkApp (trId f) (map str2tr ts) 
  SMeta _     -> mkMeta 0
----  SString s   -> K s
 where
   trId = cn . zIdent

-- tr2str :: Tree -> STree
tr2str (Tr (N (_,at,val,_,_),ts)) = case (at,val) of
  (AtC (_,f), _)         -> SApp (prt_ f,map tr2str ts)
  (AtM _,     VCn (_,c)) -> SMeta (prt_ c)
  (AtL s,     _)         -> SString s
  (AtI i,     _)         -> SInt i
  _ -> SMeta "FAILED_TO_GENERATE" ---- err monad!

------------------------------------------
-- do the main thing with a simpler data structure
-- the first Int gives tree depth, the second constrains subtrees
-- chosen for each branch. A small number, such as 2, is a good choice
-- if the depth is large (more than 3)
-- If a tree is given as argument, generation concerns its metavariables.

generate :: SGrammar -> Bool -> SCat -> Int -> Maybe Int -> Maybe STree -> [STree]
generate gr ifm cat i mn mt = case mt of
  Nothing -> [t | (c,t) <- gen 0 [], c == cat] 

  Just t -> genM t

 where

  gen :: Int -> [(SCat,STree)] -> [(SCat,STree)]
  gen n cts = if n==i then cts else
    gen (n+1) (nub [(c,SApp (f, xs)) | (f,(cs,c)) <- gr, xs <- args cs cts] ++ cts)

  args :: [SCat] -> [(SCat,STree)] -> [[STree]]
  args cs cts = combinations 
    [constr (ifmetas c [t | (k,t) <- cts, k == c]) | c <- cs]

  constr = maybe id take mn

  ifmetas c = if ifm then (SMeta c :) else id

  genM t = case t of
    SApp (f,ts) -> [SApp (f,ts') | ts' <- combinations (map genM ts)]
    SMeta k -> [t | (c,t) <- gen 0 [], c == k] 
    _ -> [t]

type SGrammar = [SRule]
type SIdent = String
type SRule = (SFun,SType)
type SType = ([SCat],SCat)
type SCat = SIdent
type SFun = SIdent

data STree = 
    SApp (SFun,[STree]) 
  | SMeta SCat
  | SString String
  | SInt Int
   deriving (Show,Eq)

------------------------------------------
-- to test

prSTree t = case t of
  SApp (f,ts) -> f ++ concat (map pr1 ts)
  SMeta c -> '?':c
  SString s -> prQuotedString s
  SInt i -> show i 
 where
  pr1 t@(SApp (_,ts)) = ' ' : (if null ts then id else prParenth) (prSTree t)
  pr1 t = prSTree t

pSRule :: String -> SRule
pSRule s = case words s of
  f : _ : cs -> (f,(init cs', last cs')) 
    where cs' = [cs !! i | i <- [0,2..length cs - 1]]
  _ -> error $ "not a rule" +++ s

exSgr = map pSRule [
   "Pred   : NP -> VP -> S"
  ,"Compl  : TV -> NP -> VP" 
  ,"PredVV : VV -> VP -> VP"
  ,"DefCN  : CN -> NP"
  ,"ModCN  : AP -> CN -> CN" 
  ,"john   : NP"
  ,"walk   : VP"
  ,"love   : TV"
  ,"try    : VV"
  ,"girl   : CN"
  ,"big    : AP"
  ]
