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
  WeNumNP = pronWithNum pronMe ;
  YeNumNP   = pronWithNum pronTe ;
  YouNP  = pronNounPhrase pronTe ;
  TheyNP = pronNounPhrase pronHe ; --- ne

  ItNP   = nameNounPhrase pronSe ;
  ThisNP = pronNounPhraseNP pronTama ;
  ThatNP = pronNounPhraseNP pronTuo ;
  TheseNumNP = pronWithNum pronNama ;
  ThoseNumNP = pronWithNum pronNuo ;

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

--- This two don't work in Finnish except out of context
--- ("kenet tapasitte - emme ket‰‰n").

  NobodyNP = {
    s = \\f => "ei" ++ kukaanPron ! Sg ! (npForm2Case Sg f) ; 
    n = Sg ;
    p = NP3
    } ;
  NothingNP = {
    s = \\f => "ei" ++ mikaanPron ! Sg ! (npForm2Case Sg f) ; 
    n = Sg ;
    p = NP3
    } ;
  
  EveryDet = jokainenDet ; 
  AllMassDet   = mkDeterminer singular (kaikkiPron Sg) ; 
  AllNumDet  = kaikkiDet ; 
  WhichDet = mikaDet ;
  WhichNumDet n = mkDeterminerGenNum n (mikaInt ! Pl) (kukaInt ! Pl) ;
  MostDet  = mkDeterminer singular (caseTable singular (sSuurin "enint‰")) ;
  MostsDet  = useimmatDet ;
  ManyDet = mkDeterminer singular moniPron ; 
  MuchDet = mkDeterminer singular (caseTable singular (sNauris "runsasta")) ;

--- The following 4 only work this way in Finnish if used outside sentences
--- with a verb.
 
  AnyDet = mkDeterminerGen Sg (mikaanPron ! Sg) (kukaanPron ! Sg) ;
  AnyNumDet n = mkDeterminerGenNum n (mikaanPron ! Pl) (kukaanPron ! Pl) ;
  NoDet = mkDeterminerGen Sg 
            (\\c => "ei" ++ mikaanPron ! Sg ! c) 
            (\\c => "ei" ++ kukaanPron ! Sg ! c) ;
  NoNumDet n = mkDeterminerGenNum n 
            (\\c => "ei" ++ mikaanPron ! Pl ! c) 
            (\\c => "ei" ++ kukaanPron ! Pl ! c) ;

  ThisDet = mkDeterminer Sg (\\c => pronTama.s ! PCase c) ;
  ThatDet = mkDeterminer Sg (\\c => pronTuo.s ! PCase c) ;
  TheseNumDet n = mkDeterminerNum n (\\c => pronNama.s ! PCase c) ;
  ThoseNumDet n = mkDeterminerNum n (\\c => pronNuo.s ! PCase c) ;

  SomeDet  = mkDeterminerGen Sg (jokinPron ! Sg) (jokuPron ! Sg) ;
  SomeNumDet n = mkDeterminerGenNum n (jokinPron ! Pl) (jokuPron ! Pl) ;

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
  PossessPrep = prepCase Gen ;
  PartPrep = prepCase Part ;
  AgentPrep = prepPostpGen "toimesta" ;

}
