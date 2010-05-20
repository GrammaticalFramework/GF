-- (c) 2010 Aarne Ranta and Olga Caprotti under LGPL

concrete WordsSpa of Words = SentencesSpa ** open
  SyntaxSpa,
  BeschSpa,
  (E = ExtraSpa),
  (L = LexiconSpa),
  (P = ParadigmsSpa), 
  (S = SyntaxSpa),
  ParadigmsSpa,
  StructuralSpa,
  Prelude in {

flags coding = utf8 ;

lin

-- kinds

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "queso") ;
    Chicken = mkCN (mkN "pollo") ;
    Coffee = mkCN (mkN "café") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "carne" feminine) ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pizza") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "té" "tés" masculine) ;
    Water = mkCN (mkN "agua") ;
    Wine = mkCN L.wine_N ;

-- properties

    Bad = L.bad_A ;
    Boring = mkA "aburrido" ;
    Cheap = cheap_A ; 
    Cold = L.cold_A ;
    Delicious = mkA "delicioso" ;
    Expensive = expensive_A ;
    Fresh = mkA "fresco" ;
    Good = L.good_A ;
    Warm = L.warm_A ;
    Suspect = mkA "sospechoso" ;

-- places

    Airport = mkPlace (mkN "aeropuerto") in_Prep ;
    AmusementPark = mkPlace (compN (mkN "parque") ["de atracciones"]) in_Prep ;
    Bank = mkPlace (mkN "banco") in_Prep ;
    Bar = mkPlace (mkN "bar") in_Prep ;
    Cafeteria = mkPlace (mkN "cafetería") in_Prep;
    Center = mkPlace (mkN "centro") in_Prep;
    Church = mkPlace (mkN "iglesia") in_Prep ;
    Cinema = mkPlace (mkN "cine") in_Prep ;
    Disco = mkPlace (mkN "disco") in_Prep;
    Hospital = mkPlace (mkN "hospital") in_Prep ;
    Hotel = mkPlace (mkN "hotel") in_Prep ;
    Museum = mkPlace (mkN "museo") in_Prep ;
    Park = mkPlace (mkN "parque") in_Prep ;
    Parking = mkPlace (mkN "aparcamiento") in_Prep ;
    Pharmacy = mkPlace (mkN "farmacia") in_Prep ;
    PostOffice = mkPlace (compN (mkN "oficina") ["de correos"]) in_Prep ;
    Pub = mkPlace (mkN "pub" "pubs" masculine) in_Prep ;
    Restaurant = mkPlace (mkN "restaurante") in_Prep ;
    School = mkPlace (mkN "escuela") in_Prep ;
    Shop = mkPlace (mkN "tienda") in_Prep ;
    Station = mkPlace (mkN "estación" feminine) in_Prep ;
    Supermarket = mkPlace (mkN "supermercado") in_Prep ;
    Theatre = mkPlace (mkN "teatro") in_Prep ;
    Toilet = mkPlace (mkN "baño") in_Prep ; 
    University = mkPlace (mkN "universidad" feminine) in_Prep ;
    Zoo = mkPlace (mkN "zoo") in_Prep ;

    CitRestaurant cit = mkCNPlace (mkCN cit (mkN "restaurante")) in_Prep to_Prep ;

-- currencies
    DanishCrown = mkCN (mkA "daneso") (mkN "corona") | mkCN (mkN "corona") ;
    Dollar = mkCN (mkN "dólar") ;
    Euro = mkCN (mkN "euro") ;
    Lei = mkCN (mkN "leu") ; 
    Leva = mkCN (mkN "lev" "lev" masculine) ; 
    NorwegianCrown = mkCN (mkA "noruego") (mkN "corona") | mkCN (mkN "corona") ;
    Pound = mkCN (mkN "libra") | mkCN (mkA "esterlino") (mkN "libra") ;
    Rouble = mkCN (mkN "rublo") ; 
    SwedishCrown = mkCN (mkA "sueco") (mkN "corona") | mkCN (mkN "corona") ;
    Zloty = mkCN (mkN "zloty" "zlotys" masculine) ;

-- nationalities

    Belgian = mkA "belga" ;
    Belgium = mkNP (mkPN "Bélgica") ;
    Bulgarian = mkNat "bulgaro" "Bulgaria" ;
    Catalan = mkNat "catalán" "Cataluña" ;
    Danish = mkNat "danés" "Dinamarca" ;
    Dutch = mkNat "neerlandés" "Holanda" ;
    English = mkNat "inglés" "Inglaterra" ;
    Finnish = mkNat "finlandés" "Finlandia" ;
    Flemish = mkNP (mkPN "flamenco") ;
    French = mkNat "francés" "Francia" ;
    German = mkNat "alemán" "Alemania" ;
    Italian = mkNat "italiano" "Italia" ;
    Norwegian = mkNat "noruego" "Noruega" ;
    Polish = mkNat "polaco" "Polonia" ;
    Romanian = mkNat "rumano" "Rumania" ;
    Russian = mkNat "ruso" "Rusia" ;
    Spanish = mkNat "español" "España" ;
    Swedish = mkNat "sueco" "Suecia" ;

-- means of transportation 

    Bike = mkTransport (mkN "bicicleta") ; 
    Bus = mkTransport (mkN "autobús" "autobuses" masculine) ;
    Car = mkTransport L.car_N | mkTransport (mkN "coche") ; 
    Ferry = mkTransport (mkN "ferry") | mkTransport (mkN "transbordador") ;
    Plane = mkTransport (mkN "avión") ;
    Subway = mkTransport (mkN "metro") ; 
    Taxi = mkTransport (mkN "taxi" masculine) ; 
    Train = mkTransport (mkN "tren") ;
    Tram = mkTransport (mkN "tranvía") ;

    ByFoot = P.mkAdv "a pie" ;    

-- actions

    AHasAge p num = mkCl p.name have_V2 (mkNP num L.year_N) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num (mkN "hijo")) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "habitación" feminine)) (S.mkAdv for_Prep (mkNP num (mkN "persona")))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "mesa")) (S.mkAdv for_Prep (mkNP num (mkN "persona")))) ;
    AHasName p name = mkCl p.name (mkV2 (reflV (mkV "llamar"))) name ;
    AHungry p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "hambre" feminine))) ;
    AIll p = mkCl p.name stateCopula (mkAP (mkA "enfermo")) ;
    AKnow p = mkCl p.name (mkV (saber_71 "saber")) ;
    ALike p item = mkCl item (mkV2 (mkV ("gustar")) dative) p.name ;
    ALive p co = mkCl p.name (mkVP (mkVP (mkV "vivir")) (S.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (mkV2 (mkV "amar")) q.name ;
    AMarried p = mkCl p.name (mkA "casado") ;
    AReady p = mkCl p.name stateCopula (mkAP (mkA "listo")) ;
    AScared p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "miedo"))) ;
    ASpeak p lang = mkCl p.name (mkV2 (mkV "hablar")) lang ;
    AThirsty p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "sed" feminine))) ;
    ATired p = mkCl p.name stateCopula (mkAP (mkA "cansado")) ;
    AUnderstand p = mkCl p.name (mkV (defender_29 "entender")) ;
    AWant p obj = mkCl p.name (mkV2 (mkV (querer_64 "querer"))) obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;


-- miscellaneous

    QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name (reflV (mkV "llamar")))) ;
    QWhatAge p = mkQS (mkQCl (mkIP how8many_IDet L.year_N) p.name have_V2) ; 
    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "costar" "cuesto"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "costar" "cuesto")) price ;

    PropOpen p = mkCl p.name stateCopula (mkAP open_A) ;
    PropClosed p = mkCl p.name stateCopula (mkAP closed_A) ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP stateCopula (mkAP open_A)) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP stateCopula (mkAP closed_A)) d) ;
    PropOpenDay p d = mkCl p.name (mkVP (mkVP stateCopula (mkAP open_A)) d.habitual) ;
    PropClosedDay p d = mkCl p.name (mkVP (mkVP stateCopula (mkAP closed_A)) d.habitual) ;


-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (ss ("nos vemos"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p = mkText (lin Text (ss ("nos vemos"))) (mkPhrase (mkUtt p.at)) ;
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("nos vemos"))) 
        (mkText (mkPhrase (mkUtt d)) (mkPhrase (mkUtt p.at))) ;

-- Relations are expressed as "my wife" or "the wife of my son", as defined by $xOf$
-- below. Languages with productive genitives can use an equivalent of
-- "my son's wife" for non-pronouns, as e.g. in English.

    Wife = xOf sing (mkN "esposa" feminine) ;
    Husband = xOf sing (mkN "marido" masculine) ;
    Son = xOf sing (mkN "hijo" masculine) ;
    Daughter = xOf sing (mkN "hija" feminine) ;
    Children = xOf plur (mkN "hijo") ;

-- week days

    Monday = mkDay "lunes" ;
    Tuesday = mkDay "martes" ;
    Wednesday = mkDay "miércoles" ;
    Thursday = mkDay "jueves" ;
    Friday = mkDay "viernes" ;
    Saturday = mkDay "sábado" ;
    Sunday = mkDay "domingo" ;

    Tomorrow = P.mkAdv "mañana" ;


-- transports

    -- "qué tan lejos está PLACE"
    HowFar place = mkQS (mkQCl far_IP place.name placeCopula) ;

    -- "qué tan lejos de X está Y"
    HowFarFrom x y = mkQS (mkQCl (mkIP far_IP (S.mkAdv from_Prep x.name)) y.name placeCopula) ; 

    -- "cuánto dura desde X hasta Y con T"
    -- x,y: Place ; t: ByTransport
    HowFarFromBy x y t = mkQS (mkQCl how8much_IAdv
       (mkCl (mkVP (mkVP (mkVP (mkVP (mkV "durar")) (S.mkAdv desde_Prep x.name)) (S.mkAdv hasta_Prep y.name)) t ))) ;

    -- "cuánto dura hasta Y con T"
    -- y: Place ; t: ByTransport
    HowFarBy y t = mkQS (mkQCl how8much_IAdv 
       (mkCl (mkVP (mkVP (mkVP (mkV "durar")) (S.mkAdv hasta_Prep y.name)) t ))) ;


oper
     far_IP = mkIP whatSg_IP (S.mkAdv (P.mkAdA "tan") (P.mkAdv "lejos")) ; -- "qué tan lejos"
     how8much_IAdv = ss "cuánto" ; -- this wasn't implemented in the resource library
     desde_Prep = mkPrep "desde" ;
     hasta_Prep = mkPrep "hasta" ;
     placeCopula = mkV2 (mkV (estar_2 "estar")) ; 

lin
    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;

-- modifiers of places

    ------------------------------------------------------------------
    -- Common adjectives like "good" or "bad" come before the noun,
    -- but most of them come after. So, when making a superlative
    -- place, we have to know in which place it belongs.
    -- 
    -- The lincat of Superlative is defined in SentencesSpa as a type
    -- OrdSuperlative, consisting of {ord: Ord ; isPre: Bool}.
    -- 
    -- The function mkSuperl returns an OrdSuperlative. SuperlPlace
    -- takes two parameters, OrdSuperlative and PlaceKind, and gives
    -- them to placeNPSuperl (defined in SentencesSpa). 
    -- In placeNPSuperl the value of isPre determines whether the
    -- superlative is placed before or after the noun.
    ------------------------------------------------------------------

    TheBest = mkSuperl L.good_A True;
    TheClosest = mkSuperl L.near_A False; 
    TheCheapest = mkSuperl cheap_A False ;
    TheMostExpensive = mkSuperl expensive_A False ;
    TheMostPopular = mkSuperl (mkA "popular") False ;
    TheWorst = mkSuperl L.bad_A True ;

    SuperlPlace sup p = placeNPSuperl sup p ;


-- auxiliaries

  oper
    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;


    -- not the most elegant solution, but it works
    mkDay : Str -> NPDay = \d ->
      case last d of {
        "s" => mkNPDay (mkNP (mkN d)) (P.mkAdv d) (P.mkAdv ("los" ++ d)) ;
         _  => mkNPDay (mkNP (mkN d)) (P.mkAdv d) (P.mkAdv ("los" ++ d + "s")) 
      } ;

    mkPlace : N -> Prep -> CNPlace = \p,i ->
      mkCNPlace (mkCN p) i dative ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> mkRelative n (mkCN x) p ; 

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = S.mkAdv with_Prep (mkNP n)
      } ;

    mkSuperl : A -> Bool -> OrdSuperlative = \a,bool ->
      let ord : Ord = S.mkOrd a in {
        ord = ord ;
        isPre = bool ;
      } ;


    -- for adjectives that express temporary state
    stateCopula = mkVA (mkV (estar_2 "estar")) ;

    cheap_A = mkA "barato" ; 
    expensive_A = mkA "caro" ;
    open_A = mkA "abierto" ;
    closed_A = mkA "cerrado" ;

}
