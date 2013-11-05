module PGF.Morphology(Lemma,Analysis,Morpho,
                      buildMorpho,isInMorpho,
                      lookupMorpho,fullFormLexicon,
                      morphoMissing,morphoKnown,morphoClassify,
                      missingWordMsg) where

import PGF.CId
import PGF.Data

import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.IntMap as IntMap
import Data.Array.IArray
--import Data.List (intersperse)
import Data.Char (isDigit) ----

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
                         , PApply funid _ <- maybe [] Set.toList (IntMap.lookup fid (productions pinfo))
                         , let CncFun fun lins = cncfuns pinfo ! funid
                         , (l,seqid) <- assocs lins
                         , sym <- elems (sequences pinfo ! seqid)
                         , t <- sym2tokns sym]
  where
    sym2tokns (SymKS t)       = [t]
    sym2tokns (SymKP ts alts) = concat (map sym2tokns ts ++ [sym2tokns sym | (syms,ps) <- alts, sym <- syms])
    sym2tokns _               = []

lookupMorpho :: Morpho -> String -> [(Lemma,Analysis)]
lookupMorpho (Morpho mo) s = maybe [] id $ Map.lookup s mo

isInMorpho :: Morpho -> String -> Bool
isInMorpho (Morpho mo) s = maybe False (const True) $ Map.lookup s mo

fullFormLexicon :: Morpho -> [(String,[(Lemma,Analysis)])]
fullFormLexicon (Morpho mo) = Map.toList mo

morphoMissing  :: Morpho -> [String] -> [String]
morphoMissing = morphoClassify False

morphoKnown    :: Morpho -> [String] -> [String]
morphoKnown = morphoClassify True

morphoClassify :: Bool -> Morpho -> [String] -> [String]
morphoClassify k mo ws = [w | w <- ws, k /= null (lookupMorpho mo w), notLiteral w] where
  notLiteral w = not (all isDigit w) ---- should be defined somewhere

missingWordMsg :: Morpho -> [String] -> String
missingWordMsg morpho ws = case morphoMissing morpho ws of
  [] -> ", but all words are known"
  ws -> "; unknown words: " ++ unwords ws

