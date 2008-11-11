--# -path=.:../foods:present:prelude

instance LexFoodsIta of LexFoods = open SyntaxIta, ParadigmsIta, BeschIta in {
  oper
    wine_N = mkN "vino" ;
    pizza_N = mkN "pizza" ;
    cheese_N = mkN "formaggio" ;
    fish_N = mkN "pesce" ;
    fresh_A = mkA "fresco" ;
    warm_A = mkA "caldo" ;
    italian_A = mkA "italiano" ;
    expensive_A = mkA "caro" ;
    delicious_A = mkA "delizioso" ;
    boring_A = mkA "noioso" ;
    drink_V2 = mkV2 (verboV (bere_27 "bere")) ;
    eat_V2 = mkV2 (mkV "mangiare") ;
    pay_V2 = mkV2 (mkV "pagare") ;
    gentleman_N = mkN "signore" ;
    lady_N = mkN "signora" ;
}
