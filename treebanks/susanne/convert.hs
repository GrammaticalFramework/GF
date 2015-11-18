import System.Directory
import System.FilePath
import Data.List
import Data.Char(toLower)
import Data.Maybe(fromMaybe)
import Control.Monad
import qualified Data.Map as Map

import PGF2
import SusanneFormat
import Parser
import Idents

main = do
  gr <- readPGF "ParseEngAbs.pgf"
  let Just eng = Map.lookup "ParseEng" (languages gr)
  fs <- getDirectoryContents "data"
  txts <- (mapM (\f -> readFile ("data" </> f)) . filter ((/= ".") . take 1)) (sort fs)
  let ts = (map (convert gr eng) . concatMap filterTree) (readTreebank (lines (concat txts)))
  writeFile "susanne.gft" (unlines (map show ts))

filterTree w@(Word _ tag _ lemma)
  | elem tag ["YB","YBL","YBR","YF","YIL","YIR","YTL","YTR", "YO"] = []
  | otherwise                                                      = [w]
filterTree (Phrase tag mods fn idx ts)
  | tag == "O" = ts'
  | tag == "Q" = ts'
  | otherwise  = [Phrase tag mods fn idx ts']
  where
    ts' = concatMap filterTree ts

convert pgf eng t@(Phrase tag mods fn idx ts)
  | tag == "S" = case runP pS pgf eng ts of
                   Just ([],x) -> x
                   _           -> Phrase tag mods fn idx ts'
  | tag == "N" = case runP pNP pgf eng ts of
                   Just ([],x) -> x
                   _           -> Phrase tag mods fn idx ts'
  | tag == "V" = case runP (pV "V") pgf eng [t] of
                   Just ([],(_,_,_,_,x)) -> x
                   _                     -> Phrase tag mods fn idx ts'
  | tag == "P" = case runP pPP pgf eng ts of
                   Just ([],x) -> x
                   _           -> Phrase tag mods fn idx ts'
  | tag == "Po"= case runP pPP pgf eng ts of
                   Just ([],x) -> x
                   _           -> Phrase tag mods fn idx ts'
  | tag == "Fr"= case runP pRS pgf eng ts of
                   Just ([],x) -> x
                   _           -> Phrase tag mods fn idx ts'
  | otherwise  = Phrase tag mods fn idx ts'
  where
    ts' = map (convert pgf eng) ts
convert pgf eng t@(Word _ tag _ lemma)
  | take 2 tag == "NN" = case runP pN pgf eng [t] of
                           Just ([],(_,x)) -> x
                           _               -> t
  | take 1 tag == "J"  = case runP pAP pgf eng [t] of
                           Just ([],x) -> x
                           _           -> t
  | otherwise          = t

pS =
  do mplus pConj (return ())
     advs <- many pAdS
     np <- pSubject
     (t,p,vp) <- pVP
     return (foldr ($) (cidUseCl t p (cidPredVP np vp)) advs)
  `mplus`
  do mplus pConj (return ())
     (t,p,vp) <- pVP
     return (cidImpVP vp)
  `mplus`
  do mplus pConj (return ())
     advs <- many pAdS
     t1 <- match convert "EX"
     (t,p,vp) <- pVP
     return (foldr ($) (cidUseCl t p (cidExistNP t1 vp)) advs)

pSubject =
  do insideOpt convert "N:s" pNP
  `mplus`
  do insideOpt convert "N:S" pNP
  `mplus`
  do insideOpt convert "M:s" pM
  `mplus`
  do insideOpt convert "M:S" pM
  `mplus`
  do insideOpt convert "Ds:s" $ do
       det <- pDet
       return (cidDetNP (det cidNumSg))
  `mplus`
  do insideOpt convert "Dp:s" $ do
       det <- pDet
       return (cidDetNP (det cidNumPl))
  `mplus`
  do insideOpt convert "Ds:S" $ do
       det <- pDet
       return (cidDetNP (det cidNumSg))
  `mplus`
  do insideOpt convert "Dp:S" $ do
       det <- pDet
       return (cidDetNP (det cidNumPl))

pConj =
  do match convert "CC"
     return ()
  `mplus`
  do match convert "CCB"
     return ()

pAdS =
  do adv <- pVPMods
     match convert "YC"
     return (\t -> cidExtAdvS adv t)
  `mplus`
  do adv <- pVPMods
     return (\t -> cidAdvS adv t)

pVP =
  do adVs     <- many pAdV
     (t,p,voice,apect,vs) <- pV "VS"
     advs     <- many pVPMods
     s        <- insideOpt convert "F:o"
                   (opt (match convert "CST") >> pS)
     return (t,p,foldr (\adv t -> cidAdVVP adv t)
                       (foldl (\t adv -> cidAdvVP t adv)
                              (cidComplVS vs s)
                              advs)
                       adVs)
  `mplus`
  do adVs     <- many pAdV
     (t,p,voice,apect,vv) <- pV "VV"
     advs     <- many pVPMods
     (p2,voice,aspect,vp) <- inside "Ti" $ do
                               match convert "s"
                               pVPInf
     return (t,p,foldr (\adv t -> cidAdVVP adv t)
                       (foldl (\t adv -> cidAdvVP t adv)
                              (cidComplVV vv cidASimul p2 vp)
                              advs)
                       adVs)
  `mplus`
  do adVs     <- many pAdV
     (t,p,voice,apect,v2) <- pV "V2"
     o        <- pObject
     opt (match convert "YC")   -- what is this?
     advs     <- many pVPMods
     return (t,p,foldr (\adv t -> cidAdVVP adv t)
                       (foldl (\t adv -> cidAdvVP t adv)
                              (cidComplSlash (cidSlashV2a v2) o)
                              advs)
                       adVs)
  `mplus`
  do adVs    <- many pAdV
     (t,p,voice,apect,v) <- pV "V"
     advs    <- many pVPMods
     return (t,p,foldr (\adv t -> cidAdVVP adv t)
                       (foldl (\t adv -> cidAdvVP t adv)
                              (cidUseV v)
                              advs)
                       adVs)
  `mplus`
  do (t,p) <- inside "V" pCopula
     comp  <- pComp
     advs  <- many pVPMods
     return (cidTTAnt t cidASimul,p,foldl (\t adv -> cidAdvVP t adv)
                                          (cidUseComp comp)
                                          advs)

pCopula = 
  do match convert "VBZ"
     p <- pPol
     return (cidTPres,p)
  `mplus`
  do match convert "VBDZ"
     p <- pPol
     return (cidTPast,p)

pComp =
  do adv <- insideOpt convert "R:e" pAdv
     return (cidCompAdv adv)
  `mplus`
  do np <- insideOpt convert "N:e" pNP
     return (cidCompNP np)
  `mplus`
  do ap <- pAP
     return (cidCompAP ap)

pAdv =
  do lemma "RP" "Adv" "s"

data Voice  = Active | Passive
data Aspect = Simple | Progressive

pV cat =
  do inside "V" $
       do v <- pVPres cat
          return (cidTTAnt cidTPres cidASimul,cidPPos,Active,Simple,v)
       `mplus`
       do v <- do lemma "VVZi" cat "s VPres"
               `mplus`
               do lemma "VVZt" cat "s VPres"
               `mplus`
               do lemma "VVZv" cat "s VPres"
          return (cidTTAnt cidTPres cidASimul,cidPPos,Active,Simple,v)
       `mplus`
       do v <- do lemma "VVDi" cat "s VPast"
               `mplus`
               do lemma "VVDt" cat "s VPast"
               `mplus`
               do lemma "VVDv" cat "s VPast"
          return (cidTTAnt cidTPast cidASimul,cidPPos,Active,Simple,v)
       `mplus`
       do (match convert "VBM" `mplus` match convert "VBR" `mplus` match convert "VBZ") -- am,are,is
          pol <- pPol
          (voice,aspect,v) <- pVPart cat
          return (cidTTAnt cidTPres cidASimul,pol,voice,aspect,v)
       `mplus`
       do (match convert "VBDZ" `mplus` match convert "VBDR") -- was,were
          pol <- pPol
          (voice,aspect,v) <- pVPart cat
          return (cidTTAnt cidTPast cidASimul,pol,voice,aspect,v)
       `mplus`
       do match convert "VH0" -- have
          pol <- pPol
          (voice,aspect,v) <- do v <- pVPastPart cat
                                 return (Active,Simple,v)
                              `mplus`
                              do match convert "VBN" -- been
                                 pVPart cat
          return (cidTTAnt cidTPres cidAAnter,pol,voice,aspect,v)
       `mplus`
       do match convert "VH0" -- have
          return (cidTTAnt cidTPres cidAAnter,cidPPos,Active,Simple,cidhave_V2)
       `mplus`
       do match convert "VHZ" -- has
          pol <- pPol
          (voice,aspect,v) <- do v <- pVPastPart cat
                                 return (Active,Simple,v)
                              `mplus`
                              do match convert "VBN" -- been
                                 pVPart cat
          return (cidTTAnt cidTPres cidAAnter,pol,voice,aspect,v)
       `mplus`
       do match convert "VHZ" -- has
          return (cidTTAnt cidTPres cidAAnter,cidPPos,Active,Simple,cidhave_V2)
       `mplus`
       do match convert "VHD" -- had
          pol <- pPol
          (voice,aspect,v) <- do v <- pVPastPart cat
                                 return (Active,Simple,v)
                              `mplus`
                              do match convert "VBN" -- been
                                 pVPart cat
          return (cidTTAnt cidTPast cidAAnter,pol,voice,aspect,v)
       `mplus`
       do match convert "VHD" -- had
          return (cidTTAnt cidTPast cidASimul,cidPPos,Active,Simple,cidhave_V2)
       `mplus`
       do w <- word "VMo" -- will
          guard (w == "will")
          pol <- pPol
          (voice,apect,vp) <- pVInf cat
          return (cidTTAnt cidTFut cidASimul,pol,voice,apect,vp)
       `mplus`
       do mplus (match convert "VD0") (match convert "VDZ") -- do,does
          match convert "XX"
          vp <- pVPres cat
          return (cidTTAnt cidTPres cidASimul,cidPNeg,Active,Simple,vp)
       `mplus`
       do match convert "VDD" -- did
          match convert "XX"
          vp <- pVPres cat
          return (cidTTAnt cidTPast cidASimul,cidPNeg,Active,Simple,vp)


pVPInf = do
  adVs <- many pAdV
  (pol,voice,apect,vp) <- do (pol,voice,apect,v2) <- inside "Vi" $
                                                       do pol <- pPol
                                                          match convert "TO"
                                                          (voice,aspect,v) <- pVInf "V2"
                                                          return (pol,voice,aspect,v)
                             o <- pObject
                             return (pol,voice,apect,cidComplSlash (cidSlashV2a v2) o)
                          `mplus`
                          do (pol,voice,apect,v2a) <- inside "Vi" $
                                                        do pol <- pPol
                                                           match convert "TO"
                                                           (voice,aspect,v) <- pVInf "V2A"
                                                           return (pol,voice,aspect,v)
                             o        <- pObject
                             ap       <- pAP
                             return (pol,voice,apect,cidComplSlash (cidSlashV2A v2a ap) o)
  advs <- many pVPMods
  return (pol,voice,apect,
              foldr (\adv t -> cidAdVVP adv t)
                    (foldl (\t adv -> cidAdvVP t adv)
                           vp
                           advs)
                    adVs)

pVInf cat =
  do v <- pVPres cat
     return (Active,Simple,v)
  `mplus`
  do match convert "VB0" -- be
     pVPart cat
  `mplus`
  do v <- match convert "VH0" -- have
     return (Active,Simple,v)

pVPPresPart =
  insideOpt convert "Vg" $ do
    v <- pVPresPart "V"
    return (cidUseV v)

pVPart cat =
  do v <- pVPresPart cat
     return (Active,Progressive,v)
  `mplus`
  do v <- pVPastPart cat
     return (Passive,Simple,v)

pVPres cat =
  do lemma "VV0i" cat "s VInf"
  `mplus`
  do lemma "VV0t" cat "s VInf"
  `mplus`
  do lemma "VV0v" cat "s VInf"

pVPresPart cat =
  do lemma "VVGi" cat "s VPresPart"
  `mplus`
  do lemma "VVGt" cat "s VPresPart"
  `mplus`
  do lemma "VVGv" cat "s VPresPart"

pVPastPart cat =
  do lemma "VVNi" cat "s VPPart"
  `mplus`
  do lemma "VVNt" cat "s VPPart"
  `mplus`
  do lemma "VVNv" cat "s VPPart"

pPol =
  do match convert "XX"
     return cidPNeg
  `mplus`
  do return cidPPos

pAdV =
  do insideOpt convert "R:c" $
       lemma "RRR" "AdV" "s"
  `mplus`
  do insideOpt convert "R:m" $
       lemma "RRR" "AdV" "s"

pObject = 
  match convert "P:u"
  `mplus`
  insideOpt convert "N:o" pNP
  `mplus`
  match convert "N:e"
  `mplus`
  insideOpt convert "M:e" pM
  `mplus`
  do insideOpt convert "Ds:e" $ do
       det <- pDet
       return (cidDetNP (det cidNumSg))
  `mplus`
  do insideOpt convert "Dp:e" $ do
       det <- pDet
       return (cidDetNP (det cidNumPl))
  `mplus`
  do insideOpt convert "P:e" $ pPP

pVPMods =
  do insideOpt convert "N:t" pTimeNPAdv
  `mplus`
  do match convert "N:h"
  `mplus`
  do insideOpt convert "P:p" $ pPP
  `mplus`
  do insideOpt convert "P:q" $ pPP
  `mplus`
  do insideOpt convert "Pb:a" $ do
       match convert "IIb"
       np <- insideOpt convert "N" pNP
       return (cidPrepNP cidby_Prep np)
  `mplus`
  do insideOpt convert "P:t" $ pPP
  `mplus`
  do insideOpt convert "P:h" $ pPP
  `mplus`
  do insideOpt convert "P:m" $ pPP
  `mplus`
  do insideOpt convert "P:r" $ pPP
  `mplus`
  do insideOpt convert "R:p" $ pAdv
  `mplus`
  do insideOpt convert "R:q" $ pAdv
  `mplus`
  do insideOpt convert "R:a" $ pAdv
  `mplus`
  do insideOpt convert "R:t" $ pAdv
  `mplus`
  do insideOpt convert "R:h" $ pAdv
  `mplus`
  do insideOpt convert "R:m" $ pAdv
  `mplus`
  do insideOpt convert "R:c" $ pAdv
  `mplus`
  do insideOpt convert "R:r" $ pAdv
  `mplus`
  do match convert "F:p"
  `mplus`
  do match convert "F:q"
  `mplus`
  do match convert "F:a"
  `mplus`
  do match convert "F:t"
  `mplus`
  do match convert "F:h"
  `mplus`
  do match convert "F:m"
  `mplus`
  do match convert "F:r"
  `mplus`
  do match convert "W:b"
  `mplus`
  do match convert "L:b"

pPP =
  do prep <- do lemma "ICS" "Prep" "s"
             `mplus`
             do lemma "ICSk" "Prep" "s"
             `mplus`
             do lemma "ICSt" "Prep" "s"
             `mplus`
             do lemma "ICSx" "Prep" "s"
             `mplus`
             do lemma "IF" "Prep" "s"
             `mplus`
             do lemma "II" "Prep" "s"
             `mplus`
             do lemma "IIa" "Prep" "s"
             `mplus`
             do lemma "IIb" "Prep" "s"
             `mplus`
             do lemma "IIg" "Prep" "s"
             `mplus`
             do lemma "IIp" "Prep" "s"
             `mplus`
             do lemma "IIt" "Prep" "s"
             `mplus`
             do lemma "IO" "Prep" "s"
             `mplus`
             do lemma "IW" "Prep" "s"
             `mplus`
             do insideOpt convert "II=" $ do
                  w1 <- word "II21"
                  w2 <- word "II22"
                  lookupForm "Prep" "s" (unwords [w1,w2])
     np   <- do insideOpt convert "N" pNP
             `mplus`
             do (mb_num,n) <- pN
                case mb_num of
                  Just num | num == cidNumPl -> return (cidDetCN (cidDetQuant cidIndefArt num) (cidUseN n))
                  _                          -> return (cidMassNP (cidUseN n))    -- we don't know the number
     return (cidPrepNP prep np)

pNP =
  do np <- pBaseNP
     mods <- many pNPMods
     return (foldl (\t mod -> mod t)
                   np
                   mods)
  `mplus`
  do pBaseNP

pBaseNP = 
  do det         <- pDet
     (mb_num,cn) <- pCN
     case mb_num of
       Just num -> return (cidDetCN (det num) cn)
       Nothing  -> mzero    -- we don't know the number
  `mplus`
  do pn <- pName
     return (cidUsePN pn)
  `mplus`
  do (mb_num,cn) <- pCN
     case mb_num of
       Just num | num == cidNumPl -> return (cidDetCN (cidDetQuant cidIndefArt num) cn)
       _                          -> return (cidMassNP cn)    -- we don't know the number     
  `mplus`
  do match convert "PPIS1"
     return (cidUsePron cidi_Pron)
  `mplus`
  do match convert "PPY"
     return (cidUsePron cidyouSg_Pron)
  `mplus`
  do match convert "PPHS1m"
     return (cidUsePron cidhe_Pron)
  `mplus`
  do match convert "PPHS1f"
     return (cidUsePron cidshe_Pron)
  `mplus`
  do match convert "PPH1"
     return (cidUsePron cidit_Pron)
  `mplus`
  do match convert "PPIS2"
     return (cidUsePron cidwe_Pron)
  `mplus`
  do match convert "PPHS2"
     return (cidUsePron cidthey_Pron)
  `mplus`
  do match convert "Nn"

pDet =
  do match convert "DDy"
     return (\num -> if num == cidNumSg
                       then cidanySg_Det
                       else cidanyPl_Det)
  `mplus`
  do det <- lemma "DA2" "Det" "s"
     return (\num -> det)
  `mplus`
  do num0 <- pNumeral
     return (\num -> cidDetQuant cidIndefArt num0)
  `mplus`
  do q   <- pQuant
     ord <- pOrd
     return (\num -> cidDetQuantOrd q num ord)
  `mplus`
  do q      <- pQuant
     mb_num <- opt pNumeral
     return (\num -> cidDetQuant q (fromMaybe num mb_num))

pQuant =
  do match convert "AT"
     return cidDefArt
  `mplus`
  do match convert "AT1"
     return cidIndefArt
  `mplus`
  do match convert "ATn"
     return cidno_Quant
  `mplus`
  do match convert "APPGi1"
     return (cidPossPron cidi_Pron)
  `mplus`
  do match convert "APPGy"
     return (cidPossPron cidyouSg_Pron)
  `mplus`
  do match convert "APPGm"
     return (cidPossPron cidhe_Pron)
  `mplus`
  do match convert "APPGf"
     return (cidPossPron cidshe_Pron)
  `mplus`
  do match convert "APPGh1"
     return (cidPossPron cidit_Pron)
  `mplus`
  do match convert "APPGi2"
     return (cidPossPron cidwe_Pron)
  `mplus`
  do match convert "APPGh2"
     return (cidPossPron cidthey_Pron)
  `mplus`
  do lemma "DD1a" "Quant" "s True Sg"
  `mplus`
  do lemma "DD1i" "Quant" "s True Sg"
  `mplus`
  do lemma "DD2a" "Quant" "s True Pl"
  `mplus`
  do lemma "DD2i" "Quant" "s True Pl"
  `mplus`
  do lemma "DDi" "Quant" "s True Pl"
  `mplus`
  insideOpt convert "G" pGenitive

pOrd =
  do a <- lemma "JJT" "A" "s (AAdj Superl Nom)"
     return (cidOrdSuperl a)

pNumeral =
  do w <- word "MC" `mplus` word "MC1"
     cnc <- getConcr
     case parse cnc "Numeral" w of
       Right [(e,_)] -> do n <- toParseTree e
                           return (cidNumCard (cidNumNumeral n))
       _             -> mzero
  `mplus`
  do w <- word "MCn"
     cnc <- getConcr
     case parse cnc "Digits" w of
       Right [(e,_)] -> do n <- toParseTree e
                           return (cidNumCard (cidNumDigits n))
       _             -> mzero
  where
    toParseTree e = 
      case unApp e of
        Just (f,es) -> do ps <- mapM toParseTree es
                          return (App f ps)
        Nothing     -> mzero

pGenitive =
  do np <- insideOpt convert "N" pNP
     match convert "GG"
     return (cidGenNP np)

pCN =
  do pn <- mplus pName (insideOpt convert "Nn" pName)
     (mb_num,cn) <- pCN
     return (mb_num,cidNameCN pn cn)
  `mplus`
  do (mb_num_n,n) <- mplus pN (inside "N" pCN)
     (mb_num,cn) <- pCN
     case mb_num_n of
       Just num | num == cidNumPl -> return (mb_num,cidCompoundPlCN (cidUseN n) cn)
       _                          -> return (mb_num,cidCompoundSgCN (cidUseN n) cn)  -- here we don't really know the number
  `mplus`
  do ap <- pAP
     (mb_num,cn) <- pCN
     return (mb_num,cidAdjCN ap cn)
  `mplus`
  do t <- match convert "NN1u&"
     mods <- many pCNMods
     return (Just cidNumSg
            ,foldl (\t mod -> mod t)
                   t
                   mods)
  `mplus`
  do (mb_num,n) <- pN
     mods <- many pCNMods
     return (mb_num,
             foldl (\t mod -> mod t)
                   (cidUseN n)
                   mods)

pAP =
  do a <-  lemma "JJ" "A" "s (AAdj Posit Nom)"
           `mplus`
           lemma "JA" "A" "s (AAdj Posit Nom)"
           `mplus`
           lemma "JB" "A" "s (AAdj Posit Nom)"
           `mplus`
           lemma "JBo" "A" "s (AAdj Posit Nom)"
           `mplus`
           lemma "DAy" "A" "s (AAdj Posit Nom)"
           `mplus`
           lemma "DAz" "A" "s (AAdj Posit Nom)"
     return (cidPositA a)
  `mplus`
  do a <-  lemma "JJR" "A" "s (AAdj Compar Nom)"
     return (cidUseComparA a)
  `mplus`
  do vp <- match convert "Tn"
     return (cidPastPartAP vp)
  `mplus`
  do vp <- insideOpt convert "Tg" pVPPresPart
     return (cidPresPartAP vp)
  `mplus`
  do insideOpt convert "J" $ do
       adas <- many pAdA
       ap <- pAP
       mods <- many pAPMods
       return (foldl (\t ada -> cidAdAP ada t)
                     (foldl (\t mod -> cidAdvAP t mod)
                            ap
                            mods)
                     adas)

pAdA = do
  a <- lemma "RR" "A" "s AAdv"
  return (cidPositAdAAdj a)

pAPMods =
  do insideOpt convert "P" pPP

pN =
  do n <- lemma "NNn" "N" "s Sg Nom"
     return (Nothing, n)
  `mplus`
  do n <- lemma "NNu" "N" "s Sg Nom"
     return (Just cidNumPl, n)
  `mplus`
  do n <- lemma "NNux" "N" "s Sg Nom"
     return (Nothing, n)
  `mplus`
  do n <- lemma "NN1c" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NN1m" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NN1n" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NN1u" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NN1ux" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NN2" "N" "s Pl Nom"
     return (Just cidNumPl, n)
  `mplus`
  do n <- lemma "NNJ1c" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NNJ1n" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NNJ2" "N" "s Pl Nom"
     return (Just cidNumPl, n)
  `mplus`
  do n <- lemma "NNLc" "N" "s Sg Nom"
     return (Nothing, n)
  `mplus`
  do n <- lemma "NNL1c" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NNL1cb" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NNL1n" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NNL2" "N" "s Pl Nom"
     return (Just cidNumPl, n)
  `mplus`
  do n <- lemma "NNS1c" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NNS1n" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NNS2" "N" "s Pl Nom"
     return (Just cidNumPl, n)
  `mplus`
  do n <- lemma "NNT1h" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NNT1m" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NNT1c" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NNT2" "N" "s Pl Nom"
     return (Just cidNumPl, n)
  `mplus`
  do n <- lemma "NNUc" "N" "s Sg Nom"
     return (Nothing, n)
  `mplus`
  do n <- lemma "NNUn" "N" "s Sg Nom"
     return (Nothing, n)
  `mplus`
  do n <- lemma "NNU1c" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NNU1n" "N" "s Sg Nom"
     return (Just cidNumSg, n)
  `mplus`
  do n <- lemma "NNU2" "N" "s Pl Nom"
     return (Just cidNumPl, n)
  `mplus`
  do inside "Ns" $ do
       (mb_num1,n1) <- pN
       match convert "YH"
       (mb_num2,n2) <- pN
       case mb_num1 of
         Just num | num == cidNumPl -> return (mb_num2,cidDashPlN n1 n2)
         _                          -> return (mb_num2,cidDashSgN n1 n2)  -- here we don't really know the number

pCNMods =
  do adv <- insideOpt convert "Po" $ pPP
     return (\t -> cidAdvCN t adv)
  `mplus`
  do adv <- insideOpt convert "P" $ pPP
     return (\t -> cidAdvCN t adv)
  `mplus`
  do adv <- insideOpt convert "Fn" $ do
              match convert "CST"
              s <- pS
              return (cidSubjS cidthat_Subj s)
     return (\t -> cidAdvCN t adv)
  `mplus`
  do fr <- insideOpt convert "Fr" pRS
     return (\t -> cidRelCN t fr)

pNPMods =
  do adv <- insideOpt convert "Po" $ pPP
     return (\t -> cidAdvNP t adv)
  `mplus`
  do adv <- insideOpt convert "P" $ pPP
     return (\t -> cidAdvNP t adv)
  `mplus`
  do adv <- insideOpt convert "Fn" $ do
              match convert "CST"
              s <- pS
              return (cidSubjS cidthat_Subj s)
     return (\t -> cidAdvNP t adv)
  `mplus`
  do match convert "YC"
     adv <- insideOpt convert "Po" $ pPP
     opt (match convert "YC")
     return (\t -> cidExtAdvNP t adv)
  `mplus`
  do match convert "YC"
     adv <- insideOpt convert "P" $ pPP
     opt (match convert "YC")
     return (\t -> cidExtAdvNP t adv)
  `mplus`
  do match convert "YC"
     adv <- insideOpt convert "Fn" $ do
              match convert "CST"
              s <- pS
              return (cidSubjS cidthat_Subj s)
     opt (match convert "YC")
     return (\t -> cidExtAdvNP t adv)
  `mplus`
  do match convert "YC"
     fr <- insideOpt convert "Fr" pRS
     opt (match convert "YC")
     return (\t -> cidRelNP t fr)

pName =
  do w1 <- word "NP1s"
     w2 <- word "NNL1cb"
     return (cidSymbPN (cidMkSymb (Lit (unwords [w1,w2]))))
  `mplus`
  do w1 <- word "NPM1"
     match convert "YH"
     w2 <- word "NPM1"
     return (cidSymbPN (cidMkSymb (Lit (unwords [w1,"-",w2]))))
  `mplus`
  do w1 <- msum [word "NP1c", word "NP1f", word "NP1g"
                ,word "NP1j", word "NP1m", word "NP1p"
                ,word "NP1s", word "NP1t", word "NP1x"
                ,word "NP1z", word "NP2c", word "NP2f"
                ,word "NP2g", word "NP2j", word "NP2m"
                ,word "NP2p", word "NP2s", word "NP2t"
                ,word "NP2x", word "NP2z"]
     return (cidSymbPN (cidMkSymb (Lit w1)))

pM = do
  num <- pNumeral
  mods <- many pNPMods
  return (foldl (\t mod -> mod t)
                (cidDetNP (cidDetQuant cidIndefArt num))
                mods)

pRS = 
  do rp <- pRP
     np <- pSubject
     (t,p,vp) <- pVP
     return (cidUseRCl t p (cidRelSlash rp (cidSlashVP np vp)))
  `mplus`
  do rp <- pRP
     (t,p,vp) <- pVP
     opt (match convert "YC")
     return (cidUseRCl t p (cidRelVP rp vp))
  `mplus`
  do (prep,rp) <- inside "Pq" $ do
                    prep <- lemma "II" "Prep" "s"
                    rp   <- pRP
                    return (prep,rp)
     np <- pSubject
     (t,p,vp) <- pVP
     opt (match convert "YC")
     return (cidUseRCl t p (cidRelSlash rp (cidSlashVP np (cidVPSlashPrep vp prep))))

pRP = 
  do inside "Dq" (match convert "DDQr")
     return cidIdRP

pTimeNPAdv = do
  day <- lemma "NPD1" "Weekday" "s Sg Nom"
  return (cidweekdayPunctualAdv day)
