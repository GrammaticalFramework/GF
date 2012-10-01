{-# LANGUAGE TupleSections, TypeOperators #-}
module Translate 
        (mapp
       ,main
       ,bigTest
       ,evaluation
       ,evaluations 
       ,main2 
       ,mainTest
       ,mainT2 
       ,testa
       ) where

import MonadSP
import Idents
import Test  
import Structure
import qualified State as S
import qualified Format as Form

import Control.Arrow hiding ((<+>))
import Control.Monad
import Control.Monad.RWS hiding (gets,modify,local)
import Data.Maybe
import Data.Char
import Data.IORef
import qualified Data.Label as P 
import Data.Label.PureM hiding (local)
import Data.List
import Data.Tree
import PGF hiding (parse)
import System.IO
import System.Process

-- Test by runnig mainTest. Use testGr, otherwise very slow

type PMonad = (RWS () [String] S.State)
type Translator a = P String Expr PMonad a


test = False
usePGF = testGr --newBigGr
testGr = ("../gf/BigTest.pgf","BigTestSwe")
bigGr  = ("../gf/Big.pgf","BigSwe")
newBigGr = ("../../../robust/chunk/ExtractPGF.pgf","BigParseSwe")
lang   = fromJust $ readLanguage "BigTestSwe"
paint  = False

tb = "../Talbanken05_20060604/FPS/P.tiger.xml"
------------------------------------------------------------------------------
-- Run functions
------------------------------------------------------------------------------
mapp f    = main' f >> return ()
main      = main' "test.xml" >> return ()
bigTest   = do res <- main' "../testSuites/testShortSimpleTwo.xml" 
               writeFile "mappingShort6.txt" $ unlines (getRes res)

evaluation :: IO ()
evaluation = evaluations "EvalMappSuite2.xml" "Evalresult.txt" 

evaluations :: FilePath -> FilePath -> IO ()
evaluations test to = do 
    res <- main' test 
    writeFile to $ unlines (show (getQuote res) : getRes res)
main2      = main' "test2.xml" >> return ()
mainTest   = main' "testSimple.xml" >>= putStrLn . compareRes . getRes
mainT2     = main' "testSimple.xml" >>= putStrLn . unlines . getRes

getRes :: [(Double,String)] -> [String]
getRes = map snd
getQuote :: [(Double,String)] -> Double
getQuote = fst . last 

-- Standard main
main' :: FilePath -> IO [(Double,String)]
main' fil  = do
  pgf <- readPGF $ fst usePGF
  let Just language = readLanguage $ snd usePGF
      morpho        = buildMorpho pgf language
  s <- fmap concat $ Form.parse fil
  print $ prune $ snd $ head s
  ref  <- newIORef (0,0,0)
  mapM (process pgf morpho ref) s

  where
    process pgf morpho ref (id,t) = do
      (cn,co,l) <- readIORef ref
      let idN =  takeWhile (/='_') id 
      putStrLn idN
      let (e,trace)     = evalRWS (parse penn pgf morpho (prune t)) () S.startState
          (cn',co')     = count (cn,co) e
          l'            = l+1
      writeIORef ref  (cn',co',l')
      when test $ putStrLn $ unlines trace
      putStrLn (showExpr [] e)
      when paint $ do
        writeFile "tmp_tree.dot" 
                                   (graphvizParseTree pgf lang e) 
        rawSystem "dot" ["-Tpdf", "tmp_tree.dot"
                        , "-otrees/tree"++showAlign l'++"GFparsX.pdf"]
        return ()
      let quote = (fromIntegral cn' / fromIntegral co') * 100
      hPutStrLn stderr (show quote)
      return (quote,idN++"\t"++showExpr [] e)

    count (cn,co) e = cn `seq` co `seq`
      case unApp e of
        Just (f,es) -> if f == meta
                         then foldl' count (cn,  co+1) es
                         else foldl' count (cn+1,co+1) es
        Nothing     -> (cn+1,co+1)


    
    prune (Node tag ts)
      |   tag == "ROOT" 
       && not (null ts)
       && last ts == Node "." [Node "." []] = Node tag (init ts)
      | otherwise                           = Node tag ts

showAlign :: Show a => a -> String
showAlign n =
      replicate (5 - length s) '0' ++ s
      where
        s = show n


------------------------------------------------------------------------------
-- The grammar : Rules for converting labels
------------------------------------------------------------------------------

penn :: Grammar (RWS () [String] S.State) String Expr
penn =
  grammar (mkApp meta)
   ["ROOT" :-> do s <- inside "MS" $ cat "S"
                                     `mplus` cat "XP"
                  write "root found"
                  return s 
   
     ,"S" :-> do write "start" 
                 conj     <- maybeParse $ inside "++" pPConj
                 subj     <- maybeParse $ cat "UK"
                 (s,s2)   <- pS
                 m_voc <- maybeParse (do opt (word2 "IK") ""
                                         inside "TT" pNP)
                 opt (word2 "IP" `mplus`
                      word2 "I?" `mplus`
                      word2 "IG" `mplus`
                      word2 "IU") ""
                 S.subj =: subj
                 let pconj = fromMaybe (mkExpr cidNoPConj) conj
                     voc   = fromMaybe (mkExpr cidNoVoc) m_voc
                 return $ mkApp cidPhrUtt [pconj, s,voc]

     ,"AP" :-> do write "in AP"
                  ad <- inside "AA" pAdA
                  write ("found adA: "++show ad)
                  a  <- inside "HD" pAdj
                  write ("found adj: "++show a)
                  return $ mkApp cidAdAP [ad,a]
               <+>
               do as <- many $ inside "AA" pAdAdj
                  a2 <- inside "HD" pAdj 
                  return (foldr (\ada ap -> mkApp cidAdAP [ada,ap]) a2 as)
       
      ,"AVP" :-> --bland annat, just nu, t ex, i kontakt... 
                 do iadv <- inside "HD" pIAdv
                    adv  <- pAdv
                    return $ mkApp cidAdvIAdv [iadv, adv]
                 <+>
                 do consume
                    return (mkExpr meta)
     -- ,"CAVP" :-> coordinated AVP 
      ,"CAP" :-> conjunct cidConsAP cidBaseAP cidConjAP pAdj

      ,"NP" :-> pflatNP
                   
      ,"PP" :-> do pr     <- write "PP!" >> inside "PR" pPrep
                   write "prep found"
                   np <- pflatNP <+> inside "HD" pNP 
                         <+> cat "PA"  -- this is for deep trees
                   write "prep noun found"
                   returnApp cidPrepNP [pr,np]
      ,"VP" :-> do write "in cat VP"
                   word2 "IM"                
                   v <- pVP "IV"
                   write $ "VP returns " ++ show v
                   return v 

   -- untranslatables
      ,"XX" :-> do n     <- maybeParse pNP    
                   let e = fromMaybe (mkExpr meta) n  
                   write ("xx returns "++show e)
                   return $ mkApp meta [e]
      ,"XP" :-> do write "xp!" 
                   x <- cat "XX"
                   write "xp found noun"
                   a <- pAdv     
                   write "xp found adv "
                   opt (word2 "IP") ""
                   return $ mkApp meta [x,a]

      ,"CNP" :-> conjunct cidConsNP cidBaseNP cidConjNP pflatNP 
      ,"CPP" :-> conjunct cidConsAdv cidBaseAdv cidConjAdv (cat "PP")
      ,"CONJP" :-> conjunct meta meta meta (pflatNP <+> cat "PP" <+> pAdj)
      ,"CVP" :-> conjunct cidConsVPS cidBaseVPS cidConjVPS (cat "VP")
      ,"CS" :-> conjunct cidConsS cidBaseS cidConjS (cat "S")
      ,"CXP" :-> conjunct meta meta meta (cat "XP")  
      --,"NAC" :-> (consume >> return (mkExpr meta))

      -- labels ----
      ,"++" :-> pPConj
      ,"+A" :-> pPredet
      ,"+F" :-> cat "S"
      ,"AA" :-> pAA
      ,"AG" :-> pSpecialPP cidBy8agent_Prep
      ,"AN" :-> pAppos
      ,"AT" :-> pAdj
      ,"CA" :-> pPredet
      ,"DT" :-> pQuant <+> pIQuant <+> pPredet 
                       <+> (fst3 <$> pN2)
      ,"EF" :-> parseRelS
      ,"EO" :-> cat "VP"
      ,"ES" :-> pNP 
      ,"FO" :-> pItPron 
      ,"FS" :-> fst <$> pFS
      ,"FV" :-> msum (map pSlashVP vForms)
      ,"IV" :-> pVP "IV" 
      ,"KA" :-> cat "S"
      ,"MA" :-> inAdv
      ,"MD" :-> cat "NP" <+> cat "PP"
      ,"NA" :-> return (mkExpr cidPNeg)
      ,"OA" :-> cat "PP" <+> cat "VP"
      ,"OO" :-> cat "S"  <+> cat "VP" 
                         <+> pAdj
                         <+> cat "NP"
      ,"PL" :-> pPart "V"  -- could be all sorts of verbs
      ,"PR" :-> pPrep
      ,"RA" :-> inAdv
      ,"SP" :-> do a <- pAdj 
                        <+>
                        pAdA 
                   write ("adj return"++show a)
                   returnApp cidCompAP [a]
                <+>
                do e <- pNP
                   write ("coplua np "++show e)
                   returnApp cidCompNP [e]
                <+>
                do e <- cat "PP"
                   returnApp cidCompAdv [e]
                <+>
                do consume
                   return (mkExpr meta) --we know we are in SP, so ok to consume
      ,"SS" :-> pNP <+> pflatNP <+> cat "NP"
      ,"TA" :-> inAdv
      ,"TT" :-> pNP
      ,"UK" :-> pConj <+> pSubj
      ,"VA" :-> inAdv
      ,"VO" :-> cat "VP"
      ,"VS" :-> cat "VP"
      ,"XA" :-> cat "PP" -- så att säga
      ,"BS" :-> cat "S" 
      ,"CJ" :-> cat "S" <+> cat "PP" <+> cat "VP"   --first conjunct
                        <+> pAdj     <+> pflatNP
      ,"C+" :-> cat "S" <+> cat "PP" <+> cat "VP"   --second conjuct
                        <+> pAdj     <+> pflatNP
      ,"CC" :-> cat "S" <+> cat "PP" <+> cat "VP"   --sister conjuct
                        <+> pAdj     <+> pflatNP
      ,"HD" :-> (pCN >>= \(a,b,c) -> return (mkApp meta [a,mkExpr b]))  <+> pAdj <+> pIAdv <+> pNP
      ,"IF" :-> pVP "IV"  -- for deep trees
      ,"PA" :-> pflatNP <+> pNP  -- for deep trees
                       <+> cat "VP" <+> cat "S" 
                       <+> cat "NP" <+> cat "CNP"
       
    ,"VG" :-> cat "VP"  -- for deep trees

      -- Not translated:
      -- punctuation: I?,"IC","ID","IG","IK","IM", "IO", "IP", "IQ", "IR", "IS", "IT", "IU",
      -- punctuation: , "JC", "JG", "JR", "JT",
      --   ,"ET" :-> cat "PP"
      --   ,"DB"  
      --   ,"MS" :-> cat "S"
      --,"ST"  paragraph
      --,"PT"  cant parse 'sjálv'
      --,"XF" :-> XP
      --,"XT" -- sa kallad
      --,"XX" unclassifiable 
      --,"YY" :-> inside "YY" (lemma "ja,jo"  "") --fix!!
   ] 

cats :: [String] -> Translator Expr 
cats tags = msum [cat c | c <- tags]
objCat :: Translator ()
objCat    = msum [pCompl t | t <- vForms ]

advsCat :: Translator Expr
advsCat = pAdv


(<$>)   = liftM
a <+> b = mplus a b
infixr 2 <+>
infixr 3 <$>

clType :: CId -> CId
clType typ | typ==cidQuestVP = cidUseQCl
           | otherwise       = cidUseCl
utType :: SentenceType -> CId
utType typ | typ==Q          = cidUttQS
           | otherwise       = cidUttS

parseSCl :: Translator Expr
parseSCl = inside "S" pCl

pS :: Translator (Expr,Maybe Expr)
pS = do
  cl <- do cl <- pCl 
           write "found cl"
           utt <- gets S.sentenceType
           return $ mkApp (utType utt) [cl] 
        <+>
        do write "to imperative"
           pImp 
        <+>
        do write "to SS"
           pSS
        <+>
        do cl <- pUttAdv
           return $ mkApp cidUttAdv [cl]
  s2 <- maybeParse $ inside "+F" (optEat (cat "S") (mkExpr meta))
  let cl1   = maybe cl (\x -> mkApp meta [x]) s2 
  return (cl1,s2)


pNPCl :: Translator Expr
pNPCl = do 
 np <- parseSubject
 return $ mkApp cidUttNP [np]

pCl ::  Translator Expr
pCl = questCl <+> questVP <+> normalCl  <+> advCl <+> iadvCl <+> topCl
 where normalCl = do  -- jag äter äpplen
         S.sentenceType =: Dir
         np   <- pSubject
         write "try normalCl, found np"
         vp   <- pVP "FV"
         advs <- many advsCat
         (temp,pol) <- getTmpPol
         nptyp      <- gets S.nptype
         let e0 = foldr (\ad e -> mkApp cidAdvVP [e,ad]) vp advs
             e1 = constructCl nptyp np e0
             e2 = mkApp cidUseCl [temp,pol,e1]
         return e2
       advCl = do  -- nu äter jag äpplen
          S.sentenceType =: Top 
          write "try advCl"
          advs  <- pAdv    
          write "try advCl, found adv"
          write "will do FV"
          vp <- pVSO "FV"          
          np <- gets S.subj
          advs' <- many advsCat
          (temp,pol) <- getTmpPol
          nptyp      <- gets S.nptype
          guard $ isJust np
          let e0 = foldr (\ad e -> mkApp cidAdvVP [e,ad]) vp advs'
              cl = constructCl nptyp (fromJust np) e0
              c  = mkApp cidTopAdv [advs,cl]
              e1 = mkApp cidUseTop [temp, pol, c ]
          return e1
       iadvCl = do -- när äter jag äpplen
          S.sentenceType =: Q
          iadv   <- cats ["RA","TA","AB"]
          write "try iadvCl, found iadv"
          iquant <- gets S.iquant
          guard iquant 
          vp <- pVSO "FV"          
          np <- gets S.subj
          advs  <- many advsCat
          (temp,pol) <- getTmpPol
          nptyp      <- gets S.nptype
          guard $ isJust np
          let e0 = foldr (\ad e -> mkApp cidAdvVP [e,ad]) vp advs
              cl = constructCl nptyp (fromJust np) e0
              c  = mkApp cidQuestIAdv [iadv,cl]
              e1 = mkApp cidUseQCl [temp, pol,c ]
          return e1
       questCl = do  -- vilka äpplen är godast? / vem har du sett?
          S.sentenceType =: Q
          ip  <- inside "SP" parseIP 
          write "try questcl, found ip"
          vp <- pVSO "FV"          
          np <- gets S.subj
          guard $ isJust np
          (temp,pol) <- getTmpPol
          let quest = mkApp cidQuestSlash [ip,mkApp cidSlashVP [fromJust np,vp]]      
          return $ mkApp cidUseQCl [temp,pol,quest]
       questVP = do -- vilka får vara med 
          ip  <- inside "SS" parseIP 
          write "try questvp, found ip"
          vp <- pVP "FV"
          (temp,pol) <- getTmpPol
          let quest = mkApp cidQuestVP [ip,vp]      
          S.sentenceType =: Q
          return $ mkApp cidUseQCl [temp,pol,quest]
       topCl   = do
          S.sentenceType =: Top
          (vp,cop) <- do vp  <- pOVS "FV" Cop    
                         return (vp,True)
                      <+>
                      do vp  <- msum $ map (pOVS "FV") (Cop `delete` vForms)
                         return (vp,False)
          np  <- gets S.subj
          obj <- gets S.object
          (temp,pol) <- getTmpPol
          guard $ isJust obj
          guard $ isJust np
          let top = if cop then cidTopAP else cidTopObj
              cl = mkApp top [fromJust obj,mkApp cidSlashVP [fromJust np,vp]]
              e1 = mkApp (clType cidUseTop) [temp,pol,cl ]
          return e1 


getTmpPol :: Translator (Expr,Expr)
getTmpPol = do
  tmp <- gets S.tmp
  pol <- gets S.pol
  ant <- gets S.anter
  let temp  = maybe (mkExpr meta) (mkTmp ant) (isVTense tmp)
  return (temp,mkPol pol)
  
         

parseIP :: Translator Expr
parseIP = do p <- inside "PO" (lemma "IP" "s NPNom"
                               <+>
                               lemma "IP" "s NPAcc" )
             return (mkExpr p)

pSS :: Translator Expr
pSS =  
  do s1   <- cat "S"    -- jag går om hon kommer
     s2   <- cat "S"
     conj <- gets S.subj
     let sub = fromMaybe (mkExpr meta) conj
     return $ mkApp cidSSubjS [s1,sub,s2] 

pSubject :: Translator Expr
pSubject = cat "SS" <+> cat "FV"

pObj :: Translator ()
pObj    =  msum $ map pCompl vForms
pObject :: Translator ()
pObject = do    --a plain object
  obj <- inside "OO" (word "POXPHH" >> return (Just $ mkExpr meta))
         <+>
         do write "look for np in oo"
            liftM Just (inside "OO" pNP)
         <+>
         do write "look for np in sp"
            liftM Just (inside "SP" pNP)
         <+>
         do o <- inside "OA" (cat "PP") 
            return (Just $ mkApp meta [o]) 
         <+>  
         do det <- inside "FO" pItPron     -- funnit det attraktivt att (VP)
            a   <- pAdj
            vp  <- inside "EO" $ cat "VP" 
            return (Just $ mkApp meta [det,mkApp meta [a,vp]])
         <+>  
         do inside "IO" $ word "POXPHH"  
            return (Just $ mkExpr cidReflIdPron) -- sig
         <+>
         liftM Just (inside "ES" pNP)
  S.object =: obj


pImp :: Translator Expr
pImp = do write "in imperative"
          vp <- pVP "FV"
          write "found vp in imp"
          tmp  <- gets S.tmp
          pol  <- gets S.pol
          guard (tmp==Just VImp)
          write "vp in imp is ok"
          advs <- many pAdv
          write ("advs found: "++show advs)
          let e0 = foldr (\ad e -> mkApp cidAdvVP [e,ad]) vp advs
              imp = mkApp cidImpVP [e0] 
          return $ mkApp cidUttImpPol [mkPol pol,imp]

-- "att det inte regnar"
pUttAdv :: Translator Expr
pUttAdv = do 
 sub <- inside "UK" pSubj 
 np  <- cat "SS" <+> cat "FS" 
 typ <- gets S.nptype
 write ("SS done for UttAdv"++show np)
 write "now to pVP"
 pol <- pPol
 v   <- parseFV
 objCat
 advs <- many pAdv
 tmp  <- gets S.tmp
 ant <- gets S.anter
 vp   <- constructVP v
 let e0 = foldr (\ad e -> mkApp cidAdvVP [e,ad]) vp advs
     e1 = constructCl typ np e0
     e2 = mkApp cidUseCl [maybe (mkExpr meta) (mkTmp ant) (isVTense tmp)
                         ,mkPol pol,e1]
 return $ mkApp cidSubjS [sub,e2]

parseFV :: Translator Expr
parseFV = do
   write "In parseFV"
   write "checked word in parseFV"
   v   <- cat "FV"
   p   <- maybeParticle "FV"
   write "FV checks tmp "
   return v

parseRelS :: Translator Expr
parseRelS = do 
  old <- putStateToZero
  rcl <- pRelS
  resetState old
  return rcl


pRelS :: Translator Expr
pRelS = do
  w <- inside "S" $ inside "SS" $ word "PO" 
  guard (w =="Som" || w == "som")
  parseTheVP <+> parseTheCl
 where parseTheVP = do
         pol <- pPol
         v   <- parseFV
         pObj  
         vp <- constructVP v
         mkRelCl pol $ mkApp cidRelVP [mkExpr cidIdRP,vp]
       parseTheCl = do
         S.object =: Just (mkExpr meta)  -- to indicate that there already is an object (outside
                                         -- of the relative clause) 'pojken som jag ser'
         np  <- pSubject
         pol <- pPol 
         v   <- parseFV
         pObj
         vp <- constructVP v
         mkRelCl pol $ mkApp cidRelSlash [mkExpr cidIdRP,mkApp cidSlashVP [np,vp]]

       mkRelCl pol cl = do
         tmp  <- gets S.tmp
         ant  <- gets S.anter
         let t     = maybe (mkExpr meta) (mkTmp ant) (isVTense tmp)
         return (mkApp cidUseRCl [t,mkPol pol,cl])



constructCl :: NPType -> Expr -> Expr -> Expr
constructCl typ np vp = 
  if typ == Generic || typ == Impers
     then mkApp (toCid typ) [vp]
     else mkApp cidPredVP [np,vp]
 where toCid Generic = cidGenericCl
       toCid Impers  = cidImpersCl
       toCid _       = meta

pSpecialPP :: CId -> Translator Expr
pSpecialPP cid = 
 do pr <- inside "PR" $ optEat (lemma "Prep" "s") meta


    write "prep found"
    guard (pr==cid)
    np     <- pflatNP
    return $ mkApp cidPrepNP [mkExpr pr,np]

isVSupin :: VForm CId -> Bool
isVSupin VSupin = True
isVSupin _      = False

isVTense :: Maybe (VForm CId) -> Maybe CId 
isVTense (Just (VTense t)) = Just t
isVTense _                 = Nothing

isVTenseForm :: CId -> VForm CId -> Bool
isVTenseForm a (VTense t) = t == a 
isVTenseForm _ _          = False


vForms :: [VPForm]
vForms =  [Cop,Sup,Fut,FutKommer,VV,VA,V2A,V2,V2Pass,VS,V]
gfvForms :: [String]
gfvForms =  ["VV","VA","V2A","V2","VS","V","V3"]

pSlashVP :: VPForm ->  Translator Expr
pSlashVP form = do
 write "in pSlashVP"
 (t,v,f) <- case form of 
                  V ->  do (t,v) <- pVerb "VV" "V"
                           write "found a pVerb of type V"
                           return (t,mkExpr v,V)
                  VV -> third VV <$> pVV
                  V2 -> third V2 <$> pV2Act
                  V2A -> do (t,v) <- pVerb "VV" "V2A"
                            return (t,mkExpr v,V2A)
                  Cop -> do t <- pCopula 
                            return (t,mkExpr meta,Cop)
                  Sup -> do t <- pHave
                            return (t,mkExpr meta,Sup)
                  VA  -> do third VA <$> pVA
                  Fut -> do t <- pFuturum
                            write "found future form"
                            return (t,mkExpr meta,Fut)
                  VS  -> do (t,v) <- pVerb "VV" "VS"
                            return (t,mkExpr v,VS)
                  V2Pass    -> third V2Pass <$> (inside "VV" pExist
                                            <+> pV2Pass)
                  FutKommer -> do t <- pFuturumKommer
                                  return (t,mkExpr meta,FutKommer)
 S.tmp   =: Just t
 S.anter =: (f==Sup)
 modify S.vform  (V:)
 return v

mkTmp :: Bool -> CId -> Expr
mkTmp False = mkTmp' cidASimul 
mkTmp True  = mkTmp' cidAAnter 

mkTmp' :: CId -> CId -> Expr
mkTmp' a t | a ==cidASimul = mkApp cidTTAnt [mkExpr t,mkExpr cidASimul] 
           | a ==cidAAnter = mkApp cidTTAnt [mkExpr t,mkExpr cidAAnter] 

pVP :: String -> Translator Expr
pVP typ = do
   write $ "doing pVP "++show typ
   msum [do v <- inside typ (pSlashVP x)
            write $ "found IV "++show v
            S.sentenceType =: Dir
            localKeepPol (do
                    pCompl x 
                    write $ "pVP have succeeded to parse for typ "++show x
                    constructVP v)
        | x <- vForms]


pVSO :: String -> Translator Expr
pVSO cat = msum $ map (pVSOCat cat) vForms

pVSOCat :: String -> VPForm -> Translator Expr
pVSOCat cat typ = do
  v  <- inside cat $ pSlashVP typ 
  np <- write "looking for SS" >> parseSubject
  write ("pVSO found np "++show np)
  S.subj =: Just np 
  localKeepPol (pCompl typ >> constructVP v)

pOVS :: String -> VPForm -> Translator Expr
pOVS cat Cop = do
  write "try OVS copula"
  pObject  --huset
  write "found compl in OVS Cop" 
  v <- inside cat $ pSlashVP Cop
  advs <- many pAdv    
  np <- write "looking for SS" >> parseSubject
  write ("pOVS found np "++show np)
  advs1 <- many pAdv    
  let np1 = foldr (\ad e -> mkApp cidAdvNP [ad, e]) np (advs++advs1)
  S.subj =: Just np1
  S.sentenceType =: Top 
  constructVP v
  return v

pOVS cat typ = do --huset målar han rött
  write "try OVS"
  pObject                                      --huset
  v  <- inside cat $ pSlashVP typ              --målar
  write $ "found compl in OVS "++show typ
  np <- write "looking for SS" >> parseSubject --han
  write ("pOVS found np "++show np)
  S.subj =: Just np 
  S.sentenceType =: Top 
  localKeepPol (do pCompl typ                  --rött
                   constructVP v)
  return v


pInfVP :: Translator (Bool,Expr)
pInfVP = 
  do write "att v?"
     im <- opt (word2 "IM" >> return True) False
     write $ "infinite marker? "++ show im
     v  <- pVP "IV" <+> inside "IF" (pVP "IV")
     return (im,v)
 
constructVP :: Expr -> Translator Expr
constructVP v = do
   (vtyp,exps,bs) <- gets S.complement
   o     <- gets S.object
   styp  <- gets S.sentenceType
   advs1 <- many pAdv  
   write $ "in constructVP, will combine for " ++ show vtyp
   vp <- pComplVP vtyp styp v (exps,bs)
   write $ "in constructVP, have combined for " ++ show vtyp
   return $ foldr (\ad e -> mkApp cidAdvVP [ad, e]) vp advs1
 
pComplVP :: VPForm -> SentenceType -> Expr -> ([Maybe Expr],[Bool]) 
         -> Translator Expr
pComplVP V q vp (exps,_) = do 
  comp <- getComplement V q exps 
  (fo,adv,part,adv1) <-  case comp of
                         (fo:a:p:a1:_) -> return (fo,a,p,a1)
                         _             -> argErr "V"
  let vp0  = fromMaybe vp part 
      vp1  = mkApp cidUseV [vp0]
      vp2  = maybe vp1 (\a -> mkApp cidAdvVP [vp1,a]) adv 
      vp3  = maybe vp2 (\a -> mkApp cidAdvVP [vp2,a]) adv1
  write ("particle "++show part++" verb "++show vp)
  return $ maybe vp3 (\fob -> mkApp meta [vp3,fob]) fo

pComplVP VA q vp (exps,_) = do 
  comp <- getComplement VA q exps
  (fo,adv,a) <-  case comp of
                  (fo:a:Just aj:_) -> return (fo,a,aj)
                  _                -> argErr "VA"
  let vp1  = maybe vp (\a -> mkApp cidAdvVPSlash [vp,a]) adv 
      vp2  = if q==Dir then mkApp cidComplVA   [vp1,a]
                     else vp1
  when (q/=Dir) $ S.object =: Just a
  return $ maybe vp2 (\fob -> mkApp meta [vp2,fob]) fo

pComplVP VV q vp (exps,bs) = do
  comp <- getComplement VV q exps
  (fo,adv,iv,p) <-  case comp of
                  (fo:a:Just i:p':_) -> return (fo,a,i,p')
                  _                  -> argErr "VV"
  let vv0 = if bs==[True] then mkApp cidDropAttVV [vp] else vp
      vv1 = fromMaybe vv0 p 
      vv2  = maybe vv1 (\a -> mkApp cidAdvVP [vv1,a]) adv 
      vv3 = if q==Dir then mkApp cidComplVV [vv2,iv] else vv2
  when (q/=Dir) $ S.object =: Just iv 
  return $ maybe vv3 (\fob -> mkApp meta [vv3,fob]) fo

pComplVP V2 q vp (exps,_) = do
  comp <- getComplement V2 q exps
  (fo,adv,obj,part) <-  case comp of
                  (fo:a:o:p:[]) -> return (fo,a,o,p) 
                  _             -> argErr "V2"
  let combineVP =
          let vp0 = mkApp cidComplSlash [vp,fromJust obj]
          in  maybe vp0 (\a -> mkApp cidAdvVP [vp0,a]) adv 
      slashedVP = maybe vp (\a -> mkApp cidAdvVPSlash [vp,a]) adv 
      vp1 = if q/=Dir || isNothing obj then slashedVP else combineVP 
  return $ maybe vp1 (\fob -> mkApp meta [vp1,fob]) fo

pComplVP V2A q vp (exps,_) = do
  comp <- getComplement V2A q exps
  (fo,adv,obj,adj) <-  case comp of  
                  (fo:a:o:Just aj:p:_) -> return (fo,a,o,aj)
                  _                    -> argErr "V2A"
  let slashVP = mkApp cidSlashV2A [vp,adj]
  case obj of
    Just o  -> do
               let vp0 = maybe slashVP (\a -> mkApp cidAdvVPSlash [slashVP,a]) adv  
                   vp1 = mkApp cidComplSlash [vp0,o]
               return $ maybe vp1 (\fob -> mkApp meta [vp1,fob]) fo
    Nothing -> do let vp1 = maybe slashVP (\a -> mkApp cidAdvVPSlash [vp,a]) adv  
                  return $ maybe vp1 (\fob -> mkApp meta [vp1,fob]) fo

pComplVP V2Pass q vp (exps,_) = do
  comp <- getComplement V2Pass q exps
  (fo,adv1,agent,eo,adv2) <-  case comp of
                  (fo:a:g:e:a2:p_) -> return (fo,a,g,e,a2)
 
                  _               -> argErr "V2Pass"
  let vp' = foldr (\a vp -> mkApp cidAdvVP [vp,a]) vp 
                               $ catMaybes [adv1,agent,adv2]
      vp3 = maybe vp' (\a -> mkApp meta [a]) eo 
  return $ maybe vp3 (\fob -> mkApp meta [vp3,fob]) fo

pComplVP Sup q vp (exps,bs) = do
  comp <- getComplement Sup q exps
  (fo,adv,sup) <-  case comp of
                    (fo:a:Just s:_) -> return (fo,a,s)
                    _            -> argErr "Sup"
  pass <- gets S.passive
  let 
      vp1  = maybe sup (\a -> mkApp cidAdvVPSlash [sup,a]) adv 
      useV = if bs == [True] || not pass then cidUseV else cidPassV2
  S.anter =: True  
  S.passive =: False
  let vp2 = mkApp useV [vp1]
  return $ maybe vp2 (\fob -> mkApp meta [vp2,fob]) fo

pComplVP Cop q vp (exps,_) = do
  comp <- getComplement Cop q exps
  (adv,sp) <-  case comp of
                  (a:s:_) -> return (a,s)
                  _            -> argErr "Cop"
  write ("copula sp "++ show sp)
  case sp of
       Just o  -> do
           let cop = mkApp cidUseComp [o]
               vp1  = maybe cop (\a -> mkApp cidAdvVPSlash [cop,a]) adv 
           return vp1
       Nothing -> return $
                   maybe (mkApp meta []) (\a -> mkApp meta [a]) adv 

pComplVP Fut q vp (exps,_) = do
  comp <- getComplement Fut q exps
  (fo,adv,v) <-  case comp of
                  (fo:a:Just s:_) -> return (fo,a,s)
                  _               -> argErr "Fut"
  let vp1  = maybe v (\a -> mkApp cidAdvVPSlash [v,a]) adv 
  write ("fut compl: "++show vp1)
  return $ maybe vp1 (\fob -> mkApp meta [vp1,fob]) fo

pComplVP FutKommer q vp (exps,_) = do
  comp <- getComplement FutKommer q exps
  (fo,adv,vp0) <-  case comp of
                  (fo:a:Just s:_) -> return (fo,a,s)
                  _               -> argErr "FutKommer"
  let vp1  = maybe vp0 (\a -> mkApp cidAdvVPSlash [vp0,a]) adv 
  return $ maybe vp1 (\fob -> mkApp meta [vp1,fob]) fo
 
pComplVP VS q vp (exps,_) = do
  comp <- getComplement VS q exps
  (fo,adv,s) <-  case comp of
                  (fo:a:Just s:_) -> return (fo,a,s)
                  _               -> argErr "VS"
  let vp0 = if q==Dir then mkApp cidComplVS [vp,s] 
                      else vp
      vp1 = maybe vp0 (\a -> mkApp cidAdvVP [vp1,a]) adv
  when (q/=Dir) $ S.object =: Just s
  return $ maybe vp1 (\fob -> mkApp meta [vp1,fob]) fo

getComplement :: VPForm -> SentenceType -> [Maybe Expr] -> Translator [Maybe Expr]
getComplement v q exps = return exps

argErr :: String -> Translator a
argErr s = do
  write ("wrong number of arguments to pCompl "++ s)
  mzero

pPart :: String -> Translator Expr
pPart v = do
  p <- do write "part right!!"
          inside "AB" (lemma v "part")
       <+>
       do write "part" 
          inside "PR" (lemma v "part") 
  return (mkExpr p)


pVV :: Translator (VForm CId,Expr)
pVV = do
  (t,v) <- tryVerb "FV" cidGet_VV "VV"  
           <+>
           tryVerb "WV" cidWant_VV "VV"
           <+>
           do write "looking for can"
              tryVerb "QV" cidCan_VV "VV"
           <+>
           tryVerb "MV" cidMust_VV "VV"
           <+>
           pVerb "VV" "VV"
  write ("VV returns tense "++show t)
  return (t,mkExpr v)

pVA :: Translator (VForm CId,Expr)
pVA = do
  (t,v) <- tryVerb "BV" cidBecome_VA "VA"
           <+>
           pVerb "FV" "VA" 
  write ("VA returs tense "++show t)
  return (t,mkExpr v)


pV2Act :: Translator (VForm CId,Expr)
pV2Act = do 
  (t,v) <- do t <- pHave
              return (t,mkExpr cidHave_V2)  
           <+>
           do (t,v) <- do write "in pV2"
                          pVerb "VV" "V2"
                       <+>                   
                       do write "får är i farten"
                          tryVerb "FV" cidGet_V2 "V2"
                       <+>
                       tryVerb "GV" cidDo_V2 "V2"
                       <+>
                       tryVerb "GV" cidDo_VV "VV"
                       <+>
                       tryVerb "BV" cidBecome_V2 "V2"
              return (t,mkExpr v)
  return (t,mkApp cidSlashV2a [v]) 

pV2Pass :: Translator (VForm CId,Expr)
pV2Pass = do
  (t,v) <- pPassVerb "VV" "V2"
           <+>
           tryVerb "GV" cidDo_V2 "V2"
           <+>
           tryVerb "FV" cidGet_V2 "V2"
  return (t,mkApp cidPassV2 [mkExpr v])

pExist :: Translator (VForm CId,Expr)
pExist =
    do lemma "NP -> Cl" "s SPres Simul Pos Main"
       return (VTense cidTPres,mkExpr cidExistNP)
    <+>
    do lemma "NP -> Cl" "s SPret Simul Pos Main"
       return (VTense cidTPast,mkExpr cidExistNP)
    <+>
    do lemma "NP -> Cl" "s SPres Anter Pos Main"
        <+>
        lemma "NP -> Cl" "s SPret Anter Pos Main"
       return (VSupin,mkExpr cidExistNP)

tryVerb :: String -> CId -> String -> Translator (VForm CId,CId)
tryVerb tag cid cat =
 do t <- tense tag
    write ("tryVerb "++tag) 
    return (t,cid) 
 <+>
  do write "no tense found"
     pVerb tag cat

pVerb :: String -> String -> Translator (VForm CId, CId)
pVerb x y = write ("in pVerb "++x++" "++y) >> pVerb' "Act" x y

pPassVerb :: String -> String -> Translator (VForm CId, CId)
pPassVerb = pVerb' "Pass"

pVerb' :: String -> String -> String -> Translator (VForm CId, CId)
pVerb' act incat cat =
        do v <- (inside incat $ lemma cat $ "s (VF (VPres "++act++"))")
                <+>
                (inside incat $ lemma "V" $ "s (VF (VPres "++act++"))")
           return (VTense cidTPres,v)
        <+>
        do v <- (inside incat $ lemma cat $ "s (VF (VImper "++ act++"))")
                <+>
                (inside incat $ lemma "V" $ "s (VF (VImper "++ act++"))")
           return (VImp,v)
        <+>
        do v <- (inside incat $ lemma cat $ "s (VI (VInfin "++ act++"))")
                <+>
                (inside incat $ lemma "V" $ "s (VI (VInfin "++ act++"))")
           return (VInf,v)
        <+>
        do v <- (inside incat $ lemma cat $ "s (VF (VPret "++ act++"))")
                <+>
                (inside incat $ lemma "V" $ "s (VF (VPret "++ act++"))")
           return (VTense cidTPast,v)
        <+>
        do v <- (inside incat $ lemma cat $ "s (VI (VSupin "++ act++"))")
                <+>
                (inside incat $ lemma "V" $ "s (VI (VSupin "++ act++"))")
           return (VSupin,v)
        
maybeVerbAdv :: Translator (Maybe Expr)
maybeVerbAdv  = maybeParse pAdv  

maybeParticle :: String -> Translator (Maybe Expr)
maybeParticle = maybeParse . inside "PL" . pPart 

metaVerb :: (VForm a,CId)
metaVerb   = (VInf,meta)

pCompl :: VPForm -> Translator ()
pCompl Cop = do
  write "copula compl begins"
  pol <- pPol
  adv <- maybeParse $ pAdvMinus ["RA"]
  write $ "copula found adv"++show adv
  sp <- hasMovedObj
        <+>
        Just <$> cat "SP"
        <+>
        do write "copula looking for adv2"
           a <- pAdv
           write "copula found adv2"
           return $ Just $ mkApp cidCompAdv [a]
  S.complement =: (Cop,[adv,sp],[])
  S.pol        =: pol

pCompl Sup = do
  write "supinum compl begins"
  fo  <- maybeParse $ cat "FO"
  pol <- pPol
  adv <- maybeVerbAdv
  (t',sup,useV) <- inside "IV" $  
                    do (t,s) <- msum [pVerb "TP" v | v <- gfvForms] 
                                <+>
                                inside "TP" (consume >> return (VSupin,meta))
                                <+>
                                msum [pVerb "VVSN" v | v <- gfvForms] 
                       return (t,s,True) 
              <+>         
               do (t,s) <- msum [pPassVerb "VVSN" v | v <- gfvForms] 
                  return (t,s,False) 
  guard (isVSupin t') 
  S.passive    =: not useV
  S.pol        =: pol
  S.complement =: (Sup,[fo,adv,Just $ mkExpr sup],[useV])

pCompl V2 = do
  write "v2 compl begins"
  (pol,fo,adv,part) <- pV2Compl
  obj <- hasMovedObj 
         <+>
         inside "OO" (word "POXPHH" >> return (Just $ mkExpr meta))
         <+>
         do write "look for np in oo"
            liftM Just (inside "OO" pNP)
         <+>
         do write "look for np in sp"
            liftM Just (inside "SP" pNP)
         <+>
         do o <- inside "OA" (cat "PP") 
            return (Just $ mkApp meta [o])
         <+>  
         do det <- inside "FO" pItPron   
            a   <- pAdj
            vp  <- inside "EO" $ cat "VP" 
            return (Just $ mkApp meta [det,mkApp meta [a,vp]]) 
         <+>  
         do inside "IO" $ word "POXPHH"  
            return Nothing -- sig
         <+>
         liftM Just (inside "ES" pNP)
  write "oo ok"
  S.pol       =: pol
  S.complement =: (V2,[fo,adv,obj,part],[])

pCompl V2A = do
  write "v2a compl begins"
  (pol,fo,adv,part) <- pV2Compl
  obj <-  hasMovedObj
         <+>
          do inside "OO" $ word "POXPHH"  
             return Nothing -- sig
         <+>
          liftM Just (inside "OO" pNP)
         <+>
          liftM Just (inside "SP" pNP)
         <+>
          do o <- inside "OA" (cat "PP" <+> cat "VP")  
             return (Just $ mkApp meta [o])
         <+>  
          do inside "IO" $ word "POXPHH"  
             return Nothing -- sig
  adj <- inside "OO" pAdj
  write "oo ok"
  S.pol       =: pol
  S.complement =: (V2A,[fo,adv,obj,Just adj,part],[])

pCompl V2Pass = do
  write "v2pass compl begins"
  fo   <- maybeParse $ cat "FO"
  pol  <- pPol
  adv1 <- maybeVerbAdv
  eo   <- maybeParse $ cat "ES" 
  part <- maybeParticle "V2"   
  write ("particle: "++show part)
  ag   <- maybeParse $  inside "AG" $ pSpecialPP cidBy8agent_Prep
  adv2 <- maybeVerbAdv
  write "agent ok"
  S.pol       =: pol
  S.complement =: (V2Pass,[fo,adv1,ag,eo,adv2,part],[])

pCompl VV = do
  write "vv compl begins"
  (pol,fo,adv,part) <- pV2Compl 
  (im,iv)  <-  do write "look for infinite verb"
                  (im,v) <- inside "OO" (inside "VP" pInfVP)
                            <+>
                            (write "inf2" >> pInfVP)
                  return (im,v) 
             <+>
               do write "looking for weird verb phrase complement for vv"
                  iv <- inside "OO" (inside "NAC" $ pVP "IV")
                  return (False,iv) 
             <+>
               do write "looking for complete verb phrase complement for vv"
                  v <- inside "OA" $ cat "VP"
                  return (True,v)  
             <+>
               do write "looking for VV in VP"
                  v <- inside "VG" $ cat "VP" 
                  return (True,v) 
  write ("iv found "++show iv)
  write "iv ok"
  p <- maybeParticle "VV"
  write ("particle: "++show p)
  S.pol        =: pol
  S.complement =: (VV,[fo,adv,Just iv,p],[im])

pCompl VA = do
  write "va compl begins"
  fo    <- maybeParse $ cat "FO"
  pol   <- pPol
  adv   <- maybeVerbAdv
  a     <- inside "SP" (pAdj <+> cat "CNP")
  S.pol        =: pol
  S.complement =: (VA,[fo,adv,Just a],[])

pCompl V = do
  write "v-simple compl begins"
  pol <- pPol
  fo  <- maybeParse $ cat "FO"
  adv <- maybeVerbAdv
  p   <- maybeParticle "V"
  write ("particle: "++show p)
  adv1  <- maybeParse $ inside "OA" $ cat "PP"
  S.pol        =: pol
  S.complement =: (V,[fo,adv,p,adv1],[])

pCompl Fut = do
  write "futurum compl begins"
  fo  <- maybeParse $ cat "FO"
  pol <- pPol
  adv <- maybeVerbAdv
  iv <- pVP "IV" 
  write ("comlpfut "++show iv)
  S.pol        =: pol
  S.complement =: (Fut,[fo,adv,Just iv],[])

pCompl FutKommer = do
  write "futurum compl begins 'komma att'"
  fo  <- maybeParse $ cat "FO"
  pol <- pPol
  word2 "IM"
  adv <- maybeVerbAdv
  iv <- pVP "IV" 
  S.pol        =: pol
  S.complement =: (FutKommer,[fo,adv,Just iv],[])

pCompl VS = do
  write "VS compl "
  (pol,fo,adv,part) <- pV2Compl  
  adv  <- maybeVerbAdv
  s    <- inside "OO" $ cat "S" 
  write "s in vs ok"
  S.pol        =: pol 
  S.complement =: (VS,[fo,adv,Just s],[])

hasMovedObj :: Translator (Maybe a)
hasMovedObj = do
  moved <- isJust <$> gets S.object
  guard moved
  return Nothing 

pV2Compl :: Translator (Maybe Bool,Maybe Expr,Maybe Expr,Maybe Expr)
pV2Compl = do
  fo <- maybeParse $ cat "FO" 
  pol <- pPol
  write "oo pol ok"
  adv <- maybeVerbAdv
  part <- maybeParticle "V2"
  write ("particle: "++show part)
  return (pol,fo,adv,part)

maybeParse :: Translator a -> Translator (Maybe a)
maybeParse = flip opt Nothing . (Just <$>)  

pflatNP :: Translator Expr
pflatNP =
  do write "in NP with Adj"
     typ <- gets S.sentenceType
     m_predet     <- maybeParse $ inside "+A" pPredet
                                  <+>
                                  inside "CA" pPredet
                                  <+>
                                  inside "DT" pPredet
     m_det        <- if typ==Q then S.iquant =: True >> Just <$> inside "DT" pIQuant
                               else  maybeParse (inside "DT" pQuant)
                                    <+>
                                     maybeParse (inside "DT" pDetRefl)
     m_n2         <- maybeParse $ inside "DT" pN2 -- 'antal'
     m_a          <- maybeParse $ inside "AT" pAdj
     (noun,n,def) <- inside "HD" pCN
     m_pt         <- maybeParse $ inside "PT" consume  --'själv'
     et           <- many $ inside "ET" $ cat "PP"
     m_app        <- maybeParse $ inside "AN" pAppos
     m_relCl      <- maybeParse $ do opt (word2 "IK") ""
                                     inside "EF" parseRelS
     write "start putting together np"
     opt (word2 "IP") ""
     t <- gets S.sentenceType
     let 
         cn0 = maybe noun (\x -> mkApp meta [noun,mkExpr meta]) m_pt  -- kvinnan själv'
         cn1 = case m_a of
                   Just a  -> mkApp cidAdjCN [a,mkApp cidUseN [cn0]]
                   Nothing -> mkApp cidUseN [cn0]
         cn2 = maybe cn1 (\rs -> mkApp cidRelCN [cn1,rs]) m_relCl 

         num = mkExpr n
         d   = fromMaybe (mkApp (getCId t cidDetQuant) [mkExpr cidDefArt,num]) m_det
         cn3 = maybe cn2 (\app -> mkApp cidApposCN [cn2,app]) m_app
     np0 <- case (def,m_det) of
                (NDef,_)         -> returnApp cidDetCN [d 
                                             ,cn3]
                (NIndef,Nothing) -> if n == cidNumSg 
                            then returnApp cidMassNP [cn3]
                            else returnApp cidDetCN 
                                            [mkApp cidDetQuant 
                                            [mkExpr cidIndefArt,num],cn3]
                (NIndef,Just d)  -> returnApp cidDetCN [d,cn3]
                (NOther,_)       -> do guard (isNothing m_predet && isNothing m_det) 
                                       return noun 
     t <- gets S.sentenceType
     let np' = maybe np0 (\(n2,num,def) -> mkApp (getCId t cidDetCN)
                                                          [mkApp cidDetQuant [def,num]
                                                          ,mkApp cidComplN2 [n2,np0]]) m_n2
         np1 = maybe np' (\p -> mkApp (getCId t cidPredetNP) [p,np']) m_predet
         res = foldr (\e n -> mkApp (getCId t cidAdvNP) [n,e]) np1 et 
     write $ "will return np" ++ show res
     return res
  <+>
  do (noun,n,def) <- inside "HD" pCN
     guard $ def == NIndef && n == cidNumSg  
     num <- pNumber
     returnApp cidCNNumNP [mkApp cidUseN [noun],num]
  <+>
  do w1 <- inside "AA" $ word "ABFA"
     w2 <- inside "HD" $ word "POZP"
     guard (map toLower w1 == "hur" && map toLower w2 == "mycket")
     S.iquant =: True
     returnApp cidhow8much_IAdv []
                 

-- returns (word :: Expr, number :: CId, determined :: NounForm)
pCN :: Translator (Expr,CId,NForm)
pCN = 
     inside "VN" pNoun
     <+>
     do n <- inside "NN" (optEat pNoun metaNoun)  
        write ("pCN gives NN "++show n) >> return n
     <+>
     inside "AN" pNoun
     <+>
     do w <- inside "POCP" consume  -- varandra, reciprokt! ej i GF
        return (mkExpr meta,cidNumPl,NOther)
     <+>
     do write "test for particip"
        (part,num,def) <- inside "SP" findNParticip
        return (part,num,def)
     <+>
     do write "test for category X"
        w <- inside "PO" (lemma "PronAQ" "s (AF (APosit (Strong GPl)) Nom)")
        return (mkApp cidQuantPronAQ [mkExpr w],cidNumPl,NIndef)
     <+>
     do word "NNDD"
        return (mkExpr meta,cidNumSg,NDef)  --may be plural...
     <+>
     do write "testing last pCN"
        word "NN"
        return (mkExpr meta,cidNumSg,NIndef)
 
 
pNoun,pNounGen :: Translator (Expr,CId,NForm)
pNoun    = pNoun' "Nom"
pNounGen = pNoun' "Gen"

pNoun' :: String -> Translator (Expr,CId,NForm)
pNoun' nom = 
  do      n <- lemma "N" ("s Pl Indef "++nom)
          return (mkExpr n,cidNumPl,NIndef)
  <+> do
          n <- lemma "N" ("s Sg Indef "++nom)
          return (mkExpr n,cidNumSg,NIndef)
  <+> do
          n <- lemma "N" ("s Sg Def "++nom)
          return (mkExpr n,cidNumSg,NDef)
  <+> do
          n <- lemma "N" ("s Pl Def "++ nom)
          return (mkExpr n,cidNumPl,NDef)


metaNoun :: (Expr, CId, NForm)
metaNoun = (mkExpr meta,cidNumSg,NIndef)
data NForm = NDef | NIndef | NOther -- NOther for reciprocs etc 
  deriving (Eq,Show)

getDef :: NForm -> CId
getDef NDef = cidDefArt
getDef NIndef = cidIndefArt
getDef NOther = meta


parseSubject :: Translator Expr
parseSubject = inside "SS" (optEat pNP (mkExpr meta)) 
               <+> 
               do (n,typ) <- inside "FS" pFS
                  S.nptype =: typ
                  return n
              
pFS :: Translator (Expr,NPType)
pFS =
     do w <- inside "PO" $ lemma "VP -> Cl" "s SPres Simul Pos Main"
        write "imperson hittad!!"
        return (mkExpr w,Impers)
     <+>
     do w <- inside "PO" $ lemma "NP -> Cl" "s SPres Simul Pos Inv"
        return (mkExpr w,Exist)

pItPron :: Translator Expr
pItPron = 
 do p <- inside "POOP" $ lemma "Pron" "s Per3 NPNom"
    return $ mkExpr p
 
pPN :: Translator Expr
pPN = do n <- inside "PN" $ optEat (lemma "PN" "s Nom") cidName
         return $ mkExpr n
pNP :: Translator Expr
pNP = 
  cat "NP" 
  <+> 
  (S.sentenceType =: Dir >> cat "AP")  
  <+> 
   do write "look for name"
      name <- pPN
      S.sentenceType =: Dir
      return (mkApp cidUsePN [name])
   <+>
   do w <- inside "POTP" $ lemma "NP" "s Per3 NPNom"
      S.sentenceType =: Dir
      return (mkExpr w)
   <+>
   do
      w   <- inside "PO" $ lemma "Pron" "s Per3 NPNom" 
      write "lemma ok"
      S.sentenceType =: Dir
      return (mkApp cidUsePron [mkExpr w])
   <+>
   do w <- inside "PO" $ lemma "VP -> Cl" "s SPres Simul Pos Main"
      write "Man hittad!!"
      S.nptype         =: Generic
      S.sentenceType   =: Dir
      return (mkExpr w)
   <+>
   do det <- pQuant
      S.sentenceType =: Dir
      return (mkApp cidDetNP [det])

   <+>
   do np <- pflatNP
      S.sentenceType =: Dir
      return np
   <+>
   do write "in complicated np"
      (n,num,def) <- pCN 
      let cn   = mkApp cidUseN [n]
          nums = mkExpr num
      t <- gets S.sentenceType
      e0 <- case def of
                 NDef -> returnApp cidDetCN 
                                   [mkApp (getCId t cidDetQuant)
                                   [mkExpr cidDefArt, nums],cn]
                 NIndef -> if num==cidNumPl then return cn
                                            else return (mkApp cidMassNP [cn])
                 NOther -> return n  -- och guards!!
      S.sentenceType =: Dir
      return e0
  
pAdj :: Translator Expr
pAdj = 
  do ad <- inside "AJKP" $ optEat (lemma "A" "s (AF ACompar Nom)") meta
     return $ mkApp cidUseComparA [mkExpr ad] 
  <+>
  do ad <- findAdj
     return $ mkApp cidPositA [ad]
  <+>
  do ad <- findA2
     return $ mkApp cidUseA2 [ad]
  <+>
  do write "will check AP"
     cat "AP"
  <+>
  cat "CAP" 
  <+>
  -- this can only be used as Comp
  do a <- inside "PO" $ lemma "PronAQ" "s (AF (APosit (Strong GPl)) Nom)"
     return $ mkApp cidCompPronAQ [mkExpr a]
  <+>
  do a <- inside "TP" $ optEat findAPerfParticip meta
     return (mkApp cidVPSlashAP  [mkExpr a]) 
  
findAdj :: Translator Expr
findAdj = 
  do ad <- inside "AJ" (optEat findA meta)
           <+>
           do write "looking for particip adjective"
              inside "SP" findA
     return $ mkExpr ad
 where findA =         lemma "A" adjSN 
               <+> lemma "A" adjSU
               <+> lemma "A" adjWSg
               <+> lemma "A" adjWPl


findA2 :: Translator Expr
findA2 = 
  do ad <- inside "AJ" (lemma "A2" "s (AF (APosit (Strong (GSg Neutr))) Nom)")
           <+>
           inside "AJ" (lemma "A2" "s (AF (APosit (Strong (GSg Utr))) Nom)")
           <+>
           inside "AJ" (lemma "A2" "s (AF (APosit (Strong GPl)) Nom)")
     return $ mkExpr ad


findNParticip :: Translator (Expr,CId,NForm)
findNParticip = pNoun 


findAPerfParticip :: Translator CId
findAPerfParticip = 
 lemma "V" "s (VI (VPtPret (Strong (GSg Utr)) Nom))"
 <+>
 lemma "V" "s (VI (VPtPret (Strong (GSg Neutr)) Nom))"
 <+>
 lemma "V" "s (VI (VPtPret (Strong GPl) Nom))"
 <+>
 lemma "V2" "s (VI (VPtPret (Strong (GSg Utr)) Nom))"
 <+>
 lemma "V2" "s (VI (VPtPret (Strong (GSg Neutr)) Nom))"
 <+>
 lemma "V2" "s (VI (VPtPret (Strong GPl) Nom))"
 <+>
 lemma "VV" "s (VI (VPtPret (Strong (GSg Utr)) Nom))"
 <+>
 lemma "VV" "s (VI (VPtPret (Strong (GSg Neutr)) Nom))"
 <+>
 lemma "VV" "s (VI (VPtPret (Strong GPl) Nom))"
 <+>
 lemma "VS" "s (VI (VPtPret (Strong (GSg Utr)) Nom))"
 <+>
 lemma "VS" "s (VI (VPtPret (Strong (GSg Neutr)) Nom))"
 <+>
 lemma "VS" "s (VI (VPtPret (Strong GPl) Nom))"

pAdA :: Translator Expr
pAdA = inside "AB" $ do a <- lemma "A" "s (AF (APosit (Strong (GSg Neutr))) Nom)"
                        return (mkApp cidPositAdAAdj [mkApp a[]])
                    <+>
                     do ada <- optEat (lemma "AdA" "s") meta
                        return (mkExpr ada)

adv :: [String]
adv = ["RA","TA","MA","+A","CA","VA"]

pAdv :: Translator Expr
pAdv = pAdv' adv 

pAdvMinus,pAdv' :: [String] -> Translator Expr
pAdvMinus xs = pAdv' $ adv \\ xs

pAdv' xs = 
  msum [ inside x inAdv | x <- xs]
  <+>
  do write "looking for adv in AA1"
     inside "AA" pAA
     
inAdv :: Translator Expr
inAdv = findAdverb <+> cat "PP" <+> cat "NP" <+> cat "AVP"

pAA :: Translator Expr
pAA =     cat "PP" 
      <+> pAdvAdj 
      <+> pAdv
      <+> findAdverb
      <+> inside "S" pUttAdv
      <+> cat "AVP"

pIAdv :: Translator Expr
pIAdv =
  msum [ inside x (cat "AVP") | x <- ["RA","TA"]]
  <+>
  do write "making a question"
     a <- inside "AB" $ lemma "IAdv" "s"
     return $ mkExpr a
  

findAdverb :: Translator Expr
findAdverb = do
  a <- inside "AB" $ optEat (lemma "Adv" "s Per3") meta
  write $ "adverb found "++show a
  return (mkExpr a) 
 
pAdvAdj :: Translator Expr
pAdvAdj = do
  a <- findAdj
  return $ mkApp cidPositAdvAdj [a]
 
pAdAdj :: Translator Expr
pAdAdj = liftM (\a -> mkApp cidPositAdAAdj [a]) findAdj         

pIQuant :: Translator Expr
pIQuant = inside "PO" piq
 where piq =    
            do dt <- lemma "IQuant" "s Sg Utr" 
                     <+>
                     lemma "IQuant" "s Sg Neutr"
               write ("det: "++show dt)
               returnApp cidDetQuant [mkExpr dt,mkExpr cidNumSg] 
            <+>
            do dt <- lemma "IQuant" "s Pl Utr"
                     <+>
                     lemma "IQuant" "s Pl Neutr"
               write ("det: "++show dt)
               returnApp cidDetQuant [mkExpr dt,mkExpr cidNumPl] 

pQuant :: Translator Expr
pQuant =
  do w <- word "PODP"   -- to avoid this_Quant when it should be DefArt
     let den = map toLower w
     guard (den=="den" || den=="det")                               
     returnApp cidDetQuant [mkExpr cidDefArt,mkExpr cidNumSg]
  <+>                                                       
  inside "PO" (   --
       do dt <-   lemma "Quant" "s Per3 Sg False False Utr" 
              <+> lemma "Quant" "s Per3 Sg False False Neutr"
          write ("det: "++show dt)
          returnApp cidDetQuant [mkExpr dt,mkExpr cidNumSg] 
       <+>
       do dt <- lemma "Quant" "s Per3 Pl False False Utr"
                <+> 
                lemma "Quant" "s Per3 Pl False False Neutr"
          write ("det: "++show dt)
          returnApp cidDetQuant [mkExpr dt,mkExpr cidNumPl]) 
  <+>
  -- no case for singular
  do w <- inside "PO" $ lemma "PronAQ" "s (AF (APosit (Strong GPl)) Nom)"
     return $ mkApp cidDetQuant [mkApp cidQuantPronAQ [mkExpr w],mkExpr cidNumPl]
  <+>
  do dt <- inside "PO" $ lemma "Pron" "s Per3 (NPPoss GPl Nom)"
     return $ mkApp cidDetQuant [mkApp cidPossPron [mkExpr dt],mkExpr cidNumPl]
  <+>
  do dt <- inside "PO" $ lemma "Det" "s Per3 False Utr"
     write ("det: "++show dt)
     return $ mkExpr dt 
  <+>
  do dt <- inside "PO" $ mplus (lemma "Pron" "s Per3 (NPPoss (GSg Neutr) Nom)")
                               (lemma "Pron" "s Per3 (NPPoss (GSg Utr) Nom)")
     return $ mkApp cidDetQuant [mkApp cidPossPron [mkExpr dt],mkExpr cidNumSg]
  <+>
  do n <- pNumber 
     return $ mkApp cidDetQuant [mkExpr cidIndefArt,mkApp cidNumCard [n]]
 <+>
  do inside "EN" $ mplus (lemma "Quant" "s Per3 Sg False False Utr")
                         (lemma "Quant" "s Per3 Sg False False Neutr")
     return $ mkApp cidDetQuant [mkExpr cidIndefArt,mkExpr cidNumSg]
  <+>
  do n <- pNumber 
     return $ mkApp cidDetQuant [mkExpr cidIndefArt,mkApp cidNumCard [n]]
  <+>
  do p <- inside "POXPHHGG" $ lemma "Pron" "s Per3 (NPPoss (GSg Utr) Nom)"
     return $ mkApp cidDetQuant [mkApp cidPossPron [mkExpr p]]
  <+>
  -- genitiv nouns
  do (n,num,def) <- insideSuff "GG" pNounGen
     let dt = mkApp cidDetQuant [mkExpr (getDef def),mkExpr num] 
         np = mkApp cidDetCN [dt,mkApp cidUseN [n]]
     return $ mkApp cidDetQuant [mkApp cidGenNP [np]] 
     



pDetRefl :: Translator Expr
pDetRefl =         
  do word "POXP" 
     write "setting it to true"
     return (mkExpr cidReflIdPron) 


pN2 :: Translator (Expr,Expr,Expr)
pN2 = 
  do np <- cat "NP"
     return (np,mkExpr cidNumSg, mkExpr cidDefArt) 
  <+>
  inside "NNDD" (do n <- lemma "N2" "s Pl Def Nom"
                    return (mkExpr n,mkExpr cidNumPl,mkExpr cidDefArt)
                  <+>
                  do n <- lemma "N2" "s Sg Def Nom" 
                     return (mkExpr n,mkExpr cidNumSg,mkExpr cidDefArt) 
                  <+>
                  do n <- lemma "N2" "s Sg Indef Nom" 
                     return (mkExpr n,mkExpr cidNumSg,mkExpr cidIndefArt) 
                  <+>
                  do n <- lemma "N2" "s Pl Indef Nom"
                     return (mkExpr n,mkExpr cidNumPl,mkExpr cidIndefArt))

pAppos :: Translator Expr
pAppos = do inside "XP" consume 
            return (mkExpr meta)

pPConj :: Translator Expr
pPConj = 
  do s <- inside "++" $ lemma "PConj" "s"
     return (mkExpr s)
  <+>
  do s <- inside "++" $ lemma "Conj" "s2"
     return (mkApp cidPConjConj [mkExpr s])

pConj :: Translator Expr
pConj = 
  do word "++OC"
     return $ mkExpr cidAndConj
  <+>
  do word "++EL"
     return $ mkExpr cidOrConj
  <+>
  do s <- inside "++" $ lemma "Conj" "s2"
     return (mkExpr s)
    
pSubj :: Translator Expr
pSubj = do 
  s <- inside "UK" $ optEat (lemma "Subj" "s") meta
  return $ mkExpr s 

pCopula, pHave :: Translator (VForm CId)
pCopula  = write "copula?" >> tense "AV"
pHave    = write "have"    >> tense "HV"  

pFuturum :: Translator (VForm CId)
pFuturum = do write "futurum?"
              t <- tense "SV"
              write ("futurum: "++show t)
              if isVTenseForm cidTPres t then return (VTense cidTFut)
                                         else return (VTense cidTCond) -- ?

pFuturumKommer :: Translator (VForm CId)
pFuturumKommer = do
               t <- tense "KV"
               write ("futurum kom att: "++show t)
               return (VTense cidTFutKommer)
  
tense :: String -> Translator (VForm CId)
tense cat =
  do word $ cat++"IV"    
     return VInf
  <+>
  do word $ cat++"PK" 
     return VPart
  <+>
  do word $ cat++"PS"
     write "presens"
     return (VTense cidTPres)
  <+>
  do word $ cat++"PT"
     return (VTense cidTPast)
  <+>
  do word $ cat++"SN" 
     return VSupin
  <+>
  do word $ cat++"IP"
     return VPart    
   
pPrep :: Translator Expr
pPrep = do write "in pPrep"
           p <- inside "PR" $ optEat (lemma "Prep" "s") meta
           return $ mkExpr p

pPredet :: Translator Expr
pPredet = 
  do w <- findPredet
     return $ mkExpr w 
  <+> parsePredetAdv

 where findPredet = do w <- word "PO"
                       let wd = map toLower w
                       guard (wd /="den" && wd /="det")
                       write "in pPredet with PO"
                       wordlookup w "Predet" "s Neutr Pl"
                        <+>
                        wordlookup w "Predet" "s Utr Pl"
                        <+>
                        wordlookup w "Predet" "s Utr Sg"
                        <+>
                        wordlookup w "Predet" "s Neutr Sg"
       parsePredetAdv = inside "AB" $ do 
                          w <- lemma "Adv" "s"
                          return (mkApp cidPredetAdvF [mkExpr w])


                       


-- translate all numers to 1. could also be NumNumeral ( num (pot... n1))
pNumber :: Translator Expr
pNumber = 
  inside "RO" $ do consume
                   return $ mkApp cidNumDigits 
                          [mkApp cidIDig 
                             [mkExpr cidD_1]] 

pPol :: Translator (Maybe Bool)
pPol =
  do w  <- cat "NA"
     return (Just False)
  <+>
     return (Just True)

listOf :: Translator a -> Translator [a]
listOf f = 
  many $ do
   a <- inside "CJ" f 
   word2 "IK"
   return a

conjunct :: CId -> CId -> CId -> Translator Expr -> Translator Expr
conjunct consf basef conjf f =
  do xs   <- listOf f
     write $ "found list of " ++show xs
     x1   <- inside "CJ" f
     write $ "found first conj " ++show x1
     conj <- inside "++" pConj 
     write $ "found  conj " ++show conj 
     x2   <- inside "CJ" f
     write $ "found snd conj " ++show x2
     let compXs x y = mkApp consf [x,y]
         conjs      = foldr  compXs (mkApp basef [x1,x2]) xs
     return $ mkApp conjf [conj, conjs]


adjSN, adjSU, adjSPl, adjWPl, adjWSg :: String
adjSN = "s (AF (APosit (Strong (GSg Neutr))) Nom)"
adjSU = "s (AF (APosit (Strong (GSg Utr))) Nom)"
adjSPl = "s (AF (APosit (Strong GPl)) Nom)"
adjWPl = "s (AF (APosit (Weak Pl)) Nom)"
adjWSg = "s (AF (APosit (Weak Sg)) Nom)" 

meta :: CId
meta = mkCId "?"

mkExpr :: CId -> Expr
mkExpr x = mkApp x []

mkPol :: Maybe Bool -> Expr
mkPol (Just True)  = mkExpr cidPPos 
mkPol (Just False) = mkExpr cidPNeg 
mkPol Nothing      = mkExpr meta 


returnApp :: CId -> [Expr] -> Translator Expr
returnApp cid exs = do
  t <- gets S.sentenceType
  return $ mkApp (getCId t cid) exs 

localKeepPol :: Translator a -> Translator a
localKeepPol m = do
  (x,st) <- local m
  S.pol =: P.get S.pol st
  return x

local :: Translator a -> Translator (a,S.State)
local m = do 
  st  <- get
  x   <- m
  loc <- get
  put st
  return (x,loc)


--For embedded clauses where the state should be cleared and later reset
putStateToZero :: Translator S.State
putStateToZero = do
  st <- get
  put S.startState
  return st

resetState :: S.State -> Translator ()
resetState = put

getCId :: SentenceType -> CId -> CId
getCId Q  c | c == cidCompNP   = cidCompIP
            | c == cidCompAdv  = cidCompIAdv
            | c == cidDetCN    = cidIdetCN
            | c == cidDetQuant = cidIdetQuant
            | c == cidPrepNP   = cidPrepIP
getCId _ c = c
  
fst3 :: (a,b,c) -> a
fst3 (a,_,_) = a
third :: a -> (VForm CId,Expr) -> (VForm CId,Expr,a)
third x = uncurry (,,x)

testa :: String -> IO [(Lemma, Analysis, String)]
testa  str = do
  pgf <- readPGF "../gf/BigTest.pgf"
  let Just language = readLanguage "BigTestSwe"
      morpho        = buildMorpho pgf language
  return [(lemma,an,cat) | (lemma,an) <- lookupMorpho morpho str
         ,let cat = maybe "" (showType []) (functionType pgf lemma)]

