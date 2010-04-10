--2 Implementations of Words, with English as example

concrete WordsRus of Words = SentencesRus ** 
    open 
      SyntaxRus, 
      ParadigmsRus, 
      (L = LexiconRus), 
      (P = ParadigmsRus), 
--      IrregRus, 
--      ExtraRus, 
      Prelude in {
--  lin

-- Kinds; many of them are in the resource lexicon, others can be built by $mkN$.

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
--    Cheese = mkCN (mkN "cheese") ;
--    Chicken = mkCN (mkN "chicken") ;
--    Coffee = mkCN (mkN "coffee") ;
    Fish = mkCN L.fish_N ;
--    Meat = mkCN (mkN "meat") ;
    Milk = mkCN L.milk_N ;
--    Pizza = mkCN (mkN "pizza") ;
    Salt = mkCN L.salt_N ;
--    Tea = mkCN (mkN "tea") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- Properties; many of them are in the resource lexicon, others can be built by $mkA$.

    Bad = L.bad_A ;
--    Boring = mkA "boring" ;
--    Cheap = mkA "cheap" ;
    Cold = L.cold_A ;
--    Delicious = mkA "delicious" ;
--    Expensive = mkA "expensive" ;
--    Fresh = mkA "fresh" ;
    Good = L.good_A ;
--    Suspect = mkA "suspect" ;
    Warm = L.warm_A ;

-- Places require different prepositions to express location; in some languages 
-- also the directional preposition varies, but in English we use $to$, as
-- defined by $mkPlace$.

--    Airport = mkPlace "airport" "at" ;
--    Bar = mkPlace "bar" "in" ;
--    Church = mkPlace "church" "in" ;
--    Cinema = mkPlace "cinema" "at" ;
--    Hospital = mkPlace "hospital" "in" ;
--    Hotel = mkPlace "hotel" "in" ;
--    Museum = mkPlace "museum" "in" ;
--    Park = mkPlace "park" "in" ;
--    Restaurant = mkPlace "restaurant" "in" ;
--    School = mkPlace "school" "at" ;
--    Shop = mkPlace "shop" "in" ;
--    Station = mkPlace "station" "at" ;
--    Theatre = mkPlace "theatre" "at" ;
--    Toilet = mkPlace "toilet" "in" ;
--    University = mkPlace "university" "at" ;

-- Currencies; $crown$ is ambiguous between Danish and Swedish crowns.

--    DanishCrown = mkCN (mkA "Danish") (mkN "crown") | mkCN (mkN "crown") ;
--    Dollar = mkCN (mkN "dollar") ;
--    Euro = mkCN (mkN "euro" "euros") ; -- to prevent euroes
--    Lei = mkCN (mkN "leu" "lei") ;
--    SwedishCrown = mkCN (mkA "Swedish") (mkN "crown") | mkCN (mkN "crown") ;

-- Nationalities

--    Belgian = mkA "Belgian" ;
--    Belgium = mkNP (mkPN "Belgium") ;
--    English = mkNat "English" "England" ;
--    Finnish = mkNat "Finnish" "Finland" ;
--    Flemish = mkNP (mkPN "Flemish") ;
--    French = mkNat "French" "France" ; 
--    Italian = mkNat "Italian" "Italy" ;
--    Romanian = mkNat "Romanian" "Romania" ;
--    Swedish = mkNat "Swedish" "Sweden" ;

-- Actions: the predication patterns are very often language-dependent.

--    AHasAge p num = mkCl p.name (mkNP num L.year_N) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
--    AHasRoom p num = mkCl p.name have_V2 
--      (mkNP (mkNP a_Det (mkN "room")) (SyntaxRus.mkAdv for_Prep (mkNP num (mkN "person")))) ;
--    AHasTable p num = mkCl p.name have_V2 
--      (mkNP (mkNP a_Det (mkN "table")) (SyntaxRus.mkAdv for_Prep (mkNP num (mkN "person")))) ;
--    AHasName p name = mkCl (nameOf p) name ;
--    AHungry p = mkCl p.name (mkA "hungry") ;
--    AIll p = mkCl p.name (mkA "ill") ;
--    AKnow p = mkCl p.name IrregRus.know_V ;
--    ALike p item = mkCl p.name (mkV2 (mkV "like")) item ;
--    ALive p co = mkCl p.name (mkVP (mkVP (mkV "live")) (SyntaxRus.mkAdv in_Prep co)) ;
--    ALove p q = mkCl p.name (mkV2 (mkV "love")) q.name ;
--    AMarried p = mkCl p.name (mkA "married") ;
--    AReady p = mkCl p.name (mkA "ready") ;
--    AScared p = mkCl p.name (mkA "scared") ;
--    ASpeak p lang = mkCl p.name  (mkV2 IrregRus.speak_V) lang ;
--    AThirsty p = mkCl p.name (mkA "thirsty") ;
--    ATired p = mkCl p.name (mkA "tired") ;
--    AUnderstand p = mkCl p.name IrregRus.understand_V ;
--    AWant p obj = mkCl p.name (mkV2 (mkV "want")) obj ;
--    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP IrregRus.go_V) place.to) ;

-- miscellaneous

--    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;
--    QWhatAge p = mkQS (mkQCl (ICompAP (mkAP L.old_A)) p.name) ;
--    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item IrregRus.cost_V)) ; 
--    ItCost item price = mkCl item (mkV2 IrregRus.cost_V) price ;

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

--  oper

--    mkNat : Str -> Str -> NPNationality = \nat,co -> 
--      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

--    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
--      let day = mkNP (mkPN d) in 
--      mkNPDay day (SyntaxRus.mkAdv on_Prep day) 
--        (SyntaxRus.mkAdv on_Prep (mkNP a_Quant plNum (mkCN (mkN d)))) ;

--    mkPlace : Str -> Str -> {name : CN ; at : Prep ; to : Prep} = \p,i -> 
--      mkCNPlace (mkCN (mkN p)) (P.mkPrep i) to_Prep ;

--    open_Adv = P.mkAdv "open" ;
--    closed_Adv = P.mkAdv "closed" ;

--    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
--      relativePerson n (mkCN x) (\a,b,c -> mkNP (GenNP b) a c) p ;

--    nameOf : NPPerson -> NP = \p -> (xOf sing (mkN "name") p).name ;

--}
}
