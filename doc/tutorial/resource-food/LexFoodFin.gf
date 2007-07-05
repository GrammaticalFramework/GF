instance LexFoodFin of LexFood = open SyntaxFin, ParadigmsFin in {

  oper
    wine_N = mkN "viini" ;
    beer_N = mkN "olut" ;
    pizza_N = mkN "pizza" ;
    cheese_N = mkN "juusto" ;
    fish_N = mkN "kala" ;
    fresh_A = mkA "tuore" ;
    warm_A = mkA "lämmin" ;
    italian_A = mkA "italialainen" ;
    expensive_A = mkA "kallis" ;
    delicious_A = mkA "herkullinen" ;
    boring_A = mkA "tylsä" ;

}
