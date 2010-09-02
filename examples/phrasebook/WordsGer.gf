-- (c) 2009 Aarne Ranta under LGPL

concrete WordsGer of Words = SentencesGer ** 
    open SyntaxGer, ParadigmsGer, IrregGer, (L = LexiconGer), ExtraGer, Prelude in {

   lin

-- kinds of food
 
    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "Käse" "Käse" "Käse" "Käse" "Käse" "Käse" masculine) ;
    Chicken = mkCN (mkN "Huhn" "Huhn" "Huhn" "Huhn" "Hühner" "Hühner" neuter) ;
    Coffee = mkCN (mkN "Kaffee" "Kaffee" "Kaffee" "Kaffee" "Kaffees" "Kaffee" masculine) ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "Fleisch" "Fleisch" "Fleisch" "Fleisch" "Fleisch" "Fleisch" neuter) ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "Pizza" "Pizzen" feminine) ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "Tee" "Tee" "Tee" "Tee" "Tees" "Tees" masculine) ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- properties

    Bad = L.bad_A ;
    Cheap = mkA "billig" ;
    Boring = mkA "langweilig" ;
    Cold = L.cold_A ;
    Delicious = mkA "lecker" ;
    Expensive = mkA "teuer" ;
    Fresh = mkA "frisch" ;
    Good = L.good_A ;
    Warm = L.warm_A ;
    Suspect = mkA "verdächtig" ;

-- places

    Airport = mkPlace (mkN "Flughafen" "Flughäfen" masculine) on_Prep zu_Prep ; 
    Church = mkPlace (mkN "Kirche") in_Prep inAcc_Prep ;
    Hospital = mkPlace (mkN "Krankenhaus" "Krankenhäuser" neuter) in_Prep inAcc_Prep ;
    Restaurant = mkPlace (mkN "Restaurant" "Restaurants" neuter) in_Prep inAcc_Prep ;
    Station = mkPlace (mkN "Bahnhof" "Bahnhöfe" masculine) on_Prep zu_Prep ;
    University = mkPlace (mkN "Universität" "Universitäten" feminine) in_Prep zu_Prep ;

    AmusementPark = mkPlace (mkN "Vergnügungspark" "Vergnügungspark" "Vergnügungspark" "Vergnügungspark" "Vergnügungsparks" "Vergnügungsparks" masculine) in_Prep inAcc_Prep ;
    Bank = mkPlace (mkN "Bank" "Bank" "Bank" "Bank" "Banken" "Banken" feminine) in_Prep zu_Prep ;
    Bar = mkPlace (mkN "Bar" "Bar" "Bar" "Bar" "Bars" "Bars" feminine) in_Prep inAcc_Prep ;
    Cafeteria = mkPlace (mkN "Cafeteria" "Cafeteria" "Cafeteria" "Cafeteria" "Cafeterien" "Cafeterien" feminine) in_Prep inAcc_Prep ;
    Center = mkPlace (mkN "Zentrum" "Zentrum" "Zentrum" "Zentrum" "Zentren" "Zentren" neuter) in_Prep zu_Prep ;
    Cinema = mkPlace (mkN "Kino" "Kino" "Kino" "Kino" "Kinos" "Kinos" neuter) in_Prep inAcc_Prep ;
    Disco = mkPlace (mkN "Disco" "Disco" "Disco" "Disco" "Discos" "Discos" feminine) in_Prep inAcc_Prep ;
    Hotel = mkPlace (mkN "Hotel" "Hotel" "Hotel" "Hotel" "Hotels" "Hotels" neuter) in_Prep inAcc_Prep ;
    Museum = mkPlace (mkN "Museum" "Museum" "Museum" "Museum" "Museen" "Museen" neuter) in_Prep inAcc_Prep ;
    Park = mkPlace (mkN "Park" "Park" "Park" "Park" "Parks" "Parks" masculine) in_Prep inAcc_Prep ;
    Parking = mkPlace (mkN "Parkplatz" "Parkplatz" "Parkplatz" "Parkplatz" "Parkplatzen" "Parkplatzen" masculine) on_Prep zu_Prep ;
    Pharmacy = mkPlace (mkN "Apotheke" "Apotheke" "Apotheke" "Apotheke" "Apotheken" "Apotheken" feminine) in_Prep zu_Prep ;
    PostOffice = mkPlace (mkN "Post" "Post" "Post" "Post" "Posten" "Posten" feminine) in_Prep inAcc_Prep ;
    Pub = mkPlace (mkN "Kneipe" "Kneipe" "Kneipe" "Kneipe" "Kneipen" "Kneipen" feminine) in_Prep inAcc_Prep;
    School = mkPlace (mkN "Schule" "Schule" "Schule" "Schule" "Schulen" "Schule" feminine) in_Prep inAcc_Prep ;
    Shop = mkPlace (mkN "Geschäft" "Geschäft" "Geschäft" "Geschäft" "Geschäfte" "Geschäfte" neuter) in_Prep inAcc_Prep ;
    Supermarket = mkPlace (mkN "Supermarkt" "Supermarkt" "Supermarkt" "Supermarkt" "Supermärkten" "Supermärkte" masculine) in_Prep inAcc_Prep ;
    Theatre = mkPlace (mkN "Theater" "Theater" "Theater" "Theaters" "Theatern" "Thaters" neuter) in_Prep inAcc_Prep ; 
    Toilet = mkPlace (mkN "Toilette" "Toilette" "Toilette" "Toilette" "Toiletten" "Toiletten" feminine) in_Prep (mkPrep "auf" accusative) ; 
    Zoo = mkPlace (mkN "Zoo" "Zoo" "Zoo" "Zoo" "Zoos" "Zoos" masculine) in_Prep inAcc_Prep ;


CitRestaurant cit = mkCNPlace (mkCN cit  (mkN "Restaurant" "Restaurants" neuter)) in_Prep inAcc_Prep ;


-- currencies

    DanishCrown = mkCN (mkA "Dänisch") (mkN "Krone" "Kronen" feminine) | mkCN (mkN "Krone" "Kronen" feminine) ;
     Dollar = mkCN (mkN "Dollar" "Dollar" "Dollar" "Dollar" "Dollar" "Dollar" masculine) ;
    Euro = mkCN (mkN "Euro" "Euro" "Euro" "Euro" "Euro" "Euro" neuter) ;
     Lei = mkCN (mkN "Leu" "Leu" "Leu" "Leu" "Lei" "Lei" masculine) ;
    SwedishCrown = mkCN (mkA "Schwedisch") (mkN "Krone" "Kronen" feminine) | mkCN (mkN "Krone" "Kronen" feminine) ;
    Leva = mkCN (mkN "Lewa" "Lewa" "Lewa" "Lewa" "Lewa" "Lewa" feminine);
    NorwegianCrown = mkCN (mkA "Norwegisch") (mkN "Krone" "Kronen" feminine) | mkCN (mkN "Krone" "Kronen" feminine) ;
    Pound = mkCN (mkN "Pfund" "Pfund" "Pfund" "Pfund" "Pfund" "Pfund" neuter) ;
    Rouble = mkCN (mkN "Rubel" "Rubel" "Rubel" "Rubel" "Rubels" "Rubels" masculine);
    Zloty = mkCN (mkN "Zloty" "Zloty" "Zloty" "Zloty" "Zloty" "Zloty" masculine);
   


-- nationalities

    Belgian = mkA "belgisch" ;
    Belgium = mkNP (mkPN "Belgien") ;
    Bulgarian = mkNat "Bulgarien" "Bulgarisch" "bulgarisch" ;	
    Catalan = mkNat "Katalonien" "Katalanisch" "katalanisch" ;
    Danish = mkNat "Dänemark" "Dänisch" "dänisch" ;
    Dutch = mkNat "den Niederlanden" "Niederländisch" "niederländisch" ;
    English = mkNat "England" "Englisch" "englisch" ;
    Finnish = mkNat "Finnland" "Finnisch" "finnisch" ;
    Flemish = mkNP (mkPN "Flämisch") ;
    French = mkNat "Frankreich" "Französisch" "französisch" ;
    German = mkNat "Deutschland" "Deutsch" "deutsche" ;
    Italian = mkNat "Italien" "Italienisch" "italienisch" ;
    Norwegian = mkNat "Norwegen" "Norwegisch" "norwegisch" ;
    Polish = mkNat "Polen" "Polnisch" "polnisch"  ;
    Romanian = mkNat "Rumänien" "Rumänisch" "rumänisch" ;
    Russian = mkNat "Russland" "Russisch" "russisch" ;
    Spanish = mkNat "Spanien" "Spanisch" "spanisch" ;
    Swedish = mkNat "Schweden" "Schwedisch" "schwedisch" ;



-- actions

    AHasAge p num = prop (mkCl p.name (mkNP num L.year_N)) ;
    AHasName p name = prop (mkCl p.name (mkV2 heißen_V) name) ;
    AHungry p = prop (mkCl p.name (mkA "hungrig")) ;
    AHasChildren p num = prop (mkCl p.name have_V2 (mkNP num L.child_N)) ;
    AHasRoom p num = prop (mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "Zimmer" "Zimmer" neuter)) 
        (SyntaxGer.mkAdv for_Prep (mkNP num (mkN "Persone"))))) ;
    AHasTable p num = prop (mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "Tisch")) 
        (SyntaxGer.mkAdv for_Prep (mkNP num (mkN "Persone"))))) ;
    AIll p = prop (mkCl p.name (mkA "krank")) ;
    AKnow p = prop (mkCl p.name wissen_V) ;
    ALike p item = prop (mkCl p.name (mkV2 mögen_V) item) ;
    ALive p co = prop (mkCl p.name (mkVP (mkVP (mkV "wohnen")) (SyntaxGer.mkAdv in_Prep co))) ;
    ALove p q = prop (mkCl p.name (mkV2 (mkV "lieben")) q.name) ;
    AMarried p = prop (mkCl p.name (mkA "verheiratet")) ;
    AReady p = prop (mkCl p.name (mkA "bereit")) ;
    AScared p = prop (mkCl p.name have_V2 (mkNP (mkN "Angst" "Angsten" feminine))) ;
    ASpeak p lang = prop (mkCl p.name (mkV2 sprechen_V) lang) ;
    AThirsty p = prop (mkCl p.name (mkA "durstig")) ;
    ATired p = prop (mkCl p.name (mkA "müde")) ;
    AUnderstand p = prop (mkCl p.name (fixprefixV "ver" stehen_V)) ;
    AWant p obj = prop (mkCl p.name want_VV (mkVP have_V2 obj)) ;
    AWantGo p place = prop (mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to)) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name heißen_V)) ;
    QWhatAge p = mkQS (mkQCl (ICompAP (mkAP L.old_A)) p.name) ;

    PropOpen p = prop (mkCl p.name open_Adv) ;
    PropClosed p = prop (mkCl p.name closed_Adv) ;
    PropOpenDate p d = prop (mkCl p.name (mkVP (mkVP d) open_Adv)) ; 
    PropClosedDate p d = prop (mkCl p.name (mkVP (mkVP d) closed_Adv)) ; 
    PropOpenDay p d = prop (mkCl p.name (mkVP (mkVP d.habitual) open_Adv)) ; 
    PropClosedDay p d = prop (mkCl p.name (mkVP (mkVP d.habitual) closed_Adv)) ; 

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "kosten"))) ; 
    ItCost item price = prop (mkCl item (mkV2 (mkV "kosten")) price) ;

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (ss ("Wir sehen uns"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p = mkText (lin Text (ss ("Wir sehen uns"))) (mkPhrase (mkUtt p.at)) ;
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("Wir sehen uns"))) 
        (mkText (mkPhrase (mkUtt d)) (mkPhrase (mkUtt p.at))) ;


-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf sing (mkN "Frau" "Frauen" feminine) ;
    Husband = xOf sing L.man_N ;
    Son = xOf sing (mkN "Sohn" "Söhne" masculine) ;
    Daughter = xOf sing (mkN "Tochter" "Töchter" feminine) ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "Montag" ;
    Tuesday = mkDay "Dienstag" ;
    Wednesday = mkDay "Mittwoch" ;
    Thursday = mkDay "Donnerstag" ;
    Friday = mkDay "Freitag" ;
    Saturday = mkDay "Samstag" ;
    Sunday = mkDay "Sonntag" ;

    Tomorrow = ParadigmsGer.mkAdv "morgen" ;

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (mkA "billig") ;
    TheMostExpensive = mkSuperl (mkA "teuer") ;
    TheMostPopular = mkSuperl (mkA "beliebt") ;
    TheWorst = mkSuperl (mkA "schlimm") ;

    SuperlPlace sup p = placeNP sup p ;


-- means of transportation 

    Bike = mkTransport L.bike_N ; 
    Bus = mkTransport (mkN "Bus" "Bus" "Bus" "Bus" "Buss" "Buss" masculine) ;
    Car = mkTransport L.car_N ;
    Ferry = mkTransport (mkN "Fähre" "Fähre" "Fähre" "Fähre" "Fähren" "Fähren" feminine) ;
    Plane = mkTransport (mkN "Flugzeug" "Flugzeug" "Flugzeug" "Flugzeug" "Flugzeuge" "Flugzeuge" neuter) ;
    Subway = mkTransport (mkN "U-Bahn" "U-Bahn" "U-Bahn" "U-Bahn" "U-Bahnen" "U-Bahnen" feminine) ;
    Taxi = mkTransport (mkN "Taxi" "Taxi" "Taxi" "Taxi" "Taxis" "Taxis" neuter) ;
    Train = mkTransport (mkN "Zug" "Zug" "Zug" "Zug" "Züge" "Züge" masculine) ;
    Tram = mkTransport (mkN "Straßenbahn" "Straßenbahn" "Straßenbahn" "Straßenbahn" "Straßenbahnen" "Straßenbahnen" feminine) ;

    ByFoot = ParadigmsGer.mkAdv "zu Fuß" ;


    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
    HowFarFrom x y = mkQS (mkQCl far_IAdv (mkNP (mkNP y.name (SyntaxGer.mkAdv from_Prep x.name)) (ParadigmsGer.mkAdv "entfernt"))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl how_long_IAdv (mkCl (mkVP (SyntaxGer.mkAdv zu_Prep (mkNP (mkNP y.name (SyntaxGer.mkAdv from_Prep x.name)) t))))) ;
    HowFarBy y t = mkQS (mkQCl how_long_IAdv (mkCl (mkVP (SyntaxGer.mkAdv zu_Prep (mkNP y.name t))))) ;
 
    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;




  oper

    mkNat : Str -> Str -> Str -> {lang : NP ; prop : A ; country : NP} = \co, la, adj -> 
      {lang = mkNP (mkPN la) ; 
       prop = mkA adj ; country = mkNP (mkPN co)} ;
     
    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in
      {name = day ; 
       point = SyntaxGer.mkAdv (mkPrep "am" dative) day ; ---- am 
       habitual = ParadigmsGer.mkAdv (d + "s") ----
      } ;

    mkPlace : N -> Prep -> Prep -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,at,to -> {
      name = mkCN p ;
      at = at ;
      to = to ;
      isPl = False
      } ;

    open_Adv = ParadigmsGer.mkAdv "geöffnet" ;  ---- Adv to get right word order easily
    closed_Adv = ParadigmsGer.mkAdv "geschlossen" ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> mkRelative n (mkCN x) p ; 
  
    
    mkSuperl : A -> Det = \a -> SyntaxGer.mkDet the_Art (SyntaxGer.mkOrd a) ;


    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxGer.mkAdv by8means_Prep (mkNP the_Det n)
      } ;

   far_IAdv = ss "wie weit" ** {lock_IAdv = <>} ; 
   how_long_IAdv = ss "wie lange dauert" ** {lock_IAdv=<>} ;
}
