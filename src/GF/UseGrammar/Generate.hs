module Generate where

import GFC
import LookAbs
import PrGrammar
import Macros

import Operations
import List

-- Generate all trees of given category and depth. AR 30/4/2004
-- (c) Aarne Ranta 2004 under GNU GPL
--
-- Purpose: to generate corpora. We use simple types and don't
-- guarantee the correctness of bindings/dependences.


-- the main function takes an abstract syntax and returns a list of trees

-- generateTrees :: GFCGrammar -> Cat -> Int -> Maybe Int -> [Exp]
generateTrees gr cat n mn = map str2tr $ generate gr' cat' n mn where
  gr' = gr2sgr gr
  cat' = prt $ snd cat

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
str2tr (STr (f,ts)) = mkApp (trId f) (map str2tr ts) where
  trId = cn . zIdent

------------------------------------------
-- do the main thing with a simpler data structure
-- the first Int gives tree depth, the second constrains subtrees
-- chosen for each branch. A small number, such as 2, is a good choice
-- if the depth is large (more than 3)


generate :: SGrammar -> SCat -> Int -> Maybe Int -> [STree]
generate gr cat i mn = [t | (c,t) <- gen 0 [], c == cat] where

  gen :: Int -> [(SCat,STree)] -> [(SCat,STree)]
  gen n cts = if n==i then cts else
    gen (n+1) (nub [(c,STr (f, xs)) | (f,(cs,c)) <- gr, xs <- args cs cts] ++ cts)

  args :: [SCat] -> [(SCat,STree)] -> [[STree]]
  args cs cts = combinations [constr [t | (k,t) <- cts, k == c] | c <- cs]

  constr = maybe id take mn

type SGrammar = [SRule]
type SIdent = String
type SRule = (SFun,SType)
type SType = ([SCat],SCat)
type SCat = SIdent
type SFun = SIdent

newtype STree = STr (SFun,[STree]) deriving (Show,Eq)

------------------------------------------
-- to test

prSTree (STr (f,ts)) = f ++ concat (map pr1 ts) where
  pr1 t@(STr (_,ts)) = ' ' : (if null ts then id else prParenth) (prSTree t)

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
