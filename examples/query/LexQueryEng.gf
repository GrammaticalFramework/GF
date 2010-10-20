instance LexQueryEng of LexQuery = 
  open SyntaxEng, (M = MakeStructuralEng), ParadigmsEng, ExtraEng, IrregEng in {

oper
  located_A : A = mkA "located" | mkA "situated" ;

  give_V3 : V3 = mkV3 give_V ;
  know_V2 = mkV2 know_V ;

-- structural words
  about_Prep : Prep = mkPrep "about" ;
  all_NP : NP = mkNP (mkPN "all") ; ---
  also_AdV : AdV = mkAdV "also" ;
  also_AdA : AdA = mkAdA "also" ;
  as_Prep : Prep = mkPrep "as" ;
  at_Prep : Prep = mkPrep "at" ;
  that_RP = ExtraEng.that_RP ;

  participlePropCN : Prop -> CN -> CN = \p,k -> mkCN p.ap k ;

  vpAP = PartVP ;

  called_A : A = mkA "called" | mkA "named" ;

  information_N : N = mkN "information" ;
  other_A : A = mkA "other" ;
  otherwise_AdV : AdV = mkAdV "otherwise" ;
  otherwise_AdA : AdA = mkAdA "otherwise" ;
  what_IQuant : IQuant = M.mkIQuant "what" "what" ;


}
