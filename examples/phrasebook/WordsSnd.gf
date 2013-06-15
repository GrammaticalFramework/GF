--2 Implementations of Words, with English as example

concrete WordsSnd of Words = SentencesSnd ** 
    open 
      SyntaxSnd,
--      CommonHindustani,
      ParadigmsSnd, 
      (L = LexiconSnd), 
      (P = ParadigmsSnd),
      MorphoSnd,
--      IrregSnd, 
     ExtraSnd, 
      Prelude in {
flags coding = utf8 ;
  lin

-- Kinds; many of them are in the resource lexicon, others can be built by $mkN$.

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN03 "پنير") ;
    Chicken = mkCN (mkN04 "ڪڪڙ") ;
    Coffee = mkCN (mkN03 "ڪافي") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN03 "گوشت") ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN12 "پيزا") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN09 "چانھ") ;
    Water = mkCN L.water_N;
    Wine = mkCN L.wine_N ;

-- Properties; many of them are in the resource lexicon, others can be built by $mkA$.

    Bad = L.bad_A ;
    Boring = mkA "فضول" ;
    Cheap = mkA "سستو" ;
    Cold = L.cold_A ;
    Delicious = mkA "ذائقيدار" ;
    Expensive = mkA "مهانگو" ;
    Fresh = mkA "تازو" ;
    Good = L.good_A ;
    Suspect = mkA "برو" ;
    Warm = L.warm_A ;

-- Places require different prepositions to express location; in some languages 
-- also the directional preposition varies, but in English we use $to$, as
-- defined by $mkPlace$.

    Airport = mkPlace "هوائي اڏو" "تي" ;
--    AmusementPark = mkCompoundPlace "اميوزيم" "پارڪ" "۾" ;
    Bank = mkPlace "بئنڪ" "۾" ;
    Bar = mkPlace "بار" "۾" ;
    Cafeteria = mkPlace "ڪينٽين" "۾" ;
    Center = mkPlace "سينٽر" "تي" ;
    Cinema = mkPlace "سينيما" "۾" ;
    Church = mkPlace "چرچ" "۾" ;
    Disco = mkPlace "ڊسڪو" "۾" ;
    Hospital = mkPlace "اسپتال" "۾" ;
    Hotel = mkPlace "هوٽل" "۾" ;
    Museum = mkPlace "ميوزيم" "۾" ;
    Park = mkPlace "پارڪ" "۾" ;
    Parking = mkCompoundPlace "ڪار" "پارڪ" "۾" ; 
    Pharmacy = mkPlace "ميڊيڪل اسٽور" "تي" ;
    PostOffice = mkCompoundPlace "پوسٽ" "آفيس" "۾" ;
    Pub = mkPlace "پب" "۾" ;
    Restaurant = mkPlace "هوٽل" "۾" ;
    School = mkPlace "اسڪول" "۾" ;
    Shop = mkPlaceFem "دڪان" "۾" Fem;
    Station = mkPlace "اسٽيشن" "تي" ;
    Supermarket = mkPlace "سپر مارڪيٽ" "۾" ; 
    Theatre = mkPlace "ٿيٽر" "۾" ;
    Toilet = mkPlace "ڪاڪوس" "۾" ;
    University = mkPlaceFem "يونيورسٽي" "۾" Fem;
    Zoo = mkPlace "راڻي باغ" "۾" ;
   
--    CitRestaurant cit = mkCNPlace (mkCN cit (mkN09 "هوٽل")) in_Prep to_Prep ;


-- Currencies; $crown$ is ambiguous between Danish and Swedish crowns.

    DanishCrown = mkCN (mkA "ڊينش") (mkCN (mkN03 "ڪراؤن")) | mkCN (mkN03 "ڪراؤن") ;
    Dollar = mkCN (mkN03 "ڊالر") ;
    Euro = mkCN (mkN12 "يورو") ; -- to prevent euroes
    Lei = mkCN (mkN03 "لي") ;
    Leva = mkCN (mkN12 "ليوا") ;
    NorwegianCrown = mkCN (mkA "نارويجين") (mkCN (mkN03 "ڪراؤن")) | mkCN (mkN03 "ڪراؤن") ;
    Pound = mkCN (mkN03 "پاؤنڊ") ;
    Rouble = mkCN (mkN03 "روبل") ;
    SwedishCrown = mkCN (mkA "سويڊش") (mkCN (mkN03 "ڪراؤن")) | mkCN (mkN03 "ڪراؤن") ;
    Zloty = mkCN (mkN03 "زلوٽي") ;

-- Nationalities

    Belgian = mkA "بيلجين" ;
    Belgium = mkNP (mkPN "بيلجيم") ;
    Bulgarian = mkNat "بلغارين" "بلغاريا" ;
--    Catalan = mkNPNationality (mkNP (mkPN "كیٹالان")) (mkNP (mkPN "كاٹالان")) (mkA "كاٹالانین") ;
    Danish = mkNat "ڊينش" "ڊينمارڪ" ;
--    Dutch =  mkNPNationality (mkNP (mkPN "ڊچ")) (mkNP the_Quant (mkN14 "نيدرلئنڊ")) (mkA "ڊچ") ;
    English = mkNat "انگلش" "انگلئنڊ" ;
    Finnish = mkNat "فنش" "فنلئنڊ" ;
    Flemish = mkNP (mkPN "فليمش") ;
    French = mkNat "فرانسيسي" "فرانس" ; 
    German = mkNat "جرمن" "جرمني" ;
    Italian = mkNat "اٽالوي" "اٽلي" ;
    Norwegian = mkNat "نارويجين" "ناروي" ;
    Polish = mkNat "پولش" "پولئنڊ" ;
    Romanian = mkNat "رومانين" "رومانيا" ;
    Russian = mkNat "روسي" "روس" ;
    Spanish = mkNat "سپيني" "سپين" ;
    Swedish = mkNat "سويڊش" "سويڊن" ;

-- Means of transportation 
 
   Bike = mkTransport L.bike_N ;
   Bus = mkTransport (mkN09 "بس" ) ;
   Car = mkTransport L.car_N ;
   Ferry = mkTransport (mkN09 "فيري") ;
   Plane = mkTransport L.airplane_N ;
   Subway = mkTransport (mkN12 "سب وي") ;
   Taxi = mkTransport (mkN09 "ٽئڪسي") ;
   Train = mkTransport (mkN09 "ريل گاڏي") ;
   Tram = mkTransport (mkN09 "ٽرام") ;

   ByFoot = P.mkAdv "پيادو" ;

-- Actions: the predication patterns are very often language-dependent.

--    AHasAge p num = mkCl p.name (mkNP (mkNP num L.year_N) (ParadigmsSnd.mkAdv "جو"));
    AHasAge p num = mkCl p.name  (mkNP num (mkCN L.year_N));
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
--    AHasRoom p num = mkCl p.name have_V2 
--      (mkNP (mkNP a_Det (mkN01 "ڪمرو")) (SyntaxSnd.mkAdv for_Prep (mkNP num (mkN03 "شخص")))) ;
--    AHasTable p num = mkCl p.name have_V2 
 --     (mkNP (mkNP a_Det (mkN04 "ميز")) (SyntaxSnd.mkAdv for_Prep (mkNP num (mkN03 "شخص")))) ;
    AHasName p name = mkCl (nameOf p) name ;
    AHungry p = mkCl p.name (mkA "بکيو") ;
    AIll p = mkCl p.name (mkA "بيمار") ;
    AKnow p = mkCl p.name (mkV "ڄاڻڻ") ;
    ALike p item = mkCl p.name (L.like_V2) item ;
    ALive p co = mkCl p.name (mkVP (mkVP (L.live_V)) (SyntaxSnd.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (L.love_V2) q.name ;
    AMarried p = mkCl p.name (mkA "پرڻيل") ;
    AReady p = mkCl p.name (mkA "تيار") ;
    AScared p = mkCl p.name (P.mkA "ڊنل") ;
    ASpeak p lang = mkCl p.name  L.speak_V2 lang ;
    AThirsty p = mkCl p.name (mkA "اُڃيو") ;
    ATired p = mkCl p.name (P.mkA "ٿڪل") ;
    AUnderstand p = mkCl p.name (mkV "سمجھڻ") ;
    AWant p obj = mkCl p.name (mkV2 (mkV "چاهڻ")) obj ;
--    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.name) ;
--    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

--    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;
    QWhatName p = mkQS (mkQCl what_IAdv (SyntaxSnd.mkNP p.poss (mkCN (mkN01 "نالو")))) ;
--    QWhatAge p = mkQS (mkQCl (mkCl (mkNP (modQuant p.poss)) (mkAdv "ڄمار"))) ;
    QWhatAge p = mkQS (mkQCl howMuch_IAdv (mkNP (modQuant p.poss) (mkCN (mkN09 "ڄمار")))) ; 
    HowMuchCost item = mkQS (mkQCl (mkCl (modNP item) (mkAdv ["جو ملھ"]))) ;
--    HowMuchCost item = mkQS (mkQCl howMuch_IAdv (mkNP cost_Predet (modNP item))) ;
    ItCost item price = mkCl item (mkV2 (mkV "ملھ")) price ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP d) open_Adv) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP d) closed_Adv) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP  d.habitual) open_Adv); 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP d.habitual) closed_Adv) ; 

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (mkPhrase (mkUtt d)) (lin Text (Prelude.ss ("ملون ٿا")))  ;
    PSeeYouPlace p = mkText (mkPhrase (mkUtt p.at)) (lin Text (Prelude.ss ("ملون ٿا")))  ;
    PSeeYouPlaceDate p d = 
      mkText (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d)))
       (lin Text (Prelude.ss ("ملون ٿا"))) ;

-- Relations are expressed as "می وiفع" or "می سon'س وiفع", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "تہع وiفع oف می سoن" for non-pronouns.

    Wife = xOf ssing (mkN04 "زال") ;
    Husband = xOf ssing (mkN03 "مڙس") ;
    Son = xOf ssing (mkN03 "پٽ") ;
    Daughter = xOf ssing (mkN07 "ڌي") ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "سومر" ;
    Tuesday = mkDay "اڱارو" ;
    Wednesday = mkDay "اربع" ;
    Thursday = mkDay "خميس" ;
    Friday = mkDay "جمعو" ;
    Saturday = mkDay "ڇنڇر" ;
    Sunday = mkDay "آچر" ;
 
    Tomorrow = P.mkAdv "سڀاڻي" ;

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (mkA "سستو") ;
    TheMostExpensive = mkSuperl (mkA "مهانگو") ;
    TheMostPopular = mkSuperl (mkA "مشهور") ;
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;


-- transports


    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
    HowFarFrom x y = mkQS (mkQCl far_IAdv (mkNP y.name (SyntaxSnd.mkAdv from_Prep x.name))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl far_IAdv (mkNP (mkNP y.name (SyntaxSnd.mkAdv from_Prep x.name)) t)) ;
    HowFarBy y t = mkQS (mkQCl far_IAdv (mkNP y.name t)) ;
 
--    WhichTranspPlace trans place = 
--      mkQS (mkQCl (SyntaxSnd.mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;



-- auxiliaries

  oper

    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
--      let day = mkNP (mkPN d) in
--       let day = (mkNP (mkCN (mkN14 d))) in
      mkNPDay (mkNP (mkCN (mkN14 d))) (SyntaxSnd.mkAdv to_Prep (mkNP (mkCN (mkN14 d)))) 
        (SyntaxSnd.mkAdv to_Prep (mkNP (mkCN (mkN14 d)))) ; --changed from plNum to sgNum
    
    mkCompoundPlace : Str -> Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \comp, p, i ->
--     mkCNPlace (mkCN (mkN14 comp (mkN14 p))) (P.mkPrep i) to_Prep ;
      mkCNPlace (mkCN (mkN14 (comp++p))) (P.mkPrep i) to_Prep ;

    mkPlace : Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i -> 
      mkCNPlace (mkCN (mkN14 p)) (P.mkPrep i) to_Prep ;
    mkPlaceFem : Str -> Str -> Gender -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i,g -> 
      mkCNPlace (mkCN (mkN14 p)) (P.mkPrep i) to_Prep ;  

    open_Adv = mkAdv  "کلي";
    closed_Adv = mkAdv "بند" ;

    xOf : SentencesSnd.GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (GenNP b) a c) p ;

    nameOf : NPPerson -> NP = \p -> (xOf ssing (mkN01 "نالو") p).name ;
    ssing = False ;

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxSnd.mkAdv by8means_Prep (mkNP n)
      } ;

--    mkSuperl : A -> Det = \a -> SyntaxSnd.mkDet the_Art (SyntaxSnd.mkOrd a) ;
      mkSuperl : A -> Det = \a -> lin Det { s = \\n,g => a.s ! n ! g ! Dir ; n = Sg } ;
    
   far_IAdv = ExtraSnd.IAdvAdv (mkAdv "پري") ;
   what_IAdv = lin IAdv {s = "ڇا"} ;
   howMuch_IAdv = lin IAdv {s = "ڪيترو"} ;
-- cost_Predet = lin Predet {s = ["جو ملھ"]} ;
-------------------
modN : N -> N = \noun -> lin N {s = \\n,c =>noun.s!n!c++"جو" ; g =noun.g} ;
modQuant : Quant -> Quant = \q -> lin Quant {s = \\n,g,c => q.s ! n ! Fem ! c ; a = q.a};
modNP : NP -> NP = \np -> lin NP {s = \\_ => np.s ! NPC Obl  ; a = np.a ; isPron = np.isPron};

}
