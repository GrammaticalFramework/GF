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
  ItNP   = nameNounPhrase pronSe ;
  WeNP   = pronNounPhrase pronMe ;
  YeNP   = pronNounPhrase pronTe ;
  YouNP  = pronNounPhrase pronTe ;
  TheyNP = pronNounPhrase pronHe ; --- ne

  EveryDet = jokainenDet ; 
  AllDet   = kaikkiDet ; 
  WhichDet = mikaDet ;
  MostDet  = useimmatDet ;

  HowIAdv = ss "kuinka" ;
  WhenIAdv = ss "koska" ;
  WhereIAdv = ss "missä" ;
  WhyIAdv = ss "miksi" ;

  AndConj = ss "ja" ** {n = Pl} ;
  OrConj = ss "tai" ** {n = Sg} ;
  BothAnd = sd2 "sekä" "että" ** {n = Pl} ;
  EitherOr = sd2 "joko" "tai" ** {n = Sg} ;
  NeitherNor = sd2 "ei" "eikä" ** {n = Sg} ;
  IfSubj = ss "jos" ;
  WhenSubj = ss "kun" ;
  AlthoughSubj = ss "vaikka" ;

  PhrYes = ss ("Kyllä" ++ stopPunct) ;
  PhrNo = ss ("Ei" ++ stopPunct) ;

  VeryAdv = ss "hyvin" ;
  TooAdv = ss "liian" ;
  OtherwiseAdv = ss "muuten" ;
  ThereforeAdv = ss "siksi" ;

}
