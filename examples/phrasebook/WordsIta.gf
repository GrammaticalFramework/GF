-- (c) 2010 Aarne Ranta and Olga Caprotti under LGPL

concrete WordsIta of Words = SentencesIta ** open
  SyntaxIta,
  BeschIta,
  (E = ExtraIta),
  (L = LexiconIta),
  (P = ParadigmsIta), 
  ParadigmsIta,
  Prelude in {

lin

-- kinds

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "formaggio") ;
    Chicken = mkCN (mkN "pollo") ;
    Coffee = mkCN (mkN "caffè") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "carne" feminine) ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pizza") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "tè") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- properties

    Bad = L.bad_A ;
    Boring = mkA "noioso" ;
    Cheap = let c = "a buon mercato" in mkA c c c c c ; ----
    Cold = L.cold_A ;
    Delicious = mkA "delizioso" ;
    Expensive = mkA "caro" ;
    Fresh = mkA "fresco" ;
    Good = L.good_A ;
    Warm = L.warm_A ;
    Suspect = mkA "sospetto" ;

-- places

    Airport = mkPlace (mkN "aeroporto") dative ;
    Bar = mkPlace (mkN "bar") P.in_Prep ;
    Church = mkPlace (mkN "chiesa") P.in_Prep ;
    Cinema = mkPlace (mkN "cinema") P.in_Prep ;
    Hospital = mkPlace (mkN "ospedale") P.in_Prep ;
    Hotel = mkPlace (mkN "albergo") P.in_Prep ;
    Museum = mkPlace (mkN "museo") P.in_Prep ;
    Park = mkPlace (mkN "parco") P.in_Prep ;
    Restaurant = mkPlace (mkN "ristorante") P.in_Prep ;
    School = mkPlace (mkN "scuola") P.in_Prep ;
    Shop = mkPlace (mkN "negozio") P.in_Prep ;
    Station = mkPlace (mkN "stazione" feminine) dative ;
    Theatre = mkPlace (mkN "teatro") P.in_Prep ;
    Toilet = mkPlace (mkN "bagno") P.in_Prep ;
    University = mkPlace (mkN "università") dative ;

-- currencies

    DanishCrown = mkCN (mkA "danese") (mkN "corona") | mkCN (mkN "corona") ;
    Dollar = mkCN (mkN "dollar") ;
    Euro = mkCN (mkN "euro" "euro" masculine) ;
    Lei = mkCN (mkN "lei") ; ---- ?
    SwedishCrown = mkCN (mkA "svedese") (mkN "corona") | mkCN (mkN "corona") ;

-- nationalities

    Belgian = mkA "belgo" ;
    Belgium = mkNP (mkPN "Belgio") ;
    English = mkNat "inglese" "Inghilterra" ;
    Finnish = mkNat "finlandese" "Finlandia" ;
    Flemish = mkNP (mkPN "fiammingo") ;
    French = mkNat "francese" "Francia" ; 
    Italian = mkNat "italiano" "Italia" ;
    Romanian = mkNat "rumeno" "Romania" ;
    Swedish = mkNat "svedese" "Svezia" ;

-- actions

    AHasAge p num = mkCl p.name have_V2 (mkNP num L.year_N) ;
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "camera")) (SyntaxIta.mkAdv for_Prep (mkNP num (mkN "persona")))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "tavolo")) (SyntaxIta.mkAdv for_Prep (mkNP num (mkN "persona")))) ;
    AHasName p name = mkCl p.name (mkV2 (reflV (mkV "chiamare"))) name ;
    AHungry p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "fame" feminine))) ;
    AIll p = mkCl p.name (mkA "malato") ;
    AKnow p = mkCl p.name (mkV (sapere_78 "sapere")) ;
    ALike p item = mkCl item (mkV2 (mkV (piacere_64 "piacere")) dative) p.name ;
    ALive p co = 
      mkCl p.name (mkVP (mkVP (mkV "abitare")) (SyntaxIta.mkAdv P.in_Prep co)) ;
    ALove p q = mkCl p.name (mkV2 (mkV "amare")) q.name ;
    AMarried p = mkCl p.name (mkA "sposato") ;
    AReady p = mkCl p.name (mkA "pronto") ;
    AScared p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "paura" feminine))) ;
    ASpeak p lang = mkCl p.name  (mkV2 (mkV "parlare")) lang ;
    AThirsty p = mkCl p.name (E.ComplCN have_V2 (mkCN (mkN "sete" feminine))) ;
    ATired p = mkCl p.name (mkA "stanco") ;
    AUnderstand p = mkCl p.name (mkV "capire") ;
    AWant p obj = mkCl p.name (mkV2 (mkV (volere_96 "volere"))) obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;


-- miscellaneous

    QWhatName p = mkQS (mkQCl how_IAdv (mkCl p.name (reflV (mkV "chiamare")))) ;
    QWhatAge p = mkQS (mkQCl (mkIP how8many_IDet L.year_N) p.name have_V2) ; 

    PropOpen p = mkCl p.name open_A ;
    PropClosed p = mkCl p.name closed_A ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_A) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_A) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ; 

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "costare"))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "costare")) price ;

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYou d = mkText (lin Text (ss ("arrivederci"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p d = 
      mkText (lin Text (ss ("arrivederci"))) 
        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "my wife" or "the wife of my son", as defined by $xOf$
-- below. Languages with productive genitives can use an equivalent of
-- "my son's wife" for non-pronouns, as e.g. in English.

    Wife = xOf sing (mkN "sposa") ;
    Husband = xOf sing (mkN "marito") ;
    Son = xOf sing (mkN "figlio") ;
    Daughter = xOf sing (mkN "figlia") ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "lunedì" ;
    Tuesday = mkDay "martedì" ;
    Wednesday = mkDay "mercoledì" ;
    Thursday = mkDay "giovedì" ;
    Friday = mkDay "venerdì" ;
    Saturday = mkDay "sabato" ;
    Sunday = mkDay "domenica" ;

    Tomorrow = P.mkAdv "domani" ;

-- auxiliaries

  oper
    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in
      mkNPDay day (P.mkAdv ("il" ++ d)) (P.mkAdv ("il" ++ d)) ; ---- ?

    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep} = \p,i ->
      mkCNPlace (mkCN p) i dative ;

    xOf : GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> mkRelative n (mkCN x) p ; 

    open_A = mkA "aperto" ;
    closed_A = mkA "chiuso" ;


}
