--# -path=.:alltenses

concrete FreDescr of Fre = IrregFre - [S] ** open (R = CommonRomance), Prelude in {

flags coding=utf8 ;

lincat 
  Display, Word, Form = Str ;
  TMood, Number, Person, NumPersI, Gender, Mood = Str ;

lin
--  DAll w = w ++ ":" ++ "la conjugaison" ;

  DForm w f = w ++ ":" ++ f ;

  VInfin = "infinitif" ;
  VFin m n p = m ++ n ++ p ;
  VImper np = "impératif" ++ np ;
  VPart g n = "participe passé" ++ g ++ n ;
  VGer = "participe présent" ;

  VPres m = m ++ "présent" ;
  VImperf m = m ++ "imparfait" ;
  VPasse = "passé simple" ;
  VFut = "futur" ;
  VCondit = "conditionnel" ;

  SgP2 = "singulier 2e" ;
  PlP1 = "pluriel 1ère" ;
  PlP2 = "pluriel 2e" ;
  Sg = "singulier" ;
  Pl = "pluriel" ;
  P1 = "1ère" ;
  P2 = "2e" ;
  P3 = "3e" ;
  Masc = "masculin" ;
  Fem = "féminin" ;
  Indic = "indicatif" ;
  Conjunct = "subjonctif" ;

  WVerb v = v.s ! R.VInfin True ;
  WVerb2 v = v.s ! R.VInfin True ;

}
