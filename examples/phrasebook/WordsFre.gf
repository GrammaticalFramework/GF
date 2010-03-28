-- (c) 2009 Ramona Enache and Aarne Ranta under LGPL

concrete WordsFre of Words = SentencesFre ** open
  SyntaxFre,
  ParadigmsFre in
{
flags coding=utf8 ;

lin

Wine = mkCN (mkN "vin") ;
    Beer = mkCN (mkN "bière") ;
    Water = mkCN (mkN "eau" feminine) ;
    Coffee = mkCN (mkN "café") ;
    Tea = mkCN (mkN "thé") ;

Cheese = mkCN (mkN "fromage" masculine) ;
Fish = mkCN (mkN "poisson" masculine) ;
Pizza = mkCN (mkN "pizza" feminine) ;

Fresh = mkAP (mkA "frais" "fraîche") ;
Warm = mkAPA "chaud" ;
Italian = mkAPA "italien" ;
Expensive = mkAPA "cher" ;
Delicious = mkAPA "délicieux" ;
Boring = mkAPA "ennuyeux" ;

    Restaurant = mkCN (mkN "restaurant") ;
    Bar = mkCN (mkN "bar") ;
    Toilet = mkCN (mkN "toilette") ;

    Euro = mkCN (mkN "euro") ;
    Dollar = mkCN (mkN "dollar") ;
    Lei = mkCN (mkN "lei") ; ---- ?

oper
mkAPA : (_ : Str) -> AP = \x -> mkAP (mkA x) ;

}
