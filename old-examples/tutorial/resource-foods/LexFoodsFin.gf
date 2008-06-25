instance LexFoodsFin of LexFoods = open SyntaxFin, ParadigmsFin in {
  oper
    wine_N = mkN "viini" ;
    pizza_N = mkN "pizza" ;
    cheese_N = mkN "juusto" ;
    fish_N = mkN "kala" ;
    fresh_A = mkA "tuore" ;
    warm_A = mkA "lämmin" ;
    italian_A = mkA "italialainen" ;
    expensive_A = mkA "kallis" ;
    delicious_A = mkA "herkullinen" ;
    boring_A = mkA "tylsä" ;

    eat_V2 = mkV2 (mkV "syödä") partitive ;
    drink_V2 = mkV2 (mkV "juoda") partitive ;
    pay_V2 = mkV2 (mkV "maksaa") ;
    lady_N = mkN "rouva" ;
    gentleman_N = mkN "herra" ;

}
