-- (c) 2010 Aarne Ranta and Olga Caprotti under LGPL

concrete WordsCat of Words = SentencesCat ** open
  SyntaxCat,
  BeschCat,
  (E = ExtraCat),
  (L = LexiconCat),
  (P = ParadigmsCat), 
  (S = SyntaxCat),
  ParadigmsCat,
  Prelude in {

lin

-- kinds

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "formatge") ;
    Chicken = mkCN (mkN "pollastre") ;
    Coffee = mkCN (mkN "cafè") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "carn" feminine) ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pizza") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "te") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- properties

    Bad = L.bad_A ;
    Boring = mkA "avorrit" "avorrida" "avorrits" "avorrides" "avorridament" ;
    Cheap = cheap_A ; 
    Cold = L.cold_A ;
    Delicious = mkA "deliciós" "deliciosa" "deliciosos" "delicioses" "deliciosament";
    Expensive = expensive_A ; 
    Fresh = mkA "fresc" ;
    Good = L.good_A ;
    Suspect = mkA "sospitós" ;
    Warm = L.warm_A ;

-- places

oper
	mkLloc : N -> CNPlace = \n -> mkPlace n dative ;
lin
    Airport = mkLloc (mkN "aeroport") ;
    AmusementPark = mkLloc (mkN "parc d' atraccions") ;
	Bank = mkLloc (mkN "banc") ;
    Bar = mkLloc (mkN "bar") ;
    Cafeteria = mkLloc (mkN "cafeteria") ;
    Center = mkLloc (mkN "centre") ;
    Cinema = mkLloc (mkN "cinema" masculine) ;
    Church = mkLloc (mkN "església")  ;
    Disco = mkLloc (mkN "discoteca") ;
    Hospital = mkLloc (mkN "hospital")  ;
    Hotel = mkLloc (mkN "alberg")  ;
    Museum = mkLloc (mkN "museu")  ;
    Park = mkLloc (mkN "parc") ;
    Parking = mkLloc (mkN "pàrking" masculine) ;
    Pharmacy = mkLloc (mkN "farmàcia") ;
	PostOffice = mkLloc (mkN "oficina de correus" feminine) ;
    Pub = mkLloc (mkN "pub" masculine) ;
    Restaurant = mkLloc (mkN "restaurant") ;
    School = mkLloc (mkN "escola") ;
    Shop = mkLloc (mkN "tenda") ;
    Station = mkLloc (mkN "estació" feminine)  ;
    Supermarket = mkLloc (mkN "supermercat" masculine) ;
    Theatre = mkLloc (mkN "teatre")  ;
    Toilet = mkLloc (mkN "lavabo")  ;
    University = mkLloc (mkN "universitat" feminine) ;
    Zoo = mkLloc (mkN "zoo" masculine) ;

    CitRestaurant cit = mkCNPlace (mkCN cit (mkN "restaurant")) in_Prep dative ;

-- currencies
oper
	Corona : A -> CN = \adj -> 
		let corona = (mkN "corona")
		in mkCN adj corona | mkCN corona ;
lin
    DanishCrown = Corona (mkA "danès" "danesa" "danesos" "daneses" "a la danesa") ; 
    Dollar = mkCN (mkN "dollar") ;
  	Euro = mkCN (mkN "euro" "euro" masculine) ;
    Lei = mkCN (mkN "leu" "lei" masculine) ;
	Leva = mkCN (mkN "lev" "lev" masculine) ; 
	NorwegianCrown = Corona (mkA "noruec" "noruega" "noruecs" "noruegues" "a la noruega") ;
	Pound = mkCN (mkN "lliura") ;
	Rouble = mkCN (mkN "ruble") ;
    SwedishCrown = Corona (mkA "suec" "sueca" "suecs" "sueques" "a la sueca") ;
	Zloty = mkCN (mkN "zloty" "zloty" masculine) ;

-- nationalities

    Belgian = mkA "belga" ;
    Belgium = mkNP (mkPN "Bèlgica") ;
	Bulgarian = mkNat "búlgar" "Bulgària" ;
	Catalan = mkNat "català" "Catalunya" ; -- "catalana" "catalans" "catalanes" "a la catalana" ;
	Danish = mkNat "danès" "Dinamarca" ; -- mkA "danès" "danesa" "danesos" "daneses" "a la danesa" ;
	Dutch = mkNat "holandès" "Holanda" ; 
    English = mkNat "anglès" "Anglaterra" ;
    Finnish = mkNat "finès" "Finlàndia" ;
    Flemish = mkNP (mkPN "flamenc") ;
    French = mkNat "francès" "França" ;
    German = mkNat "alemany" "Alemania" ;
    Italian = mkNat "italià" "Itàlia" ;
    Norwegian = mkNat "noruec" "Noruega" ; -- mkA "noruec" "noruega" "noruecs" "noruegues" "a la noruega" ;
    Polish = mkNat "polonès" "Polònia" ; 
    Romanian = mkNat "romanès" "Romania" ;
    Russian = mkNat "rus" "Rússia" ;
    Spanish = mkNat "espanyol" "Espanya" ;
    Swedish = mkNat "suec" "Suècia" ;


-- means of transportation 

    Bike = mkTransport (mkN "bici" feminine) ; 
    Bus = mkTransport (mkN "autobús" "autobusos" masculine) ; 
    Car = mkTransport L.car_N ;
    Ferry = mkTransport (mkN "ferri" masculine) ;
    Plane = mkTransport L.airplane_N ;
    Subway = mkTransport (mkN "metro") ;
    Taxi = mkTransport (mkN "taxi" masculine) ;
    Train = mkTransport (mkN "tren" masculine) ;
    Tram = mkTransport (mkN "tramvia" masculine) ;

    ByFoot = P.mkAdv "a peu" ;

-- actions

    AHasAge p num = mkCl p.name have_V2 (mkNP num L.year_N) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasName p name =
       let dir = mkV (dir_41 "dir")
       in mkCl p.name (mkV2 (reflV dir)) name ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "habitació" feminine)) (SyntaxCat.mkAdv for_Prep (mkNP num (mkN "persona")))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "taula")) (SyntaxCat.mkAdv for_Prep (mkNP num (mkN "persona")))) ;
    AHungry p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "gana" feminine))) ;
    AIll p = mkCl p.name (mkA "malalt") ;
    AKnow p =
      let saber = mkV (saber_99 "saber")
      in mkCl p.name saber ;
    ALike p item = mkCl item (mkV2 (mkV "agradar") dative) p.name ;
    ALive p co =
      let viure = mkV (viure_119 "viure")
      in mkCl p.name (mkVP (mkVP viure) (SyntaxCat.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (mkV2 (mkV "estimar")) q.name ;
    AMarried p = mkCl p.name (mkA "casat") ;
    AReady p =
      let ap = "a punt"
      in mkCl p.name (mkA ap ap ap ap ap) ;
    AScared p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "por" feminine))) ;
    ASpeak p lang = mkCl p.name  (mkV2 (mkV "parlar")) lang ;
    AThirsty p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "set" feminine))) ;
    ATired p = mkCl p.name (mkA "cansat") ;
    AUnderstand p = mkCl p.name (mkV "entendre") ;
    AWant p obj = 
      let voler = mkV (voler_120 "voler")
      in mkCl p.name (mkV2 voler) obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;


-- miscellaneous

    QWhatAge p = mkQS (mkQCl (mkIP how8many_IDet L.year_N) p.name have_V2) ; 
    QWhatName p =
       let dir = mkV (dir_41 "dir")
       in  mkQS (mkQCl how_IAdv (mkCl p.name (reflV dir))) ;
    HowMuchCost item = 
      let valer = mkV (valer_114 "valer")
      in  mkQS (mkQCl how8much_IAdv (mkCl item valer)) ; 
    ItCost item price = 
      let valer = mkV (valer_114 "valer")
      in mkCl item (mkV2 valer) price ;
    PropOpen p = mkCl p.name open_A ;
    PropClosed p = mkCl p.name closed_A ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 
-- Building phrases from strings is complicated: the solution is to use
--   mkText : Text -> Text -> Text ;
	PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("a reveure"))) 
      (mkText (mkPhrase (mkUtt d)) (mkPhrase (mkUtt p.at))) ;
    PSeeYouPlace p = mkText (lin Text (ss ("fins aviat"))) (mkPhrase (mkUtt p.at)) ;
--  PSeeYou d = mkText (lin Text (ss ("fins aviat"))) (mkPhrase (mkUtt d)) ;
    PSeeYouDate d = mkText (lin Text (ss ("a reveure"))) (mkPhrase (mkUtt d)) ;


-- Relations are expressed as "my wife" or "the wife of my son", as defined by $xOf$
-- below. Languages with productive genitives can use an equivalent of
-- "my son's wife" for non-pronouns, as e.g. in English.

-- family relations

    Wife = xOf sing (mkN "dona") ;
    Husband = xOf sing (mkN "home") ;
    Son = xOf sing (mkN "fill") ;
    Daughter = xOf sing (mkN "filla") ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "dilluns" ;
    Tuesday = mkDay "dimarts" ;
    Wednesday = mkDay "dimecres" ;
    Thursday = mkDay "dijous" ;
    Friday = mkDay "divendres" ;
    Saturday = mkDay "dissabte" ;
    Sunday = mkDay "diumenge" ;

    Tomorrow = P.mkAdv "demà" ;


-- transports

   HowFar place = mkQS (mkQCl far_IP place.name placeCopula) ;
   HowFarFrom x y = mkQS (mkQCl (mkIP far_IP (S.mkAdv from_Prep x.name)) y.name placeCopula) ; 
   HowFarFromBy x y t = mkQS (mkQCl how8much_IAdv
      (mkCl (mkVP (mkVP (mkVP (mkVP (mkV "durar")) (S.mkAdv desde_Prep x.name)) (S.mkAdv fins_Prep y.name)) t ))) ;
   HowFarBy y t = mkQS (mkQCl how8much_IAdv 
      (mkCl (mkVP (mkVP (mkVP (mkV "durar")) (S.mkAdv fins_Prep y.name)) t ))) ;
   WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;
   IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;

-- modifiers of places
    TheBest = mkSuperl L.good_A True ;
	TheClosest = mkSuperl L.near_A False; 
    TheCheapest = mkSuperl cheap_A False ;
    TheMostExpensive = mkSuperl expensive_A False ;
    TheMostPopular = mkSuperl (mkA "popular") False ;
    TheWorst = mkSuperl L.bad_A True ;
    SuperlPlace sup p = placeNPSuperl sup p ;

-- auxiliaries

  oper

  mkSuperl : A -> Bool -> OrdSuperlative = \a,bool ->
    let ord : Ord = S.mkOrd a in {
      ord = ord ;
      isPre = bool ;
    } ;

	desde_Prep = mkPrep "des de" ;

    fins_Prep = mkPrep "fins a" ;

	far_IP = mkIP whatSg_IP (S.mkAdv (P.mkAdA "tan") (P.mkAdv "lluny")) ; 
	
    placeCopula = mkV2 (mkV (estar_54 "estar")) ; 

    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d)
      in mkNPDay day (P.mkAdv ("el" ++ d)) (P.mkAdv ("el" ++ d)) ; ---- ?

    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,i ->
      mkCNPlace (mkCN p) i dative ;

	 mkTransport : N -> {name : CN ; by : Adv} = \n -> {
	      name = mkCN n ; 
	      by = S.mkAdv with_Prep (mkNP n)
	      } ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> mkRelative n (mkCN x) p ; 

    open_A = mkA "obert" ;
    closed_A = mkA "tancat" ;
	cheap_A = mkA "barat" ; 
	expensive_A = mkA "car" ;
}


