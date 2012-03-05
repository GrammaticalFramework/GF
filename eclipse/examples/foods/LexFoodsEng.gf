-- Lexicon Instance
instance LexFoodsEng of LexFoods = open SyntaxEng, ParadigmsEng in {
flags
  coding=utf8 ;
oper
  wine_N = mkN "wine" ;
  pizza_N = mkN "pizza" ;
  cheese_N = mkN "cheese" ;
  fish_N = mkN "fish" ;
  fresh_A = mkA "fresh" ;
  warm_A = mkA "warm" ;
  italian_A = mkA "Italian" ;
  expensive_A = mkA "expensive" ;
  delicious_A = mkA "delicious" ;
  boring_A = mkA "boring" ;
}
