--# -path=.:present:prelude

concrete FoodGer of Food = FoodI with 
  (Syntax = SyntaxGer),
  (LexFood = LexFoodGer) ;
