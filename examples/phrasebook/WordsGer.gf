-- (c) 2009 Aarne Ranta under LGPL

concrete WordsGer of Words = SentencesGer ** 
    open SyntaxGer, ParadigmsGer, IrregGer, (L = LexiconGer), ExtraGer, Prelude in {

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
    Cheap = mkA "billig" ;
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

    DanishCrown = mkCN (mkA "Dänisch") (mkN "Krone") | mkCN (mkN "Krone") ;
--     Dollar = mkCN (mkN "dollar" "dollar") ;
    Euro = mkCN (mkN "Euro" "Euro" "Euro" "Euro" "Euro" "Euro" neuter) ;
--     Lei = mkCN (mkN "lei" "lei") ;
    SwedishCrown = mkCN (mkA "Schwedisch") (mkN "Krone") | mkCN (mkN "Krone") ;

-- nationalities

    Belgian = mkA "Belgisch" ;
    Belgium = mkNP (mkPN "Belgien") ;
    English = mkNat "Englisch" "England" ;
    Finnish = mkNat "Finnisch" "Finnland" ;
    Flemish = mkNP (mkPN "Flämisch") ;
    French = mkNat "Französisch" "Frankreich" ; 
    Italian = mkNat "Italienisch" "Italien" ;
    Romanian = mkNat "Rumänisch" "Rumänien" ;
    Swedish = mkNat "Schwedisch" "Schweden" ;

-- actions

    AHasAge p num = mkCl p.name (mkNP num L.year_N) ;
    AHasName p name = mkCl p.name (mkV2 heißen_V) name ;
    AHungry p = mkCl p.name (mkA "hungrig") ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "Zimmer" "Zimmer" neuter)) 
        (SyntaxGer.mkAdv for_Prep (mkNP num (mkN "Persone")))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "Tisch")) 
        (SyntaxGer.mkAdv for_Prep (mkNP num (mkN "Persone")))) ;
    AIll p = mkCl p.name (mkA "Krank") ;
    AKnow p = mkCl p.name wissen_V ;
    ALike p item = mkCl item (mkV2 (fixprefixV "ge" (fallen_V)) dative) p.name ;
    ALive p co = mkCl p.name (mkVP (mkVP (mkV "wohnen")) (SyntaxGer.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (mkV2 (mkV "lieben")) q.name ;
    AMarried p = mkCl p.name (mkA "verheiratet") ;
    AReady p = mkCl p.name (mkA "fertig") ;
    AScared p = mkCl p.name have_V2 (mkNP (mkN "Angst" "Angsten" feminine)) ;
    ASpeak p lang = mkCl p.name  (mkV2 sprechen_V) lang ;
    AThirsty p = mkCl p.name (mkA "dürstig") ;
    ATired p = mkCl p.name (mkA "müde") ;
    AUnderstand p = mkCl p.name (fixprefixV "ver" stehen_V) ;
    AWant p obj = mkCl p.name want_VV (mkVP have_V2 obj) ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name heißen_V)) ;
    QWhatAge p = mkQS (mkQCl (ICompAP (mkAP L.old_A)) p.name) ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP d) open_Adv) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP d) closed_Adv) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP d.habitual) open_Adv) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP d.habitual) closed_Adv) ; 

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "kosten"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "kosten")) price ;

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

--    PSeeYou d = mkText (lin Text (ss ("auf Wiedersehen"))) (mkPhrase (mkUtt d)) ;
--    PSeeYouPlace p d = 
--      mkText (lin Text (ss ("auf Wiedersehen"))) 
--        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf sing (mkN "Frau" "Frauen" feminine) ;
    Husband = xOf sing L.man_N ;
    Son = xOf sing (mkN "Sohn" "Söhne" masculine) ;
    Daughter = xOf sing (mkN "Tochter" "Töchter" feminine) ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "Montag" ;
    Tuesday = mkDay "Dienstag" ;
    Wednesday = mkDay "Mittwoch" ;
    Thursday = mkDay "Donnerstag" ;
    Friday = mkDay "Freitag" ;
    Saturday = mkDay "Samstag" ;
    Sunday = mkDay "Sonntag" ;

    Tomorrow = ParadigmsGer.mkAdv "morgen" ;


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

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> mkRelative n (mkCN x) p ; 

}
