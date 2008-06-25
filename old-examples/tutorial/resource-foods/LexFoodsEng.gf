instance LexFoodsEng of LexFoods = open SyntaxEng, ParadigmsEng, IrregEng in {
  oper
    wine_N = mkN "wine" ;
    pizza_N = mkN "pizza" ;
    cheese_N = mkN "cheese" ;
    fish_N = mkN "fish" "fish" ;
    fresh_A = mkA "fresh" ;
    warm_A = mkA "warm" ;
    italian_A = mkA "Italian" ;
    expensive_A = mkA "expensive" ;
    delicious_A = mkA "delicious" ;
    boring_A = mkA "boring" ;

    eat_V2 = mkV2 eat_V ;
    drink_V2 = mkV2 drink_V ;
    pay_V2 = mkV2 pay_V ;
    lady_N = mkN "lady" ;
    gentleman_N = mkN "gentleman" "gentlemen" ;

}
