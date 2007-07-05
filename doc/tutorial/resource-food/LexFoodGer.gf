instance LexFoodGer of LexFood = open SyntaxGer, ParadigmsGer in {

  oper
    wine_N = mkN "Wein" ;
    beer_N = mkN "Bier" "Biere" neuter ;
    pizza_N = mkN "Pizza" "Pizzen" feminine ;
    cheese_N = mkN "Käse" "Käsen" masculine ;
    fish_N = mkN "Fisch" ;
    fresh_A = mkA "frisch" ;
    warm_A = mkA "warm" "wärmer" "wärmste" ;
    italian_A = mkA "italienisch" ;
    expensive_A = mkA "teuer" ;
    delicious_A = mkA "köstlich" ;
    boring_A = mkA "langweilig" ;

}
