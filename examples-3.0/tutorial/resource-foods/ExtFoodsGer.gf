--# -path=.:../foods:present:prelude

concrete ExtFoodsGer of ExtFoods = FoodsGer ** ExtFoodsI with 
    (Syntax = SyntaxGer),
    (LexFoods = LexFoodsGer) ;
