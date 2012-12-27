-- (C) 2009 Aarne Ranta under LGPL

concrete WordsRus of Words = SentencesRus ** 
    open SyntaxRus, (P = ParadigmsRus), (L = LexiconRus), ExtraRus, (R = ResRus), Prelude in {

flags coding = utf8 ;

  lin

-- kinds of food

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN L.cheese_N ;
    Chicken = mkCN (P.mkN "курица") ;
    Coffee = mkCN (P.mkIndeclinableNoun "кофе" P.masculine P.inanimate) ;
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
    Suspect = P.mkA "подозрительный" ;
    Warm = L.warm_A ;



-- places
 
    Airport = mkPlace "аэропорт" in_Prep ; 
    AmusementPark = mkPlace2 "развлечения" "парк" in_Prep;
    Bank = mkPlace "банк" in_Prep ;
    Bar = mkPlace "бар" in_Prep ;  
    Cafeteria = mkPlace "кафетерий" in_Prep ;
    Center = mkPlace "центр" in_Prep ;
    Church = mkPlace "церковь" in_Prep ; 
    Cinema = mkPlace "кино" in_Prep ;  
    Disco = mkPlace "дискотека" on_Prep ;
    Hospital = mkPlace "больница" in_Prep ; 
    Hotel = mkPlace "отель" in_Prep ; 
    Museum = mkPlace "музей" in_Prep ; 
    Park = mkPlace "парк" in_Prep ; 
    Parking = mkPlace "автостоянка" on_Prep ; 
    Pharmacy = mkPlace "аптека" in_Prep ;
    PostOffice = mkPlace "почта" on_Prep ;
    Pub = mkPlace "паб" in_Prep ;
    Restaurant = mkPlace "ресторан" in_Prep ; 
    Shop = mkPlace "магазин" in_Prep ;  
    School = mkPlace "школа" in_Prep ; 
    Station = mkPlace "станция" on_Prep ; 
    Supermarket = mkPlace "супермаркет" in_Prep ;
    Theatre = mkPlace "театр" in_Prep ;
    Toilet = mkPlace "туалет" in_Prep ; 
    University = mkPlace "университет" in_Prep ; 
    Zoo = mkPlace "зоопарк" in_Prep ;

 
    CitRestaurant cit = 
      mkCNPlace (mkCN cit (P.mkN "ресторан")) in_Prep to2_Prep ;    


-- currencies

    DanishCrown = mkCN (P.mkA "датский") (P.mkN "крона" P.inanimate) ;
    Dollar = mkCN (P.mkN "доллар" P.inanimate) ;
    Euro = mkCN (P.mkIndeclinableNoun "евро" P.neuter P.inanimate) ;
    Lei = mkCN (P.mkN "лей" P.inanimate) ;
    Leva = mkCN (P.mkN "лев" P.inanimate) ;
    NorwegianCrown = mkCN (P.mkA "норвежский") (P.mkN "крона" P.inanimate) ;  
    Pound = mkCN (P.mkN "фунт" P.inanimate);
    Rouble = mkCN (P.mkN "рубль" P.inanimate) ;
    SwedishCrown = mkCN (P.mkA "шведский") (P.mkN "крона" P.inanimate) ;
    Zloty = mkCN (P.mkN "злотый" P.inanimate) ;


-- Nationalities

--    Belgian = mkNat "бельгийский" (P.mkPN "Бельгия" P.feminine P.singular P.inanimate) ;
    Bulgarian = mkNat "болгарский" (P.mkPN "Болгария" P.feminine P.singular P.animate) ;
    Catalan = mkNat "каталонский" (P.mkPN "Каталония" P.feminine P.singular P.animate) ;
    Danish = mkNat "датский" (P.mkPN "Дания" P.feminine P.singular P.animate) ;
    Dutch = mkNat "нидерландский" (P.mkPN "Нидерланды" P.neuter P.plural P.inanimate) ;
    English = mkNat "английский" (P.mkPN "Англия" P.feminine P.singular P.animate) ;
    Finnish = mkNat "финский" (P.mkPN "Финляндия" P.feminine P.singular P.animate) ;
--    Flemish = mkNat "фландрийский" (P.mkPN "Фландрия" P.feminine P.singular P.animate) ;
    French = mkNat "французский" (P.mkPN "Франция" P.feminine P.singular P.animate) ;
    German = mkNat "немецкий" (P.mkPN "Германия" P.feminine P.singular P.animate) ;
    Italian = mkNat "итальянский" (P.mkPN "Италия" P.feminine P.singular P.animate) ;
    Norwegian = mkNat "норвежский" (P.mkPN "Норвегия" P.feminine P.singular P.animate) ;
    Polish = mkNat "польский" (P.mkPN "Польша" P.feminine P.singular P.animate) ;
    Romanian = mkNat "румынский" (P.mkPN "Румыния" P.feminine P.singular P.animate) ;
    Russian = mkNat "русский" (P.mkPN "Россия" P.feminine P.singular P.animate) ;
    Spanish = mkNat "испанский" (P.mkPN "Испания" P.feminine P.singular P.inanimate) ;
    Swedish = mkNat "шведский" (P.mkPN "Швеция" P.feminine P.singular P.animate) ;


-- Means of transportation


    Bike = mkTransport L.bike_N ;
    Bus = mkTransport (P.mkN "автобус") ; 
    Car = mkTransport (P.mkN "автомобиль");
    Ferry = mkTransport (P.mkN "паром") ;
    Plane = mkTransport (P.mkN "самолет") ;
    Subway = mkTransport (P.mkIndeclinableNoun "метро" P.neuter P.inanimate) ;
    Taxi = mkTransport (P.mkIndeclinableNoun "такси" P.neuter P.inanimate) ;
    Tram = mkTransport (P.mkN "трамвай") ;
    Train = mkTransport (P.mkN "поезд") ;

    ByFoot = P.mkAdv "пешком" ;



-- actions
--    AHasAge p num = mkCl p.name (mkNP num L.year_N) ; 
    AHasAge p num = mkCl (mkVP be_V3 (mkNP num L.year_N) p.name) ; 
    AHasName p name = mkCl (mkVP (P.mkV3 name_is_V "" "" P.nominative P.accusative) name p.name) ;
    AHasChildren p num = mkCl (mkVP have_V3 (mkNP num L.child_N) p.name) ; 
    AHasRoom p num = mkCl (mkVP have2_V3 
      (mkNP (mkNP a_Det (P.mkN "номер")) 
        (SyntaxRus.mkAdv for_Prep (mkNP num (L.man_N)))) p.name) ; 
    AHasTable p num = mkCl (mkVP have2_V3 
      (mkNP (mkNP a_Det (P.mkN "стол")) 
        (SyntaxRus.mkAdv for_Prep (mkNP num (L.man_N)))) p.name) ;
    AHungry p = mkCl p.name (P.mkA "голодный") ;
    AIll p = mkCl p.name (P.mkA "больной") ; 
    AKnow p = mkCl p.name (P.regV P.imperfective P.first "зна" "ю" "знал" "знай" "знать" ) ; 
    ALike p item = mkCl item (P.mkV2 (P.mkV P.imperfective "нравлюсь" "нравишься" "нравится" "нравимся" "нравитесь" "нравятся" "нравился" "нравься" "нравиться") [] P.dative) p.name ;
    ALive p co = mkCl p.name (mkVP (mkVP (P.regV P.imperfective P.firstE "жив" "у" "жил" "живи" "жить")) (SyntaxRus.mkAdv in_Prep co)) ; 
    ALove p q = mkCl p.name (P.dirV2 (P.regV P.imperfective P.second "люб" "лю" "любил" "люби" "любить" )) q.name ; 
--    AMarried p = mkCl p.name (P.mkA "женатый") ; 
    AMarried p = let status = case p.name.g of {
    		       R.PGen R.Masc => P.mkAdv "женат" ;
    		       _         => P.mkAdv "замужем"
    		       } in mkCl p.name status ;
    AReady p = mkCl p.name (P.mkA "готовый") ; 
    AScared p = mkCl p.name (P.mkV P.imperfective "боюсь" "боишься" "боится" "боимся" "бойтесь" "боятся" "боялся" "бойся" "бояться") ;
    ASpeak p lang = mkCl p.name (P.mkV2 (P.regV P.imperfective P.secondA "говор" "ю" "говорил" "говори" "говорить") "на" P.prepositional) lang ; 
    AThirsty p = mkCl p.name want_VV (mkVP (P.regV P.imperfective P.firstE "пь" "ю" "пил" "пей" "пить" )) ;
    ATired p = mkCl p.name (P.mkA "уставший" R.Rel) ; 
    AUnderstand p = mkCl p.name (P.regV P.imperfective P.first "понима" "ю" "понимал" "понимай" "понимать") ;
    AWant p obj = mkCl p.name (P.dirV2 (P.regV P.imperfective P.mixed "хо" "чу" "хотел" "хоти" "хотеть")) obj ; 
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP (P.mkV P.perfective "пошёл" "пошёл" "пошёл" "пошли" "пошли" "пошли" "пошёл" "пойди" "пойти")) place.to) ;
    --AWantGo p place = mkCl p.name want_VV (mkVP (mkVP (P.mkV P.imperfective "иду" "идёшь" "идёт" "идём" "идёте" "идут" "шёл" "иди" "идти")) place.to) ; 
    
-- miscellaneous

    QWhatName p = mkQS (mkQCl how_IAdv (mkCl (mkVP (P.mkV2 name_is_V "" P.accusative) p.name))) ;
    QWhatAge p = mkQS (mkQCl (mkIP how8many_IDet L.year_N) p.name);
    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item cost_V)) ; 
    ItCost item price = mkCl item (P.mkV2 cost_V "" P.accusative) price ;

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
      mkText (lin Text (ss ("увидимся"))) (mkPhrase (mkUtt p.at)) ; 
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("увидимся"))) 
        (mkText (mkPhrase (mkUtt d)) (mkPhrase (mkUtt p.at))) ; 

-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf sing (P.mkN "жена" P.animate) ; 
    Husband = xOf sing (P.mkN "муж" P.animate) ;
    Son = xOf sing (P.mkN "сын" P.animate) ;
    Daughter = xOf sing (P.mkN "дочь" "дочери" "дочери" "дочь" "дочерью" "дочери" "дочь" "дочери" "дочерей" "дочерям" "дочерей" "дочерьми" "дочерях" P.feminine P.animate) ;
--    Daughter = xOf sing E.daughter_N ;
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
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (P.mkA "дешевый") ;
    TheMostExpensive = mkSuperl (P.mkA "дорогой") ;
    TheMostPopular = mkSuperl (P.mkA "популярный") ;
    TheWorst = mkSuperl L.bad_A ;

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
    mkNat : Str -> PN -> NPNationality = \la,co -> 
      mkNPNationality (mkNP (mkCN (P.mkA la) (P.mkN "язык"))) (mkNP co) (P.mkA la) ;

    mkDay : Str -> P.Gender -> {name : NP ; point : Adv ; habitual : Adv} =
      \d,g -> mkNPDay (mkNP (P.mkPN d g P.singular P.inanimate)) (mkAdv (P.mkPrep "в" P.accusative) (mkNP (P.mkPN d g P.singular P.inanimate))) 
                                ---- (mkAdv on_Prep (mkNP (P.mkPN d))) 
        (mkAdv (P.mkPrep "по" P.dative) (mkNP a_Quant plNum (mkCN (P.mkN d)))) ;

--    mkPlace : N -> Str -> {name : CN ; at : Prep ; to : Prep} = \p,i -> 
--      mkCNPlace (mkCN p) (P.mkPrep i P.prepositional) to_Prep ;
    mkPlace : Str -> Prep -> {name : CN ; at : Prep ; to : Prep ; isPl : Bool} = \p,i -> 
      mkCNPlace (mkCN (P.mkN p)) i to_Prep;

    mkPlace2 : Str -> Str -> Prep -> {name : CN ; at : Prep ; to : Prep ; isPl : Bool} = \p,p2,i -> 
      mkCNPlace (mkCN (P.mkN2 (P.mkN p2)) (mkNP (P.mkN p))) i to_Prep;

    open_A = P.mkA "открытый";
    closed_A = P.mkA "закрытый";

    cost_V = P.regV P.imperfective P.secondA "сто" "ю" "стоил" "стой" "стоить" ;

    name_is_V = P.mkV P.imperfective "зову" "зовëшь" "зовут" "зовëм" "зовëте" "зовут" "звал" "зови" "звать" ;

   xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (mkNP the_Quant a c) (SyntaxRus.mkAdv possess_Prep b)) p ;

     mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ;  
     by = SyntaxRus.mkAdv on_Prep (mkNP the_Det n)
      } ;

     far_IAdv = ss "как далеко" ** {lock_IAdv = <>} ;
     long_IAdv = ss "как долго" ** {lock_IAdv = <>};

     mkSuperl : A -> Det = \a -> SyntaxRus.mkDet the_Art (SyntaxRus.mkOrd a) ;

}
