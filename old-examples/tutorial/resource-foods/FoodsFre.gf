--# -path=.:../foods:present:prelude

concrete FoodsFre of Foods = FoodsI with 
  (Syntax = SyntaxFre),
  (LexFoods = LexFoodsFre) ;
