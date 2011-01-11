--# -path=.:present

concrete FoodsIta of Foods = CommentsIta ** 
    open SyntaxIta, ParadigmsIta in {
  lin
    Wine = mkCN (mkN "vino") ;
    Pizza = mkCN (mkN "pizza") ;
    Cheese = mkCN (mkN "formaggio") ;
    Fish = mkCN (mkN "pesce") ;
    Fresh = mkAP (mkA "fresco") ;
    Warm = mkAP (mkA "caldo") ;
    Italian = mkAP (mkA "italiano") ;
    Expensive = mkAP (mkA "caro") ;
    Delicious = mkAP (mkA "delizioso") ;
    Boring = mkAP (mkA "noioso") ;
}
