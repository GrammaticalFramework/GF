--# -path=.:present:prelude

concrete FoodFin of Food = FoodI with 
  (Syntax = SyntaxFin),
  (LexFood = LexFoodFin) ;
