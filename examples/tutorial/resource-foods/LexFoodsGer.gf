instance LexFoodsGer of LexFoods = open SyntaxGer, ParadigmsGer, IrregGer in {
  oper
    wine_N = mkN "Wein" ;
    pizza_N = mkN "Pizza" "Pizzen" feminine ;
    cheese_N = mkN "Käse" "Käsen" masculine ;
    fish_N = mkN "Fisch" ;
    fresh_A = mkA "frisch" ;
    warm_A = mkA "warm" "wärmer" "wärmste" ;
    italian_A = mkA "italienisch" ;
    expensive_A = mkA "teuer" ;
    delicious_A = mkA "köstlich" ;
    boring_A = mkA "langweilig" ;

    eat_V2 = mkV2 essen_V ;
    drink_V2 = mkV2 trinken_V ;
    pay_V2 = mkV2 (mkV "bezahlen") ;
    lady_N = mkN "Frau" "Frauen" feminine ;
    gentleman_N = mkN "Herr" "Herren" masculine ;

}
