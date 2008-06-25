--# -path=.:../foods:present:prelude

concrete FoodsIta of Foods = FoodsI with 
  (Syntax = SyntaxIta),
  (LexFoods = LexFoodsIta) ;
