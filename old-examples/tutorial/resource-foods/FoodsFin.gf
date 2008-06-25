--# -path=.:../foods:present:prelude

concrete FoodsFin of Foods = FoodsI with 
  (Syntax = SyntaxFin),
  (LexFoods = LexFoodsFin) ;
