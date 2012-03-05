--2 Implementations of Words, with English as example

concrete WordsHin of Words = SentencesHin ** 
    open 
      SyntaxHin,
      CommonHindustani,
      ParadigmsHin, 
      (L = LexiconHin), 
      (P = ParadigmsHin), 
--      IrregHin, 
      ExtraHin, 
      Prelude in {
flags coding = utf8 ;

-- param Gender = Masc | Fem ;
  lin

-- Kinds; many of them are in the resource lexicon, others can be built by $mkN$.

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "पनीर" Fem) ;
    Chicken = mkCN (mkN "मुरग़ी") ;
    Coffee = mkCN (mkN "काफ़ी") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "गोश्त") ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "पिज़्ज़ा") ;
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "चाय" Fem) ;
    Water = mkCN L.water_N;
    Wine = mkCN L.wine_N ;

-- Properties; many of them are in the resource lexicon, others can be built by $mkA$.

    Bad = L.bad_A ;
    Boring = mkA "उबाऊ" ;
    Cheap = mkA "सस्ता" ;
    Cold = L.cold_A ;
    Delicious = mkA "मज़ेदार" ;
    Expensive = mkA "महंगा" ;
    Fresh = mkA "ताज़ा" ;
    Good = L.good_A ;
    Suspect = mkA "बुरा" ;
    Warm = L.warm_A ;

-- Places require different prepositions to express location; in some languages 
-- also the directional preposition varies, but in English we use $to$, as
-- defined by $mkPlace$.

    Airport = mkPlace "हवाई अड्डा" "पर" ;
    AmusementPark = mkCompoundPlace "मनोरंजन" "उद्यान" "में" ;
    Bank = mkPlace "बैंक" "में" ;
    Bar = mkPlace "बार" "में" ;
    Cafeteria = mkPlace "जलपान घर" "में" ;
    Center = mkPlace "केन्द्र" "पर" ;
    Cinema = mkPlace "सिनेमा" "में" ;
    Church = mkPlace "गिरजा" "में" ;
    Disco = mkPlace "डिस्को" "में" ;
    Hospital = mkPlace "अस्पताल" "में" ;
    Hotel = mkPlace "होटेल" "में" ;
    Museum = mkPlace "संग्रहालय" "पर" ;
    Park = mkPlace "उद्यान" "में" ;
    Parking = mkCompoundPlace "कार" "पार्क" "में" ; 
    Pharmacy = mkPlace "दवासाजी" "पर" ;
    PostOffice = mkCompoundPlace "डाक" "घर" "पर" ;
    Pub = mkPlace "पब" "में" ;
    Restaurant = mkPlace "रेस्तोरां" "में" ;
    School = mkPlace "स्कूल" "में" ;
    Shop = mkPlaceFem "दुकान" "में" Fem;
    Station = mkPlace "स्टेशन" "पर" ;
    Supermarket = mkPlace "सुपर बाज़ार" "में" ; 
    Theatre = mkPlace "रंगशाला" "पर" ;
    Toilet = mkPlace "शौचालय" "में" ; 
    University = mkPlaceFem "विश्वविद्यालय" "में" Fem;
    Zoo = mkPlace "चिड़ियाघर" "में" ;
   
    CitRestaurant cit = mkCNPlace (mkCN cit (mkN "रेस्तोरां")) in_Prep to_Prep ;


-- Currencies; $crown$ is ambiguous between Danish and Swedish crowns.

    DanishCrown = mkCN (mkA "डेनिश") (mkN "क्राउन") | mkCN (mkN "क्राउन") ;
    Dollar = mkCN (mkN "डालर") ;
    Euro = mkCN (mkN "यूरो") ; -- to prevent euroes
    Lei = mkCN (mkN "लेई") ;
    Leva = mkCN (mkN "लेवा") ;
    NorwegianCrown = mkCN (mkA "नारवीजियन") (mkN "क्राउन") | mkCN (mkN "क्राउन") ;
    Pound = mkCN (mkN "पाउंड") ;
    Rouble = mkCN (mkN "रूबल") ;
    SwedishCrown = mkCN (mkA "स्वीडिश") (mkN "क्राउन") | mkCN (mkN "क्राउन") ;
    Zloty = mkCN (mkN "ज़्लोटी" Fem) ;

-- Nationalities

    Belgian = mkA "बेल्जियन" ;
    Belgium = mkNP (mkPN "बेल्जियम") ;
    Bulgarian = mkNat "बुलगेरियाई" "बुलगेरिया" ;
    Catalan = mkNPNationality (mkNP (mkPN "केटलान")) (mkNP (mkPN "केटलान")) (mkA "केटलान") ;
    Danish = mkNat "डेनिश" "डेनमार्क" ;
    Dutch =  mkNPNationality (mkNP (mkPN "डच")) (mkNP the_Quant (mkN "नीदरलैंड्स")) (mkA "डच") ;
    English = mkNat "अंग्रेज़" "इंगलैंड" ;
    Finnish = mkNat "फ़िनिश" "फ़िनलैंड" ;
    Flemish = mkNP (mkPN "फ़्लेमिश") ;
    French = mkNat "फ़्रान्सीसी" "फ़्रान्स" ; 
    German = mkNat "जर्मन" "जर्मनी" ;
    Italian = mkNat "इतालवी" "इटली" ;
    Norwegian = mkNat "नार्वीजियन" "नार्वे" ;
    Polish = mkNat "पोलिश" "पोलैंड" ;
    Romanian = mkNat "रोमानियन" "रोमानिया" ;
    Russian = mkNat "रूसी" "रूस" ;
    Spanish = mkNat "स्पेनी" "स्पेन" ;
    Swedish = mkNat "स्वीडिश" "स्वीडन" ;

-- Means of transportation 
 
   Bike = mkTransport L.bike_N ;
   Bus = mkTransport (mkN "बस" Fem) ;
   Car = mkTransport L.car_N ;
   Ferry = mkTransport (mkN "फ़ेरी") ;
   Plane = mkTransport L.airplane_N ;
   Subway = mkTransport (mkN "सबवे") ;
   Taxi = mkTransport (mkN "टैक्सी") ;
   Train = mkTransport (mkN "रेल गाड़ी") ;
   Tram = mkTransport (mkN "ट्राम" Fem) ;

   ByFoot = P.mkAdv "पैदल चलकर" ;

-- Actions: the predication patterns are very often language-dependent.

--    AHasAge p num = mkCl p.name (mkNP (mkNP num L.year_N) (ParadigmsHin.mkAdv "का"));
    AHasAge p num = mkCl p.name  (mkNP num (mkCN (modN L.year_N)));
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "कमरा")) (SyntaxHin.mkAdv for_Prep (mkNP num (P.mkN "व्यक्ति" "व्यक्ति" "व्यक्ति" "लोग" "लोगों" "लोगो" masculine)))) ;
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "मेज़")) (SyntaxHin.mkAdv for_Prep (mkNP num (P.mkN "व्यक्ति" "व्यक्ति" "व्यक्ति" "लोग" "लोगों" "लोगो" masculine)))) ;
    AHasName p name = mkCl (nameOf p) name ;
    AHungry p = mkCl p.name (mkA "भूखा") ;
    AIll p = mkCl p.name (mkA "बीमार") ;
    AKnow p = mkCl p.name (mkV "जानना") ;
    ALike p item = mkCl p.name (L.like_V2) item ;
    ALive p co = mkCl p.name (mkVP (mkVP (L.live_V)) (SyntaxHin.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name (L.love_V2) q.name ;
    AMarried p = mkCl p.name (P.mkIrregA "शादी शुदा") ;
    AReady p = mkCl p.name (mkA "तैयार") ;
--    AScared p = mkCl p.name (P.mkCompoundA "डरा" "हुआ") ;
    ASpeak p lang = mkCl p.name  L.speak_V2 lang ;
    AThirsty p = mkCl p.name (mkA "प्यासा") ;
--    ATired p = mkCl p.name (P.mkCompoundA "थका" "हुआ") ;
    AUnderstand p = mkCl p.name (mkV "समझना") ;
    AWant p obj = mkCl p.name (mkV2 (mkV "चाहना")) obj ;
--    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.name) ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

--    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;
    QWhatName p = mkQS (mkQCl what_IAdv (mkNP p.poss (P.mkN "नाम" "नाम" "नाम" "नाम" "नाम" "नाम" masculine))) ;
--    QWhatAge p = mkQS (mkQCl (mkCl (mkNP (modQuant p.poss)) (mkAdv "उम्र"))) ;
    QWhatAge p = mkQS (mkQCl howMuch_IAdv (mkNP (modQuant p.poss) (P.mkN "उम्र" "उम्र" "उम्र" "उम्र" "उम्र" "उम्र" feminine))) ; 
    HowMuchCost item = mkQS (mkQCl (mkCl (modNP item) (mkAdv ["की क़ीमत"]))) ; 
    ItCost item price = mkCl item (mkV2 (mkV "क़ीमत")) price ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP d) open_Adv) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP d) closed_Adv) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP  d.habitual) open_Adv); 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP d.habitual) closed_Adv) ; 

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (mkPhrase (mkUtt d)) (lin Text (Prelude.ss ("मिलते हैं")))  ;
    PSeeYouPlace p = mkText (mkPhrase (mkUtt p.at))  (lin Text (Prelude.ss ("मिलते हैं"))) ;
    PSeeYouPlaceDate p d = 
      mkText (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d)))
      (lin Text (Prelude.ss ("मिलते हैं"))) ;

-- Relations are expressed as "मय wिफ़e" or "मय सon'स wिफ़e", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "तहe wिफ़e oफ़ मय सoन" for non-pronouns.

    Wife = xOf ssing (mkN "पत्नी") ;
    Husband = xOf ssing (mkN "पति") ;
    Son = xOf ssing (mkN "बेटा") ;
    Daughter = xOf ssing (mkN "बेटी") ;
    Children = xOf plur L.child_N ;

-- week days

    Monday = mkDay "सोमवार" ;
    Tuesday = mkDay "मंगलवार" ;
    Wednesday = mkDay "बुधवार" ;
    Thursday = mkDay "गुरुवार" ;
    Friday = mkDay "शुक्रवार" ;
    Saturday = mkDay "शनिवार" ;
    Sunday = mkDay "रविवार" ;
 
    Tomorrow = P.mkAdv "कल" ;

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (mkA "सस्ता") ;
    TheMostExpensive = mkSuperl (mkA "महंगा") ;
    TheMostPopular = mkSuperl (mkA "मशहूर") ;
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;


-- transports


    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
    HowFarFrom x y = mkQS (mkQCl far_IAdv (mkNP y.name (SyntaxHin.mkAdv from_Prep x.name))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl far_IAdv (mkNP (mkNP y.name (SyntaxHin.mkAdv from_Prep x.name)) t)) ;
    HowFarBy y t = mkQS (mkQCl far_IAdv (mkNP y.name t)) ;
 
    WhichTranspPlace trans place = 
      mkQS (mkQCl (SyntaxHin.mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;



-- auxiliaries

  oper

    mkNat : Str -> Str -> NPNationality = \nat,co -> 
      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
--      let day = mkNP (mkPN d) in 
      mkNPDay (mkNP (mkCN (mkN d))) (SyntaxHin.mkAdv to_Prep (mkNP (mkCN (mkN d)))) 
        (SyntaxHin.mkAdv to_Prep (mkNP (mkCN (mkN d)))) ; --changed from plNum to sgNum
    
    mkCompoundPlace : Str -> Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \comp, p, i ->
--     mkCNPlace (mkCN (P.mkN comp (mkN p))) (P.mkPrep i) to_Prep ;
      mkCNPlace (mkCN (mkN (comp++p))) (P.mkPrep i i) to_Prep ;

    mkPlace : Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i -> 
      mkCNPlace (mkCN (mkN p)) (P.mkPrep i i) to_Prep ;
    mkPlaceFem : Str -> Str -> Gender -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i,g -> 
      mkCNPlace (mkCN (P.mkN p g)) (P.mkPrep i i) to_Prep ;  

    open_Adv = P.mkAdv "खुला";
    closed_Adv = P.mkAdv "बंद" ;

    xOf : SentencesHin.GNumber -> N -> NPPerson -> NPPerson = \n,x,p -> 
      relativePerson n (mkCN x) (\a,b,c -> mkNP (GenNP b) a c) p ;

    nameOf : NPPerson -> NP = \p -> (xOf ssing (mkN "नाम") p).name ;
    ssing = False ;

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxHin.mkAdv by8means_Prep (mkNP n)
      } ;

--    mkSuperl : A -> Det = \a -> SyntaxHin.mkDet the_Art (SyntaxHin.mkOrd a) ;
      mkSuperl : A -> Det = \a -> lin Det { s = \\n,g,c => a.s ! n ! g ! c ! Superl ; n = Sg } ;
    
   far_IAdv = ExtraHin.IAdvAdv (P.mkAdv "दूर") ;
   what_IAdv = lin IAdv {s = "क्या"} ;
   howMuch_IAdv = lin IAdv {s = "कितनी"} ;
--   cost_Predet = lin Predet {s = ["की क़ीमत"]} ;
-------------------
modN : N -> N = \noun -> lin N {s = \\n,c =>noun.s!n!c++"का" ; g =noun.g} ;
modQuant : Quant -> Quant = \q -> lin Quant {s = \\n,g,c => q.s ! n ! Fem ! c ; a = q.a};
modNP : NP -> NP = \np -> lin NP {s = \\_ => np.s ! NPC Obl  ; a = np.a};

}
