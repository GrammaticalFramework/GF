module PGF.Morphology(Lemma,Analysis,Morpho,
                      buildMorpho,
                      lookupMorpho,fullFormLexicon) where

import PGF.ShowLinearize (collectWords)
import PGF.Data
import PGF.CId

import qualified Data.Map as Map
import Data.List (intersperse)

-- these 4 definitions depend on the datastructure used

type Lemma = CId
type Analysis = String

newtype Morpho = Morpho (Map.Map String [(Lemma,Analysis)])

buildMorpho :: PGF -> Language -> Morpho
buildMorpho pgf lang = Morpho (Map.fromListWith (++) (collectWords pgf lang))

lookupMorpho :: Morpho -> String -> [(Lemma,Analysis)]
lookupMorpho (Morpho mo) s = maybe [] id $ Map.lookup s mo

fullFormLexicon :: Morpho -> [(String,[(Lemma,Analysis)])]
fullFormLexicon (Morpho mo) = Map.toList mo
