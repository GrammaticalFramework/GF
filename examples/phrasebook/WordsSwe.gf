-- (c) 2010 Aarne Ranta under LGPL

concrete WordsSwe of Words = SentencesSwe ** 
    open SyntaxSwe, ParadigmsSwe, IrregSwe, (L = LexiconSwe), ExtraSwe, Prelude in {

  lin

-- kinds of food

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "ost") ;
    Chicken = mkCN (mkN "kyckling") ;
    Coffee = mkCN (mkN "kaffe" neutrum) ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "kött" "kött") ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pizza") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "te" neutrum) ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- properties

    Bad = L.bad_A ;
    Cheap = mkA "billig" ;
    Boring = mkA "tråkig" ;
    Cold = L.cold_A ;
    Delicious = mkA "läcker" ;
    Expensive = mkA "dyr" ;
    Fresh = mkA "färsk" ;
    Good = L.good_A ;
    Suspect = mkA "suspekt" "suspekt" ;
    Warm = L.warm_A ;

-- places

    Airport = mkPlace (mkN "flygplats" "flygplatser") "på" ;
    AmusementPark = mkPlace (mkN "nöjespark" "nöjesparken") "i" ;
    Bank = mkPlace (mkN "bank" "banker") "i" ;
    Bar = mkPlace (mkN "bar" "barer") "i" ;
    Cafeteria = mkPlace (mkN "café" "café") "på" ;
    Center = mkPlace (mkN "innerstad" "innerstäder") "på" ; ----
    Church = mkPlace (mkN "kyrka") "i" ;
    Cinema = mkPlace (mkN "bio" "bio" "bion" "biona") "på" ; ---- ?
    Disco = mkPlace (mkN "diskotek" "diskotek") "på" ;
    Hospital = mkPlace (mkN "sjukhus" "sjukhus") "på" ;
    Hotel = mkPlace (mkN "hotell" "hotell") "på" ;
    Museum = mkPlace (mkN "museum" "museet" "museer" "museerna") "på" ;
    Park = mkPlace (mkN "park" "parker") "i" ;
    Parking = mkPlace (mkN "parkering") "på" ;
    Pharmacy = mkPlace (mkN "apotek" "apotek") "i" ;
    PostOffice = mkPlace (mkN "post" "poster") "på" ;
    Pub = mkPlace (mkN "pub" "pubben") "på" ;
    Restaurant = mkPlace (mkN "restaurang" "restauranger") "på" ;
    Shop = mkPlace (mkN "affär" "affär") "i" ;
    School = mkPlace (mkN "skola") "på" ;
    Station = mkPlace (mkN "station" "stationer") "på" ;
    Supermarket = mkPlace (mkN "snabbköp" "snabbköp") "på" ;
    Theatre = mkPlace (mkN "teater" "teatrar") "på" ;
    Toilet = mkPlace (mkN "toalett" "toaletter") "på" ;
    University = mkPlace (mkN "universitet" "universitet") "på" ;
    Zoo = mkPlace (mkN "djurpark" "djurparker") "i" ;

    CitRestaurant cit =  mkCNPlace (mkCN cit (mkN "restaurang" "restauranger")) on_Prep to_Prep ;

-- currencies

    DanishCrown = mkCN (mkA "dansk") (mkN "krona") | mkCN (mkN "krona") ;
    Dollar = mkCN (mkN "dollar" "dollar") ;
    Euro = mkCN (mkN "euro" "euro") ;
    Lei = mkCN (mkN "lei" "lei") ;
    Leva = mkCN (mkN "leva" "leva") ;
    NorwegianCrown = mkCN (mkA "norsk") (mkN "krona") | mkCN (mkN "krona") ;
    Rouble = mkCN (mkN "rubel" "rubeln" "rubel" "rubeln") ; ---- ?
    SwedishCrown = mkCN (mkA "svensk") (mkN "krona") | mkCN (mkN "krona") ;
    Zloty = mkCN (mkN "zloty" "zloty") ;

-- nationalities

    Belgian = mkA "belgisk" ;
    Belgium = mkNP (mkPN "Belgien") ;
    Bulgarian = mkNat "bulgarisk" "Bulgarien" ;
    Catalan = mkNat "katalansk" "Katalonien" ;
    Danish = mkNat "dansk" "Danmark" ;
    Dutch = mkNat "nederländsk" "Nederländerna" ;
    English = mkNat "engelsk" "England" ;
    Finnish = mkNat "finsk" "Finland" ;
    Flemish = mkNP (mkPN "flamländska") ;
    French = mkNat "fransk" "Frankrike" ;
    German = mkNat "tysk" "Tyskland" ; 
    Italian = mkNat "italiensk" "Italien" ;
    Norwegian = mkNat "norsk" "Norge" ;
    Polish = mkNat "polsk" "Polen" ;
    Romanian = mkNat "rumänsk" "Rumänien" ;
    Russian = mkNat "rysk" "Ryssland" ;
    Spanish = mkNat "spansk" "Spanien" ;
    Swedish = mkNat "svensk" "Sverige" ;

-- means of transportation 

    Bike = mkTransport L.bike_N ; 
    Bus = mkTransport (mkN "bus" "bussar") ;
    Car = mkTransport L.car_N ;
    Ferry = mkTransport (mkN "färja") ;
    Plane = mkTransport L.airplane_N ;
    Subway = mkTransport (mkN "metro" "metron" "metro" "metrona") ; ----
    Taxi = mkTransport (mkN "taxi" "taxin" "taxibilar" "taxibilarna") ; ----
    Train = mkTransport (mkN "tåg" "tåg") ;
    Tram = mkTransport (mkN "spårvagn") ;

    ByFoot = ParadigmsSwe.mkAdv "till fots" ;

-- actions

    AHasAge p num = mkCl p.name (mkNP num L.year_N) ;
    AHasName p name = mkCl p.name (mkV2 (mkV "heter")) name ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "rum" "rum")) 
        (SyntaxSwe.mkAdv for_Prep (mkNP num (mkN "person" "personer")))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "bord" "bord")) 
        (SyntaxSwe.mkAdv for_Prep (mkNP num (mkN "person" "personer")))) ;
    AHungry p = mkCl p.name (mkA "hungrig") ;
    AIll p = mkCl p.name (mkA "sjuk") ;
    AKnow p = mkCl p.name (mkV "veta" "vet" "vet" "visste" "vetat" "visst") ; 
    ALike p item = mkCl p.name (mkV2 (mkV "tycker") (mkPrep "om")) item ;
    ALive p co = mkCl p.name (mkVP (mkVP (mkV "bo")) (SyntaxSwe.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (mkV2 (mkV "älska")) q.name ;
    AMarried p = mkCl p.name (mkA "gift") ;
    AReady p = mkCl p.name (mkA "färdig") ;
    AScared p = mkCl p.name (mkA "rädd") ;
    ASpeak p lang = mkCl p.name  (mkV2 (mkV "tala")) lang ;
    AThirsty p = mkCl p.name (mkA "törstig") ;
    ATired p = mkCl p.name (mkA "trött") ;
    AUnderstand p = mkCl p.name (mkV "förstå" "förstod" "förstått") ;
    AWant p obj = mkCl p.name want_VV (mkVP have_V2 obj) ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl whatSg_IP p.name (mkV2 (mkV "heter"))) ;
    QWhatAge p = mkQS (mkQCl (ICompAP (mkAP L.old_A)) p.name) ;
    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "kosta"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "kosta")) price ;

    PropOpen p = mkCl p.name open_A ;
    PropClosed p = mkCl p.name closed_A ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYou d = mkText (lin Text (ss ("vi ses"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p d = 
      mkText (lin Text (ss ("vi ses"))) 
        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf sing (mkN "fru" "fruar") ;
    Husband = xOf sing L.man_N ;
    Son = xOf sing (mkN "son" "söner") ;
    Daughter = xOf sing (mkN "dotter" "döttrar") ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "måndag" ;
    Tuesday = mkDay "tisdag" ;
    Wednesday = mkDay "onsdag" ;
    Thursday = mkDay "torsdag" ;
    Friday = mkDay "fredag" ;
    Saturday = mkDay "lördag" ;
    Sunday = mkDay "söndag" ;

    Tomorrow = ParadigmsSwe.mkAdv "imorgon" ;

-- transports

    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
    HowFarFrom x y = mkQS (mkQCl (mkIAdv far_IAdv (SyntaxSwe.mkAdv from_Prep x.name)) y.name) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl (mkIAdv (mkIAdv far_IAdv (SyntaxSwe.mkAdv from_Prep x.name)) t) y.name) ;
    HowFarBy y t = mkQS (mkQCl (mkIAdv far_IAdv t.by) y.name) ; 

oper far_IAdv = ExtraSwe.IAdvAdv L.far_Adv ;
lin
    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (mkA "billig") ;
    TheMostExpensive = mkSuperl (mkA "dyr") ;
    TheMostPopular = mkSuperl (mkA "populär") ;
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;

  oper
    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN (nat + "a"))) (mkNP (mkPN co)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in 
      mkNPDay day (SyntaxSwe.mkAdv on_Prep day) 
        (SyntaxSwe.mkAdv on_Prep (mkNP a_Quant plNum (mkCN (mkN d)))) ;

    mkPlace : N -> Str -> {name : CN ; at : Prep ; to : Prep} = \p,i -> 
      mkCNPlace (mkCN p) (mkPrep i) to_Prep ;

    open_A = mkA "öppen" "öppet" ;
    closed_A = mkA "stängd" "stängt" ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (GenNP b) a c) p ;

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxSwe.mkAdv with_Prep (mkNP n)
      } ;

    mkSuperl : A -> Det = \a -> mkDet the_Art (mkOrd a) ;
}
