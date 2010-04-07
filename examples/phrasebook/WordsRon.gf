-- (c) 2009 Ramona Enache under LGPL

concrete WordsRon of Words = SentencesRon ** open
  SyntaxRon,
  ParadigmsRon,
  (L = LexiconRon),
  BeschRon in {

  flags coding=utf8 ;

  lin

-- kinds

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "brânză" "brânzeturi" feminine) ;
    Fish = mkCN L.fish_N ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pizza" "pizze" feminine) ;
    Salt = mkCN L.salt_N ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- qualities

    Bad = L.bad_A ;
    Boring = mkA "plictisitor" "plictisitoare" "plictisitori" "plictisitoare" ;
    Cold = L.cold_A ;
    Delicious = mkA "delicios" "delcioasă" "delicioşi" "delicioase" ;
    Expensive = mkA "scump" "scumpă" "scumpi" "scumpe" ;
    Fresh = mkA "proaspăt" "proaspătă" "proaspeţi" "proaspete" ;
    Good = L.good_A ;
    Warm = L.warm_A ;

-- places

    Bar = mkPlace (mkNR "bar") in_Prep ;
    Restaurant = mkPlace (mkN "restaurant") in_Prep ;
    Toilet = mkPlace (mkN "toaleta") in_Prep ;

-- currencies

    Dollar = mkCN (mkN "dolar" masculine) ;
    Euro = mkCN (mkN "euro" "euro") ;
    Lei = mkCN (mkN "leu" "lei") ;

-- nationalities

--    English = SyntaxRon.mkNP (mkPN "engleză") ; ---- ?
--    Finnish = mkNP (mkPN "finnois") ;
--    French = mkNP (mkPN "français") ; 
--    Italian = mkA "italian" "italiană" "italieni" "italiene" ;
--    Romanian = SyntaxRon.mkNP (mkPN "română") ; ---- ?
--    Swedish = mkNP (mkPN "suédois") ;

-- actions

    AWant p obj = mkCl p.name (dirV2 (lin V want_VV)) obj ;
    ALike p item = mkCl p.name (dirV2 (v_besch71 "plăcea")) item ;
    ASpeak p lang = mkCl p.name  (dirV2 (mkV "vorbi")) lang ;
    ALove p q = mkCl p.name (dirV2 (mkV "iubi")) q.name ;
    AUnderstand p = mkCl p.name (v_besch83 "înţelege") ;
--    AHungry p = mkCl p have_V2 (SyntaxRon.mkNP a_Det (mkN "foame")) ;
--    AThirsty p = mkCl p (E.ComplCN have_V2 (mkCN (mkN "sete" feminine))) ;
--    ATired p = mkCl p (mkA "stanco") ;
--    AScared p = mkCl p (E.ComplCN have_V2 (mkCN (mkN "paura" feminine))) ;

-- miscellaneous

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (v_besch18 "costa"))) ; 
    ItCost item price = mkCl item (dirV2 (v_besch18 "costa")) price ;

-- auxiliaries

oper
    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,i -> {
      name = mkCN p ;
      at = i ;
      to = to_Prep   ---- ?
      } ;

}
