-- (c) 2009 Aarne Ranta under LGPL

concrete WordsGer of Words = SentencesGer ** 
    open SyntaxGer, ParadigmsGer, IrregGer, (L = LexiconGer), Prelude in {

   lin

-- kinds of food
 
    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "Käse" "Käse" masculine) ;
--    Coffee = mkCN (mkN "Kaffee" "Kaffee" masculine) ;
    Fish = mkCN L.fish_N ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pizza" "pizzen" feminine) ;
    Salt = mkCN L.salt_N ;
--    Tea = mkCN (mkN "Tee" neutrum) ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- properties

    Bad = L.bad_A ;
    Boring = mkA "langweilig" ;
    Cold = L.cold_A ;
    Delicious = mkA "lecker" ;
    Expensive = mkA "teuer" ;
    Fresh = mkA "frisch" ;
    Good = L.good_A ;
    Warm = L.warm_A ;

-- places

    Airport = mkPlace (mkN "Flughafen" "Flughäfen" masculine) on_Prep to_Prep ;
--     Bar = mkPlace (mkN "bar" "barer") "i" ;
    Church = mkPlace (mkN "Kirche") in_Prep to_Prep ;
    Hospital = mkPlace (mkN "Krankenhaus" "Krankenhäuser" neuter) in_Prep to_Prep ;
--     Museum = mkPlace (mkN "museum" "museet" "museer" "museerna") "på" ;
    Restaurant = mkPlace (mkN "Restaurant" "Restaurants" neuter) in_Prep to_Prep ;
    Station = mkPlace (mkN "Bahnhofen" "Bahnhöfen" masculine) on_Prep to_Prep ;
--     Toilet = mkPlace (mkN "toalett" "toaletter") "på" ;
    University = mkPlace (mkN "Universität" "Universitäten" feminine) 
       (mkPrep "an" dative) (mkPrep "an" accusative) ;

-- currencies

    DanishCrown = mkCN (mkA "Dänisch") (mkN "Krone") ;
--     Dollar = mkCN (mkN "dollar" "dollar") ;
    Euro = mkCN (mkN "Euro" "Euro" neuter) ;
--     Lei = mkCN (mkN "lei" "lei") ;
--     SwedishCrown = mkCN (mkA "svensk") (mkN "krona") ;

-- nationalities

    Belgian = mkA "Belgisch" ;
    Belgium = mkNP (mkPN "Belgien") ;
    English = mkNat "Englisch" "England" ;
    Finnish = mkNat "Finnisch" "Finnland" ;
--     Flemish = mkNP (mkPN "flamländska") ;
    French = mkNat "Französisch" "Frankreich" ; 
    Italian = mkNat "Italienisch" "Italien" ;
--     Romanian = mkNat "rumänsk" "Rumänien" ;
--     Swedish = mkNat "svensk" "Sverige" ;
-- 
-- -- actions

    AHasName p name = mkCl p.name (mkV2 heißen_V) name ;
    AHungry p = mkCl p.name (mkA "hungrig") ;
    AIll p = mkCl p.name (mkA "Krank") ;
    AKnow p = mkCl p.name wissen_V ;
    ALike p item = mkCl item (mkV2 (fixprefixV "ge" (fallen_V)) dative) p.name ;
    ALive p co = mkCl p.name (mkVP (mkVP (mkV "wohnen")) (SyntaxGer.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (mkV2 (mkV "lieben")) q.name ;
    AScared p = mkCl p.name have_V2 (mkNP (mkN "Angst" "Angsten" feminine)) ;
    ASpeak p lang = mkCl p.name  (mkV2 sprechen_V) lang ;
    AThirsty p = mkCl p.name (mkA "dürstig") ;
    ATired p = mkCl p.name (mkA "müde") ;
    AUnderstand p = mkCl p.name (fixprefixV "ver" stehen_V) ;
    AWant p obj = mkCl p.name want_VV (mkVP have_V2 obj) ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name heißen_V)) ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP d) open_Adv) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP d) closed_Adv) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP d.habitual) open_Adv) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP d.habitual) closed_Adv) ; 

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "kosten"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "kosten")) price ;

-- week days

    Monday = mkDay "Montag" ;
    Tuesday = mkDay "Dienstag" ;
    Wednesday = mkDay "Mittwoch" ;
    Thursday = mkDay "Donnerstag" ;
    Friday = mkDay "Freitag" ;
    Saturday = mkDay "Samstag" ;
    Sunday = mkDay "Sonntag" ;

  oper
    mkNat : Str -> Str -> {lang : NP ; prop : A ; country : NP} = \nat,co -> 
      {lang = mkNP (mkPN nat) ; 
       prop = mkA nat ; country = mkNP (mkPN co)} ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in
      {name = day ; 
       point = SyntaxGer.mkAdv (mkPrep "am" dative) day ; ---- am 
       habitual = ParadigmsGer.mkAdv (d + "s") ----
      } ;

    mkPlace : N -> Prep -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,at,to -> {
      name = mkCN p ;
      at = at ;
      to = to
      } ;

    open_Adv = mkAdv "geöffnet" ;  ---- Adv to get right word order easily
    closed_Adv = mkAdv "geschlossen" ;

}
