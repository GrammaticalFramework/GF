concrete WordsTha of Words = SentencesTha ** 
    open 
      SyntaxTha,
      ParadigmsTha,
      (P = ParadigmsTha),
      (R = ResTha),
      (L = LexiconTha),
      Prelude in {

  flags coding = utf8 ;

  lin

-- Kinds; many of them are in the resource lexicon, others can be built by $mkN$.

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN L.cheese_N ;
--    Chicken = mkCN (mkN "จหิจกเน") ;
--    Coffee = mkCN (mkN "จoฝฝเเ") ;
    Fish = mkCN L.fish_N ;
    Meat = mkCN L.meat_N ;
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN (R.thword "พิซ" "ซา") "ถาด") ;
    Salt = mkCN L.salt_N ;
--    Tea = mkCN (mkN "ตเั") ;
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- Properties; many of them are in the resource lexicon, others can be built by $mkA$.

    Bad = L.bad_A ;
    Boring = mkA (R.thword "น่า" "เบิ่อ") ;
--    Cheap = mkA "จหเัป" ;
    Cold = L.cold_A ;
    Delicious = mkA "อร่อย" ;
    Expensive = mkA "แพง" ;
    Fresh = mkA "สด" ;
    Good = mkA "ดี" ;
--    Suspect = mkA "สุสปเจต" ;
    Warm = L.warm_A ;

-- Places require different prepositions to express location; in some languages 
-- also the directional preposition varies, but in English we use $to$, as
-- defined by $mkPlace$.

--    Airport = mkPlace "ัิรปoรต" "ัต" ;
--    AmusementPark = mkCompoundPlace "ัมุสเมเนต" "ปัรก" "ัต" ;
--    Bank = mkPlace "บันก" "ัต" ;
--    Bar = mkPlace "บัร" "ิน" ;
--    Cafeteria = mkPlace "จันตเเน" "ิน" ;
--    Center = mkPlace "จเนตเร" "ิน" ;
--    Cinema = mkPlace "จินเมั" "ัต" ;
--    Church = mkPlace "จหุรจห" "ิน" ;
--    Disco = mkPlace "ดิสจo" "ัต" ;
--    Hospital = mkPlace "หoสปิตัล" "ิน" ;
--    Hotel = mkPlace "หoตเล" "ิน" ;
--    Museum = mkPlace "มุสเุม" "ัต" ;
--    Park = mkPlace "ปัรก" "ิน" ;
--    Parking = mkCompoundPlace "จัร" "ปัรก" "ิน" ; 
--    Pharmacy = mkPlace "ปหัรมัจย" "ัต" ;
--    PostOffice = mkCompoundPlace "ปoสต" "oฝฝิจเ" "ัต" ;
--    Pub = mkPlace "ปุบ" "ัต" ;
    Restaurant = mkPlace L.restaurant_N at_Prep ;
    School = mkPlace L.school_N at_Prep ;
    Shop = mkPlace L.shop_N at_Prep ;
--    Station = mkPlace "สตัติoน" "ัต" ;
--    Supermarket = mkPlace "สุปเรมัรกเต" "ัต" ; 
--    Theatre = mkPlace "ตหเัตรเ" "ัต" ;
--    Toilet = mkPlace "ตoิลเต" "ิน" ;
    University = mkPlace L.university_N at_Prep ;
--    Zoo = mkPlace "zoo" "ัต" ;
   
    CitRestaurant cit = mkCNPlace (mkCN cit L.restaurant_N) at_Prep noPrep ;


-- Currencies; $crown$ is ambiguous between Danish and Swedish crowns.

--    DanishCrown = mkCN (mkA "Dันิสห") (mkN "จรoวน") | mkCN (mkN "จรoวน") ;
--    Dollar = mkCN (mkN "ดoลลัร") ;
--    Euro = mkCN (mkN "เุรo" "เุรoส") ; -- to prevent euroes
--    Lei = mkCN (mkN "ลเุ" "ลเิ") ;
--    Leva = mkCN (mkN "ลเึ") ;
--    NorwegianCrown = mkCN (mkA "Noรวเงิัน") (mkN "จรoวน") | mkCN (mkN "จรoวน") ;
--    Pound = mkCN (mkN "ปoุนด") ;
--    Rouble = mkCN (mkN "รoุบลเ") ;
--    SwedishCrown = mkCN (mkA "็วเดิสห") (mkN "จรoวน") | mkCN (mkN "จรoวน") ;
--    Zloty = mkCN (mkN "zลoตย" "zลoตย") ;

-- Nationalities

--    Belgian = mkA "Bเลงิัน" ;
--    Belgium = mkNP (mkPN "Bเลงิุม") ;
--    Bulgarian = mkNat "Bุลงัริัน" "Bุลงัริั" ;
--    Catalan = mkNPNationality (mkNP (mkPN "Cัตัลัน")) (mkNP (mkPN "Cัตัลoนิั")) (mkA "Cัตัลoนิัน") ;
--    Danish = mkNat "Dันิสห" "Dเนมัรก" ;
--    Dutch =  mkNPNationality (mkNP (mkPN "Dุตจห")) (mkNP the_Quant (mkN "Nเตหเรลันดส")) (mkA "Dุตจห") ;
--    English = mkNat "Eนงลิสห" "Eนงลันด" ; -- citizen, language, adjective, country
--    Finnish = mkNat "Fินนิสห" "Fินลันด" ;
--    Flemish = mkNP (mkPN "Fลเมิสห") ;
--    French = mkNat "Fรเนจห" "Fรันจเ" ; 
--    German = mkNat "Gเรมัน" "Gเรมันย" ;
--    Italian = mkNat "Iตัลิัน" "Iตัลย" ;
--    Norwegian = mkNat "Noรวเงิัน" "Noรวัย" ;
--    Polish = mkNat "Poลิสห" "Poลันด" ;
--    Romanian = mkNat "ๆoมันิัน" "ๆoมันิั" ;
--    Russian = mkNat "ๆุสสิัน" "ๆุสสิั" ;
--    Spanish = mkNat "็ปันิสห" "็ปัิน" ;
--    Swedish = mkNat "็วเดิสห" "็วเดเน" ;

-- Means of transportation 

   Bike = mkTransport L.bike_N ;
--   Bus = mkTransport (mkN "บุส") ;
   Car = mkTransport L.car_N ;
--   Ferry = mkTransport (mkN "ฝเรรย") ;
   Plane = mkTransport L.airplane_N ;
--   Subway = mkTransport (mkN "สุบวัย") ;
--   Taxi = mkTransport (mkN "ตัxิ") ;
   Train = mkTransport L.train_N ;
--   Tram = mkTransport (mkN "ตรัม") ;

--   ByFoot = P.mkAdv "บย ฝooต" ;

-- Actions: the predication patterns are very often language-dependent.

--    AHasAge p num = mkCl p.name (mkNP (mkNP num L.year_N) (ParadigmsTha.mkAdv "oลด"));
    AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
--    AHasRoom p num = mkCl p.name have_V2 
--      (mkNP (mkNP a_Det (mkN "รooม")) (SyntaxTha.mkAdv for_Prep (mkNP num (mkN "ปเรสoน")))) ;
--    AHasTable p num = mkCl p.name have_V2 
--      (mkNP (mkNP a_Det (mkN "ตับลเ")) (SyntaxTha.mkAdv for_Prep (mkNP num (mkN "ปเรสoน")))) ;
    AHasName p name = mkCl (nameOf p) name ;
    AHungry p = mkCl p.name (mkA (R.thword "หิว" "ข้าว")) ;
    AIll p = mkCl p.name (mkA (R.thword "เจ็บ่" "ปวย")) ;
    AKnow p = mkCl p.name <lin V L.know_V2 : V> ;
--    ALike p item = mkCl p.name (mkV2 (mkV "ลิกเ")) item ;
--    ALive p co = mkCl p.name (mkVP (mkVP (mkV "ลิึเ")) (SyntaxTha.mkAdv in_Prep co)) ;
    ALove p q = mkCl p.name L.love_V2 q.name ;
    AMarried p = mkCl p.name (mkAP L.married_A2) ;
    AReady p = mkCl p.name L.ready_A ;
--    AScared p = mkCl p.name (mkA "สจัรเด") ;
    ASpeak p lang = mkCl p.name L.speak_V2 lang ;
--    AThirsty p = mkCl p.name (mkA "ตหิรสตย") ;
--    ATired p = mkCl p.name (mkA "ติรเด") ;
    AUnderstand p = mkCl p.name (mkV (R.thword "เข้า" "ไจ")) ;
--    AWant p obj = mkCl p.name (mkV2 (mkV "วันต")) obj ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

--    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;
--    QWhatAge p = mkQS (mkQCl (ICompAP (mkAP L.old_A)) p.name) ;
--    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item IrregTha.cost_V)) ; 
--    ItCost item price = mkCl item (mkV2 IrregTha.cost_V) price ;

    PropOpen p = mkCl p.name open_Adv ;
    PropClosed p = mkCl p.name closed_Adv ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_Adv) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_Adv) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_Adv) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_Adv) d.habitual) ; 

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

--    PSeeYouDate d = mkText (lin Text (ss ("สเเ ยoุ"))) (mkPhrase (mkUtt d)) ;
--    PSeeYouPlace p = mkText (lin Text (ss ("สเเ ยoุ"))) (mkPhrase (mkUtt p.at)) ;
--    PSeeYouPlaceDate p d = 
--      mkText (lin Text (ss ("สเเ ยoุ"))) 
--        (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) ;

-- Relations are expressed as "มย วิฝเ" or "มย สoณส วิฝเ", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "ตหเ วิฝเ oฝ มย สoน" for non-pronouns.

    Wife = xOf "เมีย" ; ---- familiar
--    Husband = xOf "ผัว" ; ---- familiar
    Son = xOf (R.thbind "ลูก ชาย") ;
    Daughter = xOf  (R.thbind "ลูก สาว") ;
    Children = xOf L.child_N.s ; ----

-- week days

    Monday = mkDay (R.thword "วัน" "จัน" "ทร์") ;
--    Tuesday = mkDay "Tุเสดัย" ;
--    Wednesday = mkDay "Wเดนเสดัย" ;
--    Thursday = mkDay "Tหุรสดัย" ;
--    Friday = mkDay "Fริดัย" ;
--    Saturday = mkDay "็ัตุรดัย" ;
--    Sunday = mkDay "็ุนดัย" ;
 
--    Tomorrow = P.mkAdv "ตoมoรรoว" ;

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
--    TheClosest = mkSuperl L.near_A ; 
--    TheCheapest = mkSuperl (mkA "จหเัป") ;
    TheMostExpensive = mkSuperl (mkA "แพง") ;
--    TheMostPopular = mkSuperl (mkA "ปoปุลัร") ;
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;


-- transports

--    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
--    HowFarFrom x y = 
--      mkQS (mkQCl far_IAdv (mkCl y.name (SyntaxTha.mkAdv from_Prep x.name))) ;
--    HowFarFromBy x y t = 
--      mkQS (mkQCl far_IAdv (mkCl y.name (SyntaxTha.mkAdv from_Prep (mkNP x.name t)))) ;
--    HowFarBy y t = mkQS (mkQCl far_IAdv (mkCl y.name t)) ;
 
    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;



-- auxiliaries

  oper

--    mkNat : Str -> Str -> NPNationality = \nat,co -> 
--      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day = lin NP (ss d) in 
      mkNPDay day (SyntaxTha.mkAdv noPrep day) 
        (SyntaxTha.mkAdv noPrep (mkNP a_Quant plNum (mkCN (mkN d)))) ;
    
    mkPlace : N -> Prep -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i -> 
      mkCNPlace (mkCN p) i noPrep ;

    open_Adv = P.mkAdv "เปิด" ;
    closed_Adv = P.mkAdv "ปิด" ;

    xOf : Str -> NPPerson -> NPPerson = \f,p -> 
      {name = mkNP the_Det (mkCN (personN f) (SyntaxTha.mkAdv possess_Prep p.name)) ; 
       isPron = False ; poss = the_Quant} ; ---- poss not used

    nameOf : NPPerson -> NP = \p -> (xOf L.name_N.s p).name ;


    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxTha.mkAdv (mkPrep "โดย") (mkNP n)
      } ;

    mkSuperl : A -> Det = \a -> SyntaxTha.mkDet the_Art (SyntaxTha.mkOrd a) ;
    
--   far_IAdv = ExtraTha.IAdvAdv (ss "ฝัร") ;

  at_Prep = mkPrep "ที่" ;
  noPrep = mkPrep [] ;
}
  