--# -path=.:../abstract:../../prelude

--1 The Top-Level Finnish Resource Grammar: Structural Words
--
-- Aarne Ranta 2002 -- 2003
--
concrete StructuralFin of Structural = 
                      CombinationsFin ** open Prelude, SyntaxFin in {
 lin

  INP    = pronNounPhrase pronMina ;
  ThouNP = pronNounPhrase pronSina ;
  HeNP   = pronNounPhrase pronHan ;
  SheNP  = pronNounPhrase pronHan ;
  WeNP   = pronWithNum pronMe ;
  YeNP   = pronWithNum pronTe ;
  YouNP  = pronNounPhrase pronTe ;
  TheyNP = pronNounPhrase pronHe ; --- ne

  ItNP   = nameNounPhrase pronSe ;
  ThisNP = pronNounPhraseNP pronTama ;
  ThatNP = pronNounPhraseNP pronTuo ;
  TheseNP = pronWithNum pronNama ;
  ThoseNP = pronWithNum pronNuo ;

  EverybodyNP = {
    s = \\f => kaikkiPron Pl ! (npForm2Case Pl f) ; -- n‰in kaikki
    n = Pl ;
    p = NP3
    } ;
  EverythingNP = {
    s = \\f => kaikkiPron Sg ! (npForm2Case Sg f) ; -- n‰in kaiken
    n = Sg ;
    p = NP3
    } ;

  SomebodyNP = {
    s = \\f => jokuPron ! Sg ! (npForm2Case Sg f) ;
    n = Sg ;
    p = NP3
    } ;
  SomethingNP = {
    s = \\f => jokinPron ! Sg ! (npForm2Case Sg f) ; -- n‰in kaiken
    n = Sg ;
    p = NP3
    } ;

  
  EveryDet = jokainenDet ; 
  AllDet   = mkDeterminer singular (kaikkiPron Sg) ; 
  AllsDet  = kaikkiDet ; 
  WhichDet = mikaDet ;
  WhichsDet n = mkDeterminerGenNum n (mikaInt ! Pl) (kukaInt ! Pl) ;
  MostDet  = mkDeterminer singular (caseTable singular (sSuurin "enint‰")) ;
  MostsDet  = useimmatDet ;
  ManyDet = mkDeterminer singular moniPron ; 
  MuchDet = mkDeterminer singular (caseTable singular (sNauris "runsasta")) ;


  ThisDet = mkDeterminer Sg (\\c => pronTama.s ! PCase c) ;
  ThatDet = mkDeterminer Sg (\\c => pronTuo.s ! PCase c) ;
  TheseDet n = mkDeterminerNum n (\\c => pronNama.s ! PCase c) ;
  ThoseDet n = mkDeterminerNum n (\\c => pronNuo.s ! PCase c) ;

  SomeDet  = mkDeterminerGen Sg (jokinPron ! Sg) (jokuPron ! Sg) ;
  SomesDet n = mkDeterminerGenNum n (jokinPron ! Pl) (jokuPron ! Pl) ;


  HowIAdv = ss "kuinka" ;
  WhenIAdv = ss "koska" ;
  WhereIAdv = ss "miss‰" ;
  WhyIAdv = ss "miksi" ;

  AndConj = ss "ja" ** {n = Pl} ;
  OrConj = ss "tai" ** {n = Sg} ;
  BothAnd = sd2 "sek‰" "ett‰" ** {n = Pl} ;
  EitherOr = sd2 "joko" "tai" ** {n = Sg} ;
  NeitherNor = sd2 "ei" "eik‰" ** {n = Sg} ;
  IfSubj = ss "jos" ;
  WhenSubj = ss "kun" ;
  AlthoughSubj = ss "vaikka" ;

  PhrYes = ss ("Kyll‰" ++ stopPunct) ;
  PhrNo = ss ("Ei" ++ stopPunct) ;

  VeryAdv = ss "hyvin" ;
  TooAdv = ss "liian" ;

  OtherwiseAdv = ss "muuten" ;
  ThereforeAdv = ss "siksi" ;

  CanVV = nomVerbVerb (vJuoda "voida") ;
  CanKnowVV = nomVerbVerb (vOsata "osata") ;
  MustVV = vHukkua "t‰yty‰" "t‰ydy" ** {c = CCase Gen} ;
  WantVV = nomVerbVerb (vOsata "haluta") ;

  EverywhereNP = ss "kaikkialla" ;
  SomewhereNP = ss "jossain" ;
  NowhereNP = ss ["ei miss‰‰n"] ;

  AlthoughSubj = ss "vaikka" ;

  AlmostAdv = ss "melkein" ;
  QuiteAdv = ss "aika" ;

  InPrep = prepCase Iness ;
  OnPrep = prepCase Adess ;
  ToPrep = prepCase Illat ; --- allat
  ThroughPrep = prepPostpGen "kautta" ;
  AbovePrep = prepPostpGen "yl‰puolella" ;
  UnderPrep = prepPostpGen "alla" ;
  InFrontPrep = prepPostpGen "edess‰" ;
  BehindPrep = prepPostpGen "takana" ;
  BetweenPrep = prepPostpGen "v‰liss‰" ;
  FromPrep = prepCase Elat ; --- ablat
  BeforePrep = prepPrep "ennen" Part ;
  DuringPrep = prepPostpGen "aikana" ;
  AfterPrep = prepPostpGen "j‰lkeen" ;
  WithPrep = prepPostpGen "kanssa" ;
  WithoutPrep = prepPrep "ilman" Part ;
  ByMeansPrep = prepPostpGen "avulla" ;
  PartPrep = prepCase Part ;
  AgentPrep = prepPostpGen "toimesta" ;

}
