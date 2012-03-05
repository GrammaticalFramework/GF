-- Functor Instantiation
--# -path=.:/home/john/.cabal/share/gf-3.2.9/lib/present
concrete FoodsEng of Foods = FoodsI - [Pizza] with
  (Syntax = SyntaxEng),
  (LexFoods = LexFoodsEng) **
  open SyntaxEng, ParadigmsEng in {
    lin Pizza = mkCN (mkA "Italian") (mkN "pie") ;
}
