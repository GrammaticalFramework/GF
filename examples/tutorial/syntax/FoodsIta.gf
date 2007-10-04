--# -path=.:../foods:prelude

concrete FoodsIta of Foods = FoodsI with 
    (Syntax = SyntaxIta),
    (Test = TestIta) ;
