import System.Directory
import System.FilePath
import Data.List
import Data.Char(toLower)
import Control.Monad
import qualified Data.Map as Map

import PGF (readPGF, readLanguage, buildMorpho, lookupMorpho, mkCId, functionType, unType)
import SusanneFormat
import Parser
import Idents

Just eng = readLanguage "DictEng"

main = do
  gr <- readPGF "DictEngAbs.pgf"
  let morpho = buildMorpho gr eng
  fs <- getDirectoryContents "data"
  txts <- (mapM (\f -> readFile ("data" </> f)) . filter ((/= ".") . take 1)) (sort fs)
  --let ts' = readTreebank (lines (concat txts))
  --writeFile "text" (unlines (map show ts'))
  let (ts',rs') = combineRes (convert gr morpho) (readTreebank (lines (concat txts)))
  let rm = Map.fromListWith (++) rs'
  writeFile "susanne.gft" (unlines (map show ts'))
  writeFile "rules" (unlines (concat [unwords ("-":cat:"->":cats) : map (\t -> "     "++show t) rs'' | (cat :-> cats,rs'') <- Map.toList rm]))

data Rule = Tag :-> [Tag]
            deriving (Eq,Ord)

convert pgf morpho w@(Word _ tag _ lemma)
  | elem tag ["YB","YBL","YBR","YF","YIL","YIR","YTL","YTR", "YO"] = ([],[])
{-  | tag == "NN1c" = convertLemma pgf morpho (mkCId "N") "s Sg Nom" w
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
  | tag == "IO"   = convertLemma pgf morpho (mkCId "Prep") "s" w-}
  | otherwise                                                 = ([w],[])
convert pgf morpho t@(Phrase tag mods fn idx ts)
  | tag == "O" = (ts',rs')
  | tag == "Q" = (ts',rs')
  | tag == "S" = case runP pS pgf morpho ts' of
                   Just ([],x) -> ([x], rs')
                   _           -> ([Phrase tag mods fn idx ts'], (r,[t]) : rs')
  | otherwise  = ([Phrase tag mods fn idx ts'], (r,[t]) : rs')
  where
    (ts',rs') = combineRes (convert pgf morpho) ts
    r         = tag :-> map getTag ts

    isExtra (Word _ "YIL" _ _) = True
    isExtra (Word _ "YIR" _ _) = True
    isExtra (Word _ "YTL" _ _) = True
    isExtra (Word _ "YTR" _ _) = True
    isExtra _                  = False

    getTag (Phrase tag mods fn idx ts) = tag++if null fn then "" else ":"++fn
    getTag (Word _ tag _ _)            = tag

convertLemma pgf morpho cat an0 w@(Word _ tag form _) =
  case [f | (f,an) <- lookupMorpho morpho (map toLower form), hasCat pgf f cat, an == an0] of
    [f] -> ([App f []], [])
    _   -> ([w],[])
  where
    hasCat pgf f cat =
      case functionType pgf f of
        Just ty -> case unType ty of
                     (_,cat1,_) -> cat1 == cat
        Nothing -> False

combineRes f ts = (ts',rs')
  where
    (x,y) = unzip (map f ts)
    ts' = concat x
    rs' = concat y

pS =
  do mplus pConj (return ())
     advs <- many pAdS
     np <- pSubject
     (t,p,vp) <- pVP
     return (foldr ($) (cidUseCl (cidTTAnt t p) (cidPredVP np vp)) advs)
  `mplus`
  do mplus pConj (return ())
     (t,p,vp) <- pVP
     return (cidImpVP vp)
  `mplus`
  do mplus pConj (return ())
     advs <- many pAdS
     t1 <- match "EX"
     (t,p,vp) <- pVP
     return (foldr ($) (cidUseCl (cidTTAnt t p) (cidExistNP t1 vp)) advs)

pSubject =
  do insideOpt "N:s" pNP
  `mplus`
  do insideOpt "N:S" pNP
  `mplus`
  do match "M:s"
  `mplus`
  do match "M:S"
  `mplus`
  do match "D:s"
  `mplus`
  do match "D:S"

pConj =
  do match "CC"
     return ()
  `mplus`
  do match "CCB"
     return ()

pAdS =
  do adv <- pAdv
     match "YC"
     return (\t -> cidExtAdvS adv t)
  `mplus`
  do adv <- pAdv
     return (\t -> cidAdvS adv t)

pVP =
  do adVs     <- many pAdV
     (t,p,vs) <- pV "VS"
     advs     <- many pAdv
     s        <- insideOpt "F:o"
                   (opt (match "CST") >> pS)
     return (t,p,foldr (\adv t -> cidAdVVP adv t)
                       (foldl (\t adv -> cidAdvVP t adv)
                              (cidComplVS vs s)
                              advs)
                       adVs)
  `mplus`
  do adVs     <- many pAdV
     (t,p,vv) <- pV "VV"
     advs     <- many pAdv
     vp       <- match "Ti"
     return (t,p,foldr (\adv t -> cidAdVVP adv t)
                       (foldl (\t adv -> cidAdvVP t adv)
                              (cidComplVV vv vp)
                              advs)
                       adVs)
  `mplus`
  do adVs     <- many pAdV
     (t,p,v2) <- pV "V2"
     o        <- pObject
     opt (match "YC")   -- what is this?
     advs     <- many pAdv
     return (t,p,foldr (\adv t -> cidAdVVP adv t)
                       (foldl (\t adv -> cidAdvVP t adv)
                              (cidComplSlash (cidSlashV2a v2) o)
                              advs)
                       adVs)
  `mplus`
  do adVs    <- many pAdV
     (t,p,v) <- pV "V"
     advs    <- many pAdv
     return (t,p,foldr (\adv t -> cidAdVVP adv t)
                       (foldl (\t adv -> cidAdvVP t adv)
                              (cidUseV v)
                              advs)
                       adVs)

pV cat =
  do inside "V" $
       do v <- lemma "VVDv" (mkCId cat) "s VPast"
          return (cidTTAnt cidTPast cidASimul,cidPPos,v)
       `mplus`
       do v <- lemma "VVDt" (mkCId cat) "s VPast"
          return (cidTTAnt cidTPast cidASimul,cidPPos,v)
       `mplus`
       do v <- lemma "VVZv" (mkCId cat) "s VPres"
          return (cidTTAnt cidTPres cidASimul,cidPPos,v)
       `mplus`
       do match "VHD"
          match "VHD"
          v <- lemma "VVNv" (mkCId cat) "s VPPart"
          return (cidTTAnt cidTPres cidAAnter,cidPPos,v)
  `mplus`
  do v <- match "V"
     return (App (mkCId "XXX") [],App (mkCId "XXX") [],v)

pAdV =
  do insideOpt "R:c" $
       lemma "RRR" (mkCId "AdV") "s"
  `mplus`
  do match "R:m"

pObject = 
  match "P:u"
  `mplus`
  insideOpt "N:o" pNP
  `mplus`
  match "N:e"
  `mplus`
  match "M:e"
  `mplus`
  match "D:e"
  `mplus`
  match "P:e"

pAdv =
  do match "N:t"
  `mplus`
  do match "N:h"
  `mplus`
  do match "P:p"
  `mplus`
  do match "P:q"
  `mplus`
  do match "P:a"
  `mplus`
  do match "P:t"
  `mplus`
  do match "P:h"
  `mplus`
  do match "P:m"
  `mplus`
  do match "P:r"
  `mplus`
  do match "R:p"
  `mplus`
  do match "R:q"
  `mplus`
  do match "R:a"
  `mplus`
  do match "R:t"
  `mplus`
  do match "R:h"
  `mplus`
  do match "R:m"
  `mplus`
  do match "R:c"
  `mplus`
  do match "R:r"
  `mplus`
  do match "F:p"
  `mplus`
  do match "F:q"
  `mplus`
  do match "F:a"
  `mplus`
  do match "F:t"
  `mplus`
  do match "F:h"
  `mplus`
  do match "F:m"
  `mplus`
  do match "F:r"
  `mplus`
  do match "W:b"
  `mplus`
  do match "L:b"

pNP = do
  q      <- pQuant
  (n,cn) <- pCN
  return (cidDetCN (cidDetQuant q n) cn)

pQuant =
  do lemma "AT" (mkCId "Quant") "s False Sg"
  `mplus`
  do match "AT1"
     return cidIndefArt

pCN =
  do np <- insideOpt "N" pNP
     (n,cn) <- pCN
     return (n,App (mkCId "Appos") [np,cn])
  `mplus`
  do a  <- lemma "JJ" (mkCId "A") "s (AAdj Posit Nom)"
     (n,cn) <- pCN
     return (n,cidAdjCN (cidPositA a) cn)
  `mplus`
  do (num,n) <- pN
     advs <- many pPo
     return (num,
             foldl (\t adv -> cidAdvCN t adv)
                   (cidUseN n)
                   advs)

pN = 
  do n <- lemma "NN1c" (mkCId "N") "s Sg Nom"
     return (cidNumSg, n)
  `mplus`
  do n <- lemma "NN1n" (mkCId "N") "s Sg Nom"
     return (cidNumSg, n)

pPo =
  insideOpt "Po" $ do
    p  <- match "IO"
    np <- insideOpt "N" pNP
    return (cidPrepNP p np)
