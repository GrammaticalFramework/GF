----------------------------------------------------------------------
-- |
-- Module      : SGrammar
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
--
-- A simple format for context-free abstract syntax used e.g. in
-- generation. AR 31\/3\/2006
--
-- (c) Aarne Ranta 2004 under GNU GPL
--
-- Purpose: to generate corpora. We use simple types and don't
-- guarantee the correctness of bindings\/dependences.
-----------------------------------------------------------------------------

module GF.Grammar.SGrammar where

import GF.Canon.GFC
import GF.Grammar.LookAbs
import GF.Grammar.PrGrammar
import GF.Grammar.Macros
import GF.Grammar.Values
import GF.Grammar.Grammar
import GF.Infra.Ident (Ident)

import GF.Data.Operations
import GF.Data.Zipper
import GF.Infra.Option

import Data.List

-- (c) Aarne Ranta 2006 under GNU GPL


type SGrammar = BinTree SCat [SRule]
type SIdent = String
type SRule = (SFun,SType)
type SType = ([SCat],SCat)
type SCat = SIdent
type SFun = (Double,SIdent)

allRules gr = concat [rs  | (c,rs) <- tree2list gr]

data STree = 
    SApp (SFun,[STree]) 
  | SMeta SCat
  | SString String
  | SInt Integer
  | SFloat Double
   deriving (Show,Eq)

depth :: STree -> Int
depth t = case t of
  SApp (_,ts@(_:_)) -> maximum (map depth ts) + 1
  _ -> 1

type Probs = BinTree Ident Double

emptyProbs :: Probs
emptyProbs = emptyBinTree

prProbs :: Probs -> String
prProbs = unlines . map pr . tree2list where
  pr (f,p) = prt f ++ "\t" ++ show p

------------------------------------------
-- translate grammar to simpler form and generated trees back

gr2sgr :: Options -> Probs -> GFCGrammar -> SGrammar
gr2sgr opts probs gr = buildTree [(c,norm (noexp c rs)) | rs@((_,(_,c)):_) <- rules] where
  noe = maybe [] (chunks ',') $ getOptVal opts (aOpt "noexpand")
  only = maybe [] (chunks ',') $ getOptVal opts (aOpt "doexpand")
  un  = getOptInt opts (aOpt "atoms")
  rules =
     prune $
       groupBy (\x y -> scat x == scat y) $
        sortBy (\x y -> compare (scat x) (scat y)) $
          [(trId f, ty') | (f,ty) <- funRulesOf gr, ty' <- trTy ty]
  trId (_,f) = let f' = prt f in case lookupTree prt f probs of
    Ok p -> (p,f')
    _ -> (2.0, f')
  trTy ty = case catSkeleton ty of
    Ok (mcs,mc) -> [(map trCat mcs, trCat mc)]
    _ -> []
  trCat (m,c) = prt c ---
  scat (_,(_,c)) = c

  prune rs = maybe rs (\n -> map (onlyAtoms n) rs) $ un

  norm = fillProb

  onlyAtoms n rs = 
    let (rs1,rs2) = partition atom rs 
    in take n rs1 ++ rs2
  atom = null . fst . snd

  noexp c rs 
    | null only = if elem c noe then [((2.0,'?':c),([],c))] else rs
    | otherwise = if elem c only then rs else [((2.0,'?':c),([],c))]

-- for cases where explicit probability is not given (encoded as
-- p > 1) divide the remaining mass by the number of such cases

fillProb :: [SRule] -> [SRule]
fillProb rs = [((defa p,f),ty) | ((p,f),ty) <- rs] where
  defa p = if p > 1.0 then def else p
  def = (1 - sum given) / genericLength nope 
  (nope,given) = partition (> 1.0) [p | ((p,_),_) <- rs]

-- str2tr :: STree -> Exp
str2tr t = case t of
  SApp ((_,'?':c),[]) -> mkMeta 0 -- from noexpand=c
  SApp ((_,f),ts) -> mkApp (trId f) (map str2tr ts) 
  SMeta _     -> mkMeta 0
  SString s   -> K s
  SInt i      -> EInt i
  SFloat i    -> EFloat i
 where
   trId = cn . zIdent

-- tr2str :: Tree -> STree
tr2str (Tr (N (_,at,val,_,_),ts)) = case (at,val) of
  (AtC (_,f), _)         -> SApp ((2.0,prt_ f),map tr2str ts)
  (AtM _,     v)         -> SMeta (catOf v)
  (AtL s,     _)         -> SString s
  (AtI i,     _)         -> SInt i
  (AtF i,     _)         -> SFloat i
  _ -> SMeta "FAILED_TO_GENERATE" ---- err monad!
 where
   catOf v = case v of
     VApp w _  -> catOf w
     VCn (_,c) -> prt_ c
     _ -> "FAILED_TO_GENERATE_FROM_META"


------------------------------------------
-- to test

prSTree t = case t of
  SApp ((_,f),ts) -> f ++ concat (map pr1 ts)
  SMeta c -> '?':c
  SString s -> prQuotedString s
  SInt i -> show i 
  SFloat i -> show i 
 where
  pr1 t@(SApp (_,ts)) = ' ' : (if null ts then id else prParenth) (prSTree t)
  pr1 t = prSTree t

pSRule :: String -> SRule
pSRule s = case words s of
  f : _ : cs -> ((2.0,f),(init cs', last cs')) 
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
