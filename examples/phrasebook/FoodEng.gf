-- (c) 2009 Aarne Ranta under LGPL

concrete FoodEng of Food = SentencesEng ** 
    open SyntaxEng, ParadigmsEng in {
  lin
    Wine = mkCN (mkN "wine") ;
    Pizza = mkCN (mkN "pizza") ;
    Cheese = mkCN (mkN "cheese") ;
    Fish = mkCN (mkN "fish" "fish") ;
    Fresh = mkAP (mkA "fresh") ;
    Warm = mkAP (mkA "warm") ;
    Italian = mkAP (mkA "Italian") ;
    Expensive = mkAP (mkA "expensive") ;
    Delicious = mkAP (mkA "delicious") ;
    Boring = mkAP (mkA "boring") ;

}
