--# -path=.:..:../../abstract:../../common:../../api

--1 LargeFinAbs: large-scale parsing of Finnish with tagged lexicon

concrete LargeFin of LargeFinAbs = 
  NounFin,
  VerbFin, 
  AdjectiveFin,
  AdverbFin,
--  NumeralFin,
  SentenceFin, 
  QuestionFin,
  RelativeFin,
  ConjunctionFin,
  PhraseFin,
--  StructuralFin - [mkPronoun],
  IdiomFin,
  TenseX
----  ,ExtraFin
--  ,WordsFin
  ** open TagFin, StemFin, ResFin, ParadigmsFin, Prelude in {

lincat
  Top = {s : Str} ;
  Punct = {s : Str} ;
lin
  PhrPunctTop phr pu = {s = phr.s ++ pu.s} ;
  PhrTop phr = phr ;
  
  thePunct = {s = tagPOS "PUNCT" ""} ;

lin
  theN = mkN [] ;
  theA = mkA [] ;
  theV = mkSVerb [] ** {sc = SCNom ; p = []} ;
  theAdv = mkAdv [] ;

  theV2 = mkV2 theV ; ---- plus other complement cases?

  sg1Pron = mkPron Sg P1 ;
  sg2Pron = mkPron Sg P2 ;
  sg3Pron = mkPron Sg P3 ;
  pl1Pron = mkPron Pl P1 ;
  pl2Pron = mkPron Pl P2 ;
  pl3Pron = mkPron Pl P3 ;

  theConj = {s1 = [] ; s2 = tagPOS "CONJ" [] ; n = Sg} ;
  theDistrConj = {s1,s2 = tagPOS "CONJ" [] ; n = Sg} ;
  theSubj = {s = tagPOS "SCONJ" []} ;
  

oper
  mkPron : Number -> Person -> Pron = \n,p -> lin Pron {
    s = \\npf => tagWord (tagPron "Prs" (Ag n p) npf) (mkTag "PRON")  ;
    a = Ag n p ;
    hasPoss = True ;
    poss = [] ; ----
    } ;


}