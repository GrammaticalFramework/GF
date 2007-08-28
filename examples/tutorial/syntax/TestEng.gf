--# -path=.:resource:prelude

concrete TestEng of Test = SyntaxEng ** open Prelude, MorphoEng in {

  lin
    wine_N = mkN "wine" ;
    cheese_N = mkN "cheese" ;
    fish_N = mkN "fish" "fish" ;
    pizza_N = mkN "pizza" ;
    waiter_N = mkN "waiter" ;
    customer_N = mkN "customer" ;
    fresh_A = mkA "fresh" ;
    warm_A = mkA "warm" ;
    italian_A = mkA "Italian" ;
    expensive_A = mkA "expensive" ;
    delicious_A = mkA "delicious" ;
    boring_A = mkA "boring" ;
    stink_V = mkV "stink" ;
    eat_V2 = mkV2 (mkV "eat") ;
    love_V2 = mkV2 (mkV "love") ;
    talk_V2 = mkV2 (mkV "talk") "about" ;
}

