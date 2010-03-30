-- (c) 2009 Ramona Enache under LGPL

concrete WordsRon of Words = SentencesRon ** open
  SyntaxRon,
  ParadigmsRon,
  BeschRon,
  DiffPhrasebookRon in
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

    AWant p obj = mkCl p want_V2 obj ;
    ALike p item = mkCl p like_V2 item ;
    AHave p kind = mkCl p have_V2 (SyntaxRon.mkNP kind) ;
    ASpeak p lang = mkCl p  (dirV2 (mkV "vorbi")) lang ;
    ALove p q = mkCl p (dirV2 (mkV "iubi")) q ;

    English = SyntaxRon.mkNP (mkPN "engleză") ; ---- ?
--    Finnish = mkNP (mkPN "finnois") ;
--    French = mkNP (mkPN "français") ; 
    Romanian = SyntaxRon.mkNP (mkPN "română") ; ---- ?
--    Swedish = mkNP (mkPN "suédois") ;

--    AHungry p = mkCl p have_V2 (SyntaxRon.mkNP a_Det (mkN "foame")) ;
--    AThirsty p = mkCl p (E.ComplCN have_V2 (mkCN (mkN "sete" feminine))) ;
--    ATired p = mkCl p (mkA "stanco") ;
--    AScared p = mkCl p (E.ComplCN have_V2 (mkCN (mkN "paura" feminine))) ;
    AUnderstand p = mkCl p (v_besch83 "înţelege") ;
{-
  GImHungry = ss "mi-e foame" ;
  GImThirsty = ss "mi-e sete" ;
  GImTired = ss "mi-e somn" ;
  GImScared = ss "mi-e frică" ;
-}


oper
mkAPA : (_,_,_,_ : Str) -> AP = \x,y,z,u -> mkAP (mkA x y z u) ;

}
