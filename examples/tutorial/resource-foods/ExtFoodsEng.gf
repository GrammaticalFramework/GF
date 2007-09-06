--# -path=.:../foods:present:prelude

concrete ExtFoodsEng of ExtFoods = FoodsEni ** ExtFoodsI with 
    (Syntax = SyntaxEng),
    (LexFoods = LexFoodsEng) ;
