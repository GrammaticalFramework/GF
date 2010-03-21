-- (c) 2009 Ramona Enache and Aarne Ranta under LGPL

concrete FoodFre of Food = SentencesFre ** open
  SyntaxFre,
  ParadigmsFre in
{
flags coding=utf8 ;

lin

Wine = mkCN (mkN "vin") ;
Cheese = mkCN (mkN "fromage" masculine) ;
Fish = mkCN (mkN "poisson" masculine) ;
Pizza = mkCN (mkN "pizza" feminine) ;

Fresh = mkAP (mkA "frais" "fraîche") ;
Warm = mkAPA "chaud" ;
Italian = mkAPA "italien" ;
Expensive = mkAPA "cher" ;
Delicious = mkAPA "délicieux" ;
Boring = mkAPA "ennuyeux" ;

oper
mkAPA : (_ : Str) -> AP = \x -> mkAP (mkA x) ;

}
