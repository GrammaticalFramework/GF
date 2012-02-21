-- [1416,4467,4623,4871,4561,4303,3763,3137,2501,1857,1353,952,646,483,332,200,116,89,54,41,20,22,7,2,4,5,0,3,2,1,0,0,0,0,0,1]
-- average 5

import Monad
import Idents
import PennFormat

import PGF hiding (Tree,parse)
import Control.Monad
import System.IO
import System.Process
import Data.Maybe
import Data.List
import Data.IORef
import Data.Char
import Data.Tree

test = False

main = do
  pgf <- readPGF "ParseEngAbs.pgf"
  let Just language = readLanguage "ParseEng"
      morpho        = buildMorpho pgf language
  s <- readFile "wsj.02-21"
  ref <- newIORef (0,0,0)
  mapM_ (process pgf morpho ref) ((if test then take 40 else id) (parseTreebank s))
  where
    process pgf morpho ref t = do
      (cn,co,l) <- readIORef ref
      let e         = (flatten . parse penn pgf morpho . prune) t
          (cn',co') = count (cn,co) e
          l'        = l+1
      writeIORef ref (cn',co',l')
      hPutStrLn stdout (showExpr [] e)
      when test $ do
        writeFile ("tmp_tree.dot") (graphvizAbstractTree pgf (True,False) e)
        rawSystem "dot" ["-Tpdf", "tmp_tree.dot", "-otrees/tree"++showAlign l'++".pdf"]
        return ()
      hPutStrLn stderr (show ((fromIntegral cn' / fromIntegral co') * 100))

    count (cn,co) e = cn `seq` co `seq`
      case unApp e of
        Just (f,es) -> if f == meta
                         then foldl' count (cn,  co+1) es
                         else foldl' count (cn+1,co+1) es
        Nothing     -> (cn+1,co+1)


    showAlign n =
      replicate (5 - length s) '0' ++ s
      where
        s = show n

    prune (Node tag ts)
      |   tag == "S" 
       && not (null ts)
       && last ts == Node "." [Node "." []] = Node tag (init ts)
      | otherwise                           = Node tag ts
      
    flatten e =
      case unApp e of
        Just (f,es) | f == meta -> mkApp f (concatMap grab es)
                    | otherwise -> mkApp f (map flatten es)
        Nothing                 -> e

    grab e =
      case unApp e of
        Just (f,es) | f == meta -> concatMap grab es
                    | otherwise -> [mkApp f (map flatten es)]
        Nothing                 -> []


penn :: Grammar String Expr
penn =
  grammar (mkApp meta) 
   [ "ADVP":-> do adv <- cat "RB"
                  case unApp adv of
                    Just (f,[a]) | f == cidPositAdvAdj -> return (mkApp cidPositAdVAdj [a])
                    _                                  -> mzero
               `mplus`
               do adV <- inside "RB" (lemma "AdV" "s")
                  return (mkApp adV [])
   , "ADJP":-> do adas <- many pAdA
                  v <- inside "JJ" (lemma "V2" "s VPPart")
                  pps <- many (cat "PP")
                  let adj  = mkApp cidPastPartAP [mkApp v []]
                      ap0  = foldr (\ada ap -> mkApp cidAdAP [ada,ap]) adj adas
                      ap   = foldr (\pp ap -> mkApp cidAdvAP [ap,pp]) ap0 pps
                  return ap
               `mplus`
               do adas0 <- many pAdA
                  adjs  <- many1 (cat "JJ")
                  let adj  = last adjs
                      adas = adas0 ++ [mkApp cidPositAdAAdj [adj] | adj <- init adjs]
                      ap   = foldr (\ada ap -> mkApp cidAdAP [ada,ap]) (mkApp cidPositA [adj]) adas
                  return ap
   , "S"   :-> do advs <- many $ do pp <- cat "PP"
                                    inside "," word
                                    return pp
                                 `mplus`
                                 do cat "ADVP"                  
                  e0 <- do (tmp,pol,sl,e) <- pClSlash
                           guard (not sl)
                           return (mkApp cidUseCl [tmp,pol,e])
                        `mplus`
                        do s <- cat "S"
                           inside "," word
                           np <- cat "NP"
                           inside "VP" $ do
                             (t,v) <- pV "VS"
                             inside "SBAR" $ do
                               cat "-NONE-"
                               inside "S" $ do
                                 cat "-NONE-"
                             return (mkApp cidUseCl [mkApp cidTTAnt [ mkApp (fromMaybe meta (isVTense t)) []
                                                                    , mkApp cidASimul []
                                                                    ]
                                                    ,mkApp cidPPos []
                                                    ,mkApp cidComplPredVP [np,mkApp cidComplVS [mkApp v [],s]]
                                                    ])
                  opt (inside "." word) ""
                  return (foldr (\ad e -> mkApp cidAdvS [ad, e]) e0 advs)
                `mplus`
                do s1 <- cat "S"
                   opt (inside "," word) ""
                   cc <- cat "CC"
                   s2 <- cat "S"
                   return (mkApp cidConjS [cc, mkApp cidBaseS [s1,s2]])
   , "SBAR" :-> do (do cat "-NONE-"    -- missing preposition
                       return ()
                    `mplus`
                    do w <- inside "IN" word
                       guard (w == "that"))
                   cat "S"
   , "NP"  :-> do (m_cc,list_np) <- pBaseNPs
                  case m_cc of
                    Just cc -> return (mkApp cidConjNP [cc, mkListNP list_np])
                    Nothing -> if length list_np > 1
                                 then return (mkApp meta list_np)
                                 else return (head list_np)
               `mplus`
               do np <- cat "NP"
                  rs <- inside "SBAR" $
                          do rp <- cat "WHNP"
                             inside "S" $
                               do (tmp,pol,sl,e) <- pClSlash
                                  guard sl
                                  return (mkApp cidUseRCl [tmp,pol,mkApp cidRelSlash [rp,e]])
                               `mplus`
                               do inside "NP" (cat "-NONE-")
                                  (tmp,pol,sl,vp) <- inside "VP" pVP
                                  guard (not sl)
                                  return (mkApp cidUseRCl [fromMaybe (mkApp meta []) (isVTense tmp)
                                                          ,mkApp pol []
                                                          ,mkApp cidRelVP [rp,vp]])
                  return (mkApp cidRelNP [np,rs])
               `mplus`
               do (m_cc,list_np) <- pNPs
                  case m_cc of
                    Just cc -> return (mkApp cidConjNP [cc, mkListNP list_np])
                    Nothing -> if length list_np > 1
                                 then return (mkApp meta list_np)
                                 else return (head list_np)
   , "VP"  :-> do (_,_,_,e) <- pVP
                  return e
   , "PP"  :-> do prep <- do cat "IN"
                          `mplus`
                          do inside "TO" word
                             return (mkApp cidto_Prep [])
                          `mplus`
                          do w1 <- inside "JJ" word
                             w2 <- inside "IN" word
                             guard (w1 == "such" && w2 == "as")
                             return (mkApp cidsuch_as_Prep [])
                  np   <- cat "NP"
                  return (mkApp cidPrepNP [prep,np])
               `mplus`
               do pp1 <- cat "PP"
                  inside "," word
                  conj <- cat "CC"
                  pp2 <- cat "PP"
                  opt (inside "," word) ""
                  return (mkApp cidConjAdv [conj, mkApp cidBaseAdv [pp1,pp2]])
   , "CC"  :-> do cc <- word
                  case cc of
                    "and" -> return (mkApp cidand_Conj [])
                    "&"   -> return (mkApp cidamp_Conj [])
                    "or"  -> return (mkApp cidor_Conj  [])
                    _     -> mzero
   , "DT"  :-> do (dt,b) <- pDT
                  return dt
   , "IN"  :-> do prep <- lemma "Prep" "s"
                  return (mkApp prep [])
   , "NN"  :-> do transform (concatMap splitDashN)
                  (do n <- lemma "N" "s Sg Nom"
                      (do inside "-" word
                          n2 <- lemma "N" "s Sg Nom"
                          return (mkApp cidDashCN [mkApp n [], mkApp n2 []])
                       `mplus`
                       do return (mkApp n [])))
               `mplus`
               do v <- lemma "V" "s VPresPart"
                  return (mkApp cidGerundN [mkApp v []])
   , "NNS" :-> do transform (concatMap splitDashN)
                  (do n <- lemma "N" "s Pl Nom"
                      return (mkApp n [])
                   `mplus`
                   do n1 <- lemma "N" "s Sg Nom"
                      inside "-" word
                      n2 <- lemma "N" "s Pl Nom"
                      return (mkApp cidDashCN [mkApp n1 [], mkApp n2 []]))
   , "PRP" :-> do p <- (lemma "Pron" "s (NCase Nom)"
                        `mplus`
                        lemma "Pron" "s NPAcc"
                        `mplus`
                        (do w <- word
                            guard (w == "I")   -- upper case word
                            return cidi_Pron))
                  return (mkApp p [])
   , "PRP$":-> do p <- lemma "Pron" "s (NCase Gen)"
                  return (mkApp cidPossPron [mkApp p []])
   , "RB"  :-> do a <- lemma "A" "s AAdv"
                  return (mkApp cidPositAdvAdj [mkApp a []])
               `mplus`
               do adv <- lemma "Adv" "s"
                  return (mkApp adv [])
   , "QP"  :-> do adn <- inside "IN" (lemma "AdN" "s")
                  num <- pCD
                  return (mkApp cidDetQuant [mkApp cidIndefArt [], mkApp cidNumCard [mkApp cidAdNum [mkApp adn [], num]]])
   , "WHNP":-> cat "WP"
               `mplus`
               cat "WDT"
               `mplus`
               cat "WP$"
               `mplus`
               do cat "-NONE-"
                  return (mkApp cidno_RP [])
               `mplus`
               do w <- inside "IN" word
                  guard (w == "that")
                  return (mkApp cidthat_RP [])
   , "-NONE-"
           :-> return (mkApp meta [])
   , "JJ"  :-> do a <- lemma "A" "s (AAdj Posit Nom)"
                  return (mkApp a [])
   , "JJR" :-> do a <- lemma "A" "s (AAdj Compar Nom)"
                  return (mkApp a [])
   , "JJS" :-> do a <- lemma "A" "s (AAdj Superl Nom)"
                  return (mkApp cidOrdSuperl [mkApp a []])
   , "VB"  :-> do v <- mplus (lemma "V" "s VInf")  (lemma "V2" "s VInf")
                  return (mkApp v [])
   , "VBD" :-> do v <- mplus (lemma "V" "s VPast") (lemma "V2" "s VPast")
                  return (mkApp v [])
   , "VBG" :-> do v <- mplus (lemma "V" "s VPresPart") (lemma "V2" "s VPresPart")
                  return (mkApp v [])
   , "VBN" :-> do v <- mplus (lemma "V" "s VPPart") (lemma "V2" "s VPPart")
                  return (mkApp v [])
   , "VBP" :-> do v <- mplus (lemma "V" "s VInf") (lemma "V2" "s VInf")
                  return (mkApp v [])
   , "VBZ" :-> do v <- mplus (lemma "V" "s VPres") (lemma "V2" "s VPres")
                  return (mkApp v [])
   , "PDT" :-> do pdt <- lemma "Predet" "s"
                  return (mkApp pdt [])
   , "WP"  :-> do rp <- (lemma "RP" "s (RC Masc (NCase Nom))"
                         `mplus`
                         lemma "RP" "s (RC Masc NPAcc)")
                  return (mkApp rp [])
   , "WDT" :-> do rp <- lemma "RP" "s (RC Neutr (NCase Nom))"
                  return (mkApp rp [])
   , "WP$" :-> do rp <- lemma "RP" "s (RC Masc (NCase Gen))"
                  return (mkApp rp [])
   ]

data VForm a
  = VInf | VPart | VGerund | VTense a

instance Functor VForm where
  fmap f VInf       = VInf
  fmap f VPart      = VPart
  fmap f VGerund    = VGerund
  fmap f (VTense t) = VTense (f t)

isVInf VInf = True
isVInf _    = False

isVPart VPart = True
isVPart _     = False

isVGerund VGerund = True
isVGerund _       = False

isVTense (VTense t) = Just t
isVTense _          = Nothing


pVP = do
  (t,a,p,sl,e0) <- do t <- pCopula
                      p <- pPol
                      inside "VP" $ do
                        advs <- many (cat "ADVP")
                        (t',p',sl,e0) <- pVP
                        guard (isVPart t' && sl && p' == cidPPos)
                        let e1 = mkApp cidPassVPSlash [e0]
                            e2 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e1 advs
                        return (t,cidASimul,p,False,e2)
                   `mplus`
                   do t <- pCopula
                      p <- pPol
                      advs <- many (cat "ADVP")
                      e <- do e <- cat "ADJP"
                              return (mkApp cidCompAP [e])
                           `mplus`
                           do e <- cat "NP"
                              return (mkApp cidCompNP [e])
                           `mplus`
                           do e <- cat "NP"
                              return (mkApp cidCompNP [e])
                           `mplus`
                           do e <- cat "PP"
                              return (mkApp cidCompAdv [e])
                           `mplus`
                           do e <- cat "SBAR"       
                              return (mkApp cidCompS [e])
                           `mplus`
                           do e <- inside "S" $ do
                                      inside "NP" (cat "-NONE-")
                                      (tmp,pol,sl,e) <- inside "VP" pVP
                                      guard (isVInf tmp && not sl && pol == cidPPos)
                                      return e
                              return (mkApp cidCompVP [e])
                      let e1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) (mkApp cidUseComp [e]) advs
                      return (t,cidASimul,p,False,e1)
                   `mplus`
                   do t <- pCopula
                      p <- pPol
                      advs <- many (cat "ADVP")
                      (tmp,pol,sl,e) <- inside "VP" pVP
                      guard (isVGerund tmp && not sl && pol == cidPPos)
                      let e1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e advs
                      return (t,cidASimul,p,False,mkApp cidProgrVP [e1])
                   `mplus`
                   do t <- pCopula
                      p <- pPol
                      adv <- cat "ADVP"
                      return (t,cidASimul,p,False,mkApp cidUseComp [mkApp cidCompAdv [adv]])
                   `mplus`
                   do w <- inside "MD" word
                      t <- case w of
                             "will"  -> return cidTFut
                             "would" -> return cidTCond
                             _       -> mzero
                      p <- pPol
                      advs <- many (cat "ADVP")
                      (tmp,pol,sl,e0) <- inside "VP" pVP
                      guard (isVInf tmp && pol == cidPPos)
                      let e1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e0 advs
                      return (VTense t,cidASimul,p,sl,e1)
                   `mplus`
                   do t <- pHave
                      p <- pPol
                      advs   <- many (cat "ADVP")
                      (tmp,pol,sl,e0) <- inside "VP" pVP
                      guard (isVPart tmp && pol == cidPPos)
                      let e1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e0 advs
                      return (t,cidAAnter,p,sl,e1)
                   `mplus`
                   do t <- pDo
                      p <- pPol
                      advs <- many (cat "ADVP")
                      (tmp,p',sl,e0) <- inside "VP" $ pVP
                      guard (p' == cidPPos)
                      let e1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e0 advs
                      return (t,cidASimul,p,sl,e1)
                   `mplus`
                   do advs <- many (cat "ADVP")
                      inside "TO" word                        -- infinitives
                      e0 <- cat "VP"
                      let e1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e0 advs
                      return (VInf,cidASimul,cidPPos,False,e1)
                   `mplus`
                   do advs1 <- many (cat "ADVP")
                      (t,v) <- pV "V2"
                      pps   <- many (cat "PP")
                      let e0 = mkApp cidSlashV2a [mkApp v []]
                          e1 = foldl (\e pp -> mkApp cidAdvVPSlash [e, pp]) e0 pps
                      (sl,e2) <- (do (inside "NP" (cat "-NONE-")
                                      `mplus`
                                      inside "SBAR" (cat "-NONE-"))
                                     return (True,e1)
                                  `mplus`
                                  do np <- cat "NP"
                                     return (False,mkApp cidComplSlash [e1, np]))
                      let e3 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e2 advs1
                      return (t,cidASimul,cidPPos,sl,e3)
                   `mplus`
                   do (t,v) <- inside "MD" $
                                 (do v <- lemma "VV" "s (VVF VPres)"
                                     return (cidTPres,v)
                                  `mplus`
                                  do v <- lemma "VV" "s (VVF VPast)"
                                     return (cidTPast,v))
                      p <- pPol
                      advs <- many (cat "ADVP")
                      vp <- cat "VP"
                      let e0 = mkApp cidComplVV [mkApp v [], vp]
                          e1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e0 advs
                      return (VTense t,cidASimul,p,False,e1)
                   `mplus`
                   do advs <- many (cat "ADVP")
                      (t,v) <- pVV
                      vp    <- inside "S" $ do
                                  inside "NP" (cat "-NONE-")
                                  (tmp,pol,sl,e) <- inside "VP" pVP
                                  guard ((isVInf tmp || isVGerund tmp) && not sl && pol == cidPPos)
                                  return e
                      let e0 = mkApp cidComplVV [mkApp v [], vp]                          
                          e1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e0 advs
                      return (t,cidASimul,cidPPos,False,e1)
                   `mplus`
                   do advs <- many (cat "ADVP")
                      (t,v) <- pV "V2V"
                      inside "S" $ 
                        (do inside "NP" (cat "-NONE-")
                            (tmp,pol,sl,vp) <- inside "VP" pVP
                            guard (isVInf tmp && not sl)
                            let e0 = mkApp cidSlashV2V [mkApp v [], mkApp pol [], vp]
                                e1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e0 advs
                            return (t,cidASimul,cidPPos,True,e1)
                         `mplus`
                         do np <- cat "NP"
                            (tmp,pol,sl,vp) <- inside "VP" pVP
                            guard (isVInf tmp && not sl)
                            let e0 = mkApp cidComplSlash [mkApp cidSlashV2V [mkApp v [], mkApp pol [], vp], np]
                                e1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e0 advs
                            return (t,cidASimul,cidPPos,False,e1))
                   `mplus`
                   do advs <- many (cat "ADVP")
                      (t,v) <- pV "VA"
                      adjp  <- cat "ADJP"
                      let e0 = mkApp cidComplVA [mkApp v [], adjp]
                          e1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e0 advs
                      return (t,cidASimul,cidPPos,False,e1)
                   `mplus`
                   do advs <- many (cat "ADVP")
                      (t,v) <- pV "VS"
                      s     <- cat "S" `mplus` cat "SBAR"
                      let e0 = mkApp cidComplVS [mkApp v [], s]
                          e1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e0 advs
                      return (t,cidASimul,cidPPos,False,e1)
                   `mplus`
                   do advs <- many (cat "ADVP")
                      (t,v) <- pV "V"
                      let e0 = mkApp cidUseV [mkApp v []]
                          e1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) e0 advs
                      return (t,cidASimul,cidPPos,False,e1)
  pps <- many (cat "PP"
               `mplus`
               inside "ADVP" (cat "RB"))
  let tmp = fmap (\t -> mkApp cidTTAnt [mkApp t [],mkApp a []]) t
      e1  = foldl (\e pp -> mkApp (if sl then cidAdvVPSlash else cidAdvVP) [e, pp]) e0 pps
  return (tmp, p, sl, e1)

pClSlash = do np <- cat "NP"
              advs <- many (cat "ADVP")
              (tmp,pol,sl,vp) <- do (tmp,pol,sl,vp) <- inside "VP" pVP
                                    return (isVTense tmp,pol,sl,vp)
                                 `mplus`
                                 do vp <- cat "VP"
                                    return (Nothing,meta,False,vp)
              let vp1 = foldr (\pp e -> mkApp cidAdVVP [pp, e]) vp advs
              return (fromMaybe (mkApp meta []) tmp
                     ,mkApp pol []
                     ,sl
                     ,mkApp (if sl then cidSlashVP else cidPredVP) [np,vp1]
                     )

pV cat =
  do v <- lookup "VB" "s VInf"
     return (VInf,v)
  `mplus`
  do v <- lookup "VBP" "s VInf"
     return (VTense cidTPres,v)
  `mplus`
  do v <- lookup "VBZ" "s VPres"
     return (VTense cidTPres,v)
  `mplus`
  do v <- lookup "VBD" "s VPast"
     return (VTense cidTPast,v)
  `mplus`
  do v <- lookup "VBN" "s VPPart"
     return (VPart,v)
  `mplus`
  do v <- lookup "VBG" "s VPresPart"
     return (VGerund,v)
  where
    lookup pos fld = 
       inside pos $
         (do lemma cat fld
          `mplus`
          do w <- word
             return (mkCId ("["++w++"_"++cat++"]")))

pVV =
  do v <- lookup "VB" "s (VVF VInf)"
     return (VInf,v)
  `mplus`
  do v <- lookup "VBP" "s (VVF VInf)"
     return (VTense cidTPres,v)
  `mplus`
  do v <- lookup "VBZ" "s (VVF VPres)"
     return (VTense cidTPres,v)
  `mplus`
  do v <- lookup "VBD" "s (VVF VPast)"
     return (VTense cidTPast,v)
  `mplus`
  do v <- lookup "VBN" "s (VVF VPPart)"
     return (VPart,v)
  `mplus`
  do v <- lookup "VBG" "s (VVF VPresPart)"
     return (VGerund,v)
  where
    lookup pos fld = 
       inside pos $
         (do lemma "VV" fld
          `mplus`
          do w <- word
             return (mkCId ("["++w++"_VV]")))

pCopula =
  do s <- inside "VB" word
     guard (s == "be")
     return VInf
  `mplus`
  do s <- inside "VBP" word
     guard (s == "am" || s == "'m" || s == "are" || s == "'re")
     return (VTense cidTPres)
  `mplus`
  do s <- inside "VBZ" word
     guard (s == "is" || s == "'s")
     return (VTense cidTPres)
  `mplus`
  do s <- inside "VBD" word
     guard (s == "were" || s == "was")
     return (VTense cidTPast)
  `mplus`
  do s <- inside "VBN" word
     guard (s == "been")
     return VPart
  `mplus`
  do s <- inside "VBG" word
     guard (s == "being")
     return VGerund

pDo =
  do s <- inside "VB" word
     guard (s == "do")
     return VInf
  `mplus`
  do s <- inside "VBP" word
     guard (s == "do")
     return (VTense cidTPres)
  `mplus`
  do s <- inside "VBZ" word
     guard (s == "does")
     return (VTense cidTPres)
  `mplus`
  do s <- inside "VBD" word
     guard (s == "did")
     return (VTense cidTPast)

pHave =
  do s <- inside "VB" word
     guard (s == "have")
     return VInf
  `mplus`
  do s <- inside "VBP" word
     guard (s == "have")
     return (VTense cidTPres)
  `mplus`
  do s <- inside "VBZ" word
     guard (s == "has")
     return (VTense cidTPres)
  `mplus`
  do s <- inside "VBD" word
     guard (s == "had")
     return (VTense cidTPast)
  `mplus`
  do s <- inside "VBN" word
     guard (s == "had")
     return VPart

pPol =
  do w <- inside "RB" word
     guard (w == "n't" || w == "not")
     return cidPNeg
  `mplus`
  do return cidPPos

pBaseNP = 
  do np <- inside "NN" (lemma "NP" "s (NCase Nom)")
     return (mkApp np [])
  `mplus`
  do m_pdt <- opt (liftM Just (cat "PDT")) Nothing
     m_q   <- opt (liftM Just pQuant) Nothing
     m_num <- opt (liftM Just pCD   ) Nothing
     m_ord <- opt (liftM Just (cat "JJS")) Nothing
     adjs  <- many pModCN
     ns    <- many1 (mplus (cat "NN"  >>= \n -> return (n,cidNumSg)) 
                           (cat "NNS" >>= \n -> return (n,cidNumPl)))
     let (n,s) = last ns
         cn0   = foldr (\(n,s) e -> mkApp cidCompoundCN [mkApp s [], n, e])
                       (mkApp cidUseN [n])
                       (init ns)
         cn    = foldr (\adj e -> mkApp cidAdjCN [adj, e]) 
                       cn0
                       adjs
         num   = maybe (mkApp s []) (\n -> mkApp cidNumCard [n]) m_num
         
         mkDetQuant q num =
           case m_ord of
             Just ord -> mkApp cidDetQuantOrd [q,num,ord]
             Nothing  -> mkApp cidDetQuant    [q,num]

     e0 <- if s == cidNumSg
             then case m_q of
                    Just (q,True)  -> return (mkApp cidDetCN [mkDetQuant q num,cn])
                    Just (q,False) -> return (mkApp cidDetCN [q,cn])
                    Nothing        -> do guard (isNothing m_num)
                                         return (mkApp cidMassNP [cn])
             else case m_q of
                    Just (q,True)  -> return (mkApp cidDetCN [mkDetQuant q num,cn])
                    Just (q,False) -> return (mkApp cidDetCN [q,cn])
                    Nothing        -> return (mkApp cidDetCN [mkDetQuant (mkApp cidIndefArt []) num,cn])
     let e1 = case m_pdt of
                Just pdt -> mkApp cidPredetNP [pdt,e0]
                Nothing  -> e0
     return e1
  `mplus`
  do dt <- cat "QP"
     n  <- mplus (cat "NN") (cat "NNS")
     return (mkApp cidDetCN [dt,mkApp cidUseN [n]])
  `mplus`
  do m_q <- opt (liftM Just pQuant) Nothing
     ws2 <- many1 (inside "NNP" word `mplus` inside "NNPS" word)
     let e0 = mkApp cidSymbPN
                    [mkApp cidMkSymb 
                           [mkStr (unwords ws2)]]
     case m_q of
       Just (q,b) -> do guard b
                        return (mkApp cidUseQuantPN [q,e0])
       Nothing    -> return (mkApp cidUsePN      [e0])
  `mplus`
  do p <- inside "PRP" (lemma "NP" "s (NCase Nom)")
     return (mkApp p [])
  `mplus`
  do p <- cat "PRP"
     return (mkApp cidUsePron [p])
  `mplus`
  do np   <- cat "NP"
     pps  <- many1 (cat "PP")
     prns <- many  (cat "PRN")
     let e0 = foldl (\e pp -> mkApp cidAdvNP [e, pp]) np pps
         e1 = foldl (\e pn -> mkApp meta     [e, pn]) e0 prns
     return e1
  `mplus`
  do np <- cat "NP"
     inside "," word
     (t',p',sl,vp) <- inside "VP" pVP
     guard (isVPart t' && sl && p' == cidPPos)
     inside "," word
     return (mkApp meta [np, vp])
  `mplus`
  do (q,b) <- pQuant
     return (mkApp cidDetNP [if b
                               then mkApp cidDetQuant [mkApp cidIndefArt [],mkApp cidNumSg []]
                               else q])
  `mplus`
  do n <- pCD
     return (mkApp cidDetNP [mkApp cidDetQuant [mkApp cidIndefArt [],mkApp cidNumCard [n]]])

pBaseNPs = do
  np <- pBaseNP
  (do inside "," word
      (m_cc,nps) <- pBaseNPs
      return (m_cc   ,np:nps)
   `mplus`
   do cc  <- cat "CC"
      np2 <- pBaseNP
      return (Just cc,[np,np2])
   `mplus`
   do return (Nothing,[np]))

pNPs = do
  (t1,t2) <- do w <- inside "DT" word
                case map toLower w of
                  "both"   -> return (mkApp cidand_Conj [],mkApp cidboth7and_DConj [])
                  "either" -> return (mkApp cidor_Conj [],mkApp cideither7or_DConj [])
                  _        -> mzero
             `mplus`
             do return (mkApp meta [],mkApp meta [])
  (m_cc,nps) <- pList
  return (fmap (toDConj t1 t2) m_cc,nps)
  where
    toDConj t1 t2 cc
      | cc == t1  = t2
      | otherwise = cc

    pList = do
      np <- cat "NP"
      (do inside "," word
          (m_cc,nps) <- pList
          return (m_cc   ,np:nps)
       `mplus`
       do cc  <- cat "CC"
          np2 <- cat "NP"
          return (Just cc,[np,np2])
       `mplus`
       do return (Nothing,[np]))

mkListNP nps0 =
  foldr (\np1 np2 -> mkApp cidConsNP [np1,np2]) (mkApp cidBaseNP nps2) nps1
  where
    (nps1,nps2) = splitAt (length nps0-2) nps0

pModCN =
  do v <- inside "VBN" (lemma "V2" "s VPPart")
     return (mkApp cidPastPartAP [mkApp v []])
  `mplus`
  do v <- inside "JJ" (lemma "V2" "s VPPart")
     return (mkApp cidPastPartAP [mkApp v []])
  `mplus`
  do v <- inside "JJ" (lemma "V" "s VPresPart")
     return (mkApp cidGerundAP [mkApp v []])
  `mplus`
  do a <- cat "JJ"
     return (mkApp cidPositA [a])
  `mplus`
  do a <- cat "ADJP"
     return a

pCD = 
  do w0 <- inside "CD" word
     let w = filter (/=',') w0
     guard (not (null w) && all isDigit w)
     let es = [mkApp (mkCId ("D_"++[d])) [] | d <- w]
         e0 = foldr (\e1 e2 -> mkApp cidIIDig [e1,e2]) (mkApp cidIDig [last es]) (init es)
         e1 = mkApp cidNumDigits [e0]
     return e1
  `mplus`
  do w <- inside "CD" word
     e <- case map toLower w of
            "one"   -> return (mkApp cidnum [mkApp cidpot2as3 [mkApp cidpot1as2 [mkApp cidpot0as1 [mkApp cidpot01 []]]]])
            "two"   -> return (mkApp cidnum [mkApp cidpot2as3 [mkApp cidpot1as2 [mkApp cidpot0as1 [mkApp cidpot0 [mkApp cidn2 []]]]]])
            "three" -> return (mkApp cidnum [mkApp cidpot2as3 [mkApp cidpot1as2 [mkApp cidpot0as1 [mkApp cidpot0 [mkApp cidn3 []]]]]])
            "four"  -> return (mkApp cidnum [mkApp cidpot2as3 [mkApp cidpot1as2 [mkApp cidpot0as1 [mkApp cidpot0 [mkApp cidn4 []]]]]])
            "five"  -> return (mkApp cidnum [mkApp cidpot2as3 [mkApp cidpot1as2 [mkApp cidpot0as1 [mkApp cidpot0 [mkApp cidn5 []]]]]])
            "six"   -> return (mkApp cidnum [mkApp cidpot2as3 [mkApp cidpot1as2 [mkApp cidpot0as1 [mkApp cidpot0 [mkApp cidn6 []]]]]])
            "seven" -> return (mkApp cidnum [mkApp cidpot2as3 [mkApp cidpot1as2 [mkApp cidpot0as1 [mkApp cidpot0 [mkApp cidn7 []]]]]])
            "eight" -> return (mkApp cidnum [mkApp cidpot2as3 [mkApp cidpot1as2 [mkApp cidpot0as1 [mkApp cidpot0 [mkApp cidn8 []]]]]])
            "nine"  -> return (mkApp cidnum [mkApp cidpot2as3 [mkApp cidpot1as2 [mkApp cidpot0as1 [mkApp cidpot0 [mkApp cidn9 []]]]]])
            _       -> mzero
     return (mkApp cidNumNumeral [e])
  `mplus`
  do cat "CD"

pQuant =
  inside "DT" pDT
  `mplus`
  do dt <- cat "PRP$"
     return (dt,True)
  `mplus`
  do np <- inside "NP" $ do
             np <- pBaseNP
             inside "POS" word
             return np
     return (mkApp cidGenNP [np],True)
  `mplus`
  do dt <- pMany
     return (dt,False)

pDT =
  do dt <- mplus (lemma "Quant" "s False Sg")
                 (lemma "Quant" "s False Pl")
     return (mkApp dt [],True)
  `mplus`
  do dt <- lemma "Det" "s"
     return (mkApp dt [],False)

pMany =
  do w <- inside "JJ" word
     guard (map toLower w == "many")
     return (mkApp cidmany_Det [])

pAdA = do adv <- cat "RB"
          case unApp adv of
            Just (f,[a]) | f == cidPositAdvAdj 
                   -> return (mkApp cidPositAdAAdj [a])
            _      -> mzero
       `mplus`
       do ada <- inside "RB" (lemma "AdA" "s")
          return (mkApp ada [])

splitDashN (Node w []) =
  case break (=='-') w of
    (w1,'-':w2) -> Node w1 [] : Node "-" [Node "-" []] : splitDashN (Node w2 [])
    _           -> [Node w []]
splitDashN t = [t]

meta = mkCId "?"
