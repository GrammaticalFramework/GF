instance LexMathSpa of LexMath = 
  open SyntaxSpa, ParadigmsSpa, (L = LexiconSpa) in {

oper
  zero_PN = mkPN "cero" ;
  successor_N2 = mkN2 (mkN "sucesor") genitive ;
  sum_N2 = mkN2 (mkN "suma") genitive ;
  product_N2 = mkN2 (mkN "producto") genitive ;
  even_A = mkA "par" ;
  odd_A = mkA "impar" ;
  prime_A = mkA "primo" ;
  equal_A2 = mkA2 (mkA "igual") dative ;
  small_A = L.small_A ;
  great_A = L.big_A ;
  divisible_A2 = mkA2 (mkA "divisible") (mkPrep "por") ;
  number_N = mkN "entero" ;

}
