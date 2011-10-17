-- Functor Instantiation
--# -path=.:/home/john/.cabal/share/gf-3.2.9/lib/present
concrete FoodsGer of Foods = FoodsI with 
  (Syntax = SyntaxGer),
  (LexFoods = LexFoodsGer) ;
