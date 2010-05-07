-- (c) 2009 Ramona Enache under LGPL

concrete WordsRon of Words = SentencesRon ** open
  SyntaxRon, ResRon, Prelude,
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
    Chicken = mkCN (P.mkN "pui" "pui" P.masculine) ;
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
    AmusementPark = mkPlace (P.compN (P.mkNR "parc") ["de distracții"]) in_Prep ;
    Bank = mkPlace (P.mkN "bancă" "bănci") in_Prep ;
    Bar = mkPlace (P.mkNR "bar") at_Prep ;
    Cafeteria = mkPlace (P.mkN "cantină" "cantine") in_Prep ;
    Center = mkPlace (P.mkN "centru" "centre" ) in_Prep ; 
    Church = mkPlace (P.mkN "biserică" "biserici") at_Prep ; 
    Cinema = mkPlace (P.mkNR "cinematograf") at_Prep ;
    Disco = mkPlace (P.mkN "discotecă" "discoteci" ) at_Prep ; 
    Hospital = mkPlace (P.mkN "spital") at_Prep ;
    Hotel = mkPlace (P.mkNR "hotel") at_Prep ; 
    Museum = mkPlace (P.mkN "muzeu" "muzee") at_Prep ; 
    Park = mkPlace (P.mkNR "parc") at_Prep ;
    Parking = mkPlace (P.mkN "parcare" "parcări") in_Prep ;
    Pharmacy = mkPlace (P.mkN "farmacie" "farmacii" P.feminine) at_Prep;
    PostOffice = mkPlace (P.mkN "poștă" "poște") at_Prep ;
    Pub = mkPlace (P.mkNR "pub") in_Prep ;
    Restaurant = mkPlace (P.mkN "restaurant") at_Prep ; 
    School = mkPlace (P.mkN "şcoală" "şcoli") at_Prep ;
    Shop = mkPlace (P.mkN "magazin") at_Prep ;
    Station = mkPlace (P.mkN "gară" "gări") at_Prep ;
    Supermarket = mkPlace (P.mkNR "supermarket") at_Prep ;
    Theatre = mkPlace (P.mkN "teatru" "teatre") at_Prep ;
    Toilet = mkPlace (P.mkN "toaletă") at_Prep ;
    University = mkPlace (P.mkN "universitate") at_Prep ;
    Zoo = {name = mkCN (P.mkA "zoologic") (P.mkN "grădină" "grădini");
           to = to_Prep; at = at_Prep };

    CitRestaurant cit = mkCNPlace (mkCN cit.prop (P.mkN "restaurant" "restaurante")) in_Prep to_Prep;  

-- currencies

    DanishCrown = mkCN (P.mkA "danez") (P.mkN "coroană") ;
    Dollar = mkCN (P.mkN "dolar" P.masculine) ;
    Euro = mkCN (P.mkN "euro" "euro" P.masculine) ;
    Lei = mkCN (P.mkN "leu" "lei") ;
    Leva = mkCN (P.mkN "levă" "leve") ;
    NorwegianCrown = mkCN (P.mkA "norvegian") (P.mkN "coroană") ;
    Pound = mkCN (P.mkA "sterlin") (P.mkN "liră") ;
    Rouble = mkCN (P.mkN "rublă" "ruble") ;
    SwedishCrown = mkCN (P.mkA "suedez") (P.mkN "coroană") ;
    Zloty = mkCN (P.mkN "zlot" P.masculine) ;    

-- nationalities

    Belgian = mkCitizenshipRon (P.mkA "belgian" "belgiană" "belgieni" "belgiene")  "belgian" "belgiancă" "belgieni" "belgience" ;
    Belgium = mkNP (P.mkPN "Belgia") ;
    Bulgarian = mkCompNat "bulgar" "Bulgaria" "bulgăresc" "bulgar" "bulgăroaică" "bulgari" "bulgăroaice";
    Catalan = mkSimpSimpNat "catalan" "Catalonia" ;
    Danish = mkSimpSimpNat "danez" "Danemarca" ;
    Dutch = mkSimpSimpNat "olandez" "Olanda" ;
    English = mkNat "englez" "Anglia" "englez" "englezoaică" "englezi" "englezoaice" ;
    Finnish = mkSimpSimpNat "finlandez" "Finlanda" ;
    Flemish = mkNP (P.mkPN "flamandă") ; 
    French = mkCompNat "francez" "Franţa" "franțuzesc" "francez" "franțuzoaică" "francezi" "franțuzoaice";
    German = mkCompNat "german" "Germania" "nemțesc" "neamț" "nemțoaică" "nemți" "nemțoaice"; 
    Italian = mkSimpNat "italian"  "Italia" "italian" "italiancă" "italieni" "italience" ;
    Norwegian = mkSimpSimpNat "norvegian" "Norvegia";
    Polish = mkSimpSimpNat "polonez" "Polonia" ;
    Romanian = mkNat "român" "România" "român" "româncă" "români" "românce" ;
    Russian = mkNat "rus" "Rusia" "rus" "rusoaică" "ruși" "rusoaice";
    Spanish = mkSimpSimpNat "spaniol" "Spania" ;
    Swedish = mkSimpSimpNat "suedez" "Suedia" ;
    
-- means of transportation 

    Bike = mkTransport L.bike_N ; 
    Bus = mkTransport (P.mkN "autobuz" "autobuze") ;
    Car = mkTransport L.car_N ;
    Ferry = mkTransport (P.mkNR "feribot") ;
    Plane = mkTransport L.airplane_N ;
    Subway = mkTransport (P.mkNR "metrou") ; 
    Taxi = mkTransport (P.mkNR "taxi") ; 
    Train = mkTransport (P.mkNR "tren") ;
    Tram = mkTransport (P.mkN "tramvai" "tramvaie") ;

    ByFoot = P.mkAdv "pe jos" ;

    HowFar place = mkQS (mkQCl how8much_IAdv (mkDestination place.name)) ;
    HowFarFrom x y = mkQS (mkQCl how8much_IAdv (mkNP (mkDestination y.name) (SyntaxRon.mkAdv from_Prep x.name))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl how8much_IAdv (mkNP (mkNP (mkDestination y.name) (SyntaxRon.mkAdv from_Prep x.name)) t)) ;
    HowFarBy y t = mkQS (mkQCl how8much_IAdv (mkNP (mkDestination y.name) t)) ; 

   WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name (mkDestination place.name)))) ;


-- actions

    AHasAge p num = mkCl p.name have_V2 (mkNP num L.year_N) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (P.mkN "cameră")) (SyntaxRon.mkAdv for_Prep (mkNP num (P.mkN "persoană")))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (P.mkN "masa" "mese")) (SyntaxRon.mkAdv for_Prep (mkNP num (P.mkN "persoană")))) ;
    AHasName p name = mkCl p.name (P.mmkV2 (mkRVAcc (v_besch119 "numi")) (P.noPrep P.Nom)) name ;
    AHungry p = DatSubjCl p.name (mkVP (mkNP (P.mkN "foame"))) ;
    AIll p = mkCl p.name (P.mkA "bolnav") ;
    AKnow p = mkCl p.name (v_besch122 "şti") ;
    ALike p item = DatSubjCompCl p.name  (mkVP (v_besch71 "plăcea")) item ;
    ALive p co = 
      mkCl p.name (mkVP (mkVP (v_besch121 "locui")) (SyntaxRon.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (P.dirV2 (P.mkV "iubi")) q.name ;
    AMarried p = mkCl p.name (P.mkA "căsătorit") ;
    AReady p = mkCl p.name (P.mkA "gata" "gata" "gata" "gata") ;
    AScared p = mkCl p.name (P.mkA "speriat") ;
    ASpeak p lang = mkCl p.name  (P.mmkV2 (P.mkV "vorbi") (P.noPrep P.Nom)) lang ;
    AThirsty p = DatSubjCl p.name (mkVP (mkNP (P.mkN "sete"))) ;
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

    PSeeYouDate d = mkText (lin Text {s = ("ne" ++ "vedem")}) (mkPhrase (mkUtt d)) ;
    PSeeYouPlaceDate p d = 
      mkText (lin Text { s = ("ne" ++ "vedem")}) 
        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;
    PSeeYouPlace p = mkText (lin Text {s = ("ne" ++ "vedem")}) (mkPhrase (mkUtt p.at)) ;

-- Relations are expressed as "my wife" or "the wife of my son", as defined by $xOf$
-- below. Languages with productive genitives can use an equivalent of
-- "my son's wife" for non-pronouns, as e.g. in English.

    Wife = xOf sing (P.mkN "soţie") ;
    Husband = xOf sing (P.mkN "soţ" "soţi") ;
    Son = xOf sing (P.mkN "fiu" "fii") ;
    Daughter = xOf sing (P.mkN "fiică" "fiice") ;
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

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (P.mkA "ieftin") ;
    TheMostExpensive = mkSuperl (P.mkA "scump") ;
    TheMostPopular = mkSuperl (P.mkA "popular") ;
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;





oper

closed_A : A = P.mkA "închis" ;
open_A : A = P.mkA "deschis" ;

-- auxiliaries     

   mkSimpSimpNat : Str -> Str -> NPNationalityRon = \nat, co -> 
     mkSimpNat nat co nat (nat + "ă") (nat + "i") (nat+"e");

    mkSimpNat : Str -> Str -> Str -> Str -> Str -> Str -> NPNationalityRon = \nat,co, citMS, citFS, citMP, citFP -> let adj = P.mkA nat in
      mkNPNationalityRon (mkNP (P.mkPN (nat+"ă"))) (mkNP (P.mkPN co)) adj citMS citFS citMP citFP ;

    mkNat : Str -> Str -> Str -> Str -> Str -> Str -> NPNationalityRon = \nat,co, citMS, citFS, citMP, citFP -> let adj = P.mkA (nat+"esc") in
      mkNPNationalityRon (mkNP (P.mkPN (nat+"ă"))) (mkNP (P.mkPN co)) adj citMS citFS citMP citFP ;

   mkCompNat : Str -> Str -> Str -> Str -> Str -> Str -> Str -> NPNationalityRon = \nat,co, adj, citMS, citFS, citMP, citFP -> let a = P.mkA adj in
      mkNPNationalityRon (mkNP (P.mkPN (nat+"ă"))) (mkNP (P.mkPN co)) a citMS citFS citMP citFP ;
   


mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (P.mkPN d P.Feminine) ;
          ad = {s = d; lock_Adv=<>} in
      mkNPDay day ad ad; ---- difference is enforced by additional constructions

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> mkRelative n (refCN x) p ; 

    
    
-- auxiliaries

oper
    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,i -> {
      name = mkCN p ;
      at = i ;
      to = to_Prep   -- in Romanian, most of the time they would be the same
      } ;

   mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxRon.mkAdv with_Prep (mkNP the_Det n)
      } ;

    mkSuperl : A -> Det = \a -> mkDet the_Art (SyntaxRon.mkOrd a) ;

    mkDestination : NP -> NP = \np -> heavyNP {s = \\c => "pâna la"++np.indForm ; 
                                               a = np.a; hasClit = HasRef False;
                                               ss = "pâna la"++np.indForm} ** {lock_NP =<>};

}
