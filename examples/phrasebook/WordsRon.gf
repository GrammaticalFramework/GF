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

Fresh = mkA "proaspăt" "proaspătă" "proaspeţi" "proaspete" ;
Warm = mkA "cald" "caldă" "calzi" "calde" ;
Expensive = mkA "scump" "scumpă" "scumpi" "scumpe" ;
Delicious = mkA "delicios" "delcioasă" "delicioşi" "delicioase" ;
Boring = mkA "plictisitor" "plictisitoare" "plictisitori" "plictisitoare" ;
Good = mkA "bun" "bună" "buni" "bune" "bine" ;

    Restaurant = mkPlace (mkN "restaurant") in_Prep ;
    Bar = mkPlace (mkNR "bar") in_Prep ;
    Toilet = mkPlace (mkN "toaleta") in_Prep ;

    Euro = mkCN (mkN "euro" "euro") ;
    Dollar = mkCN (mkN "dolar" masculine) ;
    Lei = mkCN (mkN "leu" "lei") ;

--    English = SyntaxRon.mkNP (mkPN "engleză") ; ---- ?
--    Finnish = mkNP (mkPN "finnois") ;
--    French = mkNP (mkPN "français") ; 
--    Italian = mkA "italian" "italiană" "italieni" "italiene" ;
--    Romanian = SyntaxRon.mkNP (mkPN "română") ; ---- ?
--    Swedish = mkNP (mkPN "suédois") ;

    AWant p obj = mkCl p.name want_V2 obj ;
    ALike p item = mkCl p.name like_V2 item ;
    AHave p kind = mkCl p.name have_V2 (SyntaxRon.mkNP kind) ;
    ASpeak p lang = mkCl p.name  (dirV2 (mkV "vorbi")) lang ;
    ALove p q = mkCl p.name (dirV2 (mkV "iubi")) q.name ;
    AUnderstand p = mkCl p.name (v_besch83 "înţelege") ;

--    AHungry p = mkCl p have_V2 (SyntaxRon.mkNP a_Det (mkN "foame")) ;
--    AThirsty p = mkCl p (E.ComplCN have_V2 (mkCN (mkN "sete" feminine))) ;
--    ATired p = mkCl p (mkA "stanco") ;
--    AScared p = mkCl p (E.ComplCN have_V2 (mkCN (mkN "paura" feminine))) ;


{-
  GImHungry = ss "mi-e foame" ;
  GImThirsty = ss "mi-e sete" ;
  GImTired = ss "mi-e somn" ;
  GImScared = ss "mi-e frică" ;
-}

oper
    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,i -> {
      name = mkCN p ;
      at = i ;
      to = to_Prep   ---- ?
      } ;

}
