--# -path=.:../foods:present:prelude

concrete FoodsEni of Foods = FoodsI with 
    (Syntax = SyntaxEng),
    (LexFoods = LexFoodsEng) ;
