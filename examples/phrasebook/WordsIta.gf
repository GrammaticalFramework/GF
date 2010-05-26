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
    Coffee = mkCN (mkN "caffè") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "carne" feminine) ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pizza") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "tè") ;
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
    University = mkPlace (mkN "università") dative ;
    Zoo = mkPlace (mkN "zoo") dative ;

    CitRestaurant cit = mkCNPlace (mkCN cit (mkN "ristorante")) P.in_Prep dative ;



-- transports

   HowFar place = mkQS (mkQCl how8much_IAdv (mkCl place.name (mkV "distare")));

-- -- how far is place from x
   HowFarFrom x place = mkQS (mkQCl how8much_IAdv (mkCl place.name (mkVP (mkV2 (mkV "distare") from_Prep) x.name ))) ;

-- -- how far is place by t
   HowFarBy place t = mkQS (mkQCl how8much_IAdv (mkCl place.name (mkVP (mkVP (mkV "distare")) t)) ); 

-- -- how far is place from x by t
   HowFarFromBy x place t = mkQS (mkQCl how8much_IAdv (mkCl place.name (mkVP (mkVP (mkV2 (mkV "distare") from_Prep)x.name) t) )); 

--   HowFarFromBy x y t =  mkQS (mkQCl (mkIAdv (mkIAdv L.far_Adv (SyntaxIta.mkAdv from_Prep x.name)) t) y.name) ;

-- currencies

    DanishCrown = mkCN (mkA "danese") (mkN "corona") | mkCN (mkN "corona") ;
    Dollar = mkCN (mkN "dollar") ;
    Euro = mkCN (mkN "Euro" "Euro" masculine) ;
    Lei = mkCN (mkN "leu") ; 
    Leva = mkCN (mkN "lev" "lev" masculine) ; 
    NorwegianCrown = mkCN (mkA "norvegese") (mkN "corona") | mkCN (mkN "corona") ;
    Pound = mkCN (mkN "sterlina") ;
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
    Spanish = mkNat "spagnolo" "Spagna" ;
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

    Monday = mkDay "lunedì" ;
    Tuesday = mkDay "martedì" ;
    Wednesday = mkDay "mercoledì" ;
    Thursday = mkDay "giovedì" ;
    Friday = mkDay "venerdì" ;
    Saturday = mkDay "sabato" ;
    Sunday = mkDay "domenica" ;

    Tomorrow = P.mkAdv "domani" ;

lin
    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;

-- modifiers of places

    TheBest = mkSuperl True L.good_A ;
    TheClosest = mkSuperl False L.near_A ; 
    TheCheapest = mkSuperl False (mkA (mkA "economico") (mkA "meno caro")) ;
    TheMostExpensive = mkSuperl False (mkA "costoso") ;
    TheMostPopular = mkSuperl False (mkA "alla moda") ;
    TheWorst = mkSuperl True L.bad_A ;

    SuperlPlace sup kind = 
      let 
        det  : Det = mkDet the_Art (mkOrd sup.s) ;
        name : NP  = case sup.isPre of {
          True  => mkNP det kind.name ;                 -- il migliore bar
          False => mkNP the_Art (mkCN (mkAP (mkOrd sup.s)) kind.name)  -- il bar più caro
          } 
      in {
        name = name ;
        at = SyntaxIta.mkAdv kind.at name ;
        to = SyntaxIta.mkAdv kind.to name
      } ;

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
      by = E.PrepCN P.in_Prep n
      } ;

    mkSuperl : Bool -> A -> {s : A ; isPre : Bool} = \b,a -> 
      {s = a ; isPre = b} ;

    open_A = mkA "aperto" ;
    closed_A = mkA "chiuso" ;

}
