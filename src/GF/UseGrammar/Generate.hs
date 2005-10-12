----------------------------------------------------------------------
-- |
-- Module      : Generate
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/12 12:38:30 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.16 $
--
-- Generate all trees of given category and depth. AR 30\/4\/2004
--
-- (c) Aarne Ranta 2004 under GNU GPL
--
-- Purpose: to generate corpora. We use simple types and don't
-- guarantee the correctness of bindings\/dependences.
-----------------------------------------------------------------------------

module GF.UseGrammar.Generate (generateTrees) where

import GF.Canon.GFC
import GF.Grammar.LookAbs
import GF.Grammar.PrGrammar
import GF.Grammar.Macros
import GF.Grammar.Values
import GF.Grammar.Grammar (Cat)

import GF.Data.Operations
import GF.Data.Zipper
import GF.Infra.Option

import Data.List

-- Generate all trees of given category and depth. AR 30/4/2004
-- (c) Aarne Ranta 2004 under GNU GPL
--
-- Purpose: to generate corpora. We use simple types and don't
-- guarantee the correctness of bindings/dependences.


-- | the main function takes an abstract syntax and returns a list of trees
generateTrees :: Options -> GFCGrammar -> Cat -> Int -> Maybe Int -> Maybe Tree -> [Exp]
generateTrees opts gr cat n mn mt = map str2tr $ generate gr' ifm cat' n mn mt'
  where
    gr'  = gr2sgr ats gr
    cat' = prt $ snd cat
    mt'  = maybe Nothing (return . tr2str) mt
    ifm  = oElem withMetas opts
    ats  = getOptInt opts (aOpt "atoms")

------------------------------------------
-- translate grammar to simpler form and generated trees back

gr2sgr :: Maybe Int -> GFCGrammar -> SGrammar
gr2sgr un gr = buildTree [(c,rs) | rs@((_,(_,c)):_) <- prune rules] where
  rules =
    groupBy (\x y -> scat x == scat y) $
      sortBy (\x y -> compare (scat x) (scat y)) 
        [(trId f, ty') | (f,ty) <- funRulesOf gr, ty' <- trTy ty]
  trId = prt . snd
  trTy ty = case catSkeleton ty of
    Ok (mcs,mc) -> [(map trCat mcs, trCat mc)]
    _ -> []
  trCat (m,c) = prt c ---
  scat (_,(_,c)) = c

  prune rs = maybe rs (\n -> map (onlyAtoms n) rs) $ un
  onlyAtoms n rs = 
    let (rs1,rs2) = partition atom rs 
    in take n rs1 ++ rs2
  atom = null . fst . snd

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
  (AtM _,     v)         -> SMeta (catOf v)
  (AtL s,     _)         -> SString s
  (AtI i,     _)         -> SInt i
  _ -> SMeta "FAILED_TO_GENERATE" ---- err monad!
 where
   catOf v = case v of
     VApp w _  -> catOf w
     VCn (_,c) -> prt_ c
     _ -> "FAILED_TO_GENERATE_FROM_META"

------------------------------------------
-- do the main thing with a simpler data structure
-- the first Int gives tree depth, the second constrains subtrees
-- chosen for each branch. A small number, such as 2, is a good choice
-- if the depth is large (more than 3)
-- If a tree is given as argument, generation concerns its metavariables.

generate :: SGrammar -> Bool -> SCat -> Int -> Maybe Int -> Maybe STree -> [STree]
generate gr ifm cat i mn mt = case mt of
  Nothing -> gen cat
  Just t  -> genM t
 where

  gen cat = concat $ errVal [] $ lookupTree id cat $ allTrees

  allTrees = genAll i

  -- dynamic generation
  genAll :: Int -> BinTree SCat [[STree]]
  genAll i = iter i genNext (mapTree (\ (c,_) -> (c,[[]])) gr)

  iter 0 f tr = tr
  iter n f tr = iter (n-1) f (f tr)

  genNext tr = mapTree (genNew tr) tr

  genNew tr (cat,ts) = let size = length ts in
    (cat, [SApp (f, xs) | 
            (f,(cs,_)) <- funs cat, 
            xs <- combinations (map look cs),
            let fxs = SApp (f, xs),
            depth fxs == size]
         : ts)
   where
     look c = concat $ errVal [] $ lookupTree id c tr

  funs cat = maybe id take mn $ errVal [] $ lookupTree id cat gr

  genM t = case t of
    SApp (f,ts) -> [SApp (f,ts') | ts' <- combinations (map genM ts)]
    SMeta k     -> gen k 
    _ -> [t]

type SGrammar = BinTree SCat [SRule]
type SIdent = String
type SRule = (SFun,SType)
type SType = ([SCat],SCat)
type SCat = SIdent
type SFun = SIdent

allRules gr = concat [rs  | (c,rs) <- tree2list gr]

data STree = 
    SApp (SFun,[STree]) 
  | SMeta SCat
  | SString String
  | SInt Int
   deriving (Show,Eq)

depth :: STree -> Int
depth t = case t of
  SApp (_,ts@(_:_)) -> maximum (map depth ts) + 1
  _ -> 1

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
