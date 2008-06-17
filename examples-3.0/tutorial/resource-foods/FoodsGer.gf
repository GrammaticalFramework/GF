--# -path=.:../foods:present:prelude

concrete FoodsGer of Foods = FoodsI with 
    (Syntax = SyntaxGer),
    (LexFoods = LexFoodsGer) ;
