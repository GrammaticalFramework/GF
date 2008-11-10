--# -path=.:../foods:present:prelude

instance LexFoodsFre of LexFoods = open SyntaxFre,ParadigmsFre,IrregFre in {
  oper
    wine_N = mkN "vin" ;
    pizza_N = mkN "pizza" feminine ;
    cheese_N = mkN "fromage" masculine ;
    fish_N = mkN "poisson" ;
    fresh_A = mkA "frais" "fraîche" "frais" "fraîches";
    warm_A = mkA "chaud" ;
    italian_A = mkA "italien" ;
    expensive_A = mkA "cher" ;
    delicious_A = mkA "délicieux" ;
    boring_A = mkA "ennuyeux" ;
    drink_V2 = boire_V2 ;
    eat_V2 = mkV2 (mkV "manger") ;
    pay_V2 = mkV2 (mkV "payer") ;
    gentleman_N = mkN "monsieur" "messieurs" masculine ;
    lady_N = mkN "madame" "mesdames" feminine ;
}
