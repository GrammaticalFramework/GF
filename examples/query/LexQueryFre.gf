instance LexQueryFre of LexQuery = 
  open SyntaxFre, (M = MakeStructuralFre), ParadigmsFre, ExtraFre, IrregFre in {

oper
  located_A : A = mkA "situé" ;

  giveMe = \np -> mkVP (mkV2 (mkV "montrer")) np ; ---
  know_V2 = connaître_V2 ;

-- structural words
  about_Prep : Prep = mkPrep "sur" ;
  all_NP : NP = mkNP (mkPN "tout") ; ---
  also_AdV : AdV = mkAdV "aussi" ;
  also_AdA : AdA = mkAdA "aussi" ;
  as_Prep : Prep = mkPrep "pour" ; --- only used for "vad har X för Y"
  at_Prep : Prep = mkPrep "chez" ; --- | mkPrep "hos" | mkPrep "vid" ;
  that_RP = which_RP ;

  participlePropCN : Prop -> CN -> CN = variants {} ;

  vpAP _ = mkAP (mkA "nonexistant") ; --- not used, see LexQuery.participlePropCN

  called_A : A = mkA "appelé" ;

  information_N : N = mkN "information" feminine ;
  other_A : A = prefixA (mkA "autre") ;
  otherwise_AdV : AdV = mkAdV "autrement" ;
  otherwise_AdA : AdA = mkAdA "autrement" ;
  what_IQuant : IQuant = which_IQuant ;


}
