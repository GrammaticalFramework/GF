--2 Implementations of Words, with English as example

concrete WordsPes of Words = SentencesPes ** 
    open 
      SyntaxPes,
      ResPes,
      ParadigmsPes, 
      (L = LexiconPes), 
      (P = ParadigmsPes), 
--      IrregPes, 
      ExtraPes, 
      Prelude in {
flags coding = utf8 ;

-- param Gender = Masc | Fem ;
  lin

-- Kinds; many of them are in the resource lexicon, others can be built by $mkN01$.

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN01 "پنیر" Inanimate) ;
    Chicken = mkCN (mkN01 "مرغ" Animate) ;
    Coffee = mkCN (mkN01 "قهوه" Inanimate) ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN01 "گوشت" Inanimate) ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN01 "پیتزا" Inanimate) ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN01 "چای" Inanimate) ;
    Water = mkCN L.water_N;
    Wine = mkCN L.wine_N ;

-- Properties; many of them are in the resource lexicon, others can be built by $mkA$.

    Bad = L.bad_A ;
    Boring = mkA ["خسته کننده"] ;
    Cheap = mkA "ارزان" ;
    Cold = L.cold_A ;
    Delicious = mkA "خوشمزه" ;
    Expensive = mkA "گران" ;
    Fresh = mkA "تازه" ;
    Good = L.good_A ;
    Suspect = mkA "مشکوک" ;
    Warm = L.warm_A ;

-- Places require different prepositions to express location; in some languages 
-- also the directional preposition varies, but in English we use $to$, as
-- defined by $mkPlace$.

    Airport = mkPlace "فرودگاه" "در" ;
    AmusementPark = mkPlace "شهربازی" "در" ;
    Bank = mkPlace "بانک" "در" ;
    Bar = mkPlace "بار" "در" ;
    Cafeteria = mkPlace ["کافه تریا"] "در" ;
    Center = mkPlace "مرکز" "در" ;
    Cinema = mkPlace "سینما" "در" ;
    Church = mkPlace "کلیسا" "در" ;
    Disco = mkPlace "دیسکو" "در" ;
    Hospital = mkPlace "بیمارستان" "در" ;
    Hotel = mkPlace "هتل" "در" ;
    Museum = mkPlace "موزه" "در" ;
    Park = mkPlace "پارک" "در" ;
    Parking = mkPlace "پارکینگ" "در" ; 
    Pharmacy = mkPlace "داروخانه" "در" ;
    PostOffice = mkCompoundPlace "اداره" "پست" "در" ;
    Pub = mkPlace "میخانه" "در" ;
    Restaurant = mkPlace "رستوران" "در" ;
    School = mkPlace "مدرسه" "در" ;
    Shop = mkPlace "مغازه" "در";
    Station = mkPlace "ایستگاه" "در" ;
    Supermarket = mkPlace "فروشگاه" "در" ; 
    Theatre = mkPlace "تئاتر" "در" ;
    Toilet = mkPlace "دستشویی" "در" ;
    University = mkPlace "دانشگاه" "در";
    Zoo = mkPlace ["باغ وحش"] "در" ;
   
    CitRestaurant cit = mkCNPlace (mkCN cit (mkCN (mkN01 "رستوران" Inanimate))) in_Prep to_Prep ;


-- Currencies; $crown$ is ambiguous between Danish and Swedish crowns.

    DanishCrown = mkCN (mkA "دانمارک") (mkCN (mkN01 "کرون" Inanimate)) | mkCN (mkN01 "کرون" Inanimate) ;
    Dollar = mkCN (mkN01 "دلار" Inanimate) ;
    Euro = mkCN (mkN01 "یورو" Inanimate) ; -- to prevent euroes
    Lei = mkCN (mkN01 "لی" Inanimate) ; -- check this
    Leva = mkCN (mkN01 "لوا" Inanimate) ;
    NorwegianCrown = mkCN (mkA "نروژ") (mkCN (mkN01 "کرون" Inanimate)) | mkCN (mkN01 "کرون" Inanimate) ;
    Pound = mkCN (mkN01 "پوند" Inanimate) ;
    Rouble = mkCN (mkN01 "روبل" Inanimate) ;
    SwedishCrown = mkCN (mkA "سوئد") (mkCN (mkN01 "کرون" Inanimate)) | mkCN (mkN01 "کرون" Inanimate) ;
    Zloty = mkCN (mkN01 "زلوتی" Inanimate) ; check this

-- Nationalities

    Belgian = mkA "بلژیکی" ;
    Belgium = mkNP (mkPN "بلژیک" Inanimate) ;
    Bulgarian = mkNat "بلغاری" "بلغارستان" ;
    Catalan = mkNPNationality (mkNP (mkPN "کاتالان" Inanimate)) (mkNP (mkPN "کاتالان" Inanimate)) (mkA "کاتالان") ;
    Danish = mkNat "دانمارکی" "دانمارک" ;
    Dutch =  mkNPNationality (mkNP (mkPN "هلندی" Inanimate)) (mkNP the_Quant (mkCN (mkN01 "هلندی" Inanimate))) (mkA "هلندی") ;
    English = mkNat "انگلیسی" "انگلستان" ;
    Finnish = mkNat "فنلاندی" "فنلاند" ;
    Flemish = mkNP (mkPN "فلاندرز" Inanimate) ;
    French = mkNat "فرانسوی" "فرانسه" ; 
    German = mkNat "آلمانی" "آلمان" ;
    Italian = mkNat "ایتالیایی" "ایتالیا" ;
    Norwegian = mkNat "نروژی" "نروژ" ;
    Polish = mkNat "لهستانی" "لهستان" ;
    Romanian = mkNat "رومانیایی" "رومانی" ;
    Russian = mkNat "روسی" "روسیه" ;
    Spanish = mkNat "اسپانیایی" "اسپانیا" ;
    Swedish = mkNat "سوئدی" "سوئد" ;

-- Means of transportation 
 
   Bike = mkTransport L.bike_N ;
   Bus = mkTransport (mkN01 "اتوبوس" Inanimate) ;
   Car = mkTransport L.car_N ;
   Ferry = mkTransport (mkN01 "قایق" Inanimate) ;
   Plane = mkTransport L.airplane_N ;
   Subway = mkTransport (mkN01 "مترو" Inanimate) ;
   Taxi = mkTransport (mkN01 "تاکسی" Inanimate) ;
   Train = mkTransport (mkN01 "قطار" Inanimate) ; -- check this
   Tram = mkTransport (mkN01 "تراموا" Inanimate) ;

   ByFoot = P.mkAdv "پیاده" ;

-- Actions: the predication patterns are very often language-dependent.

--    AHasAge p num = mkCl p.name (mkNP (mkNP num L.year_N) (ParadigmsPes.mkAdv "ک"));
    AHasAge p num = mkCl p.name  (mkNP num (mkCN L.year_N));
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkCN (mkN01 "اتاق" Inanimate))) (SyntaxPes.mkAdv for_Prep (mkNP num (mkCN (P.mkN01 "شخص" Animate))))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkCN (mkN01 "میز" Inanimate))) (SyntaxPes.mkAdv for_Prep (mkNP num (mkCN (P.mkN01 "شخص" Animate))))) ;
    AHasName p name = mkCl (nameOf p) name ;
    AHungry p = mkCl p.name (mkA "گرسنه") ;
    AIll p = mkCl p.name (mkA "بیمار") ;
    AKnow p = mkCl p.name (mkV "داستن" "دان") ;
    ALike p item = mkCl p.name (L.like_V2) item ;
    ALive p co = mkCl p.name (mkVP (mkVP (L.live_V)) (SyntaxPes.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (L.love_V2) q.name ;
    AMarried p = mkCl p.name (mkA "متأهل") ;
    AReady p = mkCl p.name (mkA "آماده") ;
    AScared p = mkCl p.name (P.mkA "ترسیده") ;
    ASpeak p lang = mkCl p.name  L.speak_V2 lang ;
    AThirsty p = mkCl p.name (mkA "تشنه") ;
    ATired p = mkCl p.name (P.mkA "خسته") ;
    AUnderstand p = mkCl p.name (mkV "فهمیدن" "فهم") ; -- "فهمید" is the past root and "فهمیدن" is the infinitive
    AWant p obj = mkCl p.name (mkV2 (mkV "خواستن" "خواه")) obj ;
--    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.name) ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) (SyntaxPes.mkAdv (P.mkPrep "به") place.name)) ;

-- miscellaneous

--    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;
    QWhatName p = mkQS (mkQCl what_IAdv (mkNP p.poss (lin N (mkN01 "نام" Inanimate)))) ;
--    QWhatAge p = mkQS (mkQCl (mkCl (mkNP p.poss) (P.mkAdv "سال"))) ;
    QWhatAge p = mkQS (mkQCl howMuchAge_IAdv (mkNP (mkNP p.poss) (P.mkAdv "سال"))) ; 
--    HowMuchCost item = mkQS (mkQCl (mkCl item (P.mkAdv ["قیمت داشتن"]))) ;
    HowMuchCost item = mkQS (mkQCl howMuchCost_IAdv (mkNP (lin Predet {s = "قیمت"}) item)) ; 
    ItCost item price = mkCl item (mkV2 (mkV "قیمت" "")) price ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
 --   PropOpenDate p d = mkCl p.name (mkVP (mkVP d) open_Adv) ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_Adv) d) ; 
--    PropClosedDate p d = mkCl p.name (mkVP (mkVP d) closed_Adv) ;
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_Adv) d) ; 
--    PropOpenDay p d = mkCl p.name (mkVP (mkVP  open_Adv) d.habitual);
    PropOpenDay p d = mkCl p.name (mkVP (mkNP d.name open_Adv)); 
--    PropClosedDay p d = mkCl p.name (mkVP (mkVP d.habitual) closed_Adv) ;
    PropClosedDay p d = mkCl p.name (mkVP (mkNP d.name closed_Adv)) ; 

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (lin Text (Prelude.ss ("شما را"))) (mkText (mkPhrase (mkUtt d)) (lin Text (Prelude.ss ("می بینم")))) ;
    PSeeYouPlace p = mkText (lin Text (Prelude.ss ("شما را"))) (mkText (mkPhrase (mkUtt p.at)) (lin Text (Prelude.ss ("می بینم")))) ;
    PSeeYouPlaceDate p d = 
      mkText (lin Text (Prelude.ss ("شما را"))) 
        (mkText (mkPhrase (mkUtt p.at)) (mkText (mkPhrase (mkUtt d)) (lin Text (Prelude.ss ("می بینم"))))) ;

-- Relations are expressed as "می wفe" or "می سْn'س wفe", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "تهe wفe ْف می سْن" for non-pronouns.

    Wife = xOf ssing (mkN01 "زن" Animate) ;
    Husband = xOf ssing (mkN01 "شوهر" Animate) ;
    Son = xOf ssing (mkN01 "پسر" Animate) ;
    Daughter = xOf ssing (mkN01 "دختر" Animate) ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "دوشنبه" ;
    Tuesday = mkDay "سه شنبه" ;
    Wednesday = mkDay "چهارشنبه" ;
    Thursday = mkDay "پنج شنبه" ;
    Friday = mkDay "جمعه" ;
    Saturday = mkDay "شنبه" ;
    Sunday = mkDay "یکشنبه" ;
 
    Tomorrow = P.mkAdv "فردا" ;

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (mkA "ارزان") ;
    TheMostExpensive = mkSuperl (mkA "گران") ;
    TheMostPopular = mkSuperl (mkA "پرطرفدار") ;
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;


-- transports


    HowFar place = mkQS (mkQCl far_IAdv (mkNP tA_Prep place.name)) ;
    HowFarFrom x y = mkQS (mkQCl far_IAdv (mkNP (mkNP from_Prep x.name) (SyntaxPes.mkAdv tA_Prep y.name ))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl far_IAdv (mkNP (mkNP (mkNP from_Prep x.name) (SyntaxPes.mkAdv tA_Prep y.name)) t)) ;
    HowFarBy y t = mkQS (mkQCl far_IAdv (mkNP (mkNP tA_Prep y.name) t)) ;
 
    WhichTranspPlace trans place = 
      mkQS (mkQCl (SyntaxPes.mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;



-- auxiliaries

  oper

    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat Inanimate)) (mkNP (mkPN co Inanimate)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = mkNP (mkPN d Inanimate) in 
      mkNPDay day (SyntaxPes.mkAdv no_Prep day) 
        (SyntaxPes.mkAdv to_Prep (mkNP a_Quant sgNum (mkCN (mkN01 d Inanimate)))) ; --changed from plNum to sgNum
    
    mkCompoundPlace : Str -> Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \comp, p, i ->
--     mkCNPlace (mkCN (P.mkN01 comp (mkN01 p))) (P.mkPrep i) to_Prep ;
      mkCNPlace (mkCN (mkN01 (comp++p) Inanimate)) (P.mkPrep i) to_Prep ;

    mkPlace : Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i -> 
      mkCNPlace (mkCN (mkN01 p Inanimate)) (P.mkPrep i) to_Prep ;
--    mkPlaceFem : Str -> Str -> Gender -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i,g -> 
--      mkCNPlace (mkCN (P.mkN01 p Inanimate)) (P.mkPrep i) to_Prep ;  

    open_Adv = P.mkAdv "باز";
    open_Predet = lin Predet {s = "باز"};
    closed_Adv = P.mkAdv "بسته" ;

    xOf : SentencesPes.GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (GenNP b) a c) p ;

    nameOf : NPPerson -> NP = \p -> (xOf ssing (mkN01 "نام" Inanimate) p).name ;
    ssing = False ;

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxPes.mkAdv by8means_Prep (mkNP n)
      } ;

--    mkSuperl : A -> Det = \a -> SyntaxPes.mkDet the_Art (SyntaxPes.mkOrd a) ;
      mkSuperl : A -> Det = \a -> lin Det { s = a.s ! bEzafa ++ "ترین" ; n = Sg ; isNum = False ; fromPron = False} ;
    
--   far_IAdv = ExtraPes.IAdvAdv (P.mkAdv "دور") ;
   far_IAdv = lin IAdv {s = "چقدر راه"} ;
   howMuchAge_IAdv = lin IAdv {s = "چند"} ;
   howMuchCost_IAdv = lin IAdv {s = "چقدر"} ;
   what_IAdv = lin IAdv {s = ["چه چیزی"]} ;
   no_Prep = lin Prep {s = ""} ;
   tA_Prep = lin Prep {s = "تا"} ;
-------------------
--modN : N -> N = \noun -> lin N {s = \\n,c =>noun.s!n!c++"ک" ; g =noun.g} ;
--modQuant : Quant -> Quant = \q -> lin Quant {s = \\n,g,c => q.s ! n ! Fem ! c ; a = q.a};
--modNP : NP -> NP = \np -> lin NP {s = \\_ => np.s ! NPC Obl  ; a = np.a};

}
