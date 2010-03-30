-- (c) 2009 Ramona Enache under LGPL

concrete WordsRon of Words = SentencesRon ** open
  SyntaxRon,
  ParadigmsRon,
  DiffPhrasebookRon,
  (R = Roles) in
{
flags coding=utf8 ;

lin

Wine = mkCN (mkN "vin" "vinuri" neuter) ;
    Beer = mkCN (mkN "bere") ;
    Water = mkCN (mkN "apă") ;
----    Coffee = mkCN (mkN "coffee") ;
----    Tea = mkCN (mkN "tea") ;

Cheese = mkCN (mkN "brânză" "brânzeturi" feminine) ;
Fish = mkCN (mkN "peşte" "peşti" masculine) ;
Pizza = mkCN (mkN "pizza" "pizze" feminine) ;

Fresh = mkAPA "proaspăt" "proaspătă" "proaspeţi" "proaspete" ;
Warm = mkAPA "cald" "caldă" "calzi" "calde" ;
Italian = mkAPA "italian" "italiană" "italieni" "italiene" ;
Expensive = mkAPA "scump" "scumpă" "scumpi" "scumpe" ;
Delicious = mkAPA "delicios" "delcioasă" "delicioşi" "delicioase" ;
Boring = mkAPA "plictisitor" "plictisitoare" "plictisitori" "plictisitoare" ;

    Restaurant = mkCN (mkN "restaurant") ;
    Bar = mkCN (mkNR "bar") ;
    Toilet = mkCN (mkN "toaleta") ;

    Euro = mkCN (mkN "euro" "euro") ;
    Dollar = mkCN (mkN "dolar" masculine) ;
    Lei = mkCN (mkN "leu" "lei") ;

    English = SyntaxRon.mkNP (mkPN "engleză") ; ---- ?
--    Finnish = mkNP (mkPN "finnois") ;
--    French = mkNP (mkPN "français") ; 
    Romanian = SyntaxRon.mkNP (mkPN "română") ; ---- ?
--    Swedish = mkNP (mkPN "suédois") ;

    AWant p obj = {s = \\r => mkCl (p.s ! r) want_V2 obj} ;
    ALike p item = {s = \\r => mkCl (p.s ! r) like_V2 item} ;
    AHave p kind = {s = \\r => mkCl (p.s ! r) have_V2 (SyntaxRon.mkNP kind)} ;
    ASpeak p lang = {s = \\r => mkCl (p.s ! r) (dirV2 (mkV "vorbi")) lang} ;
    ALove p q = {s = \\r => mkCl (p.s ! R.PPolite) (dirV2 (mkV "iubi")) (q.s ! r)} ; ---- linking slow

oper
mkAPA : (_,_,_,_ : Str) -> AP = \x,y,z,u -> mkAP (mkA x y z u) ;

}
