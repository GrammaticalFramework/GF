concrete WordsChi of Words = SentencesChi **
open
SyntaxChi,
ParadigmsChi,
(P = ParadigmsChi),
(R = ResChi),
(L = LexiconChi),
Prelude in {

flags coding = utf8 ;

lin

-- Kinds; many of them are in the resource lexicon, others can be built by $mkN$.

Apple = mkCN L.apple_N ;
Beer = mkCN L.beer_N ;
Bread = mkCN L.bread_N ;
Cheese = mkCN L.cheese_N ;
Chicken = mkCN (mkN "鸡" "只" ) ;
Coffee = mkCN (mkN "咖啡" ) ;
Fish = mkCN L.fish_N ;
Meat = mkCN L.meat_N ;
Milk = mkCN L.milk_N ;
Pizza = mkCN (mkN "比萨饼") ;
Salt = mkCN L.salt_N ;
Tea = mkCN (mkN "茶" ) ;
Water = mkCN L.water_N ;
Wine = mkCN L.wine_N ;

-- Properties; many of them are in the resource lexicon, others can be built by $mkA$.

Bad = L.bad_A ;
Boring = mkA "难吃" ;
Cheap = (mkA "廉价" ) ;
Cold = L.cold_A ;
Delicious = mkA "美味" ;
Expensive = (mkA "昂贵" ) ;
Fresh = (mkA "新鲜" ) ;
Good = (mkA "好" ) ;
Suspect = mkA "可疑" ;
Warm = L.warm_A ;

-- Places require different prepositions to express location; in some languages
-- also the directional preposition varies, but in English we use $to$, as
-- defined by $mkPlace$.

Airport = mkPlace (( (mkN "机场" ) )) ;
AmusementPark = mkPlace (mkN "游乐园") ;
Bank = mkPlace (( (L.bank_N ) )) ;
Bar = mkPlace (( (mkN "酒吧" ) )) ;
Cafeteria = mkPlace (( (L.bank_N ) )) ;
Center = mkPlace (mkN "中心") ;
Cinema = mkPlace (mkN "电影院") ;
Church = mkPlace (L.church_N ) ;
Disco = mkPlace (mkN "迪斯科") ;
Hospital = mkPlace (mkN "医院" ) ;
Hotel = mkPlace (mkN "旅馆" ) ;
Museum = mkPlace (mkN "博物馆" ) ;
Park = mkPlace (mkN "公园" ) ;
Parking = mkPlace (mkN "地方停车") ;
Pharmacy = mkPlace (mkN "药店") ;
PostOffice = mkPlace (mkN "邮局") ;
Pub = mkPlace (mkN "酒吧") ;
Restaurant = mkPlace L.restaurant_N ;
School = mkPlace L.school_N ;
Shop = mkPlace L.shop_N ;
Station = mkPlace (mkN "车站" ) ;
Supermarket = mkPlace (mkN "超级市场" "家" ) ;
Theatre = mkPlace (mkN "剧院") ;
Toilet = mkPlace (mkN "厕所" ) ;
University = mkPlace L.university_N ;
Zoo = mkPlace (mkN "动物园") ;

CitRestaurant cit = mkCNPlace (mkCN cit L.restaurant_N) at_Prep noPrep ;


-- Currencies; $crown$ is ambiguous between Danish and Swedish crowns.

-- DanishCrown = mkCN (mkA (R.thword "เดน" "มาร์ค")) (mkN "โครน") | mkCurrency "โครน" ; ---#
-- Dollar = mkCurrency (R.thword "ดอล" "ล่า" "ห์") ;
-- Euro = mkCurrency (R.thword "ยู" "โร") ;
-- Lei = mkCurrency "ลี" ;
-- Leva = mkCurrency (R.thword "ลี" "วา") ;
-- NorwegianCrown = mkCN (mkA (R.thword "นอร" "เว" "ย์")) (mkN "โครน") | mkCurrency "โครน" ;
-- Pound = mkCurrency (R.thword "ปอน" "ด์") ;
-- Rouble = mkCurrency (R.thword "รู" "เบิล") ;
-- SwedishCrown = mkCN (mkA (R.thword "สวี" "ดิช")) (mkN "โครน") | mkCurrency "โครน" ;
-- Zloty = mkCurrency (R.thword "สะ" "ลอ" "ตี้") ;

-- Nationalities

-- Belgian = mkA (R.thword "เบล" "เยี่ยน") ;
-- Belgium = mkNP (mkPN (R.thword "เบล" "เยี่ยม")) ;
-- Bulgarian = mkNat (R.thword "บัล" "แก" "เรียน") ;
-- Catalan = mkNat (R.thword "คะ" "ตะ" "ลัน") ;
-- Danish = mkNat (R.thword "เดน" "นิช") ;
-- Dutch = mkNat (R.thword "ดัทช์") ;
-- English = mkNat (R.thword "อัง" "กฤษ") ;
-- Finnish = mkNat (R.thword "ฟิน" "นิช") ;
-- Flemish = mkNP (mkPN (R.thword "เฟลม" "มิช")) ;
-- French = mkNat (R.thword "ฝรั่ง" "เศส") ;
-- German = mkNat (R.thword "เยอร" "มัน") ;
-- Italian = mkNat (R.thword "อิ" "ตา" "เลียน") ;
-- Norwegian = mkNat (R.thword "นอร" "เวย์" "เจี้ยน") ;
-- Polish = mkNat (R.thword "โป" "ลิช") ;
-- Romanian = mkNat (R.thword "โร" "มา" "เนียน") ;
-- Russian = mkNat (R.thword "รัส" "เซียน") ;
-- Spanish = mkNat (R.thword "สแปน" "นิช") ;
-- Swedish = mkNat (R.thword "สวี" "ดิช") ;

-- Means of transportation

Bike = mkTransport L.bike_N ;
Bus = mkTransport (mkN "公共汽车" ) ;
Car = mkTransport L.car_N ;
Ferry = mkTransport (mkN "渡船") ;
Plane = mkTransport L.airplane_N ;
Subway = mkTransport (mkN "地铁") ;
Taxi = mkTransport (mkN "出租车") ;
Train = mkTransport L.train_N ;
Tram = mkTransport (mkN "电车") ;

-- ByFoot = P.mkAdv (R.thword "ด้วย" "การ" "เดิน") ;

-- Actions: the predication patterns are very often language-dependent.

AHasAge p nu = mkCl (lin NP {s = p.name.s ++ nu.s}) (mkV "岁") ; ----
AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
AHasRoom p num = mkCl p.name have_V2
(mkNP (mkNP a_Det (mkN "房间" ) ) (SyntaxChi.mkAdv for_Prep (mkNP num (L.person_N ) ))) ;
AHasTable p num = mkCl p.name have_V2
(mkNP (mkNP a_Det L.table_N ) (SyntaxChi.mkAdv for_Prep (mkNP num (L.person_N ) ))) ;
AHasName p name = mkCl p.name (mkV2 "叫") name ;
AHungry p = mkCl p.name (mkA "饿") ;
AIll p = mkCl p.name (mkA "生病" ) ;
AKnow p = mkCl p.name <lin V L.know_V2 : V> ;
ALike p item = mkCl p.name (L.like_V2 ) item ;
ALive p co = mkCl p.name (mkV2 (mkV "住")) co ;
ALove p q = mkCl p.name L.love_V2 q.name ;
AMarried p = mkCl p.name (mkAP L.married_A2) ;
AReady p = mkCl p.name L.ready_A ;
AScared p = mkCl p.name (mkA "惊慌") ;
ASpeak p lang = mkCl p.name L.speak_V2 lang ;
AThirsty p = mkCl p.name (mkA "渴") ;
ATired p = mkCl p.name (mkA "累") ;
AUnderstand p = mkCl p.name (lin V (mkV "理解" ) ) ;
AWant p obj = mkCl p.name (mkV2 "要") obj ;
AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

QWhatName p = lin QS {s = p.name.s ++ R.word "贵姓"} ; ---
QWhatAge p = lin QS {s = p.name.s ++ (R.word "几岁" | R.word "多大")} ; ---
HowMuchCost item = lin QS {s = item.s ++ R.word "是多少呢"} ;
ItCost item price = mkCl item (mkV2 "成本") price ;

PropOpen p = mkCl p.name (mkA "开放" ) ;
PropClosed p = mkCl p.name closed_A ;
PropOpenDate p d = mkCl p.name (mkVP (mkVP (mkA "开放" ) ) d) ;
PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ;
PropOpenDay p d = mkCl p.name (mkVP (mkVP (mkA "开放" ) ) d.habitual) ;
PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ;

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

PSeeYouDate d = lin Text (ss (d.s ++ "见")) ;
PSeeYouPlace p = lin Text (ss (p.at.s ++ "见")) ; ---
PSeeYouPlaceDate p d = lin Text (ss (d.s ++ p.at.s ++ "见")) ; ----

-- Relations are expressed as "มย วิฝเ" or "มย สoณส วิฝเ", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "ตหเ วิฝเ oฝ มย สoน" for non-pronouns.

Wife = xOf (L.wife_N ) ;
Husband = xOf (L.husband_N ) ;
Wife = xOf (L.wife_N ) ;
Son = xOf (mkN "儿子" ) ;
Daughter = xOf (mkN "女儿" ) ;
Children = xOf L.child_N ; ----

-- week days

Monday = mkDay "星期一" ;
Tuesday = mkDay "星期二" ;
Wednesday = mkDay "星期三" ;
Thursday = mkDay "星期四" ;
Friday = mkDay "星期五" ;
Saturday = mkDay "星期六" ;
Sunday = mkDay "星期日" ;

Tomorrow = ParadigmsChi.mkAdv "明天" ;

-- modifiers of places

TheBest = mkSuperl L.good_A ;
TheClosest = mkSuperl L.near_A ;
TheCheapest = mkSuperl (mkA "廉价" ) ;
TheMostExpensive = mkSuperl (mkA "昂贵" ) ;
TheMostPopular = mkSuperl (mkA "流行" ) ;
TheWorst = mkSuperl L.bad_A ;

SuperlPlace sup p = placeNP sup p ;


-- transports

HowFar place = lin QS {s = place.name.s ++ R.word "有多远"} ;

HowFarFrom x y = lin QS {s = "从" ++ x.name.s ++ "到" ++ y.name.s ++ R.word "有多远"} ; ----

-- HowFarFromBy x y t =
-- mkQS (mkQCl howFar.how (mkCl (mkNP y.name howFar.far)
-- (lin AP (R.thbind from_Prep (mkNP x.name t))))) ;
-- mkQS (mkQCl howFar.how (mkCl (mkNP y.name howFar.far)
-- (SyntaxChi.mkAdv from_Prep (mkNP x.name t)))) ;

-- HowFarBy y t = mkQS (mkQCl howFar.how (mkCl (mkNP y.name howFar.far) <t : AP>)) ;

-- WhichTranspPlace trans place =
-- mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

-- IsTranspPlace trans place =
-- mkQS (mkQCl (mkCl (mkCN (mkCN trans.name (mkSC (mkVP L.go_V))) place.to))) ;



-- auxiliaries

oper
mkNat : Str -> NPNationality = \nat ->
mkNPNationality (mkNP (mkCN (mkA nat) L.language_N)) (mkNP (mkCN (mkA nat) L.country_N)) (mkA nat) ;

mkDay : Str -> {name : NP ; point : SyntaxChi.Adv ; habitual : SyntaxChi.Adv} = \d ->
let day = mkNP (mkPN d) in
mkNPDay day (SyntaxChi.mkAdv noPrep day)
(SyntaxChi.mkAdv noPrep (mkNP a_Quant plNum (mkCN (mkN d)))) ;

mkPlace : N -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p ->
mkCNPlace (mkCN p) at_Prep noPrep ;

placeN : Str -> N = \s -> mkN s "间" ;

-- open_A = P.mkA "เปิด" ;
closed_A = P.mkA "关闭" ;

xOf : N -> NPPerson -> NPPerson = \f,p ->
{name = mkNP the_Det (mkCN f (SyntaxChi.mkAdv possess_Prep p.name)) ;
isPron = False ; poss = the_Quant} ; ---- poss not used


mkTransport : N -> {name : CN ; by : SyntaxChi.Adv} = \n -> {
name = mkCN n ;
by = SyntaxChi.mkAdv by8means_Prep (mkNP n)
} ;

mkSuperl : A -> Det = \a -> SyntaxChi.mkDet the_Art (SyntaxChi.mkOrd a) ;

-- mkCurrency : Str -> CN = \s -> mkCN (mkN [] s) ; ---- just a classifier

-- howFar : {howfar : IComp ; far : Adv ; how : IAdv} = { --- to avoid yuu
-- howfar = lin IComp (ss ("ไกล" + "เท่า" + "ไร")) ; far = lin Adv (ss ("ไกล" + "เท่า" + "ไร")) ; how = lin IAdv (ss [])
-- } ;

at_Prep = (mkPrep "在" ) ;
noPrep = mkPrep [] ;

--------------------------------------------------
-- New 30/11/2011 AR
--------------------------------------------------

-- lin
-- Thai = mkNat "ไทย" ;
-- Baht = mkCurrency "บาท" ;

-- Rice = mkCN (mkN ("ข้าว")) ;
-- Pork = mkCN (mkN ("หมู")) ;
-- Beef = mkCN (mkN ("เนื้อ")) ;
-- Egg = mkCN L.egg_N ;
-- Noodles = mkCN (mkN (R.thword "ก๋วย" "เตี๋ยว")) ;
-- Shrimps = mkCN (mkN ("กุ้ง")) ;
-- Chili = mkCN (mkN "พริก") ;
-- Garlic = mkCN (mkN (R.thword "กะ" "เทียม")) ;
-- Durian = mkCN (mkN (R.thword "ทุ" "เรียน")) ;
-- Mango = mkCN (mkN (R.thword "มะ" "ม่วง")) ;
-- Pineapple = mkCN (mkN (R.thword "สับ" "ปะ" "รด")) ;
-- Coke = mkCN (mkN ("โค้ก")) ;
-- IceCream = mkCN (mkN (R.thword "ไอ" "ศ" "กรีม")) ;
-- Salad = mkCN (mkN "สลัด") ;
-- OrangeJuice = mkCN (mkN (R.thword "น้ำ" "ส้ม" "คั้น")) ;
-- Lemonade = mkCN (mkN (R.thword "น้ำ" "มะ" "นาว")) ;
-- Beach = mkPlace (placeN (R.thword "หาด")) ;

-- ItsRaining = mkCl (mkVP L.rain_V0) ;
-- ItsCold = mkCl (mkVP L.cold_A) ;
-- ItsWarm = mkCl (mkVP L.warm_A) ;
-- ItsWindy = mkCl (mkVP (P.mkA (R.thword "ลม" "จัด"))) ;
-- SunShine = mkCl (mkNP the_Det L.sun_N) (mkVP (R.regV (R.thword "ฉาย" "แสง"))) ;

-- Smoke = mkVP (P.mkV (R.thword "สูบ" "บุ" "รี")) ;

-- ADoctor = mkProfession (P.personN "หมอ") ;
-- AProfessor = mkProfession (P.personN (R.thword "อา" "จารย์")) ;
-- ALawyer = mkProfession (P.personN (R.thword "มัก" "กฎ" "หมาย")) ;
-- AEngineer = mkProfession (P.personN (R.thword "วิ" "ศวกร")) ;
-- ATeacher = mkProfession (P.personN "ครู") ;
-- ACook = mkProfession (P.personN (R.thword "ภัก" "ษกาน")) ;
-- AStudent = mkProfession (P.personN (R.thword "นัก" "ศึก" "ษา")) ;
-- ABusinessman = mkProfession (P.personN (R.thword "ฝู้" "ประ" "กอบ" "การ")) ;

-- oper
-- mkProfession : N -> NPPerson -> Cl = \n,p -> mkCl p.name n ;
--}

}
