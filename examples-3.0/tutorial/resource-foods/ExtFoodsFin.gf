--# -path=.:../foods:present:prelude

concrete ExtFoodsFin of ExtFoods = FoodsFin ** ExtFoodsI with 
    (Syntax = SyntaxFin),
    (LexFoods = LexFoodsFin) ;
