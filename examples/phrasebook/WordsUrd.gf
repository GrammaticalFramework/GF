--2 Implementations of Words, with English as example

concrete WordsUrd of Words = SentencesUrd ** 
    open 
      SyntaxUrd,
      CommonHindustani,
      ParadigmsUrd, 
      (L = LexiconUrd), 
      (P = ParadigmsUrd), 
--      IrregUrd, 
      ExtraUrd, 
      Prelude in {
flags coding = utf8 ;
  lin

-- Kinds; many of them are in the resource lexicon, others can be built by $mkN$.

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "پنیر" Fem) ;
    Chicken = mkCN (mkN "مرغی") ;
    Coffee = mkCN (mkN "كافی") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "گوشت") ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "پیزہ") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "چاے" Fem) ;
    Water = mkCN L.water_N;
    Wine = mkCN L.wine_N ;

-- Properties; many of them are in the resource lexicon, others can be built by $mkA$.

    Bad = L.bad_A ;
    Boring = mkA "فضول" ;
    Cheap = mkA "سستا" ;
    Cold = L.cold_A ;
    Delicious = mkA "مزیدار" ;
    Expensive = mkA "مہنگا" ;
    Fresh = mkA "تازہ" ;
    Good = L.good_A ;
    Suspect = mkA "برا" ;
    Warm = L.warm_A ;

-- Places require different prepositions to express location; in some languages 
-- also the directional preposition varies, but in English we use $to$, as
-- defined by $mkPlace$.

    Airport = mkPlace "ہوای اڈہ" "پر" ;
    AmusementPark = mkCompoundPlace "ایمیوزیم" "پارك" "میں" ;
    Bank = mkPlace "بینك" "میں" ;
    Bar = mkPlace "بار" "میں" ;
    Cafeteria = mkPlace "كنتین" "میں" ;
    Center = mkPlace "سنٹر" "پر" ;
    Cinema = mkPlace "سینما" "میں" ;
    Church = mkPlace "چرچ" "میں" ;
    Disco = mkPlace "ڈسكو" "میں" ;
    Hospital = mkPlace "ہسپتال" "میں" ;
    Hotel = mkPlace "ہوٹل" "میں" ;
    Museum = mkPlace "میوزیم" "پر" ;
    Park = mkPlace "پارك" "میں" ;
    Parking = mkCompoundPlace "كار" "پارك" "میں" ; 
    Pharmacy = mkPlace "فارمیسی" "پر" ;
    PostOffice = mkCompoundPlace "ڈاك" "خانہ" "پر" ;
    Pub = mkPlace "پب" "میں" ;
    Restaurant = mkPlace "ہوٹل" "میں" ;
    School = mkPlace "سكول" "میں" ;
    Shop = mkPlaceFem "دوكان" "میں" Fem;
    Station = mkPlace "سٹیشن" "پر" ;
    Supermarket = mkPlace "سپر ماركیٹ" "میں" ; 
    Theatre = mkPlace "تھیٹر" "پر" ;
    Toilet = mkPlace "غسل خانہ" "میں" ;
    University = mkPlaceFem "یونیورسٹی" "میں" Fem;
    Zoo = mkPlace "چڑیا گھر" "میں" ;
   
    CitRestaurant cit = mkCNPlace (mkCN cit (mkN "ہوٹل")) in_Prep to_Prep ;


-- Currencies; $crown$ is ambiguous between Danish and Swedish crowns.

    DanishCrown = mkCN (mkA "ڈینش") (mkN "كراون") | mkCN (mkN "كراون") ;
    Dollar = mkCN (mkN "ڈالر") ;
    Euro = mkCN (mkN "یورو") ; -- to prevent euroes
    Lei = mkCN (mkN "لی") ;
    Leva = mkCN (mkN "لیوا") ;
    NorwegianCrown = mkCN (mkA "نارویجن") (mkN "كراون") | mkCN (mkN "كراون") ;
    Pound = mkCN (mkN "پاونڈ") ;
    Rouble = mkCN (mkN "روبل") ;
    SwedishCrown = mkCN (mkA "سویڈش") (mkN "كراون") | mkCN (mkN "كراون") ;
    Zloty = mkCN (mkN "زلوٹی" Fem) ;

-- Nationalities

    Belgian = mkA "بلجیم" ;
    Belgium = mkNP (mkPN "بلجیم") ;
    Bulgarian = mkNat "بلغارین" "بلغاریہ" ;
    Catalan = mkNPNationality (mkNP (mkPN "كیٹالان")) (mkNP (mkPN "كاٹالان")) (mkA "كاٹالانین") ;
    Danish = mkNat "ڈینش" "ڈنمارك" ;
    Dutch =  mkNPNationality (mkNP (mkPN "ڈچ")) (mkNP the_Quant (mkN "نیدرلینڈ")) (mkA "ڈچ") ;
    English = mkNat "انگلش" "انگلینڈ" ;
    Finnish = mkNat "فنش" "فنلینڈ" ;
    Flemish = mkNP (mkPN "فلیمش") ;
    French = mkNat "فرانسیسی" "فرانس" ; 
    German = mkNat "جرمن" "جرمنی" ;
    Italian = mkNat "اطالوی" "اٹلی" ;
    Norwegian = mkNat "نارویجن" "ناروے" ;
    Polish = mkNat "پولش" "پولینڈ" ;
    Romanian = mkNat "رومانین" "رومانیہ" ;
    Russian = mkNat "روسی" "روس" ;
    Spanish = mkNat "سپینی" "سپین" ;
    Swedish = mkNat "سویڈش" "سویڈن" ;

-- Means of transportation 
 
   Bike = mkTransport L.bike_N ;
   Bus = mkTransport (mkN "بس" Fem) ;
   Car = mkTransport L.car_N ;
   Ferry = mkTransport (mkN "فیری") ;
   Plane = mkTransport L.airplane_N ;
   Subway = mkTransport (mkN "سب وے") ;
   Taxi = mkTransport (mkN "ٹیكسی") ;
   Train = mkTransport (mkN "ریل گاڑی") ;
   Tram = mkTransport (mkN "ٹرام" Fem) ;

   ByFoot = P.mkAdv "پیدل" ;

-- Actions: the predication patterns are very often language-dependent.

--    AHasAge p num = mkCl p.name (mkNP (mkNP num L.year_N) (ParadigmsUrd.mkAdv "كا"));
    AHasAge p num = mkCl p.name  (mkNP num (mkCN (modN L.year_N)));
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "كمرہ")) (SyntaxUrd.mkAdv for_Prep (mkNP num (P.mkN "شخص" "شخص" "شخص" "اشخاص" "اشخاص" "شخصو" masculine)))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "میز")) (SyntaxUrd.mkAdv for_Prep (mkNP num (P.mkN "شخص" "شخص" "شخص" "اشخاص" "اشخاص" "شخصو" masculine)))) ;
    AHasName p name = mkCl (nameOf p) name ;
    AHungry p = mkCl p.name (mkA "بھوكا") ;
    AIll p = mkCl p.name (mkA "بیمار") ;
    AKnow p = mkCl p.name (mkV "جاننا") ;
    ALike p item = mkCl p.name (L.like_V2) item ;
    ALive p co = mkCl p.name (mkVP (mkVP (L.live_V)) (SyntaxUrd.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (L.love_V2) q.name ;
    AMarried p = mkCl p.name (mkA "شادی شدہ") ;
    AReady p = mkCl p.name (mkA "تیار") ;
    AScared p = mkCl p.name (P.mkCompoundA "ڈرا" "ہوا") ;
    ASpeak p lang = mkCl p.name  L.speak_V2 lang ;
    AThirsty p = mkCl p.name (mkA "پیاسا") ;
    ATired p = mkCl p.name (P.mkCompoundA "تھكا" "ہوا") ;
    AUnderstand p = mkCl p.name (mkV "سمجھنا") ;
    AWant p obj = mkCl p.name (mkV2 (mkV "چاہنا")) obj ;
--    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.name) ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

--    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;
    QWhatName p = mkQS (mkQCl what_IAdv (mkNP p.poss (P.mkN "نام" "نام" "نام" "نام" "نام" "نام" masculine))) ;
--    QWhatAge p = mkQS (mkQCl (mkCl (mkNP (modQuant p.poss)) (mkAdv "عمر"))) ;
    QWhatAge p = mkQS (mkQCl howMuch_IAdv (mkNP (modQuant p.poss) (P.mkN "عمر" feminine))) ; 
    HowMuchCost item = mkQS (mkQCl (mkCl (modNP item) (mkAdv ["كی قیمت"]))) ;
--    HowMuchCost item = mkQS (mkQCl howMuch_IAdv (mkNP cost_Predet (modNP item))) ;
    ItCost item price = mkCl item (mkV2 (mkV "قیمت")) price ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP d) open_Adv) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP d) closed_Adv) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP  d.habitual) open_Adv); 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP d.habitual) closed_Adv) ; 

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (mkPhrase (mkUtt d)) (lin Text (Prelude.ss ("ملتے ہیں")))  ;
    PSeeYouPlace p = mkText (mkPhrase (mkUtt p.at)) (lin Text (Prelude.ss ("ملتے ہیں")))  ;
    PSeeYouPlaceDate p d = 
      mkText (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d)))
       (lin Text (Prelude.ss ("ملتے ہیں"))) ;

-- Relations are expressed as "می وiفع" or "می سon'س وiفع", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "تہع وiفع oف می سoن" for non-pronouns.

    Wife = xOf ssing (mkN "بیوی") ;
    Husband = xOf ssing (mkN "شوہر") ;
    Son = xOf ssing (mkN "بیٹا") ;
    Daughter = xOf ssing (mkN "بیٹی") ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "سوموار" ;
    Tuesday = mkDay "منگل" ;
    Wednesday = mkDay "بدھ" ;
    Thursday = mkDay "جمعرات" ;
    Friday = mkDay "جمعہ" ;
    Saturday = mkDay "ہفتہ" ;
    Sunday = mkDay "اتوار" ;
 
    Tomorrow = P.mkAdv "كل" ;

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (mkA "سستا") ;
    TheMostExpensive = mkSuperl (mkA "مہنگا") ;
    TheMostPopular = mkSuperl (mkA "مشہور") ;
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;


-- transports


    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
    HowFarFrom x y = mkQS (mkQCl far_IAdv (mkNP y.name (SyntaxUrd.mkAdv from_Prep x.name))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl far_IAdv (mkNP (mkNP y.name (SyntaxUrd.mkAdv from_Prep x.name)) t)) ;
    HowFarBy y t = mkQS (mkQCl far_IAdv (mkNP y.name t)) ;
 
    WhichTranspPlace trans place = 
      mkQS (mkQCl (SyntaxUrd.mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;



-- auxiliaries

  oper

    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
--      let day = mkNP (mkPN d) in
--       let day = (mkNP (mkCN (mkN d))) in
      mkNPDay (mkNP (mkCN (mkN d))) (SyntaxUrd.mkAdv to_Prep (mkNP (mkCN (mkN d)))) 
        (SyntaxUrd.mkAdv to_Prep (mkNP (mkCN (mkN d)))) ; --changed from plNum to sgNum
    
    mkCompoundPlace : Str -> Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \comp, p, i ->
--     mkCNPlace (mkCN (P.mkN comp (mkN p))) (P.mkPrep i) to_Prep ;
      mkCNPlace (mkCN (mkN (comp++p))) (P.mkPrep i i) to_Prep ;

    mkPlace : Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i -> 
      mkCNPlace (mkCN (mkN p)) (P.mkPrep i i) to_Prep ;
    mkPlaceFem : Str -> Str -> Gender -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i,g -> 
      mkCNPlace (mkCN (P.mkN p g)) (P.mkPrep i i) to_Prep ;  

    open_Adv = P.mkAdv "كھلا" "كھلی";
    closed_Adv = P.mkAdv "بند" ;

    xOf : SentencesUrd.GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (GenNP b) a c) p ;

    nameOf : NPPerson -> NP = \p -> (xOf ssing (mkN "نام") p).name ;
    ssing = False ;

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxUrd.mkAdv by8means_Prep (mkNP n)
      } ;

--    mkSuperl : A -> Det = \a -> SyntaxUrd.mkDet the_Art (SyntaxUrd.mkOrd a) ;
      mkSuperl : A -> Det = \a -> lin Det { s = \\n,g,c => a.s ! n ! g ! c ! Superl ; n = Sg } ;
    
   far_IAdv = ExtraUrd.IAdvAdv (P.mkAdv "دور") ;
   what_IAdv = lin IAdv {s = "كیا"} ;
   howMuch_IAdv = lin IAdv {s = "كتنی"} ;
-- cost_Predet = lin Predet {s = ["كی قیمت"]} ;
-------------------
modN : N -> N = \noun -> lin N {s = \\n,c =>noun.s!n!c++"كا" ; g =noun.g} ;
modQuant : Quant -> Quant = \q -> lin Quant {s = \\n,g,c => q.s ! n ! Fem ! c ; a = q.a};
modNP : NP -> NP = \np -> lin NP {s = \\_ => np.s ! NPC Obl  ; a = np.a};

}
