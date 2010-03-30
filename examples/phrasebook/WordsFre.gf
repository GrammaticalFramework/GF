-- (c) 2009 Ramona Enache and Aarne Ranta under LGPL

concrete WordsFre of Words = SentencesFre ** open
  SyntaxFre,
  DiffPhrasebookFre,
  IrregFre,
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

    English = mkNP (mkPN "anglais") ;
    Finnish = mkNP (mkPN "finnois") ;
    French = mkNP (mkPN "français") ; 
    Romanian = mkNP (mkPN "roumain") ;
    Swedish = mkNP (mkPN "suédois") ;

    AWant p obj = {s = \\r => mkCl (p.s ! r) want_V2 obj} ;
    ALike p item = {s = \\r => mkCl item plaire_V2 (p.s ! r)} ;
    AHave p kind = {s = \\r => mkCl (p.s ! r) have_V2 (mkNP kind)} ;
    ASpeak p lang = {s = \\r => mkCl (p.s ! r) (mkV2 (mkV "parler")) lang} ;
    ALove p q = {s = \\r => mkCl (p.s ! r) (mkV2 (mkV "aimer")) (q.s ! r)} ;


  oper
    mkAPA : (_ : Str) -> AP = \x -> mkAP (mkA x) ;


}
