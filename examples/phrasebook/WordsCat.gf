-- (c) 2010 Aarne Ranta and Olga Caprotti under LGPL

concrete WordsCat of Words = SentencesCat ** open
  SyntaxCat,
  BeschCat,
  (E = ExtraCat),
  (L = LexiconCat),
  (P = ParadigmsCat), 
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
    Cheap = mkA "barat" ; 
    Cold = L.cold_A ;
    Delicious = mkA "deliciós" "deliciosa" "deliciosos" "delicioses" "deliciosament";
    Expensive = mkA "car" ;
    Fresh = mkA "fresc" ;
    Good = L.good_A ;
    Warm = L.warm_A ;
    Suspect = mkA "sospitós" ;

-- places

    Airport = mkPlace (mkN "aeroport") dative ;
    Bar = mkPlace (mkN "bar") dative ;
    Church = mkPlace (mkN "església") dative ;
    Cinema = mkPlace (mkN "cinema" masculine) dative ;
    Hospital = mkPlace (mkN "hospital") dative ;
    Hotel = mkPlace (mkN "alberg") dative ;
    Museum = mkPlace (mkN "museu") dative ;
    Park = mkPlace (mkN "parc") dative ;
    Restaurant = mkPlace (mkN "restaurant") dative ;
    School = mkPlace (mkN "escola") dative ;
    Shop = mkPlace (mkN "tenda") dative ;
    Station = mkPlace (mkN "estació" feminine) dative ;
    Theatre = mkPlace (mkN "teatre") dative ;
    Toilet = mkPlace (mkN "lavabo") dative ;
    University = mkPlace (mkN "universitat" feminine) dative ;

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
    SwedishCrown = Corona (mkA "suec" "sueca" "suecs" "sueques" "a la sueca") ;

-- nationalities

    Belgian = mkA "belga" ;
    Belgium = mkNP (mkPN "Bèlgica") ;
    English = mkNat "anglès" "Anglaterra" ;
    Finnish = mkNat "finès" "Finlàndia" ;
    Flemish = mkNP (mkPN "flamenc") ;
    French = mkNat "francès" "França" ; 
    Italian = mkNat "italià" "Itàlia" ;
    Romanian = mkNat "romanès" "Romania" ;
    Swedish = mkNat "suec" "Suècia" ;

-- actions

    AHasAge p num = mkCl p.name have_V2 (mkNP num L.year_N) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "habitació" feminine)) (SyntaxCat.mkAdv for_Prep (mkNP num (mkN "persona")))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "taula")) (SyntaxCat.mkAdv for_Prep (mkNP num (mkN "persona")))) ;
    AHasName p name =
       let dir = mkV (dir_41 "dir")
       in mkCl p.name (mkV2 (reflV dir)) name ;
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

    QWhatName p =
       let dir = mkV (dir_41 "dir")
       in  mkQS (mkQCl how_IAdv (mkCl p.name (reflV dir))) ;
    QWhatAge p = mkQS (mkQCl (mkIP how8many_IDet L.year_N) p.name have_V2) ; 
    PropOpen p = mkCl p.name open_A ;
    PropClosed p = mkCl p.name closed_A ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 

    HowMuchCost item = 
      let valer = mkV (valer_114 "valer")
      in  mkQS (mkQCl how8much_IAdv (mkCl item valer)) ; 
    ItCost item price = 
      let valer = mkV (valer_114 "valer")
      in mkCl item (mkV2 valer) price ;

-- Building phrases from strings is complicated: the solution is to use
--   mkText : Text -> Text -> Text ;

    PSeeYou d = mkText (lin Text (ss ("fins aviat"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p = mkText (lin Text (ss ("fins aviat"))) (mkPhrase (mkUtt p.at)) ;
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("a reveure"))) 
        (mkText (mkPhrase (mkUtt d)) (mkPhrase (mkUtt p.at))) ;

-- Relations are expressed as "my wife" or "the wife of my son", as defined by $xOf$
-- below. Languages with productive genitives can use an equivalent of
-- "my son's wife" for non-pronouns, as e.g. in English.

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

-- auxiliaries

  oper
    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d)
      in mkNPDay day (P.mkAdv ("el" ++ d)) (P.mkAdv ("el" ++ d)) ; ---- ?

    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,i ->
      mkCNPlace (mkCN p) i dative ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> mkRelative n (mkCN x) p ; 

    open_A = mkA "obert" ;
    closed_A = mkA "tancat" ;
}
