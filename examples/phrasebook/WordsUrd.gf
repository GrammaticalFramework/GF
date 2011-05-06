--2 Implementations of Words, with English as example

concrete WordsUrd of Words = SentencesUrd ** 
    open 
      SyntaxUrd, 
      ParadigmsUrd, 
      (L = LexiconUrd), 
      (P = ParadigmsUrd), 
--      IrregUrd, 
      ExtraUrd, 
      Prelude in {
  lin

-- Kinds; many of them are in the resource lexicon, others can be built by $mkN$.

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "pnyr") ;
    Chicken = mkCN (mkN "mrGy") ;
    Coffee = mkCN (mkN "kafy") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "gwXt") ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "pyzh") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "caE") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- Properties; many of them are in the resource lexicon, others can be built by $mkA$.

    Bad = L.bad_A ;
    Boring = mkA "fZ-wl" ;
    Cheap = mkA "ssta" ;
    Cold = L.cold_A ;
    Delicious = mkA "mzydar" ;
    Expensive = mkA "mhnga" ;
    Fresh = mkA "tazh" ;
    Good = L.good_A ;
    Suspect = mkA "" ;
    Warm = L.warm_A ;

-- Places require different prepositions to express location; in some languages 
-- also the directional preposition varies, but in English we use $to$, as
-- defined by $mkPlace$.

    Airport = mkPlace "hway aDh" "pr" ;
--    AmusementPark = mkCompoundPlace "amusement" "park" "at" ;
    Bank = mkPlace "bynk" "myn" ;
    Bar = mkPlace "bar" "myn" ;
    Cafeteria = mkPlace "kntyn" "myn" ;
    Center = mkPlace "cnTr" "pr" ;
    Cinema = mkPlace "synma" "myn" ;
    Church = mkPlace "crc" "myn" ;
    Disco = mkPlace "Dskw" "myn" ;
    Hospital = mkPlace "hsptal" "myn" ;
    Hotel = mkPlace "hwTl" "myn" ;
    Museum = mkPlace "museum" "at" ;
    Park = mkPlace "park" "myn" ;
--    Parking = mkCompoundPlace "car" "park" "in" ; 
    Pharmacy = mkPlace "pharmacy" "at" ;
--    PostOffice = mkCompoundPlace "post" "office" "at" ;
    Pub = mkPlace "pb" "myN" ;
    Restaurant = mkPlace "hwTl" "myn" ;
    School = mkPlace "skwl" "myn" ;
    Shop = mkPlace "dwkan" "myn" ;
    Station = mkPlace "sTyXn" "pr" ;
    Supermarket = mkPlace "spr markyT" "myn" ; 
    Theatre = mkPlace "th-Tr" "pr" ;
    Toilet = mkPlace "Gsl Kanh" "myn" ;
    University = mkPlace "ynywrsTy" "myn" ;
    Zoo = mkPlace "cRya gh-r" "myn" ;
   
    CitRestaurant cit = mkCNPlace (mkCN cit (mkN "hwTl")) in_Prep to_Prep ;


-- Currencies; $crown$ is ambiguous between Danish and Swedish crowns.

    DanishCrown = mkCN (mkA "DynX") (mkN "crawn") | mkCN (mkN "crawn") ;
    Dollar = mkCN (mkN "Dalr") ;
    Euro = mkCN (mkN "ywrw") ; -- to prevent euroes
    Lei = mkCN (mkN "leu") ;
    Leva = mkCN (mkN "lev") ;
    NorwegianCrown = mkCN (mkA "narwyjn") (mkN "crawn") | mkCN (mkN "crawn") ;
    Pound = mkCN (mkN "pawnD") ;
    Rouble = mkCN (mkN "rwbl") ;
    SwedishCrown = mkCN (mkA "swyDX") (mkN "crawn") | mkCN (mkN "crawn") ;
    Zloty = mkCN (mkN "zlwTy") ;

-- Nationalities

    Belgian = mkA "bljym" ;
    Belgium = mkNP (mkPN "bljym") ;
    Bulgarian = mkNat "blGaryn" "blGaryh" ;
    Catalan = mkNPNationality (mkNP (mkPN "cyTalan")) (mkNP (mkPN "caTalan")) (mkA "caTalanyn") ;
    Danish = mkNat "DynX" "Dnmark" ;
    Dutch =  mkNPNationality (mkNP (mkPN "Dwc")) (mkNP the_Quant (mkN "nydrlynD")) (mkA "Dwc") ;
    English = mkNat "English" "anglynD" ;
    Finnish = mkNat "Finnish" "fnlynD" ;
    Flemish = mkNP (mkPN "flymX") ;
    French = mkNat "fransysy" "frans" ; 
    German = mkNat "grmn" "grmny" ;
    Italian = mkNat "at-lwy" "aTly" ;
    Norwegian = mkNat "narwyjn" "narwE" ;
    Polish = mkNat "pwlX" "pwlynD" ;
    Romanian = mkNat "rwmanyn" "rwmanyh" ;
    Russian = mkNat "rwsy" "rws" ;
    Spanish = mkNat "spyny" "spyn" ;
    Swedish = mkNat "swDX" "swyDn" ;

-- Means of transportation 
 
   Bike = mkTransport L.bike_N ;
   Bus = mkTransport (mkN "bs") ;
   Car = mkTransport L.car_N ;
   Ferry = mkTransport (mkN "fyry") ;
   Plane = mkTransport L.airplane_N ;
   Subway = mkTransport (mkN "sb wE") ;
   Taxi = mkTransport (mkN "Tyksy") ;
   Train = mkTransport (mkN "ryl GaRy") ;
   Tram = mkTransport (mkN "Tram") ;

   ByFoot = P.mkAdv "pydl" ;

-- Actions: the predication patterns are very often language-dependent.

    AHasAge p num = mkCl p.name (mkNP (mkNP num L.year_N) (ParadigmsUrd.mkAdv "ka"));
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "kmrh")) (SyntaxUrd.mkAdv for_Prep (mkNP num (mkN "XKS")))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "table")) (SyntaxUrd.mkAdv for_Prep (mkNP num (mkN "person")))) ;
    AHasName p name = mkCl (nameOf p) name ;
    AHungry p = mkCl p.name (mkA "bh-wka") ;
    AIll p = mkCl p.name (mkA "bymar") ;
    AKnow p = mkCl p.name (mkV "janna") ;
    ALike p item = mkCl p.name (L.like_V2) item ;
    ALive p co = mkCl p.name (mkVP (mkVP (L.live_V)) (SyntaxUrd.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (L.love_V2) q.name ;
    AMarried p = mkCl p.name (mkA "XaXdy Xdh") ;
    AReady p = mkCl p.name (mkA "tyar") ;
    AScared p = mkCl p.name (mkA "dra hwa") ;
    ASpeak p lang = mkCl p.name  L.speak_V2 lang ;
    AThirsty p = mkCl p.name (mkA "pyasa") ;
    ATired p = mkCl p.name (mkA "th-ka hwa") ;
    AUnderstand p = mkCl p.name (mkV "smjh-na") ;
    AWant p obj = mkCl p.name (mkV2 (mkV "cahna")) obj ;
--    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.name) ;
--    AWantGo p place = mkCl p.name (mkVP (mkVP want_VV (mkVP L.go_V)) place.name) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;
----    QWhatAge p = mkQS (mkQCl (ICompAP (mkAP L.old_A)) p.name) ;
--    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item IrregUrd.cost_V)) ; 
--    ItCost item price = mkCl item (mkV2 IrregUrd.cost_V) price ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_Adv) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_Adv) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_Adv) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_Adv) d.habitual) ; 

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (ss ("mltE hyN"))) (mkPhrase (mkUtt d)) ;
    PSeeYouPlace p = mkText (lin Text (ss ("mltE hyN"))) (mkPhrase (mkUtt p.at)) ;
    PSeeYouPlaceDate p d = 
      mkText (lin Text (ss ("mltE hyN"))) 
        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf ssing (mkN "bywy") ;
    Husband = xOf ssing (mkN "Xwhr") ;
    Son = xOf ssing (mkN "byTa") ;
    Daughter = xOf ssing (mkN "byTy") ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "swmwar" ;
    Tuesday = mkDay "mngl" ;
    Wednesday = mkDay "bdh-" ;
    Thursday = mkDay "jmerat" ;
    Friday = mkDay "jmeh" ;
    Saturday = mkDay "hfth" ;
    Sunday = mkDay "atwar" ;
 
    Tomorrow = P.mkAdv "kl" ;

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (mkA "ssta") ;
    TheMostExpensive = mkSuperl (mkA "mhnga") ;
    TheMostPopular = mkSuperl (mkA "mXhwr") ;
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;


-- transports

{-
    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
    HowFarFrom x y = mkQS (mkQCl far_IAdv (mkNP y.name (SyntaxUrd.mkAdv from_Prep x.name))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl far_IAdv (mkNP (mkNP y.name (SyntaxUrd.mkAdv from_Prep x.name)) t)) ;
    HowFarBy y t = mkQS (mkQCl far_IAdv (mkNP y.name t)) ;
-} 
--    WhichTranspPlace trans place = 
--      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;



-- auxiliaries

  oper

    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d) in 
      mkNPDay day (SyntaxUrd.mkAdv on_Prep day) 
        (SyntaxUrd.mkAdv on_Prep (mkNP a_Quant plNum (mkCN (mkN d)))) ;
    
--    mkCompoundPlace : Str -> Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \comp, p, i ->
--     mkCNPlace (mkCN (P.mkN comp (mkN p))) (P.mkPrep i) to_Prep ;

    mkPlace : Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i -> 
      mkCNPlace (mkCN (mkN p)) (P.mkPrep i i) to_Prep ; ---- AR mkPrep i i

    open_Adv = P.mkAdv "open" ;
    closed_Adv = P.mkAdv "closed" ;

    xOf : SentencesUrd.GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (GenNP b) a c) p ;

    nameOf : NPPerson -> NP = \p -> (xOf ssing (mkN "nam") p).name ;
    ssing = False ;

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxUrd.mkAdv by8means_Prep (mkNP n)
      } ;

    mkSuperl : A -> Det = \a -> SyntaxUrd.mkDet the_Art (SyntaxUrd.mkOrd a) ;
    
----   far_IAdv = ExtraUrd.IAdvAdv (ss "dwr") ;

}
