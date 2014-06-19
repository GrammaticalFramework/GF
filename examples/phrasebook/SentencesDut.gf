concrete SentencesDut of Sentences = NumeralDut ** SentencesI - 
  [SHaveNo,SHaveNoMass,
   Proposition,Action, Is, IsMass, SProp, SPropNot, QProp,
   AHaveCurr, ACitizen, ABePlace, AKnowSentence, AKnowPerson, AKnowQuestion,
----   QDoHave, QWhereDoVerbPhrase, QWhereModVerbPhrase, SHave, 
   SHaveNo,
   QModVerbPhrase, 
   ADoVerbPhrase, AModVerbPhrase, ADoVerbPhrasePlace, AModVerbPhrasePlace]
  with 
  (Syntax = SyntaxDut),
  (Symbolic = SymbolicDut),
  (Lexicon = LexiconDut) ** open Prelude, SyntaxDut in {

  lincat
    Proposition, Action = Prop ;
  oper
    Prop = {pos : Cl ; neg : S} ;  -- x F y ; x F niet/geen y
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

  lincat
    Nationality = {lang : CN ; country : NP ; prop : A} ;
    Language = CN ; -- kein Deutsch

-- the new things
  lin
    ADoVerbPhrase p vp = prop (mkCl p.name vp) ;
    AModVerbPhrase m p vp = prop (mkCl p.name (mkVP m vp)) ;
    ADoVerbPhrasePlace p vp x = prop (mkCl p.name (mkVP vp x.at)) ;
    AModVerbPhrasePlace m p vp x = prop (mkCl p.name (mkVP m (mkVP vp x.at))) ;

-- the old things
  lin 
    SHaveNo p k = mkS (mkCl p.name have_V2 (mkNP no_Quant plNum k)) ;
    SHaveNoMass p k = mkS (mkCl p.name have_V2 (mkNP no_Quant k)) ;

}

