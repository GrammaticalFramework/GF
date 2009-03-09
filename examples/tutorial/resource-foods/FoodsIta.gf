--# -path=.:../foods:minimal:present:prelude

concrete FoodsIta of Foods = FoodsI with 
  (Syntax = SyntaxIta),
  (LexFoods = LexFoodsIta) ;
