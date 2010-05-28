-- (c) 2009 Aarne Ranta under LGPL


concrete WordsDut of Words = SentencesDut ** 
    open SyntaxDut, (P = ParadigmsDut), (I = IrregDut), (L = LexiconDut), ExtraDut, Prelude in {

  lin

-- kinds of food

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN L.cheese_N ;
    Chicken = mkCN (P.mkN "kip" "kippen" P.de) ;
    Coffee = mkCN (P.mkN "koffie" "koffie" P.de) ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (P.mkN "vlees" "vleesen" P.het) ;
    Milk = mkCN L.milk_N ; 
    Pizza = mkCN (P.mkN "pizza" "pizza's" P.de) ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (P.mkN "thee" "thee" P.de) ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- properties


    Bad = P.mkA "slecht" ;
    Cheap = P.mkA "goedkoop" ;
    Boring = P.mkA "saai" ;
    Cold = L.cold_A ;
    Delicious = P.mkA "lekker" ;
    Expensive = P.mkA "duur" ;
    Fresh = P.mkA "vers" ;
    Good = L.good_A ;
    Suspect = P.mkA "verdacht" ;
    Warm = L.warm_A ;



-- places
 
    Airport = mkPlace (P.mkN "luchthaven" "luchthavens" P.de) "op" ; 
    AmusementPark = mkPlace (P.mkN "pretpark" "pretparken" P.het) "in" ;
    Bank = mkPlace (P.mkN "bank" "banken" P.de) "op" ;
    Bar = mkPlace (P.mkN "bar" P.de) "in" ;  
    Cafeteria = mkPlace (P.mkN "cafetaria" "cafetaria's" P.de) "in" ;
    Center = mkPlace (P.mkN "centrum" "centra" P.het) "in" ;
    Church = mkPlace (P.mkN "kerk" "kerken" P.de) "in" ; 
    Cinema = mkPlace (P.mkN "bioscoop" "bioscopen" P.de) "in" ;  
    Disco = mkPlace (P.mkN "disco" "disco's" P.de) "in" ;
    Hospital = mkPlace (P.mkN "ziekenhuis" "ziekenhuizen" P.het) "in" ; 
    Hotel = mkPlace (P.mkN "hotel" "hotels" P.het) "in" ; 
    Museum = mkPlace (P.mkN "museum" "musea" P.het) "in" ; 
    Park = mkPlace (P.mkN "park" "parken" P.het) "in" ; 
    Parking = mkPlace (P.mkN "parkeerplaats" "parkeerplaatsen" P.de) "op" ; --parkeren x parkeerplaats -- naar op 
    Pharmacy = mkPlace (P.mkN "apotheek" "apotheken" P.de)  "in" ;
    PostOffice = mkPlace (P.mkN "postkantoor" "postkantoren" P.het) "op" ;
    Pub = mkPlace (P.mkN "kroeg" "kroegen" P.de) "in" ;
    Restaurant = mkPlace (P.mkN "restaurant" "restaurants" P.het) "in" ; 
    Shop = mkPlace (P.mkN "winkel" "winkels" P.de) "in" ; -- shop x winkel 
    School = mkPlace (P.mkN "school" "scholen" P.de) "in" ; 
    Station = mkPlace (P.mkN "station" "stations" P.het) "op" ; 
    Supermarket = mkPlace (P.mkN "supermarkt" "supermarkten" P.de) "in" ;
    Theatre = mkPlace (P.mkN "theater" "theaters" P.het) "in" ;
    Toilet = mkPlace (P.mkN "toilet" "toiletten" P.het) "op" ; 
    University = mkPlace (P.mkN "universiteit" "universiteiten" P.de) "in" ; --universitair x universiteit -- naar in
    Zoo = mkPlace (P.mkN "dierentuin" "dierentuinen" P.de) "op" ;

 
    CitRestaurant cit = 
      mkCNPlace (mkCN cit (P.mkN "restaurant" "restaurants" P.het)) in_Prep to_Prep ;    


-- currencies

    DanishCrown = mkCN (P.mkA "Deens") (P.mkN "kroon" "kronen" P.de) ;
    Dollar = mkCN (P.mkN "dollar" "dollars" P.de) ;
    Euro = mkCN (P.mkN "euro" "euro's" P.de) ;
    Lei = mkCN (P.mkA "Roemeens") (P.mkN "leu" "lei" P.de) ;
    Leva = mkCN (P.mkA "Bulgaars") (P.mkN "leva" "levs" P.de) ;
    NorwegianCrown = mkCN (P.mkA "Noors") (P.mkN "kroon" "kronen "P.de) ;  
    Pound = mkCN (P.mkA "Brits") (P.mkN "pond" "pond" P.het);
    Rouble = mkCN (P.mkA "Russisch") (P.mkN "roebel" "roebel" P.de) ;
    SwedishCrown = mkCN (P.mkA "Zweeds") (P.mkN "kroon" "kronen" P.de) ;
    Zloty = mkCN (P.mkA "Pools") (P.mkN "zloty" "zloty" P.de) ;


-- Nationalities

    Belgian = P.mkA "Belgisch" ;
    Belgium = mkNP (P.mkPN "België") ;
    Bulgarian = mkNat "Bulgaars" "Bulgarije" ;
    Catalan = mkNat "Catalaans" "Catalonië" ;
    Danish = mkNat "Deens" "Denemarken" ;
    Dutch = mkNat "Nederlands" "Nederland" ;
    English = mkNat "Engels" "Engeland" ;
    Finnish = mkNat "Fins" "Finland" ;
    Flemish = mkNP (P.mkPN "Vlaams") ;
    French = mkNat "Frans" "Frankrijk" ; 
    German = mkNat "Duits" "Duitsland" ;
    Italian = mkNat "Italiaans" "Italië" ;
    Norwegian = mkNat "Noors" "Noorwegen" ;
    Polish = mkNat "Pools" "Polen" ;
    Romanian = mkNat "Roemeens" "Roemenië" ;
    Russian = mkNat "Russisch" "Rusland" ;
    Spanish = mkNat "Spaans" "Spanje" ;
    Swedish = mkNat "Zweeds" "Zweden" ;


-- Means of transportation


    Bike = mkTransport L.bike_N ;
    Bus = mkTransport (P.mkN "bus" "bussen" P.de) ; 
    Car = mkTransport (P.mkN "auto" "auto's" P.de);
    Ferry = mkTransport (P.mkN "veerboot" "veerboten" P.de) ; -- ferry x veerboot
    Plane = mkTransport (P.mkN "vliegtuig" "vliegtuigen" P.het) ;
    Subway = mkTransport (P.mkN "metro" "metro" P.de) ;
    Taxi = mkTransport (P.mkN "taxi" "taxi's" P.de) ;
    Tram = mkTransport (P.mkN "tram" "trams" P.de) ;
    Train = mkTransport (P.mkN "trein" "treinen" P.de) ;

    ByFoot = P.mkAdv "te voet" ;
{-
 ik ga met de/het ....
ik ga te voet/ ik ga lopend

-}



-- actions
    AHasAge p num = mkCl p.name (mkNP num L.year_N) ; -- ik ben ... jaar
    AHasName p name = mkCl p.name (P.mkV2 I.heten_V) name ;  -- ik heet ...
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ; -- ik heb ... kinderen
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (P.mkN "kamer")) 
        (SyntaxDut.mkAdv for_Prep (mkNP num (P.mkN "persoon")))) ; -- ik heb een ... persoons kamer/ ik heb een kamer voor ... personen
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (P.mkN "tafel")) 
        (SyntaxDut.mkAdv for_Prep (mkNP num (P.mkN "persoon")))) ;
    AHungry p = mkCl p.name have_V2 (mkNP (P.mkN "honger")) ; -- to have   
    AIll p = mkCl p.name (P.mkA "ziek") ; -- to be ?
    AKnow p = mkCl p.name I.weten_V ; -- ik weet het.
    ALike p item = mkCl p.name (P.mkV2 I.houden_V P.van_Prep) item ; -- lekker
    ALive p co = mkCl p.name (mkVP (mkVP (P.mkV "wonen")) (SyntaxDut.mkAdv in_Prep co)) ; -- woon
    ALove p q = mkCl p.name (P.mkV2 (P.mkV "lief" P.hebben_V)) q.name ; -- houden van
    AMarried p = mkCl p.name (P.mkA "getrouwd") ; -- ik ben getrouwd
    AReady p = mkCl p.name (P.mkA "klaar") ; -- ik ben klaar
    AScared p = mkCl p.name (P.mkA "bang") ; -- ik ben bang
    ASpeak p lang = mkCl p.name (P.mkV2 I.spreken_V) lang ; -- ik spreek .../ ik versta ...
    AThirsty p = mkCl p.name have_V2 (mkNP (P.mkN "dorst")) ; -- ik heb dorst
    ATired p = mkCl p.name (P.mkA "moe") ; -- ik ben moe
    AUnderstand p = mkCl p.name (P.mkV "verstaan" "verstond" "verstonden" "verstaan") ; 
    AWant p obj = mkCl p.name want_VV (mkVP have_V2 obj) ; -- ik wil
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ; -- ik wil naar ...

-- miscellaneous

    QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name  I.heten_V)) ; --hoe heet je
    QWhatAge p =  mkQS (mkQCl (ICompAP (mkAP L.old_A)) p.name) ;
    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (P.mkV "kosten"))) ; --hoeveel kost...
    ItCost item price = mkCl item (P.mkV2 (P.mkV "kosta")) price ; --..item.. kost ..price..

    PropOpen p = mkCl p.name open_A ; 
    PropClosed p = mkCl p.name closed_A ; 
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; --de winkel is geopend op vrijdag(s)
           --normaal gesproken ga ik op vrijdag ..action../vrijdags ga ik ..action..
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; -- gesloten
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (ss ("ik zie je"))) (mkPhrase (mkUtt d)) ; -- zie je / tot 
    PSeeYouPlace p = 
      mkText (lin Text (ss ("ik zie je"))) (mkPhrase (mkUtt p.at)) ; -- tot ziens in p (AR) 
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("ik zie je"))) 
        (mkText (mkPhrase (mkUtt d)) (mkPhrase (mkUtt p.at))) ; --tot ... op/in/bij

-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf sing (P.mkN "vrouw" "vrowen" P.de) ; -- x vrouw
    Husband = xOf sing L.man_N ;
    Son = xOf sing (P.mkN "zoon" "zonen" P.de) ;
    Daughter = xOf sing (P.mkN "dochter" "dochters" P.de) ;
    Children = xOf plur L.child_N ; -- kind


 
-- week days

    Monday = mkDay "maandag" ;
    Tuesday = mkDay "dinsdag" ;
    Wednesday = mkDay "woensdag" ;
    Thursday = mkDay "donderdag" ;
    Friday = mkDay "vrijdag" ;
    Saturday = mkDay "zaterdag" ;
    Sunday = mkDay "zondag" ;

  Tomorrow = P.mkAdv "morgen" ;

-- modifiers of places 
    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl (P.mkA 
      "dichtbijzijnd" "dichtbijzijnde" "dichtbijzijndes" 
      "dichterbijzijnd" "dichtestbijzijnd") ; 
    TheCheapest = mkSuperl (P.mkA "goedkoop") ;
    TheMostExpensive = mkSuperl (P.mkA "duur") ;
    TheMostPopular = mkSuperl (P.mkA "populair") ;
    TheWorst = mkSuperl (P.mkA "slecht") ;

    SuperlPlace sup p = placeNP sup p ;

-- transports

    HowFar place = mkQS (mkQCl far_IAdv place.name) ; -- hoe ver is de dierentuin
    HowFarFrom x y = mkQS (mkQCl far_IAdv (mkNP y.name (SyntaxDut.mkAdv from_Prep x.name))) ;
-- how far is the center from the hotel ? hoever is het centrum van het hotel
    HowFarFromBy x y t = 
      mkQS (mkQCl far_IAdv (mkNP (mkNP y.name (SyntaxDut.mkAdv from_Prep x.name)) t)) ;
--hoelang duurt het om van het vliegveld naar het hotel te gaan per taxi
    HowFarBy y t = mkQS (mkQCl far_IAdv (mkNP y.name t)) ; --hoe ver is het museum per bus
 
    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;




  oper
    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (P.mkPN nat)) (mkNP (P.mkPN co)) (P.mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d -> 
      mkNPDay (mkNP (P.mkPN d)) (mkAdv (P.mkPrep []) (mkNP (P.mkPN d))) 
                                ---- (mkAdv on_Prep (mkNP (P.mkPN d))) 
        (mkAdv on_Prep (mkNP a_Quant plNum (mkCN (P.mkN d (d + "en") P.utrum)))) ;

    mkPlace : N -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i -> 
      mkCNPlace (mkCN p) (P.mkPrep i) to_Prep ;

    open_A = P.mkA "geopend" ;
    closed_A = P.mkA "gesloten" ;

   xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (mkNP the_Quant a c) (SyntaxDut.mkAdv possess_Prep b)) p ;

     mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxDut.mkAdv with_Prep (mkNP the_Det n)
      } ;

  far_IAdv = ss "hoe ver" ** {lock_IAdv = <>} ;
  long_IAdv = ss "hoe lang" ** {lock_IAdv = <>};

  mkSuperl : A -> Det = \a -> SyntaxDut.mkDet the_Art (SyntaxDut.mkOrd a) ;


{- 
    HowFarFrom : how far is the center from the hotel ? hoe ver is het centrum van het hotel
    HowFarFromBy : how far is the airport from the hotel by taxi ? hoe lang duurt het om van het vliegveld naar het hotel te gaan per taxi
    HowFarBy : how far is the museum by bus ? hoe ver is het museum per bus/ hoelang doe je er over om met de bus naar het museum te gaan/hoelang doet de bus er over tot het museum


-}


}
