instance LexFoodsSwe of LexFoods = open SyntaxSwe, ParadigmsSwe, IrregSwe in {
  oper
    wine_N = mkN "vin" "vinet" "viner" "vinerna" ;
    pizza_N = mkN "pizza" ;
    cheese_N = mkN "ost" ;
    fish_N = mkN "fisk" ;
    fresh_A = mkA "färsk" ;
    warm_A = mkA "varm" ;
    italian_A = mkA "italiensk" ;
    expensive_A = mkA "dyr" ;
    delicious_A = mkA "läcker" "läckert" "läckra" "läckrare" "läckrast" ;
    boring_A = mkA "tråkig" ;

    eat_V2 = mkV2 (mkV "äta" "åt" "ätit") ;
    drink_V2 = mkV2 (mkV "dricka" "drack" "druckit") ;
    pay_V2 = mkV2 "betala" ;
    lady_N = mkN "dam" "damer" ;
    gentleman_N = mkN "herr" ;

}
