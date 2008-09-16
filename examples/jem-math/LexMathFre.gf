instance LexMathFre of LexMath = 
  open SyntaxFre, ParadigmsFre, (L = LexiconFre) in {

oper
  zero_PN = mkPN "zéro" ;
  successor_N2 = mkN2 (mkN "successeur") genitive ;
  sum_N2 = mkN2 (mkN "somme") genitive ;
  product_N2 = mkN2 (mkN "produit") genitive ;
  even_A = mkA "pair" ;
  odd_A = mkA "impair" ;
  prime_A = mkA "premier" ;
  equal_A2 = mkA2 (mkA "égal") dative ;
  small_A = L.small_A ;
  great_A = L.big_A ;
  divisible_A2 = mkA2 (mkA "divisible") (mkPrep "par") ;
  number_N = mkN "entier" ;

}
