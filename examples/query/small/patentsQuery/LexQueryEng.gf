instance LexQueryEng of LexQuery = open ParadigmsEng, SyntaxEng, ExtraEng, IrregEng in {

oper
-- structural words
  about_Prep = mkPrep "about" ;
  all_NP = mkNP (mkPN "all") ; ---
  also_AdV = mkAdV "also" | mkAdV "otherwise" ;
  as_Prep = mkPrep "as" ;
  at_Prep = mkPrep "at" ;
  called_A = mkA "called" | mkA "named" ;
  give_V3 = mkV3 give_V ;
  information_N = mkN "information" ;
  other_A = mkA "other" ;
  name_N = mkN "name" ;

-- lexical constructors
  mkName : Str -> NP =
    \s -> mkNP (mkPN s) ;

oper  
  mkRelation : Str -> {cn : CN ; prep : Prep} =
    \s -> {cn = mkCN (mkN s) ; prep = possess_Prep} ;

  that_RP = ExtraEng.that_RP ; 

}