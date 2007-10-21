instance LexBaseEng of LexBase = open SyntaxEng, ParadigmsEng in {

oper
  even_A = mkA "even" ;
  odd_A = mkA "odd" ;
  prime_A = mkA "prime" ;
  great_A = mkA "great" ;
  common_A = mkA "common" ;
  equal_A2 = mkA2 (mkA "equal") (mkPrep "to") ;
  greater_A2 = mkA2 (mkA "greater") (mkPrep "than") ; ---
  smaller_A2 = mkA2 (mkA "smaller") (mkPrep "than") ; ---
  divisible_A2 = mkA2 (mkA "divisible") (mkPrep "by") ;
  number_N = mkN "number" ;
  sum_N2 = mkN2 (mkN "sum") (mkPrep "of") ;
  product_N2 = mkN2 (mkN "product") (mkPrep "of") ;
  divisor_N2 = mkN2 (mkN "divisor") (mkPrep "of") ;

  none_NP = mkNP (mkPN "none") ; ---

}
