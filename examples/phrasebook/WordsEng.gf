-- (c) 2009 Aarne Ranta under LGPL

concrete WordsEng of Words = SentencesEng ** 
    open SyntaxEng, ParadigmsEng in {
  lin
    Wine = mkCN (mkN "wine") ;
    Beer = mkCN (mkN "beer") ;
    Water = mkCN (mkN "water") ;
    Coffee = mkCN (mkN "coffee") ;
    Tea = mkCN (mkN "tea") ;

    Pizza = mkCN (mkN "pizza") ;
    Cheese = mkCN (mkN "cheese") ;
    Fish = mkCN (mkN "fish" "fish") ;
    Fresh = mkAP (mkA "fresh") ;
    Warm = mkAP (mkA "warm") ;
    Italian = mkAP (mkA "Italian") ;
    Expensive = mkAP (mkA "expensive") ;
    Delicious = mkAP (mkA "delicious") ;
    Boring = mkAP (mkA "boring") ;

    Restaurant = mkCN (mkN "restaurant") ;
    Bar = mkCN (mkN "bar") ;
    Toilet = mkCN (mkN "toilet") ;

    Euro = mkCN (mkN "euro" "euros") ; -- to prevent euroes
    Dollar = mkCN (mkN "dollar") ;
    Lei = mkCN (mkN "leu" "lei") ;

}
