instance LexMathSwe of LexMath = 
  open SyntaxSwe, ParadigmsSwe, (L = LexiconSwe) in {

oper
  zero_PN = mkPN "noll" neutrum ;
  successor_N2 = mkN2 (mkN "efterföljare" "efterföljare") (mkPrep "till") ;
  sum_N2 = mkN2 (mkN "summa") (mkPrep "av") ;
  product_N2 = mkN2 (mkN "produkt" "produkter") (mkPrep "av") ;
  even_A = mkA "jämn" ;
  odd_A = mkA "udda" "udda" ;
  prime_A = mkA "prim" ;
  equal_A2 = mkA2 (mkA "lika" "lika") (mkPrep "med") ;
  small_A = L.small_A ;
  great_A = L.big_A ;
  divisible_A2 = mkA2 (mkA "delbar") (mkPrep "med") ;
  number_N = mkN "tal" "tal" ;

}
