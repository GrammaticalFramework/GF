-- (c) 2010 Aarne Ranta under LGPL

concrete WordsFin of Words = SentencesFin ** 
  open 
    SyntaxFin, ParadigmsFin, (L = LexiconFin), 
    Prelude, (E = ExtraFin) in {

  lin

-- kinds

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "juusto") ;
    Chicken = mkCN (mkN "kana") ;
    Coffee = mkCN (mkN "kahvi") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "liha") ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pizza") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "tee") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- qualities

    Bad = L.bad_A ;
    Boring = mkA "tylsä" ;
    Cheap = mkA "halpa" ;
    Cold = L.cold_A ;
    Delicious = mkA "herkullinen" ;
    Expensive = mkA "kallis" ;
    Fresh = mkA "tuore" ;
    Good = L.good_A ;
    Suspect = mkA "epäilyttävä" ;
    Warm = L.warm_A ;

-- places

    Restaurant = mkPlace (mkN "ravintola") ssa ;
    Bank = mkPlace (mkN "pankki") ssa ;
    PostOffice = mkPlace (mkN "posti") ssa ;
    Bar = mkPlace (mkN "baari") ssa ;
    Toilet = mkPlace (mkN "vessa") ssa ;
    Museum = mkPlace (mkN "museo") ssa ;
    Airport = mkPlace (mkN "lento" (mkN "kenttä")) lla ;
    Station = mkPlace (mkN "asema") lla ;
    Hospital = mkPlace (mkN "sairaala") ssa ;
    Church = mkPlace (mkN "kirkko") ssa ;
    Cinema = mkPlace (mkN "elokuva" (mkN "teatteri")) ssa ;
    Theatre = mkPlace (mkN "teatteri") ssa ;
    Shop = mkPlace (mkN "kauppa") ssa ;
    Park = mkPlace (mkN "puisto") ssa ;
    Hotel = mkPlace (mkN "hotelli") ssa ;
    University = mkPlace (mkN "yliopisto") lla ;
    School = mkPlace (mkN "koulu") lla ;

    CitRestaurant cit = {
      name = mkCN cit (mkN "ravintola") ; at = casePrep inessive ; to = casePrep illative; isPl = False
      } ;
    Parking = mkPlace (mkN "pysäköinti" (mkN "alue")) lla ;
    Supermarket = mkPlace (mkN "supermarket") ssa ;
    Pharmacy = mkPlace (mkN "apteekki") ssa ;
    Center = mkPlace (mkN "keskusta") ssa ;
    Cafeteria = mkPlace (mkN "kahvila") ssa ;
    Disco = mkPlace (mkN "disko") ssa ;
    Pub = mkPlace (mkN "pub") ssa ;
    AmusementPark = mkPlace (mkN "huvi" (mkN "puisto")) ssa ;   
    Zoo = mkPlace (mkN "eläin" (mkN "tarha")) ssa ;   

-- currencies

    DanishCrown = mkCN (mkN "Tanskan kruunu") | mkCN (mkN "kruunu") ;
    Dollar = mkCN (mkN "dollari") ;
    Euro = mkCN (mkN "euro") ;
    Lei = mkCN (mkN "lei") ;
    Leva = mkCN (mkN "leva") ;
    NorwegianCrown = mkCN (mkN "Norjan kruunu") | mkCN (mkN "kruunu") ;
    Pound = mkCN (mkN "punta") ;
    Rouble = mkCN (mkN "rupla") ;
    SwedishCrown = mkCN (mkN "Ruotsin kruunu") | mkCN (mkN "kruunu") ;
    Zloty = mkCN (mkN "zloty" "zlotyja") ;

-- nationalities

    Belgian = mkA "belgialainen" ;
    Belgium = mkNP (mkPN "Belgia") ;
    Bulgarian = mkNat (mkPN "bulgaria") (mkPN "Bulgaria") (mkA "bulgarialainen") ;
    Catalan = mkNat (mkPN "katalaani") (mkPN "Katalonia") (mkA "katalonialainen") ;
    Danish = mkNat (mkPN "tanska") (mkPN "Tanska") (mkA "tanskalainen") ;
    Dutch = mkNat (mkPN "hollanti") (mkPN "Hollanti") (mkA "hollantilainen") ;
    English = mkNat (mkPN "englanti") (mkPN "Englanti") (mkA "englantilainen") ;
    Finnish = 
      mkNat (mkPN (mkN "suomi" "suomia")) (mkPN (mkN "Suomi" "Suomia")) 
            (mkA "suomalainen") ;
    Flemish = mkNP (mkPN "flaami") ;
    French = mkNat (mkPN "ranska") (mkPN "Ranska") (mkA "ranskalainen") ; 
    German = mkNat (mkPN "saksa") (mkPN "Saksa") (mkA "saksalainen") ;
    Italian = mkNat (mkPN "italia") (mkPN "Italia") (mkA "italialainen") ;
    Norwegian = mkNat (mkPN "norja") (mkPN "Norja") (mkA "norjalainen") ;
    Polish = mkNat (mkPN "puola") (mkPN "Puola") (mkA "puolalainen") ;
    Romanian = mkNat (mkPN "romania") (mkPN "Romania") (mkA "romanialainen") ;
    Russian = mkNat (mkPN "venäjä") (mkPN "Venäjä") (mkA "venäläinen") ;
    Spanish = mkNat (mkPN "espanja") (mkPN "Espanja") (mkA "espanjalainen") ;
    Swedish = mkNat (mkPN "ruotsi") (mkPN "Ruotsi") (mkA "ruotsalainen") ;

    ---- it would be nice to have a capitalization Predef function

-- means of transportation 

    Bike = mkTransport L.bike_N ; 
    Bus = mkTransport (mkN "bussi") ;
    Car = mkTransport L.car_N ;
    Ferry = mkTransport (mkN "lautta") ;
    Plane = mkTransport L.airplane_N ;
    Subway = mkTransport (mkN "metro") ;
    Taxi = mkTransport (mkN "taksi") ;
    Train = mkTransport L.train_N ;
    Tram = mkTransport (mkN "raitiovaunu") ;

    ByFoot = ParadigmsFin.mkAdv "jalkaisin" ;


-- actions

    AHasAge p num = mkCl p.name (mkNP num L.year_N) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasName p name = mkCl (nameOf p) name ;
    AHasRoom p = haveForPerson p.name (mkCN (mkN "huone")) ;
    AHasTable p = haveForPerson p.name (mkCN (mkN "pöytä")) ;
    AHungry p = E.AdvExistNP (SyntaxFin.mkAdv on_Prep p.name) (mkNP (mkN "nälkä")) ;
    AIll p = mkCl p.name (mkA "sairas") ;
    AKnow p = mkCl p.name (mkV "tietää") ;
    ALike p item = mkCl p.name L.like_V2 item ;
    ALive p co = mkCl p.name (mkVP (mkVP (mkV "asua")) (SyntaxFin.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (mkV2 (mkV "rakastaa") partitive) q.name ;
    AMarried p = mkCl p.name (ParadigmsFin.mkAdv "naimisissa") ;
    AReady p = mkCl p.name (ParadigmsFin.mkA "valmis") ;
    AScared p = mkCl p.name (caseV partitive (mkV "pelottaa")) ;
    ASpeak p lang = mkCl p.name  (mkV2 (mkV "puhua") partitive) lang ;
    AThirsty p = E.AdvExistNP (SyntaxFin.mkAdv on_Prep p.name) (mkNP (mkN "jano")) ;
    ATired p = mkCl p.name (caseV partitive (mkV "väsyttää")) ;
    AUnderstand p = mkCl p.name (mkV "ymmärtää") ;
    AWant p obj = mkCl p.name (mkV2 "haluta") obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;
    QWhatAge p = mkQS (mkQCl (E.ICompAP (mkAP L.old_A)) p.name) ;
    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "maksaa"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "maksaa")) price ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_Adv) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_Adv) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_Adv) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_Adv) d.habitual) ; 


-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (ss ("nähdään"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p = mkText (lin Text (ss ("nähdään"))) (mkPhrase (mkUtt p.at)) ;
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("nähdään"))) 
        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf sing (mkN "vaimo") ;
    Husband = xOf sing L.man_N ;
    Son = xOf sing L.boy_N ;
    Daughter = xOf sing (mkN "tytär") ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = let d = "maanantai" in mkDay (mkPN d) (d + "sin") ;
    Tuesday = let d = "tiistai" in mkDay (mkPN d) (d + "sin") ;
    Wednesday = let d = "keskiviikko" in mkDay (mkPN d) (d + "isin") ;
    Thursday = let d = "torstai" in mkDay (mkPN d) (d + "sin") ;
    Friday = let d = "perjantai" in mkDay (mkPN d) (d + "sin") ;
    Saturday = let d = "lauantai" in mkDay (mkPN d) (d + "sin") ;
    Sunday = let d = "sunnuntai" in mkDay (mkPN d) (d + "sin") ;

    Tomorrow = ParadigmsFin.mkAdv "huomenna" ;

-- transports

    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
    HowFarFrom x y = 
      mkQS (mkQCl far_IAdv (mkCl y.name (SyntaxFin.mkAdv from_Prep x.name))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl far_IAdv (mkCl y.name 
        (mkVP (mkVP (SyntaxFin.mkAdv from_Prep x.name)) t))) ;
    HowFarBy place t = 
      mkQS (mkQCl far_IAdv (mkCl place.name t)) ;
      -- mkQS (mkQCl (mkIAdv far_IAdv t) y.name) ; 

    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkVP (mkVP (mkVP (mkV "päästä")) trans.by) place.to))) ;
      -- pääseekö keskustaan bussilla
      -- mkQS (mkQCl (E.AdvPredNP place.to L.go_V (E.PartCN (trans.name)))) ; 
      -- meneekö keskustaan bussia

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl (mkA (mkN "läheinen") "lähempi" "lähin") ;
    TheCheapest = mkSuperl (mkA (mkN "halpa") "halvempi" "halvin") ;
    TheMostExpensive = mkSuperl (mkA (mkN "kallis") "kalliimpi" "kallein") ;
    TheMostPopular = mkSuperl (mkA "suosittu") ;
    TheWorst = mkSuperl (mkA "huono") ;

    SuperlPlace sup p = placeNP sup p ;

  oper
    mkNat : PN -> PN -> A -> 
      {lang : NP ; prop : A ; country : NP} = \nat,co,pro ->
        {lang = mkNP nat ; 
         prop = pro ;
         country = mkNP co
        } ;

    ---- using overloaded paradigms slows down compilation dramatically
    mkDay : PN -> Str -> {name : NP ; point : Adv ; habitual : Adv} = \d,s ->
      let day = mkNP d in
      {name = day ; 
       point = SyntaxFin.mkAdv (casePrep essive) day ; 
       habitual = ParadigmsFin.mkAdv s
      } ;

    mkPlace : N -> Bool -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,e -> {
      name = mkCN p ;
      at = casePrep (if_then_else Case e adessive inessive) ;  -- True: external
      to = casePrep (if_then_else Case e allative illative) ;
      isPl = False   
   } ;
    ssa = False ;
    lla = True ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (E.GenNP b) a c) p ;

    nameOf : NPPerson -> NP = \p -> (xOf sing L.name_N p).name ;

  oper 
    -- do you have a table for five persons
    haveForPerson : NP -> CN -> Card -> Cl = \p,a,n ->
      mkCl p have_V2 
----      (mkNP (E.PartCN a)  ---- partitive works in questions )
        (mkNP (mkNP a_Det a)
           (SyntaxFin.mkAdv for_Prep (mkNP n (mkN "henki" "henkiä")))) ;

    open_Adv = ParadigmsFin.mkAdv "avoinna" ;
    closed_Adv = ParadigmsFin.mkAdv "kiinni" ;

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxFin.mkAdv (casePrep adessive) (mkNP n)
      } ;

    mkSuperl : A -> Det = \a -> mkDet the_Quant (mkOrd a) ;

    far_IAdv = E.IAdvAdv L.far_Adv ;
}
