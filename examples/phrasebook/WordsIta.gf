-- (c) 2010 Aarne Ranta and Olga Caprotti under LGPL

concrete WordsIta of Words = SentencesIta ** open
  SyntaxIta,
  BeschIta,
  (E = ExtraIta),
  (L = LexiconIta),
  (P = ParadigmsIta), 
  ParadigmsIta,
  Prelude in {

lin

-- kinds

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "formaggio") ;
    Chicken = mkCN (mkN "pollo") ;
    Coffee = mkCN (mkN "caff�") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "carne" feminine) ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pizza") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "t�") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- properties

    Bad = L.bad_A ;
    Boring = mkA "noioso" ;
    Cheap = mkA "conveniente";
    Cold = L.cold_A ;
    Delicious = mkA "delizioso" ;
    Expensive = mkA "costoso" ;
    Fresh = mkA "fresco" ;
    Good = L.good_A ;
    Warm = L.warm_A ;
    Suspect = mkA "sospetto" ;

-- places

    Airport = mkPlace (mkN "aeroporto") dative ;
    AmusementPark = mkPlace (mkN "parco divertimenti") dative ;
    Bank = mkPlace (mkN "banca") P.in_Prep ;
    Bar = mkPlace (mkN "bar") dative ;
    Cafeteria = mkPlace (mkN "mensa") P.in_Prep;
    Center = mkPlace (mkN "centro") P.in_Prep;
    Church = mkPlace (mkN "chiesa") P.in_Prep ;
    Cinema = mkPlace (mkN "cinema" masculine) dative ;
    Disco = mkPlace (mkN "discoteca") P.in_Prep;
    Hospital = mkPlace (mkN "ospedale") P.in_Prep ;
    Hotel = mkPlace (mkN "albergo") P.in_Prep ;
    Museum = mkPlace (mkN "museo") dative ;
    Park = mkPlace (mkN "parco") dative ;
    Parking = mkPlace (mkN "parcheggio") dative ;
    Pharmacy = mkPlace (mkN "farmacia") P.in_Prep ;
    PostOffice = mkPlace (mkN "ufficio postale") dative ;
    Pub = mkPlace (mkN "birreria") P.in_Prep ;
    Restaurant = mkPlace (mkN "ristorante") dative ;
    School = mkPlace (mkN "scuola") dative ;
    Shop = mkPlace (mkN "negozio") P.in_Prep ;
    Station = mkPlace (mkN "stazione" feminine) dative ;
    Supermarket = mkPlace (mkN "supermercato") dative ;
    Theatre = mkPlace (mkN "teatro") dative ;
    Toilet = mkPlace (mkN "bagno") P.in_Prep ;
    University = mkPlace (mkN "universit�") dative ;
    Zoo = mkPlace (mkN "zoo") dative ;

    CitRestaurant cit = mkCNPlace (mkCN cit (mkN "ristorante")) P.in_Prep dative ;


-- currencies

    DanishCrown = mkCN (mkA "danese") (mkN "corona") | mkCN (mkN "corona") ;
    Dollar = mkCN (mkN "dollar") ;
    Euro = mkCN (mkN "Euro" "Euro" masculine) ;
    Lei = mkCN (mkN "leu") ; 
    Leva = mkCN (mkN "lev" "lev" masculine) ; 
    NorwegianCrown = mkCN (mkA "norvegese") (mkN "corona") | mkCN (mkN "corona") ;
    Rouble = mkCN (mkN "rublo") ; 
    SwedishCrown = mkCN (mkA "svedese") (mkN "corona") | mkCN (mkN "corona") ;
    Zloty = mkCN (mkN "zloty" "zlotych" masculine) ;

-- nationalities

    Belgian = mkA "belga" ;
    Belgium = mkNP (mkPN "Belgio") ;
    Bulgarian = mkNat "bulgaro" "Bulgaria" ;
    Catalan = mkNat "catalano" "Catalonia" ;
    Danish = mkNat "danese" "Danimarca" ;
    Dutch = mkNat "olandese" "Olanda" ;
    English = mkNat "inglese" "Inghilterra" ;
    Finnish = mkNat "finlandese" "Finlandia" ;
    Flemish = mkNP (mkPN "fiammingo") ;
    French = mkNat "francese" "Francia" ;
    German = mkNat "tedesco" "Germania" ;
    Italian = mkNat "italiano" "Italia" ;
    Norwegian = mkNat "norvegese" "Norvegia" ;
    Polish = mkNat "polacco" "Polonia" ;
    Romanian = mkNat "rumeno" "Romania" ;
    Russian = mkNat "russo" "Russia" ;
    Spanish = mkNat "spagnolo" "Spania" ;
    Swedish = mkNat "svedese" "Svezia" ;

-- means of transportation 

    Bike = mkTransport (mkN "bicicletta") ; 
    Bus = mkTransport (mkN "autobus" "autobus" masculine) ;
    Car = mkTransport L.car_N ;
    Ferry = mkTransport (mkN "traghetto") ;
    Plane = mkTransport L.airplane_N ;
    Subway = mkTransport (mkN "metro" feminine) ; 
    Taxi = mkTransport (mkN "taxi" masculine) ; 
    Train = mkTransport (mkN "treno") ;
    Tram = mkTransport (mkN "tram") ;

    ByFoot = ParadigmsIta.mkAdv "a piedi" ;    

-- actions

    AHasAge p num = mkCl p.name have_V2 (mkNP num L.year_N) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "camera")) (SyntaxIta.mkAdv for_Prep (mkNP num (mkN "persona")))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "tavolo")) (SyntaxIta.mkAdv for_Prep (mkNP num (mkN "persona")))) ;
    AHasName p name = mkCl p.name (mkV2 (reflV (mkV "chiamare"))) name ;
    AHungry p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "fame" feminine))) ;
    AIll p = mkCl p.name (mkA "malato") ;
    AKnow p = mkCl p.name (mkV (sapere_78 "sapere")) ;
    ALike p item = mkCl item (mkV2 (mkV (piacere_64 "piacere")) dative) p.name ;
    ALive p co = 
      mkCl p.name (mkVP (mkVP (mkV "abitare")) (SyntaxIta.mkAdv P.in_Prep co)) ;
    ALove p q = mkCl p.name (mkV2 (mkV "amare")) q.name ;
    AMarried p = mkCl p.name (mkA "sposato") ;
    AReady p = mkCl p.name (mkA "pronto") ;
    AScared p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "paura" feminine))) ;
    ASpeak p lang = mkCl p.name  (mkV2 (mkV "parlare")) lang ;
    AThirsty p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "sete" feminine))) ;
    ATired p = mkCl p.name (mkA "stanco") ;
    AUnderstand p = mkCl p.name (mkV "capire") ;
    AWant p obj = mkCl p.name (mkV2 (mkV (volere_96 "volere"))) obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;


-- miscellaneous

    QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name (reflV (mkV "chiamare")))) ;
    QWhatAge p = mkQS (mkQCl (mkIP how8many_IDet L.year_N) p.name have_V2) ; 
    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "costare"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "costare")) price ;

    PropOpen p = mkCl p.name open_A ;
    PropClosed p = mkCl p.name closed_A ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 


-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (ss ("ci vediamo"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p = mkText (lin Text (ss ("ci vediamo"))) (mkPhrase (mkUtt p.at)) ;
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("ci vediamo"))) 
        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "my wife" or "the wife of my son", as defined by $xOf$
-- below. Languages with productive genitives can use an equivalent of
-- "my son's wife" for non-pronouns, as e.g. in English.

    Wife = xOf sing (mkN "moglie" feminine) ;
    Husband = xOf sing (mkN "marito" masculine) ;
    Son = xOf sing (mkN "figlio" masculine) ;
    Daughter = xOf sing (mkN "figlia" feminine) ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "luned�" ;
    Tuesday = mkDay "marted�" ;
    Wednesday = mkDay "mercoled�" ;
    Thursday = mkDay "gioved�" ;
    Friday = mkDay "venerd�" ;
    Saturday = mkDay "sabato" ;
    Sunday = mkDay "domenica" ;

    Tomorrow = P.mkAdv "domani" ;


-- transports

--    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
--    HowFarFrom x y = mkQS (mkQCl (mkIAdv far_IAdv (SyntaxIta.mkAdv from_Prep x.name)) y.name) ;
--    HowFarFromBy x y t =       mkQS (mkQCl (mkIAdv (mkIAdv far_IAdv (SyntaxIta.mkAdv from_Prep x.name)) t) y.name) ;
--    HowFarBy y t = mkQS (mkQCl (mkIAdv far_IAdv t.by) y.name) ; 

-- oper far_IAdv = E.IAdvAdv L.far_Adv ;

lin
    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (mkA "economico") ;
    TheMostExpensive = mkSuperl (mkA "costoso") ;
    TheMostPopular = mkSuperl (mkA "di moda") ;
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;




-- auxiliaries

  oper
    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in
      mkNPDay day (P.mkAdv d) (P.mkAdv ("di" ++ d)) ; ---- ?

    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,i ->
      mkCNPlace (mkCN p) i dative ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> mkRelative n (mkCN x) p ; 

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxIta.mkAdv with_Prep (mkNP n)
      } ;

    mkSuperl : A -> Det = \a -> SyntaxIta.mkDet the_Art (SyntaxIta.mkOrd a) ;

    open_A = mkA "aperto" ;
    closed_A = mkA "chiuso" ;


}
