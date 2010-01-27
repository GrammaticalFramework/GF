module PGF.Morphology(Lemma,Analysis,Morpho,
                      buildMorpho,
                      lookupMorpho,fullFormLexicon) where

import PGF.CId
import PGF.Data

import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.IntMap as IntMap
import Data.Array.IArray
import Data.List (intersperse)

-- these 4 definitions depend on the datastructure used

type Lemma = CId
type Analysis = String

newtype Morpho = Morpho (Map.Map String [(Lemma,Analysis)])

buildMorpho :: PGF -> Language -> Morpho
buildMorpho pgf lang = Morpho $
  case Map.lookup lang (concretes pgf) of
    Just pinfo -> collectWords pinfo
    Nothing    -> Map.empty

collectWords pinfo = Map.fromListWith (++)
  [(t, [(fun,lbls ! l)]) | (CncCat s e lbls) <- Map.elems (cnccats pinfo)
                         , fid <- [s..e]
                         , PApply funid _ <- maybe [] Set.toList (IntMap.lookup fid (pproductions pinfo))
                         , let CncFun fun lins = cncfuns pinfo ! funid
                         , (l,seqid) <- assocs lins
                         , sym <- elems (sequences pinfo ! seqid)
                         , t <- sym2tokns sym]
  where
    sym2tokns (SymKS ts)      = ts
    sym2tokns (SymKP ts alts) = ts ++ [t | Alt ts ps <- alts, t <- ts]
    sym2tokns _               = []

lookupMorpho :: Morpho -> String -> [(Lemma,Analysis)]
lookupMorpho (Morpho mo) s = maybe [] id $ Map.lookup s mo

fullFormLexicon :: Morpho -> [(String,[(Lemma,Analysis)])]
fullFormLexicon (Morpho mo) = Map.toList mo
