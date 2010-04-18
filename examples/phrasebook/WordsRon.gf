-- (c) 2009 Ramona Enache under LGPL

concrete WordsRon of Words = SentencesRon ** open
  SyntaxRon,
  (P = ParadigmsRon),
  (L = LexiconRon),
  BeschRon,
  ExtraRon  in {

  flags coding=utf8 ;

  lin

-- kinds

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN L.cheese_N ;
    Chicken = mkCN (P.mkN "pui" "pui") ;
    Coffee = mkCN (P.mkN "cafea") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (P.mkN "carne" "cărnuri" "cărni") ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (P.mkN "pizză") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (P.mkNR "ceai") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;
    
-- qualities

    Bad = L.bad_A ;
    Boring = P.mkA "plictisitor" "plictisitoare" "plictisitori" "plictisitoare" ;
    Cheap = P.mkA "ieftin" ;
    Cold = L.cold_A ;
    Delicious = P.mkA "delicios" "delcioasă" "delicioşi" "delicioase" ;
    Expensive = P.mkA "scump" "scumpă" "scumpi" "scumpe" ;
    Fresh = P.mkA "proaspăt" "proaspătă" "proaspeţi" "proaspete" ;
    Good = L.good_A ;
    Suspect = P.mkA "suspect" ;
    Warm = L.warm_A ;
    
-- places

    Airport = mkPlace (P.mkNR "aeroport") at_Prep ; 
    Bar = mkPlace (P.mkNR "bar") at_Prep ; 
    Church = mkPlace (P.mkN "biserică" "biserici") at_Prep ; 
    Cinema = mkPlace (P.mkNR "cinema") at_Prep ; 
    Hospital = mkPlace (P.mkN "spital") at_Prep ;
    Hotel = mkPlace (P.mkNR "hotel") at_Prep ; 
    Museum = mkPlace (P.mkN "muzeu" "muzee") at_Prep ; 
    Park = mkPlace (P.mkNR "parc") at_Prep ;
    Restaurant = mkPlace (P.mkN "restaurant") at_Prep ; 
    School = mkPlace (P.mkN "şcoală" "şcoli") at_Prep ;
    Shop = mkPlace (P.mkN "magazin") at_Prep ;
    Station = mkPlace (P.mkN "gară" "gări") at_Prep ;
    Theatre = mkPlace (P.mkN "teatru" "teatre") at_Prep ;
    Toilet = mkPlace (P.mkN "toaletă") at_Prep ;
    University = mkPlace (P.mkN "universitate") at_Prep ;

-- currencies

    Dollar = mkCN (P.mkN "dolar" P.masculine) ;
    Euro = mkCN (P.mkN "euro" "euro") ;
    Lei = mkCN (P.mkN "leu" "lei") ;
    DanishCrown = mkCN (P.mkA "danez") (P.mkN "coroană") ;
    SwedishCrown = mkCN (P.mkA "suedez") (P.mkN "coroană") ;
    
-- nationalities

    Belgian = P.mkA "belgian" ;
    Belgium = UsePN (P.mkPN "Belgia") ;
    English = mkNat "englez" "Anglia" ;
    Finnish = mkNat "finlandez" "Finlanda" ;
    Flemish = UsePN (P.mkPN "flamandă") ; 
    French = mkNat "francez" "Franţa" ; 
    Italian = mkNat "italian" "Italia" ;
    Romanian = mkNat "român" "România" ;
    Swedish = mkNat "suedez" "Suedia" ;
    

-- actions

    AHasAge p num = mkCl p.name have_V2 (mkNP num L.year_N) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (P.mkN "cameră")) (SyntaxRon.mkAdv for_Prep (mkNP num (P.mkN "persoană")))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (P.mkN "masa" "mese")) (SyntaxRon.mkAdv for_Prep (mkNP num (P.mkN "persoană")))) ;
    AHasName p name = mkCl p.name (P.dirV2 (mkRVAcc (v_besch119 "numi"))) name ;
    AHungry p = DatSubjCl p.name (mkVP (UseN (P.mkN "foame"))) ;
    AIll p = mkCl p.name (P.mkA "bolnav") ;
    AKnow p = mkCl p.name (v_besch122 "şti") ;
    ALike p item = mkCl p.name (P.dirV2 (v_besch71 "plăcea")) item ;
    ALive p co = 
      mkCl p.name (mkVP (mkVP (v_besch121 "locui")) (SyntaxRon.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (P.dirV2 (P.mkV "iubi")) q.name ;
    AMarried p = mkCl p.name (P.mkA "căsătorit") ;
    AReady p = mkCl p.name (P.mkA "gata" "gata" "gata" "gata") ;
    AScared p = mkCl p.name (P.mkA "speriat") ;
    ASpeak p lang = mkCl p.name  (P.dirV2 (P.mkV "vorbi")) lang ;
    AThirsty p = DatSubjCl p.name (mkVP (UseN (P.mkN "sete"))) ;
    ATired p = mkCl p.name (P.mkA "obosit") ;
    AUnderstand p = mkCl p.name (v_besch83 "înţelege") ;
    AWant p obj = mkCl p.name (P.dirV2 (v_besch74 "vrea")) obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name (mkRVAcc (v_besch29 "chema")))) ;
    QWhatAge p = mkQS (mkQCl (mkIP how8many_IDet L.year_N) p.name have_V2) ; 

    PropOpen p = mkCl p.name open_A ;
    PropClosed p = mkCl p.name closed_A ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 
    
    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (v_besch18 "costa"))) ; 
    ItCost item price = mkCl item (P.dirV2 (v_besch18 "costa")) price ;

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYou d = mkText (lin Text {s = ("pe" ++ "curând")}) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p d = 
      mkText (lin Text { s = ("ne" ++ "vedem")}) 
        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "my wife" or "the wife of my son", as defined by $xOf$
-- below. Languages with productive genitives can use an equivalent of
-- "my son's wife" for non-pronouns, as e.g. in English.

    Wife = xOf sing (P.mkN "soţie") ;
    Husband = xOf sing (P.mkN "soţ" "soţi") ;
    Son = xOf sing (P.mkN "fiu") ;
    Daughter = xOf sing (P.mkN "fiică") ;
    Children = xOf plur L.child_N ;    
    
-- week days

    Monday = mkDay "luni" ;
    Tuesday = mkDay "marţi" ;
    Wednesday = mkDay "miercuri" ;
    Thursday = mkDay "joi" ;
    Friday = mkDay "vineri" ;
    Saturday = mkDay "sâmbătă" ;
    Sunday = mkDay "duminică" ;

    Tomorrow = P.mkAdv "mâine" ;

oper

closed_A : A = P.mkA "inchis" ;
open_A : A = P.mkA "deschis" ;

-- auxiliaries

    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (UsePN (P.mkPN nat)) (UsePN (P.mkPN co)) (P.mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = UsePN (P.mkPN d P.Feminine) ;
          ad = {s = d} in
      mkNPDay day ad ad; ---- difference is enforced by additional constructions

   -- mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,i ->
   --   mkCNPlace (mkCN p) i P.dative ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> mkRelative n (mkCN x) p ; 
    
    
-- auxiliaries

oper
    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,i -> {
      name = mkCN p ;
      at = i ;
      to = to_Prep   -- in Romanian, most of the time they would be the same
      } ;

}
