module PGF.Morphology where

import PGF.ShowLinearize
import PGF.Data
import PGF.CId

import qualified Data.Map as Map
import Data.List (intersperse)

-- these 4 definitions depend on the datastructure used

type Morpho = Map.Map String [(Lemma,Analysis)]

lookupMorpho :: Morpho -> String -> [(Lemma,Analysis)]
lookupMorpho mo s = maybe noAnalysis id $ Map.lookup s mo

buildMorpho :: PGF -> CId -> Morpho
buildMorpho pgf = Map.fromListWith (++) . collectWords pgf

prFullFormLexicon :: Morpho -> String
prFullFormLexicon mo = 
  unlines [w ++ " : " ++ prMorphoAnalysis ts | (w,ts) <- Map.assocs mo]

prMorphoAnalysis :: [(Lemma,Analysis)] -> String
prMorphoAnalysis lps = unlines [l ++ " " ++ p | (l,p) <- lps]

type Lemma = String
type Analysis = String

noAnalysis :: [(Lemma,Analysis)]
noAnalysis = []

collectWords :: PGF -> CId -> [(String, [(Lemma,Analysis)])]
collectWords pgf lang = 
    concatMap collOne 
      [(f,c,0) | (f,(DTyp [] c _,_)) <- Map.toList $ funs $ abstract pgf] 
  where
    collOne (f,c,i) = 
      fromRec f [prCId c] (recLinearize pgf lang (EApp f (replicate i (EMeta 888))))
    fromRec f v r = case r of
      RR  rs -> concat [fromRec f v t | (_,t) <- rs] 
      RT  rs -> concat [fromRec f (p:v) t | (p,t) <- rs]
      RFV rs -> concatMap (fromRec f v) rs
      RS  s  -> [(s,[(prCId f,unwords (reverse v))])]
      RCon c -> [] ---- inherent

