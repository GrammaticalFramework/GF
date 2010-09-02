concrete SentencesGer of Sentences = NumeralGer ** SentencesI - 
  [PYesToNo,SHaveNo,SHaveNoMass,
   Proposition, Action, Is, IsMass, SProp, SPropNot, QProp,
   AHaveCurr, ACitizen, ABePlace, AKnowSentence, AKnowPerson, AKnowQuestion
  ] with 
  (Syntax = SyntaxGer),
  (Symbolic = SymbolicGer),
  (Lexicon = LexiconGer) ** open Prelude, SyntaxGer in {

  lin 
    PYesToNo = mkPhrase (lin Utt (ss "doch")) ;
    SHaveNo p k = mkS (mkCl p.name have_V2 (mkNP no_Quant plNum k)) ;
    SHaveNoMass p k = mkS (mkCl p.name have_V2 (mkNP no_Quant k)) ;

  lincat
    Proposition, Action = Prop ;
  oper
    Prop = {pos : Cl ; neg : S} ;  -- x F y ; x F nicht/kein y
    mkProp : Cl -> S -> Prop = \pos,neg -> {pos = pos ; neg = neg} ;
    prop : Cl -> Prop = \cl -> mkProp cl (mkS negativePol cl) ;
  lin
    Is i q = prop (mkCl i q) ;
    IsMass m q = prop (mkCl (mkNP m) q) ;
    SProp p = mkS p.pos ;
    SPropNot p = p.neg ;
    QProp p = mkQS (mkQCl p.pos) ;

    AHaveCurr p curr = prop (mkCl p.name have_V2 (mkNP aPl_Det curr)) ;
    ACitizen p n = prop (mkCl p.name n) ;
    ABePlace p place = prop (mkCl p.name place.at) ;

    AKnowSentence p s = prop (mkCl p.name Lexicon.know_VS s) ;
    AKnowQuestion p s = prop (mkCl p.name Lexicon.know_VQ s) ;
    AKnowPerson p q = prop (mkCl p.name Lexicon.know_V2 q.name) ;

}
