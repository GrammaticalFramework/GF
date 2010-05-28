--2 Implementations of Words, with English as example

concrete WordsBul of Words = SentencesBul ** 
    open 
      SyntaxBul,
      (R = ResBul),
      ParadigmsBul, 
      (L = LexiconBul), 
      (P = ParadigmsBul), 
      ExtraBul,
      MorphoFunsBul,
      Prelude in {
   
  flags
    coding=utf8;

  lin

-- Kinds; many of them are in the resource lexicon, others can be built by $mkN$.

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN066 "сирене") ;
    Chicken = mkCN (mkN065 "пиле") ;
    Coffee = mkCN (mkN065 "кафе") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN054 "месо") ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN041 "пица") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN028 "чай") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- Properties; many of them are in the resource lexicon, others can be built by $mkA$.

    Bad = L.bad_A ;
    Boring = mkA079 "еднообразен" ;
    Cheap = mkA076 "евтин" ;
    Cold = L.cold_A ;
    Delicious = mkA079 "превъзходен" ;
    Expensive = mkA076 "скъп" ;
    Fresh = mkA076 "свеж" ;
    Good = L.good_A ;
    Suspect = mkA079 "подозрителен" ;
    Warm = L.warm_A ;

-- Places require different prepositions to express location; in some languages 
-- also the directional preposition varies, but in English we use $to$, as
-- defined by $mkPlace$.

    Airport = mkPlace (mkN066 "летище") na_Prep ;
    AmusementPark = mkCompoundPlace (mkA079 "увеселителен") (mkN001 "парк") in_Prep ;
    Bank = mkPlace (mkN041 "банка") in_Prep ;
    Bar = mkPlace (mkN001 "бар") in_Prep ;
    Cafeteria = mkPlace (mkN065 "кафе") in_Prep ;
    Center = mkPlace (mkN009a "център") in_Prep ;
    Cinema = mkPlace (mkN054 "кино") na_Prep ;
    Church = mkPlace (mkN041 "църква") in_Prep ;
    Disco = mkPlace (mkN041 "дискотека") in_Prep ;
    Hospital = mkPlace (mkN041 "болница") in_Prep ;
    Hotel = mkPlace (mkN007 "хотел") in_Prep ;
    Museum = mkPlace (mkN032 "музей") in_Prep ;
    Park = mkPlace (mkN001 "парк") in_Prep ;
    Parking = mkPlace (mkN007 "паркинг") na_Prep ; 
    Pharmacy = mkPlace (mkN041 "аптека") in_Prep ;
    PostOffice = mkPlace (mkN041 "поща") in_Prep ;
    Pub = mkPlace (mkN001 "бар") in_Prep ;
    Restaurant = mkPlace (mkN007 "ресторант") in_Prep ;
    School = mkPlace (mkN007 "училище") in_Prep ;
    Shop = mkPlace (mkN007 "магазин") in_Prep ;
    Station = mkPlace (mkN041 "гара") na_Prep ;
    Supermarket = mkPlace (mkN007 "супермаркет") in_Prep ;
    Theatre = mkPlace (mkN009 "театър") na_Prep ;
    Toilet = mkPlace (mkN041 "тоалетна") in_Prep ;
    University = mkPlace (mkN007 "университет") in_Prep ;
    Zoo = mkPlace (mkN001 "зоопарк") in_Prep ;
    
    CitRestaurant cit = mkCNPlace (mkCN cit.s2 (mkN007 "ресторант")) in_Prep to_Prep ;

-- Currencies; $crown$ is ambiguous between Danish and Swedish crowns.

    DanishCrown = mkCN (mkA078 "датски") (mkN041 "крона") | mkCN (mkN041 "крона") ;
    Dollar = mkCN (mkN007 "долар") ;
    Euro = mkCN (mkN054 "евро") ;
    Lei = mkCN (mkN047 "лея") ;
    Leva = mkCN (mkN001 "лев") ;
    NorwegianCrown = mkCN (mkA078 "норвежки") (mkN041 "крона") | mkCN (mkN041 "крона") ;
    Pound = mkCN (mkN007 "паунд") ;
    Rouble = mkCN (mkN041 "рубла") ;
    SwedishCrown = mkCN (mkA078 "шведски") (mkN041 "крона") | mkCN (mkN041 "крона") ;
    Zloty = mkCN (mkN041 "злота") ;

-- Nationalities

    Belgian = mkCitizenship (mkN013 "белгиец") (mkN041 "белгийка") (mkA078 "белгийски") ;
    Belgium = mkPN "Белгия" R.Fem ;
    Bulgarian = mkNat (mkN018 "българин") (mkN041 "българка") (mkA078 "български") (mkPN "България" R.Fem) ;
    Catalan = mkNat (mkN008a "каталонец") (mkN041 "каталонка") (mkA078 "каталонски") (mkPN "Каталуния" R.Fem) ;
    Danish = mkNat (mkN018 "датчанин") (mkN041 "датчанка") (mkA078 "датски") (mkPN "Дания" R.Fem) ;
    Dutch =  mkNat (mkN008a "холандец") (mkN041 "холандка") (mkA078 "холандски") (mkPN "Холандия" R.Fem) ;
    English =  mkNat (mkN018 "англичанин") (mkN041 "англичанка") (mkA078 "английски") (mkPN "Англия" R.Fem) ;
    Finnish = mkNat (mkN008a "финландец") (mkN041 "финландка") (mkA078 "финландски") (mkPN "Финландия" R.Fem) ;
    Flemish = mkA078 "фламандски" ;
    French = mkNat (mkN018 "французин") (mkN041 "французойка") (mkA078 "френски") (mkPN "Франция" R.Fem) ;
    German = mkNat (mkN008a "германец") (mkN041 "германка") (mkA078 "немски") (mkPN "Германия" R.Fem) ;
    Italian = mkNat (mkN008a "италианец") (mkN041 "италианка") (mkA078 "италиански") (mkPN "Италия" R.Fem) ;
    Norwegian = mkNat (mkN008a "норвежец") (mkN041 "норвежка") (mkA078 "норвежки") (mkPN "Норвегия" R.Fem) ;
    Polish = mkNat (mkN014 "поляк") (mkN047 "полякиня") (mkA078 "полски") (mkPN "Полша" R.Fem) ;
    Romanian = mkNat (mkN008a "румънец") (mkN041 "румънка") (mkA078 "румънски") (mkPN "Румъния" R.Fem) ;
    Russian = mkNat (mkN014 "руснак") (mkN047 "рускиня") (mkA078 "руски") (mkPN "Русия" R.Fem) ;
    Swedish = mkNat (mkN007 "швед") (mkN041 "шведка") (mkA078 "шведски") (mkPN "Швеция" R.Fem) ;
    Spanish = mkNat (mkN008a "испанец") (mkN041 "испанка") (mkA078 "испански") (mkPN "Испания" R.Fem) ;

-- Means of transportation 

    Bike = mkTransport L.bike_N ;
    Bus = mkTransport (mkN007 "автобус") ;
    Car = mkTransport L.car_N ;
    Ferry = mkTransport (mkN007 "ферибот") ;
    Plane = mkTransport (mkN007 "самолет") ;
    Subway = mkTransport (mkN054 "метро") ;
    Taxi = mkTransport (mkN073 "такси") ;
    Train = mkTransport (mkN001 "влак") ;
    Tram = mkTransport (mkN032 "трамвай") ;

    ByFoot = P.mkAdv "пеша" ;

-- Actions: the predication patterns are very often language-dependent.

    AHasAge p num = mkCl p.name (SyntaxBul.mkAdv na_Prep (mkNP num L.year_N)) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 (mkNP (mkNP a_Det (mkN047 "стая")) (SyntaxBul.mkAdv (mkPrep "за" R.Acc) (mkNP num (mkN014 "човек")))) ;
    AHasTable p num = mkCl p.name have_V2 (mkNP (mkNP a_Det (mkN041 "маса")) (SyntaxBul.mkAdv (mkPrep "за" R.Acc) (mkNP num (mkN014 "човек")))) ;
    AHasName p name = mkCl p.name (dirV2 (medialV (actionV (mkV186 "казвам") (mkV156 "кажа")) R.Acc)) name ;
    AHungry p = mkCl p.name (mkA079 "гладен") ;
    AIll p = mkCl p.name (mkA079 "болен") ;
    AKnow p = mkCl p.name (actionV (mkV186 "знам") (mkV162 "зная")) ;
    ALike p item = mkCl p.name (dirV2 (actionV (mkV186 "харесвам") (mkV186 "харесам"))) item ;
    ALive p co = mkCl p.name (mkVP (mkVP (stateV (mkV160 "живея"))) (SyntaxBul.mkAdv in_Prep (mkNP co))) ;
    ALove p q = mkCl p.name (dirV2 (actionV (mkV186 "обичам") (mkV152 "обикна"))) q.name ;
    AMarried p = mkCl p.name (mkA076 (case p.name.a.gn of {
                                        R.GSg R.Fem => "омъжен" ;
                                        _           => "женен"
                                      })) ;
    AReady p = mkCl p.name (mkA076 "готов") ;
    AScared p = mkCl p.name (mkA076 "уплашен") ;
    ASpeak p lang = mkCl p.name (dirV2 (stateV (mkV173 "говоря"))) (mkNP (adj2noun lang)) ;
    AThirsty p = mkCl p.name (mkA079 "жаден") ;
    ATired p = mkCl p.name (mkA076 "уморен") ;
    AUnderstand p = mkCl p.name (actionV (mkV186 "разбирам") (mkV170 "разбера")) ;
    AWant p obj = mkCl p.name (dirV2 (stateV (mkV186 "искам"))) obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP (actionV (mkV186 "отивам") (mkV146 "отида"))) place.to) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name (medialV (actionV (mkV186 "казвам") (mkV156 "кажа")) R.Acc))) ;
    QWhatAge p = mkQS (mkQCl (MorphoFunsBul.mkIAdv "на колко") (mkCl p.name (mkNP a_Quant plNum L.year_N))) ;
    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (stateV (mkV186 "струвам")))) ; 
    ItCost item price = mkCl item (dirV2 (stateV (mkV186 "струвам"))) price ;

    PropOpen p = mkCl p.name open_AP ;
    PropClosed p = mkCl p.name closed_AP ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_AP) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_AP) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_AP) d.habitual) ;
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_AP) d.habitual) ;

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (ss ("ще се видим"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p = mkText (lin Text (ss ("ще се видим"))) (mkPhrase (mkUtt p.at)) ;
    PSeeYouPlaceDate p d =
      mkText (lin Text (ss ("ще се видим"))) 
        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf sing (mkN041 "съпруга") ;
    Husband = xOf sing (mkN015 "съпруг") ;
    Son = xOf sing (mkN018 "син") ;
    Daughter = xOf sing (mkN047 "дъщеря") ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay (mkN014 "понеделник") ;
    Tuesday = mkDay (mkN014 "вторник") ;
    Wednesday = mkDay (mkN043 "сряда") ;
    Thursday = mkDay (mkN014 "четвъртък") ;
    Friday = mkDay (mkN014 "петък") ;
    Saturday = mkDay (mkN041 "събота") ;
    Sunday = mkDay (mkN047 "неделя") ;
 
    Tomorrow = P.mkAdv "утре" ;

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (mkA076 "евтин") ;
    TheMostExpensive = mkSuperl (mkA076 "скъп") ;
    TheMostPopular = mkSuperl (mkA079 "известен") ;
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;


-- transports

    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
    HowFarFrom x y = mkQS (mkQCl far_IAdv (mkNP y.name (SyntaxBul.mkAdv from_Prep x.name))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl far_IAdv (mkNP (mkNP y.name (SyntaxBul.mkAdv from_Prep x.name)) t)) ;
    HowFarBy y t = mkQS (mkQCl far_IAdv (mkNP y.name t)) ;

    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;

-- auxiliaries

  oper
    mkCitizenship : N -> N -> A -> Citizenship
                  = \male, female, adj -> lin Citizenship {s1 = table {R.Fem => female.s; _ => male.s}; s2 = adj} ;

    mkNat : N -> N -> A -> PN -> Nationality
          = \male, female, adj, country -> lin Nationality {s1 = table {R.Fem => female.s; _ => male.s}; s2 = adj; s3 = country} ;

    mkDay : N -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day    : NP   = mkNP d ;
      in mkNPDay day
                 (SyntaxBul.mkAdv in_Prep day) 
                 (SyntaxBul.mkAdv in_Prep (mkNP the_Quant plNum (mkCN d))) ;

    mkCompoundPlace : A -> N -> Prep -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \a, n, p ->
     mkCNPlace (mkCN a n) p to_Prep ;

    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \n,p -> 
      mkCNPlace (mkCN n) p to_Prep ;

    open_AP = mkAP (mkA076 "отворен") ;
    closed_AP = mkAP (mkA076 "затворен") ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (mkNP the_Quant a c) (SyntaxBul.mkAdv (mkPrep "" R.Dat) b)) p ;

    adj2noun : A -> N ;
    adj2noun a = let g = R.AMasc R.NonHuman
                 in lin N {s = \\nf => a.s ! R.nform2aform nf g; g = g} ;

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxBul.mkAdv with_Prep (mkNP n)
      } ;

    mkSuperl : A -> Det = \a -> SyntaxBul.mkDet the_Art (SyntaxBul.mkOrd a) ;

    far_IAdv = ExtraBul.IAdvAdv (ss "далече") ;
    
    na_Prep = mkPrep "на" R.Acc ;

}
