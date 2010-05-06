-- (c) 2010 Aarne Ranta and Olga Caprotti under LGPL

concrete WordsSpa of Words = SentencesSpa ** open
  SyntaxSpa,
  BeschSpa,
  (E = ExtraSpa),
  (L = LexiconSpa),
  (P = ParadigmsSpa), 
  ParadigmsSpa,
  StructuralSpa,
  Prelude in {

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
    Tea = mkCN (mkN "té") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- properties

    Bad = L.bad_A ;
    Boring = mkA "aburrido" ;
    Cheap = mkA "económico" ; 
    Cold = L.cold_A ;
    Delicious = mkA "delicioso" ;
    Expensive = mkA "caro" ;
    Fresh = mkA "fresco" ;
    Good = L.good_A ;
    Warm = L.warm_A ;
    Suspect = mkA "sospechoso" ;

-- places


    Airport = mkPlace (mkN "aeropuerto") dative ;
    AmusementPark = mkPlace (mkN "parque de atracciones") dative ;
    Bank = mkPlace (mkN "banco") StructuralSpa.in_Prep ;
--    Bar = mkPlace (mkN "bar") in_Prep ;
    Cafeteria = mkPlace (mkN "cafetería") StructuralSpa.in_Prep;
    Center = mkPlace (mkN "centro") StructuralSpa.in_Prep;
    Church = mkPlace (mkN "iglesia") in_Prep ;
    Cinema = mkPlace (mkN "cine") in_Prep ;
    Disco = mkPlace (mkN "disco") in_Prep;
    Hospital = mkPlace (mkN "hospital") in_Prep ;
    Hotel = mkPlace (mkN "hotel") in_Prep ;
    Museum = mkPlace (mkN "museo") in_Prep ;
    Park = mkPlace (mkN "parque") in_Prep ;
    Parking = mkPlace (mkN "estacionamiento") dative ;
    Pharmacy = mkPlace (mkN "farmacia") in_Prep ;
    PostOffice = mkPlace (mkN "oficina de correos") dative ;
    Restaurant = mkPlace (mkN "restaurante") in_Prep ;
    School = mkPlace (mkN "escuela") in_Prep ;
    Shop = mkPlace (mkN "tienda") in_Prep ;
    Station = mkPlace (mkN "estación") in_Prep ;
    Supermarket = mkPlace (mkN "supermercado") dative ;
    Theatre = mkPlace (mkN "teatro") in_Prep ;
    Toilet = mkPlace (mkN "baño") in_Prep ; 
    University = mkPlace (mkN "universidad") dative ;
    Zoo = mkPlace (mkN "zoo") dative ;

    CitRestaurant cit = mkCNPlace (mkCN cit (mkN "restaurante")) in_Prep to_Prep ;

-- currencies
    DanishCrown = mkCN (mkA "danesa") (mkN "corona") | mkCN (mkN "corona") ;
    Dollar = mkCN (mkN "dólar") ;
    Euro = mkCN (mkN "Euro" "Euro" masculine) ;
    Lei = mkCN (mkN "leu") ; 
    Leva = mkCN (mkN "lev" "lev" masculine) ; 
    NorwegianCrown = mkCN (mkA "noruega") (mkN "corona") | mkCN (mkN "corona") ;
    Rouble = mkCN (mkN "rublo") ; 
    SwedishCrown = mkCN (mkA "sueca") (mkN "corona") | mkCN (mkN "corona") ;
    Zloty = mkCN (mkN "zloty" "zlotych" masculine) ;

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
    Bus = mkTransport (mkN "autobús" "autobús" masculine) ;
    Car = mkTransport L.car_N ;
    Ferry = mkTransport (mkN "balsa") ;
    Plane = mkTransport L.airplane_N ;
    Subway = mkTransport (mkN "metro" feminine) ; 
    Taxi = mkTransport (mkN "taxi" masculine) ; 
    Train = mkTransport (mkN "tren") ;
    Tram = mkTransport (mkN "tranvía") ;

    ByFoot = ParadigmsSpa.mkAdv "a pie" ;    

-- actions

    AHasAge p num = mkCl p.name have_V2 (mkNP num L.year_N) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "habitación")) (SyntaxSpa.mkAdv for_Prep (mkNP num (mkN "persona")))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "mesa")) (SyntaxSpa.mkAdv for_Prep (mkNP num (mkN "persona")))) ;
--   AHasName p name = mkCl p.name (mkV2 (reflV (mkV "chiamare"))) name ;
    AHungry p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "hambre" feminine))) ;
    AIll p = mkCl p.name (mkA "enfermo") ;
--   AKnow p = mkCl p.name (mkV (sapere_78 "sapere")) ;
--   ALike p item = mkCl item (mkV2 (mkV (piacere_64 "piacere")) dative) p.name ;
--   ALive p co = mkCl p.name (mkVP (mkVP (mkV "abitare")) (SyntaxSpa.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (mkV2 (mkV "amar")) q.name ;
    AMarried p = mkCl p.name (mkA "casado") ;
    AReady p = mkCl p.name (mkA "preparado") ;
--    AScared p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "paura" feminine))) ;
    ASpeak p lang = mkCl p.name  (mkV2 (mkV "hablar")) lang ;
    AThirsty p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "sed" feminine))) ;
    ATired p = mkCl p.name (mkA "cansado") ;
    AUnderstand p = mkCl p.name (mkV "entender") ;
--    AWant p obj = mkCl p.name (mkV2 (mkV (volere_96 "volere"))) obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;


-- miscellaneous

--    QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name (reflV (mkV "chiamare")))) ;
--    QWhatAge p = mkQS (mkQCl (mkIP how8many_IDet L.year_N) p.name have_V2) ; 
--    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "cuestar"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "cuestar")) price ;

    PropOpen p = mkCl p.name open_A ;
    PropClosed p = mkCl p.name closed_A ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 


-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (ss ("nos vemos"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p = mkText (lin Text (ss ("nos vemos"))) (mkPhrase (mkUtt p.at)) ;
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("nos vemos"))) 
        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "my wife" or "the wife of my son", as defined by $xOf$
-- below. Languages with productive genitives can use an equivalent of
-- "my son's wife" for non-pronouns, as e.g. in English.

    Wife = xOf sing (mkN "esposa" feminine) ;
    Husband = xOf sing (mkN "marido" masculine) ;
    Son = xOf sing (mkN "hijo" masculine) ;
    Daughter = xOf sing (mkN "hija" feminine) ;
    Children = xOf plur L.child_N ;

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

--    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
--    HowFarFrom x y = mkQS (mkQCl (mkIAdv far_IAdv (SyntaxSpa.mkAdv from_Prep x.name)) y.name) ;
--    HowFarFromBy x y t =       mkQS (mkQCl (mkIAdv (mkIAdv far_IAdv (SyntaxSpa.mkAdv from_Prep x.name)) t) y.name) ;
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
    TheCheapest = mkSuperl (mkA "barato") ;
    TheMostExpensive = mkSuperl (mkA "caro") ;
    TheMostPopular = mkSuperl (mkA "populares") ;
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;




-- auxiliaries

  oper
    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in
      mkNPDay day (P.mkAdv d) (P.mkAdv ("los" ++ d)) ; ---- ?

    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,i ->
      mkCNPlace (mkCN p) i dative ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> mkRelative n (mkCN x) p ; 

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxSpa.mkAdv with_Prep (mkNP n)
      } ;

    mkSuperl : A -> Det = \a -> SyntaxSpa.mkDet the_Art (SyntaxSpa.mkOrd a) ;

    open_A = mkA "abierto" ;
    closed_A = mkA "cerrado" ;


}
