-- (c) 2009 Aarne Ranta under LGPL

concrete WordsNor of Words = SentencesNor ** 
    open SyntaxNor, ParadigmsNor, IrregNor, (L = LexiconNor), ExtraNor, StructuralNor, Prelude in {

  lin

-- kinds of food

    Apple = mkCN (mkN "eple" "eplet" "epler" "eplene") ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "ost" "osten" "oster" "ostene") ;
    Chicken = mkCN (mkN "kylling" "kyllingen" "kyllinger" "kyllingene") ;
    Coffee = mkCN (mkN "kaffe" "kaffet" "kaffen" "kaffene") ; -- av kaffe ?
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "kjøtt" "kjøttet" "kjøtt" "kjøtta") ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pizza" "pizzaen" "pizzaer" "pizzaene") ; -- av pizza ?
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "te" "teen" "teer" "teene") ; -- av te ?
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- properties

    Bad = L.bad_A ;
    Cheap = mkA "billig" ;
    Boring = mkA "kjedelig" ;
    Cold = L.cold_A ;
    Delicious = mkA "deilig" ;
    Expensive = mkA "dyr" ;
    Fresh = mkA "fersk" ;
    Good = L.good_A ;
    Suspect = mkA "suspekt" "suspekt" ;
    Warm = L.warm_A ;

-- places


    Airport = mkPlace (mkN "flyplass" "flyplassen" "flyplasser" "flyplassene") "på" "til";
    AmusementPark = mkPlace (mkN "fornøyelsespark" "fornøyelsesparken" "fornøyelsesparker" "fornøyelsesparkene") "i" "til";
    Bank = mkPlace (mkN "bank" "banken" "banker" "bankene") "i" "til";
    Bar = mkPlace (mkN "bar" "baren" "barer" "barene") "i" "til"; -- ?? check forms
    Cafeteria = mkPlace (mkN "kafeteria" "kafeterian" "kafeterier" "kafeteriene") "i" "til";
    Center = mkPlace (mkN "sentrum" "sentrum" "sentre" "sentrene") "i" "til";
    Cinema = mkPlace (mkN "kino" "kino" "kinoer" "kinoene") "på" "på";
    Church = mkPlace (mkN "kirke" "kirka" "kirker" "kirkene") "i" "til"; 
    Disco = mkPlace (mkN "diskotek" "diskoteket" "diskoteker" "diskotekene") "i" "på";
    Hospital = mkPlace (mkN "sykehus" "sykehuset" "sykehus" "sykehusa") "på" "til";

    Hotel = mkPlace (mkN "hotel" "hotellet" "hoteller" "hotellene") "på" "til";
    Museum = mkPlace (mkN "museum" "museet" "museer" "museene") "i" "til";
    Park = mkPlace (mkN "park" "parken" "parker" "parkene") "i" "til";
    Parking = mkPlace (mkN "parkeringsplass" "parkeringsplassen" "parkeringsplasser" "parkeringplassene") "på" "til";
    Pharmacy = mkPlace (mkN "apotek" "apoteket" "apoteker" "apotekene") "i" "til";
    PostOffice = mkPlace (mkN "postkontor" "postkontoret" "postkontorer" "postkontorene") "på" "til";
    Pub = mkPlace (mkN "pub" "puben" "puber" "pubene") "i" "til";
    Restaurant = mkPlace (mkN "restaurant" "restauranten" "restauranter" "restaurantene") "i" "til";
    School = mkPlace (mkN "skole" "skola" "skoler" "skolene") "i" "til";
    Shop = mkPlace (mkN "butikk" "butikken" "butikker" "butikkene") "i" "til";
    Station = mkPlace (mkN "stasjon" "stasjonen" "stasjoner" "stasjonene") "i" "til";
    Supermarket = mkPlace (mkN "supermarked" "supermarkedet" "supermarkeder" "supermarkedene") "i" "til";
    Theatre = mkPlace (mkN "teater" "teatret" "teatre" "teatrene") "i" "på";
    Toilet = mkPlace (mkN "toalett" "toalettet" "toaletter" "toalettene") "på" "på";
    University = mkPlace (mkN "universitet" "universitetet" "universitet" "universiteta") "i" "til";
    Zoo = mkPlace (mkN "dyrepark" "dyreparken" "dyreparker" "dyreparkene") "på" "til";

    CitRestaurant cit = mkCNPlace (mkCN cit (mkN "restaurant" "restauranten" "restauranter" "restaurantene")) in_Prep to_Prep ;

-- currencies

    DanishCrown = mkCN (mkA "dansk") (mkN "krone" "krona" "kroner" "kronene") | mkCN (mkN "krone" "krona" "kroner" "kronene") ;
    Dollar = mkCN (mkN "dollar" "dollaren" "dollar" "dollar") ; -- i dollar ?
    Euro = mkCN (mkN "euro" "euroen" "euro" "euro") ; -- i euro 
    Lei = mkCN (mkN "leu" "leu" "leis" "leis") ; -- den leis ?
    Leva = mkCN (mkN "lev" "lev" "leva" "leva") ; -- det leva ?
    NorwegianCrown = mkCN (mkA "norsk") (mkN "krone" "krona" "kroner" "kronene") | mkCN (mkN "krone" "krona" "kroner" "kronene") ;
    Pound = mkCN (mkN "pund" "pundet" "pund" "punda") ; -- i pounds ?
    Rouble = mkCN (mkN "rubel" "rubelen" "rubler" "rublene") ; -- av rubler ?
    SwedishCrown = mkCN (mkA "svensk") (mkN "krone" "krona" "kroner" "kronene") | mkCN (mkN "krone" "krona" "kroner" "kronene") ;
    Zloty = mkCN (mkN "zloty" "zloty" "zloty" "zloty") ; -- i/den zloty ?

-- nationalities


    Belgian = mkA "belgisk" ;
    Belgium = mkNP (mkPN "Belgia") ;
    Bulgarian = mkNat "bulgarsk" "Bulgaria" ;
    Catalan = mkNat "katalansk" "Katalonia" ;
    Danish = mkNat "dansk" "Danmark" ;
    Dutch =  mkNat "nederlandsk" "Nederland" ;
    English = mkNat "engelsk" "England" ;
    Finnish = mkNat "finsk" "Finland" ;
    Flemish = mkNP (mkPN "flamsk") ;
    French = mkNat "fransk" "Frankrike" ; 
    German = mkNat "tysk" "Tyskland" ;
    Italian = mkNat "italiensk" "Italia" ;
    Norwegian = mkNat "norsk" "Norge" ;
    Polish = mkNat "polsk" "Polen" ;
    Romanian = mkNat "rumensk" "Romania" ;
    Russian = mkNat "russisk" "Russland" ;
    Spanish = mkNat "spansk" "Spania" ;
    Swedish = mkNat "svensk" "Sverige" ;



-- Means of transportation 

   Bike = mkTransport L.bike_N ;
   Bus = mkTransport (mkN "buss" "bussen" "busser" "bussene") ;
   Car = mkTransport L.car_N ;
   Ferry = mkTransport (mkN "ferge" "fergen" "ferger" "fergene") ;
   Plane = mkTransport L.airplane_N ;
   Subway = mkTransport (mkN "undergrunnsbane" "undergrunnsbanen" "undergrunnsbaner" "undergrunnsbanene") ; -- check ?
   Taxi = mkTransport (mkN "drosje" "drosja" "drosjer" "drosjene") ;
   Train = mkTransport (mkN "tog" "toget" "tog" "toga") ;
   Tram = mkTransport (mkN "trikk" "trikken" "trikker" "trikkene") ;

   ByFoot = ParadigmsNor.mkAdv "til fots" ;




-- actions

    AHasAge p num = mkCl p.name (mkNP num L.year_N) ;
    AHasName p name = mkCl p.name (mkV2 hete_V) name ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "rom" "rommet" "rommene" "romma")) 
        (SyntaxNor.mkAdv for_Prep (mkNP num (mkN "person" "personen" "personer" "personene")))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "bord" "bordet" "bord" "borda")) 
        (SyntaxNor.mkAdv for_Prep (mkNP num (mkN "person" "personen" "personer" "personene")))) ;
    AHungry p = mkCl p.name (mkA "sulten" "sultet" "sultne") ;
    AIll p = mkCl p.name (mkA "syk") ;
    AKnow p = mkCl p.name vite_V ; 
    ALike p item = mkCl p.name (dirV2 (mk2V "like" "likte")) item ;
    ALive p co = mkCl p.name  (mkVP (mkVP (mkV "bor")) (SyntaxNor.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (dirV2 (regV "elske")) q.name ;
    AMarried p = mkCl p.name (mkA "gift") ;
    AReady p = mkCl p.name (mkA "klar") ;
    AScared p = mkCl p.name (mkA "redd") ;
    ASpeak p lang = mkCl p.name  (dirV2 (regV "snakke")) lang ;
    AThirsty p = mkCl p.name (mkA "tørstig") ;
    ATired p = mkCl p.name (mkA "sliten") ;
    AUnderstand p = mkCl p.name (irregV "forstå" "forstod" "forstått") ;
    AWant p obj = mkCl p.name want_VV (mkVP have_V2 obj) ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl whatSg_IP p.name (mkV2 hete_V)) ;
    QWhatAge p = mkQS (mkQCl (ICompAP (mkAP L.old_A)) p.name) ;
    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "koste"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "koste")) price ;

    PropOpen p = mkCl p.name open_A ;
    PropClosed p = mkCl p.name closed_A ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (ss ("vi ses"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p = mkText (lin Text (ss ("vi ses"))) (mkPhrase (mkUtt p.at)) ;
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("vi ses"))) 
        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf sing (mkN "kone" "kona" "koner" "konene") ;
    Husband = xOf sing L.man_N ;
    Son = xOf sing (mkN "sønn" "sønnen" "sønner" "sønnene") ;
    Daughter = xOf sing (mkN "datter" "datteren" "døtre" "døtrene") ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "mandag" ;
    Tuesday = mkDay "tirsdag" ;
    Wednesday = mkDay "onsdag" ;
    Thursday = mkDay "torsdag" ;
    Friday = mkDay "fredag" ;
    Saturday = mkDay "lørdag" ;
    Sunday = mkDay "søndag" ;

    Tomorrow = ParadigmsNor.mkAdv "i morgen" ;


-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (mkA "billig") ;
    TheMostExpensive = mkSuperl (mkA "dyr") ;
    TheMostPopular = mkSuperl (mkA "populær") ;
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;




-- transports

    HowFar place = 
      mkQS (mkQCl far_IAdv (mkCl (mkVP place.to))) ;
    HowFarFrom x y = 
      mkQS (mkQCl far_IAdv (mkCl (mkVP (mkVP y.to) 
                    (SyntaxNor.mkAdv from_Prep x.name)))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl far_IAdv (mkCl (mkVP (mkVP (mkVP y.to) 
                    (SyntaxNor.mkAdv from_Prep x.name)) t))) ;
    HowFarBy place t = 
      mkQS (mkQCl far_IAdv (mkCl (mkVP (mkVP place.to) t))) ;

    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;


  oper
    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

   mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in 
      mkNPDay day (SyntaxNor.mkAdv on_Prep day) 
        (SyntaxNor.mkAdv on_Prep (mkNP a_Quant plNum (mkCN (mkN d)))) ;

    mkPlace : N -> Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i,t -> 
    mkCNPlace (mkCN p) (mkPrep i) (mkPrep t) ;

    open_A = mkA "åpen" "åpent";
    closed_A = mkA "stengt" "stengt";

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePersonNor n (mkCN x) (\a,b,c -> mkNP (GenNP b) a c) p ;

    mkSuperl : A -> Det = \a -> mkDet the_Art (mkOrd a) ;

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxNor.mkAdv by8means_Prep (mkNP the_Det n)
      } ;

    far_IAdv = ExtraNor.IAdvAdv (ParadigmsNor.mkAdv "langt") ;

    how8much_IAdv : IAdv = ss "hvor mye" ** {lock_IAdv = <>};

  relativePersonNor : GNumber -> CN -> (Num -> NP -> CN -> NP) -> NPPerson -> NPPerson = 
    \n,x,f,p -> 
      let num = if_then_else Num n plNum sgNum in {
      name = case p.isPron of {
        True => PossNP (mkNP the_Quant num x) p.name ;
        _    => f num p.name x
        } ;
      isPron = False ;
      poss = mkQuant he_Pron -- not used because not pron
      } ;

}
