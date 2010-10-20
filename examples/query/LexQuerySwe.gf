instance LexQuerySwe of LexQuery = 
  open SyntaxSwe, (M = MakeStructuralSwe), ParadigmsSwe, ExtraSwe, IrregSwe in {

oper
  located_A : A = compoundA (mkA "belägen" "beläget" "belägna" [] []) ;

  give_V3 : V3 = mkV3 giva_V ;
  know_V2 = mkV2 veta_V ;

-- structural words
  about_Prep : Prep = mkPrep "om" ;
  all_NP : NP = mkNP (mkPN "allt") ; ---
  also_AdV : AdV = mkAdV "också" ;
  also_AdA : AdA = mkAdA "även" ;
  as_Prep : Prep = mkPrep "som" ;
  at_Prep : Prep = mkPrep "på" ; --- | mkPrep "hos" | mkPrep "vid" ;
  that_RP = which_RP ;

  participlePropCN : Prop -> CN -> CN = variants {} ;

  vpAP _ = mkAP (mkA "obefintlig") ; --- not used, see LexQuery.participlePropCN

  called_A : A = compoundA (mkA "kallad" "kallat" "kallade" "kallade" "kallade") ;

  information_N : N = mkN "information" "informationer" ;
  other_A : A = compoundA (mkA "annan" "annat" "andra" "andra" "andra") ;
  otherwise_AdV : AdV = mkAdV "annars" ;
  otherwise_AdA : AdA = mkAdA "annars" ;
  what_IQuant : IQuant = which_IQuant ;


}
