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
    Parking = mkPlace (P.mkN "автостоянка") on_Prep ; 
    Pharmacy = mkPlace (P.mkN "аптека") in_Prep ;
    PostOffice = mkPlace (P.mkN "почта") on_Prep ;
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

    DanishCrown = mkCN (P.mkA "датский") (P.mkN "крона") ;
    Dollar = mkCN (P.mkN "доллар") ;
    Euro = mkCN (P.mkN "евро") ;
    Lei = mkCN (P.mkN "лей") ;
    Leva = mkCN (P.mkN "лев") ;
    NorwegianCrown = mkCN (P.mkA "норвежский") (P.mkN "крона") ;  
    Pound = mkCN (P.mkN "фунт");
    Rouble = mkCN (P.mkN "рубль") ;
    SwedishCrown = mkCN (P.mkA "шведский") (P.mkN "крона") ;
    Zloty = mkCN (P.mkN "злотый") ;


-- Nationalities

--    Belgian = mkNat "бельгийский" (P.mkN "Бельгия" "Бельгии" "Бельгию" "Бельгию" "Бельгией" "Бельгии" "Бельгии" "Бельгии" "Бельгий" "Бельгиям" "Бельгии" "Бельгиями" "Бельгиях" P.feminine P.animate) ;
    Bulgarian = mkNat "болгарский" (P.mkN "Болгария" "Болгарии" "Болгарию" "Болгарию" "Болгарией" "Болгарии" "Болгарии" "Болгарии" "Болгарий" "Болгариям" "Болгарии" "Болгариями" "Болгариях" P.feminine P.animate) ;
    Catalan = mkNat "каталонский" (P.mkN "Каталония" "Каталонии" "Каталонию" "Каталонию" "Каталонией" "Каталонии" "Каталонии" "Каталонии" "Каталоний" "Каталониям" "Каталонии" "Каталониями" "Каталониях" P.feminine P.animate) ;
    Danish = mkNat "датский" (P.mkN "Дания" "Дании" "Данию" "Данию" "Данией" "Дании" "Дании" "Дании" "Даний" "Даниям" "Дании" "Даниями" "Даниях" P.feminine P.animate) ;
    Dutch = mkNat "нидерландский" (P.mkN "Нидерланды" P.animate) ;
    English = mkNat "английский" (P.mkN "Англия" "Англии" "Англию" "Англию" "Англией" "Англии" "Англии" "Англии" "Англий" "Англиям" "Англии" "Англиями" "Англиях" P.feminine P.animate) ;
    Finnish = mkNat "финский" (P.mkN "Финляндия" "Финляндии" "Финляндию" "Финляндию" "Финляндией" "Финляндии" "Финляндии" "Финляндии" "Финляндий" "Финляндиям" "Финляндии" "Финляндиями" "Финляндиях" P.feminine P.animate) ;
--    Flemish = mkNat "фландрийский" (P.mkN "Фландрия" "Фландрии" "Фландрию" "Фландрию" "Фландрией" "Фландрии" "Фландрии" "Фландрии" "Фландрий" "Фландриям" "Фландрии" "Фландриями" "Фландриях" P.feminine P.animate) ;
    French = mkNat "французский" (P.mkN "Франция" "Франции" "Францию" "Францию" "Францией" "Франции" "Франции" "Франции" "Франций" "Франциям" "Франции" "Франциями" "Франциях" P.feminine P.animate) ;
    German = mkNat "немецкий" (P.mkN "Германия" "Германии" "Германию" "Германию" "Германией" "Германии" "Германии" "Германии" "Германий" "Германиям" "Германии" "Германиями" "Германиях" P.feminine P.animate) ;
    Italian = mkNat "итальянский" (P.mkN "Италия" "Италии" "Италию" "Италию" "Италией" "Италии" "Италии" "Италии" "Италий" "Италиям" "Италии" "Италиями" "Италиях" P.feminine P.animate) ;
    Norwegian = mkNat "норвежский" (P.mkN "Норвегия" "Норвегии" "Норвегию" "Норвегию" "Норвегией" "Норвегии" "Норвегии" "Норвегии" "Норвегий" "Норвегиям" "Норвегии" "Норвегиями" "Норвегиях" P.feminine P.animate) ;
    Polish = mkNat "польский" (P.mkN "Польша" "Польши" "Польшу" "Польшу" "Польшей" "Польше" "Польше" "Польши" "Польш" "Польшам" "Польши" "Польшами" "Польшах" P.feminine P.animate) ;
    Romanian = mkNat "румынский" (P.mkN "Румыния" "Румынии" "Румынию" "Румынию" "Румынией" "Румынии" "Румынии" "Румынии" "Румыний" "Румыниям" "Румынии" "Румыниями" "Румыниях" P.feminine P.animate) ;
    Russian = mkNat "русский" (P.mkN "Россия" "России" "Россию" "Россию" "Россией" "России" "России" "России" "Россий" "Россиям" "России" "Россиями" "Россиях" P.feminine P.animate) ;
    Spanish = mkNat "испанский" (P.mkN "Испания" "Испании" "Испанию" "Испанию" "Испанией" "Испании" "Испании" "Испании" "Испаний" "Испаниям" "Испании" "Испаниями" "Испаниях" P.feminine P.animate) ;
    Swedish = mkNat "шведский" (P.mkN "Швеция" "Швеции" "Швецию" "Швецию" "Швецией" "Швеции" "Швеции" "Швеции" "Швеций" "Швециям" "Швеции" "Швециями" "Швециях" P.feminine P.animate) ;


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
    AIll p = mkCl p.name (P.mkA "болен") ; 
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
    AUnderstand p = mkCl p.name (P.regV P.imperfective P.first "понима" "ю" "понимал" "понимай" "понимать") ;
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

    Monday = mkDay "понедельник" P.masculine ;
    Tuesday = mkDay "вторник" P.masculine ;
    Wednesday = mkDay "среда" P.feminine ;
    Thursday = mkDay "четверг" P.masculine ;
    Friday = mkDay "пятница" P.feminine ;
    Saturday = mkDay "суббота" P.feminine ;
    Sunday = mkDay "воскресенье" P.neuter ;

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
    mkNat : Str -> N -> NPNationality = \la,co -> 
      mkNPNationality (mkNP (P.mkPN la P.masculine P.animate)) (mkNP co) (P.mkA la) ;

    mkDay : Str -> P.Gender -> {name : NP ; point : Adv ; habitual : Adv} = \d,g -> 
      mkNPDay (mkNP (P.mkPN d g P.inanimate)) (mkAdv (P.mkPrep [] P.nominative) (mkNP (P.mkPN d g P.inanimate))) 
                                ---- (mkAdv on_Prep (mkNP (P.mkPN d))) 
        (mkAdv on_Prep (mkNP a_Quant plNum (mkCN (P.mkN d)))) ;

--    mkPlace : N -> Str -> {name : CN ; at : Prep ; to : Prep} = \p,i -> 
--      mkCNPlace (mkCN p) (P.mkPrep i P.prepositional) to_Prep ;
    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep ; isPl : Bool} = \p,i -> 
      mkCNPlace (mkCN p) i to_Prep;


   open_A = P.mkA "открыт" ;
   closed_A = P.mkA "закрыт" ;

   xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (mkNP the_Quant a c) (SyntaxRus.mkAdv possess_Prep b)) p ;

     mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxRus.mkAdv with_Prep (mkNP the_Det n)
      } ;

  far_IAdv = ss "как далеко" ** {lock_IAdv = <>} ;
  long_IAdv = ss "как долго" ** {lock_IAdv = <>};

  mkSuperl : A -> Det = \a -> SyntaxRus.mkDet the_Art (SyntaxRus.mkOrd a) ;




}
