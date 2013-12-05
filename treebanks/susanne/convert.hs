import System.Directory
import System.FilePath
import Data.List
import Data.Char(toLower)

import PGF (readPGF, readLanguage, buildMorpho, lookupMorpho, mkCId, functionType, unType)
import SusanneFormat

Just eng = readLanguage "ParseEng"

main = do
  gr <- readPGF "../../ParseEngAbs.pgf"
  let morpho = buildMorpho gr eng
  fs <- getDirectoryContents "data"
  txts <- (mapM (\f -> readFile ("data" </> f)) . filter ((/= ".") . take 1)) (sort fs)
  --let ts = concatMap (convert gr morpho) (readTreebank (lines (concat txts)))
  let ts = readTreebank (lines (concat txts))
  writeFile "text" (unlines (map show ts))

convert pgf morpho w@(Word _ tag _ lemma)
  | elem tag ["YB","YBL","YBR","YF","YIL","YIR","YTL","YTR", "YO"] = []
  | tag == "NN1c" = convertLemma pgf morpho (mkCId "N") "s Sg Nom" w
  | tag == "NN1n" = convertLemma pgf morpho (mkCId "N") "s Sg Nom" w
  | tag == "NN2"  = convertLemma pgf morpho (mkCId "N") "s Pl Nom" w
  | tag == "JJ"   = convertLemma pgf morpho (mkCId "A") "s (AAdj Posit Nom)" w
  | tag == "JB"   = convertLemma pgf morpho (mkCId "A") "s (AAdj Posit Nom)" w
  | tag == "JBo"  = convertLemma pgf morpho (mkCId "A") "s (AAdj Posit Nom)" w
  | tag == "AT"   = convertLemma pgf morpho (mkCId "Quant") "s False Sg" w
  | tag == "VVDi" = convertLemma pgf morpho (mkCId "V") "s VPast" w
  | tag == "VVDt" = convertLemma pgf morpho (mkCId "V2") "s VPast" w
  | tag == "VVDv" = convertLemma pgf morpho (mkCId "V") "s VPast" w
  | tag == "VVZi" = convertLemma pgf morpho (mkCId "V") "s VPres" w
  | tag == "VVZt" = convertLemma pgf morpho (mkCId "V2") "s VPres" w
  | tag == "VVZv" = convertLemma pgf morpho (mkCId "V") "s VPres" w
  | tag == "PPHS2"= convertLemma pgf morpho (mkCId "Pron") "s (NCase Nom)" w
  | tag == "PPHO2"= convertLemma pgf morpho (mkCId "Pron") "s NPAcc" w
  | tag == "RR"   = convertLemma pgf morpho (mkCId "Adv") "s" w
  | tag == "II"   = convertLemma pgf morpho (mkCId "Prep") "s" w
  | tag == "IO"   = convertLemma pgf morpho (mkCId "Prep") "s" w
  | otherwise                                                 = [w]
convert pgf morpho (Phrase tag mods fn idx ts)
  | tag == "O" = concatMap (convert pgf morpho) ts
  | otherwise  = [Phrase tag mods fn idx (concatMap (convert pgf morpho) ts)]

convertLemma pgf morpho cat an0 w@(Word _ tag form _) =
  case [f | (f,an) <- lookupMorpho morpho (map toLower form), hasCat pgf f cat, an == an0] of
    [f] -> [App f []]
    _   -> [w]
  where
    hasCat pgf f cat =
      case functionType pgf f of
        Just ty -> case unType ty of
                     (_,cat1,_) -> cat1 == cat
        Nothing -> False
