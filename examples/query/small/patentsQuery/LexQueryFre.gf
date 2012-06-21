instance LexQueryFre of LexQuery = open ParadigmsFre, SyntaxFre, ExtraFre, IrregFre, Prelude in {

oper
  about_Prep = on_Prep ;
  also_AdV = lin AdV (ss "aussi") ;
  as_Prep = mkPrep "comme" ;
  at_Prep = mkPrep "chez" ;
  called_A = mkA "appelé" ;
  give_V3 = mkV3 (mkV "montrer") ;
  information_N = mkN "information" ;
  other_A = prefixA (mkA "autre") ;
  name_N = mkN "nom" ;
  all_NP = mkName "tout" ; ----

-- lexical constructors
  mkName : Str -> NP =
    \s -> mkNP (mkPN s) ;

oper  
  mkRelation : Str -> {cn : CN ; prep : Prep} =
    \s -> {cn = mkCN (mkN s) ; prep = possess_Prep} ;

  that_RP = which_RP ;

}