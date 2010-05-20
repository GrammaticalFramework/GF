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

    Belgian = mkA078 "белгийски" ;
    -- Belgium = mkNP (mkPN "Белгия" Fem) ;
    -- English = mkA078 "английски" ;
--    Finnish = mkNat "Finnish" "Finland" ;
--    Flemish = mkNP (mkPN "Flemish") ;
--    French = mkNat "French" "France" ; 
--    Italian = mkNat "Italian" "Italy" ;
--    Romanian = mkNat "Romanian" "Romania" ;
--    Swedish = mkNat "Swedish" "Sweden" ;

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

--    Wife = xOf sing (mkN "wife") ;
--    Husband = xOf sing (mkN "husband") ;
--    Son = xOf sing (mkN "son") ;
--    Daughter = xOf sing (mkN "daughter") ;
--    Children = xOf plur L.child_N ;

-- week days

--    Monday = mkDay "Monday" ;
--    Tuesday = mkDay "Tuesday" ;
--    Wednesday = mkDay "Wednesday" ;
--    Thursday = mkDay "Thursday" ;
--    Friday = mkDay "Friday" ;
--    Saturday = mkDay "Saturday" ;
--    Sunday = mkDay "Sunday" ;
 
--    Tomorrow = P.mkAdv "tomorrow" ;

-- auxiliaries

  oper

--    mkNat : Str -> Str -> NPNationality = \nat,co -> 
--      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

--    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
--      let day = mkNP (mkPN d) in 
--      mkNPDay day (SyntaxBul.mkAdv on_Prep day) 
--        (SyntaxBul.mkAdv on_Prep (mkNP a_Quant plNum (mkCN (mkN d)))) ;

    mkCompoundPlace : A -> N -> Str -> {name : CN ; at : Prep ; to : Prep} = \a, n, i ->
     mkCNPlace (mkCN a n) (P.mkPrep i R.Acc) to_Prep ;

    mkPlace : N -> Str -> {name : CN ; at : Prep ; to : Prep} = \p,i -> 
      mkCNPlace (mkCN p) (P.mkPrep i R.Acc) to_Prep ;

--    open_Adv = P.mkAdv "open" ;
--    closed_Adv = P.mkAdv "closed" ;

--    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
--      relativePerson n (mkCN x) (\a,b,c -> mkNP (GenNP b) a c) p ;

--    nameOf : NPPerson -> NP = \p -> (xOf sing (mkN "name") p).name ;


}
