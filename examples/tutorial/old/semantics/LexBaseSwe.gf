instance LexBaseSwe of LexBase = open SyntaxSwe, ParadigmsSwe in {

oper
  even_A = mkA "jämn" ;
  odd_A = invarA "udda" ;
  prime_A = mkA "prim" ;
  great_A = mkA "stor" "större" "störst" ;
  common_A = mkA "gemensam" ;
  equal_A2 = mkA2 (invarA "lika") (mkPrep "med") ;
  greater_A2 = mkA2 (invarA "större") (mkPrep "än") ; ---
  smaller_A2 = mkA2 (invarA "mindre") (mkPrep "än") ; ---
  divisible_A2 = mkA2 (mkA "delbar") (mkPrep "med") ;
  number_N = mkN "tal" "tal" ;
  sum_N2 = mkN2 (mkN "summa") (mkPrep "av") ;
  product_N2 = mkN2 (mkN "produkt") (mkPrep "av") ;
  divisor_N2 = mkN2 (mkN "delare") (mkPrep "av") ;

  none_NP = mkNP (mkPN "inget" neutrum) ; ---

  invarA : Str -> A = \x -> mkA x x x x x ; ---
 
}
