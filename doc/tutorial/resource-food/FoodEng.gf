--# -path=.:present:prelude

concrete FoodEng of Food = FoodI - [Pizza] with 
  (Syntax = SyntaxEng),
  (LexFood = LexFoodEng) ** 
    open SyntaxEng, ParadigmsEng in {

  lin Pizza = mkCN (mkA "Italian") (mkN "pie") ;
}
