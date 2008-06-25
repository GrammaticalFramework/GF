module PGF.Morphology where

import PGF.ShowLinearize (collectWords)
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

