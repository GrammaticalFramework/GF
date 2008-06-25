--# -path=.:../foods:prelude

concrete FoodsEng of Foods = FoodsI with 
    (Syntax = SyntaxEng),
    (Test = TestEng) ;
