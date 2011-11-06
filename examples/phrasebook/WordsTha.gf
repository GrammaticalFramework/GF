concrete WordsTha of Words = SentencesTha ** 
    open 
      (R = ResTha),
      (S = StringsTha),
      Prelude in {

  flags coding = utf8 ;

  lin

-- Kinds; many of them are in the resource lexicon, others can be built by $mkN$.

--    Apple = mkCN L.apple_N ;
    Beer = ss S.biar_s ;
--    Bread = mkCN L.bread_N ;
--    Cheese = mkCN (mkN "จหเเสเ") ;
--    Chicken = mkCN (mkN "จหิจกเน") ;
--    Coffee = mkCN (mkN "จoฝฝเเ") ;
--    Fish = mkCN L.fish_N ;
--    Meat = mkCN (mkN "มเัต") ;
--    Milk = mkCN L.milk_N ;
--    Pizza = mkCN (mkN "ปิzzั") ;
--    Salt = mkCN L.salt_N ;
--    Tea = mkCN (mkN "ตเั") ;
--    Water = mkCN L.water_N ;
--    Wine = mkCN L.wine_N ;

-- Properties; many of them are in the resource lexicon, others can be built by $mkA$.

--    Bad = L.bad_A ;
--    Boring = mkA "บoรินง" ;
--    Cheap = mkA "จหเัป" ;
--    Cold = L.cold_A ;
    Delicious = ss "อร่อย" ;
    Expensive = ss "แพง" ;
--    Fresh = mkA "ฝรเสห" ;
    Good = ss "ดี" ;
--    Suspect = mkA "สุสปเจต" ;
--    Warm = L.warm_A ;

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
--    Restaurant = mkPlace "รเสตัุรันต" "ิน" ;
--    School = mkPlace "สจหooล" "ัต" ;
--    Shop = mkPlace "สหoป" "ัต" ;
--    Station = mkPlace "สตัติoน" "ัต" ;
--    Supermarket = mkPlace "สุปเรมัรกเต" "ัต" ; 
--    Theatre = mkPlace "ตหเัตรเ" "ัต" ;
--    Toilet = mkPlace "ตoิลเต" "ิน" ;
--    University = mkPlace "ุนิึเรสิตย" "ัต" ;
--    Zoo = mkPlace "zoo" "ัต" ;
   
--    CitRestaurant cit = mkCNPlace (mkCN cit (mkN "รเสตัุรันต")) in_Prep to_Prep ;


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
--    English = mkNat "Eนงลิสห" "Eนงลันด" ;
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

--   Bike = mkTransport L.bike_N ;
--   Bus = mkTransport (mkN "บุส") ;
--   Car = mkTransport L.car_N ;
--   Ferry = mkTransport (mkN "ฝเรรย") ;
--   Plane = mkTransport L.airplane_N ;
--   Subway = mkTransport (mkN "สุบวัย") ;
--   Taxi = mkTransport (mkN "ตัxิ") ;
--   Train = mkTransport (mkN "ตรัิน") ;
--   Tram = mkTransport (mkN "ตรัม") ;

--   ByFoot = P.mkAdv "บย ฝooต" ;

-- Actions: the predication patterns are very often language-dependent.

--    AHasAge p num = mkCl p.name (mkNP (mkNP num L.year_N) (ParadigmsTha.mkAdv "oลด"));
    AHasChildren p num = R.mkClause p 
      (R.insertObj (R.mkVP (R.regV "มี")) 
         (ss (R.thbind "ลูก" (num.s ++ S.khon_s)))) ; ---- bind num
--    AHasRoom p num = mkCl p.name have_V2 
--      (mkNP (mkNP a_Det (mkN "รooม")) (SyntaxTha.mkAdv for_Prep (mkNP num (mkN "ปเรสoน")))) ;
--    AHasTable p num = mkCl p.name have_V2 
--      (mkNP (mkNP a_Det (mkN "ตับลเ")) (SyntaxTha.mkAdv for_Prep (mkNP num (mkN "ปเรสoน")))) ;
--    AHasName p name = mkCl (nameOf p) name ;
--    AHungry p = mkCl p.name (mkA "หุนงรย") ;
--    AIll p = mkCl p.name (mkA "ิลล") ;
--    AKnow p = mkCl p.name IrregTha.know_V ;
--    ALike p item = mkCl p.name (mkV2 (mkV "ลิกเ")) item ;
--    ALive p co = mkCl p.name (mkVP (mkVP (mkV "ลิึเ")) (SyntaxTha.mkAdv in_Prep co)) ;
    ALove p q = R.mkClause p (R.insertObj (R.mkVP (R.regV "รัก")) q) ;
--    AMarried p = mkCl p.name (mkA "มัรริเด") ;
--    AReady p = mkCl p.name (mkA "รเัดย") ;
--    AScared p = mkCl p.name (mkA "สจัรเด") ;
--    ASpeak p lang = mkCl p.name  (mkV2 IrregTha.speak_V) lang ;
--    AThirsty p = mkCl p.name (mkA "ตหิรสตย") ;
--    ATired p = mkCl p.name (mkA "ติรเด") ;
--    AUnderstand p = mkCl p.name IrregTha.understand_V ;
--    AWant p obj = mkCl p.name (mkV2 (mkV "วันต")) obj ;
--    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP IrregTha.go_V) place.to) ;

-- miscellaneous

--    QWhatName p = mkQS (mkQCl whatSg_IP (mkVP (nameOf p))) ;
--    QWhatAge p = mkQS (mkQCl (ICompAP (mkAP L.old_A)) p.name) ;
--    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item IrregTha.cost_V)) ; 
--    ItCost item price = mkCl item (mkV2 IrregTha.cost_V) price ;

--    PropOpen p = mkCl p.name open_Adv ;
--    PropClosed p = mkCl p.name closed_Adv ;
--    PropOpenDate p d = mkCl p.name (mkVP (mkVP open_Adv) d) ; 
--    PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_Adv) d) ; 
--    PropOpenDay p d = mkCl p.name (mkVP (mkVP open_Adv) d.habitual) ; 
--    PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_Adv) d.habitual) ; 

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
    Husband = xOf "ผัว" ; ---- familiar
    Son = xOf (R.thbind "ลูก จาย") ;
    Daughter = xOf  (R.thbind "ลูก สาว") ;
--    Children = xOf plur L.child_N ;

-- week days

--    Monday = mkDay "Moนดัย" ;
--    Tuesday = mkDay "Tุเสดัย" ;
--    Wednesday = mkDay "Wเดนเสดัย" ;
--    Thursday = mkDay "Tหุรสดัย" ;
--    Friday = mkDay "Fริดัย" ;
--    Saturday = mkDay "็ัตุรดัย" ;
--    Sunday = mkDay "็ุนดัย" ;
 
--    Tomorrow = P.mkAdv "ตoมoรรoว" ;

-- modifiers of places

--    TheBest = mkSuperl L.good_A ;
--    TheClosest = mkSuperl L.near_A ; 
--    TheCheapest = mkSuperl (mkA "จหเัป") ;
--    TheMostExpensive = mkSuperl (mkA "เxปเนสิึเ") ;
--    TheMostPopular = mkSuperl (mkA "ปoปุลัร") ;
--    TheWorst = mkSuperl L.bad_A ;

--    SuperlPlace sup p = placeNP sup p ;


-- transports

--    HowFar place = mkQS (mkQCl far_IAdv place.name) ;
--    HowFarFrom x y = 
--      mkQS (mkQCl far_IAdv (mkCl y.name (SyntaxTha.mkAdv from_Prep x.name))) ;
--    HowFarFromBy x y t = 
--      mkQS (mkQCl far_IAdv (mkCl y.name (SyntaxTha.mkAdv from_Prep (mkNP x.name t)))) ;
--    HowFarBy y t = mkQS (mkQCl far_IAdv (mkCl y.name t)) ;
 
--    WhichTranspPlace trans place = 
--      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

--    IsTranspPlace trans place =
--      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;



-- auxiliaries

  oper

--    mkNat : Str -> Str -> NPNationality = \nat,co -> 
--      mkNPNationality (mkNP (mkPN nat)) (mkNP (mkPN co)) (mkA nat) ;

--    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
--      let day = mkNP (mkPN d) in 
--      mkNPDay day (SyntaxTha.mkAdv on_Prep day) 
--        (SyntaxTha.mkAdv on_Prep (mkNP a_Quant plNum (mkCN (mkN d)))) ;
    
--    mkCompoundPlace : Str -> Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \comp, p, i ->
--     mkCNPlace (mkCN (P.mkN comp (mkN p))) (P.mkPrep i) to_Prep ;

--    mkPlace : Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i -> 
--      mkCNPlace (mkCN (mkN p)) (P.mkPrep i) to_Prep ;

--    open_Adv = P.mkAdv "oปเน" ;
--    closed_Adv = P.mkAdv "จลoสเด" ;

    xOf : Str -> R.NP -> R.NP = \x,p -> 
      ss (R.thbind x "ของ" p.s) ;  ---- optional particle

--    nameOf : NPPerson -> NP = \p -> (xOf sing (mkN "นัมเ") p).name ;


--    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
--      name = mkCN n ; 
--      by = SyntaxTha.mkAdv by8means_Prep (mkNP n)
--      } ;

--    mkSuperl : A -> Det = \a -> SyntaxTha.mkDet the_Art (SyntaxTha.mkOrd a) ;
    
--   far_IAdv = ExtraTha.IAdvAdv (ss "ฝัร") ;

--}
}
