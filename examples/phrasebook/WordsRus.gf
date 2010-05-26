-- (c) 2009 Aarne Ranta under LGPL

concrete WordsRus of Words = SentencesRus ** 
    open SyntaxRus, (P = ParadigmsRus), (L = LexiconRus), Prelude in {

flags coding = utf8 ;

  lin

-- kinds of food

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN L.cheese_N ;
    Chicken = mkCN (P.mkN "курица") ;
    Coffee = mkCN (P.mkN "кофе") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (P.mkN "мясо") ;
    Milk = mkCN L.milk_N ; 
    Pizza = mkCN (P.mkN "пицца") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (P.mkN "чай") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- properties


    Bad = P.mkA "плохой" ;
    Cheap = P.mkA "дешевый" ;
    Boring = P.mkA "скучный" ;
    Cold = L.cold_A ;
    Delicious = P.mkA "вкусный" ;
    Expensive = P.mkA "дорогой" ;
    Fresh = P.mkA "свежий" ;
    Good = L.good_A ;
    Suspect = P.mkA "подозреваемый" ;
    Warm = L.warm_A ;



-- places
 
    Airport = mkPlace (P.mkN "аэропорт") in_Prep ; 
--    AmusementPark = ? парк развлечений
    Bank = mkPlace (P.mkN "банк") in_Prep ;
    Bar = mkPlace (P.mkN "бар") in_Prep ;  
    Cafeteria = mkPlace (P.mkN "кафетерий") in_Prep ;
    Center = mkPlace (P.mkN "центр") in_Prep ;
    Church = mkPlace (P.mkN "церковь") in_Prep ; 
    Cinema = mkPlace (P.mkN "кино") in_Prep ;  
    Disco = mkPlace (P.mkN "дискотека") on_Prep ;
    Hospital = mkPlace (P.mkN "больница") in_Prep ; 
    Hotel = mkPlace (P.mkN "отель") in_Prep ; 
    Museum = mkPlace (P.mkN "музей") in_Prep ; 
    Park = mkPlace (P.mkN "парк") in_Prep ; 
    Parking = mkPlace (P.mkN "автостоянки") on_Prep ; 
    Pharmacy = mkPlace (P.mkN "аптека") in_Prep ;
    PostOffice = mkPlace (P.mkN "почтовое") in_Prep ;
    Pub = mkPlace (P.mkN "паб") in_Prep ;
    Restaurant = mkPlace (P.mkN "ресторан") in_Prep ; 
    Shop = mkPlace (P.mkN "магазин") in_Prep ;  
    School = mkPlace (P.mkN "школа") in_Prep ; 
    Station = mkPlace (P.mkN "станция") on_Prep ; 
    Supermarket = mkPlace (P.mkN "супермаркет") in_Prep ;
    Theatre = mkPlace (P.mkN "театр") in_Prep ;
    Toilet = mkPlace (P.mkN "туалет") in_Prep ; 
    University = mkPlace (P.mkN "университет") in_Prep ; 
    Zoo = mkPlace (P.mkN "зоопарк") in_Prep ;

 
    CitRestaurant cit = 
      mkCNPlace (mkCN cit (P.mkN "ресторан")) in_Prep to_Prep ;    


-- currencies

    DanishCrown = mkCN (P.mkA "датско") (P.mkN "венец") ;
    Dollar = mkCN (P.mkN "доллар") ;
    Euro = mkCN (P.mkN "евро") ;
    Lei = mkCN (P.mkN "лей") ;
    Leva = mkCN (P.mkN "левов") ;
    NorwegianCrown = mkCN (P.mkA "норвежец") (P.mkN "венец") ;  
    Pound = mkCN (P.mkN "фунт");
    Rouble = mkCN (P.mkN "рубль") ;
    SwedishCrown = mkCN (P.mkA "шведский") (P.mkN "венец") ;
    Zloty = mkCN (P.mkN "злотый") ;


-- Nationalities

    Belgian = P.mkA "Belgisch" ;
    Belgium = mkNP (P.mkPN "België") ;
    Bulgarian = mkNat "болгарском" "Болгарии" ;
    Catalan = mkNat "каталонский" "Каталонии" ;
    Danish = mkNat "датском" "Дании" ;
    Dutch = mkNat "голландский" "Нидерландов" ;
    English = mkNat "английский" "Англии" ;
    Finnish = mkNat "финском" "Финляндии" ;
    Flemish = mkNP (P.mkPN "Vlaams") ;
    French = mkNat "французском" "Франции" ; 
    German = mkNat "немецкого" "Германии" ;
    Italian = mkNat "итальянский" "Италии" ;
    Norwegian = mkNat "норвежец" "Норвегии" ;
    Polish = mkNat "польский" "Польши" ;
    Romanian = mkNat "румынском" "Румынии" ;
    Russian = mkNat "русский." "России" ;
    Spanish = mkNat "испанском" "Испании" ;
    Swedish = mkNat "шведский" "Швеции" ;


-- Means of transportation


    Bike = mkTransport L.bike_N ;
    Bus = mkTransport (P.mkN "автобус") ; 
    Car = mkTransport (P.mkN "автомобиль");
    Ferry = mkTransport (P.mkN "паром") ;
    Plane = mkTransport (P.mkN "самолет") ;
    Subway = mkTransport (P.mkN "метро") ;
    Taxi = mkTransport (P.mkN "такси") ;
    Tram = mkTransport (P.mkN "трамвай") ;
    Train = mkTransport (P.mkN "поезд") ;

    ByFoot = P.mkAdv "пешком" ;



-- actions
    AHasAge p num = mkCl p.name (mkNP num L.year_N) ; 
--    AHasName p name = ? 
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ; 
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (P.mkN "номер")) 
        (SyntaxRus.mkAdv for_Prep (mkNP num (P.mkN "человек")))) ; 
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (P.mkN "стол")) 
        (SyntaxRus.mkAdv for_Prep (mkNP num (P.mkN "человек")))) ;
    AHungry p = mkCl p.name (P.mkAdv "голоден") ;    
    AIll p = mkCl p.name (P.mkA "олен") ; 
    AKnow p = mkCl p.name (P.regV P.imperfective P.first "зна" "ю" "знал" "знай" "знать" ) ; 
    ALike p item = mkCl p.name (P.dirV2 (P.regV P.imperfective P.second "нрав" "лю" "нравил" "нравь" "нравить" )) item ; 
    ALive p co = mkCl p.name (mkVP (mkVP (P.regV P.imperfective P.firstE "жив" "у" "жил" "живи" "жить")) (SyntaxRus.mkAdv in_Prep co)) ; 
    ALove p q = mkCl p.name (P.dirV2 (P.regV P.imperfective P.second "люб" "лю" "любил" "люби" "любить" )) q.name ; 
    AMarried p = mkCl p.name (P.mkA "женат") ; 
    AReady p = mkCl p.name (P.mkA "готов") ; 
    AScared p = mkCl p.name (P.mkA "боюсь") ;
    ASpeak p lang = mkCl p.name (P.mkV2 (P.regV P.imperfective P.secondA "говор" "ю" "говорил" "говори" "говорить")
               "на" P.prepositional) lang ; 
    AThirsty p = mkCl p.name (P.mkA "жажду") ; 
    ATired p = mkCl p.name (P.mkA "устал") ; 
    AUnderstand p = mkCl p.name (P.regV P.imperfective P.first "понима" "ю" "понимал" "понимай" "понимать"); ; 
    AWant p obj = mkCl p.name want_VV (mkVP have_V2 obj) ; 
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ; 

-- miscellaneous

--    QWhatName p = ? 
--    QWhatAge p =  ?
--    HowMuchCost item = ?
--    ItCost item price = ? 

    PropOpen p = mkCl p.name open_A ; 
    PropClosed p = mkCl p.name closed_A ; 
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (ss ("увидимся"))) (mkPhrase (mkUtt d)) ; 
    PSeeYouPlace p = 
      mkText (lin Text (ss ("Вы видите"))) (mkPhrase (mkUtt p.at)) ; 
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("увидимся"))) 
        (mkText (mkPhrase (mkUtt d)) (mkPhrase (mkUtt p.at))) ; 

-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf sing (P.mkN "жена") ; 
    Husband = xOf sing (P.mkN "муж") ;
    Son = xOf sing (P.mkN "сын") ;
    Daughter = xOf sing (P.mkN "дочь") ;
    Children = xOf plur L.child_N ; 


 
-- week days

    Monday = mkDay "понедельник" ;
    Tuesday = mkDay "вторник" ;
    Wednesday = mkDay "среда" ;
    Thursday = mkDay "четверг" ;
    Friday = mkDay "пятница" ;
    Saturday = mkDay "суббота" ;
    Sunday = mkDay "воскресенье" ;

  Tomorrow = P.mkAdv "завтра" ;

-- modifiers of places 
    TheBest = mkSuperl L.good_A ;
    --TheClosest = mkSuperl ? ; 
    TheCheapest = mkSuperl (P.mkA "дешевый") ;
    TheMostExpensive = mkSuperl (P.mkA "duur") ;
    TheMostPopular = mkSuperl (P.mkA "популярный") ;
    TheWorst = mkSuperl (P.mkA "плохой") ;

    SuperlPlace sup p = placeNP sup p ;

-- transports

    HowFar place = mkQS (mkQCl far_IAdv place.name) ; 
    HowFarFrom x y = mkQS (mkQCl far_IAdv (mkNP y.name (SyntaxRus.mkAdv from_Prep x.name))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl far_IAdv (mkNP (mkNP y.name (SyntaxRus.mkAdv from_Prep x.name)) t)) ;
    HowFarBy y t = mkQS (mkQCl far_IAdv (mkNP y.name t)) ; 
 
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

    mkPlace : N -> Str -> {name : CN ; at : Prep ; to : Prep} = \p,i -> 
      mkCNPlace (mkCN p) (P.mkPrep i) to_Prep ;

--    open_A = P.mkA ? ;  seem to use a verb
--    closed_A = P.mkA ? ;

   xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (mkNP the_Quant a c) (SyntaxRus.mkAdv possess_Prep b)) p ;

     mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxRus.mkAdv with_Prep (mkNP the_Det n)
      } ;

  far_IAdv = ss "как далеко" ** {lock_IAdv = <>} ;
  long_IAdv = ss "Как долго" ** {lock_IAdv = <>};

  mkSuperl : A -> Det = \a -> SyntaxRus.mkDet the_Art (SyntaxRus.mkOrd a) ;




}
