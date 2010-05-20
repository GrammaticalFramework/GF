--2 Implementations of Words, with English as example

concrete WordsBul of Words = SentencesBul ** 
    open 
      SyntaxBul,
      (R = ResBul),
      ParadigmsBul, 
      (L = LexiconBul), 
      (P = ParadigmsBul), 
      ExtraBul, 
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

    Airport = mkPlace (mkN066 "летище") "на" ;
    AmusementPark = mkCompoundPlace (mkA079 "увеселителен") (mkN001 "парк") "в" ;
    Bank = mkPlace (mkN041 "банка") "в" ;
    Bar = mkPlace (mkN042 "бар") "в" ;
    Cafeteria = mkPlace (mkN065 "кафе") "в" ;
    Center = mkPlace (mkN009a "център") "в" ;
    Cinema = mkPlace (mkN054 "кино") "на" ;
    Church = mkPlace (mkN041 "църква") "в" ;
    Disco = mkPlace (mkN041 "дискотека") "в" ;
    Hospital = mkPlace (mkN041 "болница") "в" ;
    Hotel = mkPlace (mkN007 "хотел") "в" ;
    Museum = mkPlace (mkN032 "музей") "в" ;
    Park = mkPlace (mkN001 "парк") "в" ;
    Parking = mkPlace (mkN007 "паркинг") "на" ; 
    Pharmacy = mkPlace (mkN041 "аптека") "в" ;
    PostOffice = mkPlace (mkN041 "поща") "в" ;
    Pub = mkPlace (mkN042 "бар") "в" ;
    Restaurant = mkPlace (mkN007 "ресторант") "в" ;
    School = mkPlace (mkN007 "училище") "в" ;
    Shop = mkPlace (mkN007 "магазин") "в" ;
    Station = mkPlace (mkN041 "гарата") "на" ;
    Supermarket = mkPlace (mkN007 "супермаркет") "в" ;
    Theatre = mkPlace (mkN009 "театър") "на" ;
    Toilet = mkPlace (mkN007 "тоалет") "в" ;
    University = mkPlace (mkN007 "университет") "в" ;
    Zoo = mkPlace (mkN001 "зоопарк") "в" ;

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

    AHasAge p num = mkCl p.name (mkNP num L.year_N) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
--    AHasRoom p num = mkCl p.name have_V2 
--      (mkNP (mkNP a_Det (mkN "room")) (SyntaxBul.mkAdv for_Prep (mkNP num (mkN "person")))) ;
--    AHasTable p num = mkCl p.name have_V2 
--      (mkNP (mkNP a_Det (mkN "table")) (SyntaxBul.mkAdv for_Prep (mkNP num (mkN "person")))) ;
--    AHasName p name = mkCl (nameOf p) name ;
--    AHungry p = mkCl p.name (mkA "hungry") ;
--    AIll p = mkCl p.name (mkA "ill") ;
--    AKnow p = mkCl p.name IrregBul.know_V ;
--    ALike p item = mkCl p.name (mkV2 (mkV "like")) item ;
--    ALive p co = mkCl p.name (mkVP (mkVP (mkV "live")) (SyntaxBul.mkAdv in_Prep co)) ;
--    ALove p q = mkCl p.name (mkV2 (mkV "love")) q.name ;
--    AMarried p = mkCl p.name (mkA "married") ;
--    AReady p = mkCl p.name (mkA "ready") ;
--    AScared p = mkCl p.name (mkA "scared") ;
--    ASpeak p lang = mkCl p.name  (mkV2 IrregBul.speak_V) lang ;
--    AThirsty p = mkCl p.name (mkA "thirsty") ;
--    ATired p = mkCl p.name (mkA "tired") ;
--    AUnderstand p = mkCl p.name IrregBul.understand_V ;
--    AWant p obj = mkCl p.name (mkV2 (mkV "want")) obj ;
--    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP IrregBul.go_V) place.to) ;

-- miscellaneous

--    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;
--    QWhatAge p = mkQS (mkQCl (ICompAP (mkAP L.old_A)) p.name) ;
--    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item IrregBul.cost_V)) ; 
--    ItCost item price = mkCl item (mkV2 IrregBul.cost_V) price ;

--    PropOpen p = mkCl p.name open_Adv ;
--    PropClosed p = mkCl p.name closed_Adv ;
--    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_Adv) d) ; 
--    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_Adv) d) ; 
--    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_Adv) d.habitual) ; 
--    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_Adv) d.habitual) ; 

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

--    PSeeYou d = mkText (lin Text (ss ("see you"))) (mkPhrase (mkUtt d)) ;
--    PSeeYouPlace p d = 
--      mkText (lin Text (ss ("see you"))) 
--        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

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

-- auxiliaries

  oper
    mkCitizenship : N -> N -> A -> Citizenship
                  = \male, female, adj -> lin Citizenship {s1 = table {R.Fem => female.s; _ => male.s}; s2 = adj} ;

    mkNat : N -> N -> A -> PN -> Nationality
          = \male, female, adj, country -> lin Nationality {s1 = table {R.Fem => female.s; _ => male.s}; s2 = adj; s3 = country} ;

    mkDay : N -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day    : NP   = mkNP d ;
          w_Prep : Prep = mkPrep "в" R.Acc
      in mkNPDay day
                 (SyntaxBul.mkAdv w_Prep day) 
                 (SyntaxBul.mkAdv w_Prep (mkNP the_Quant plNum (mkCN d))) ;

    mkCompoundPlace : A -> N -> Str -> {name : CN ; at : Prep ; to : Prep} = \a, n, i ->
     mkCNPlace (mkCN a n) (P.mkPrep i R.Acc) to_Prep ;

    mkPlace : N -> Str -> {name : CN ; at : Prep ; to : Prep} = \p,i -> 
      mkCNPlace (mkCN p) (P.mkPrep i R.Acc) to_Prep ;

--    open_Adv = P.mkAdv "open" ;
--    closed_Adv = P.mkAdv "closed" ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (mkNP the_Quant a c) (SyntaxBul.mkAdv (mkPrep "" R.Dat) b)) p ;

--    nameOf : NPPerson -> NP = \p -> (xOf sing (mkN "name") p).name ;

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxBul.mkAdv (P.mkPrep "с" R.Acc) (mkNP n)
      } ;

}
