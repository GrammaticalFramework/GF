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
Warm = (mkA "热") ; -- L.warm_A ;

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
Parking = mkPlace (mkN "停车场") ;
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

Dollar = mkCN (mkN "美元") ;
DanishCrown = mkCN (mkN "丹麦克朗") ;
Euro =  mkCN (mkN "欧元") ;
Lei =  mkCN (mkN "列弗") ;
Leva =  mkCN (mkN "列伊") ;
Pound =  mkCN (mkN "英镑") ;
Rouble =  mkCN (mkN "卢布") ;
SwedishCrown =  mkCN (mkN "瑞典克朗") ;
Zloty =  mkCN (mkN "兹罗提") ;
NorwegianCrown = mkCN (mkN "挪威克朗") ;

-- Nationalities
Belgian = mkA ( "比利时") ;
Belgium = mkNP (mkPN "比利时" ) ; 
Bulgarian = mkNat "保加利亚语" "保加利亚" ;
Catalan = mkNat "加泰罗尼亚语" "加泰罗尼亚" ;
Danish = mkNat "丹麦语" "丹麦" ;
Dutch = mkNat  "荷兰语" "荷兰" ;
English = mkNat "英语" "英国" ;
Finnish = mkNat "芬兰语" "芬兰" ;
Flemish = mkNP (mkPN "佛兰德语") ;
French = mkNat "法语"  "法国"  ;
German = mkNat "德语" "德国"  ;
Italian = mkNat "意大利语" "意大利" ;
Norwegian = mkNat "挪威语" "挪威";
Polish = mkNat "波兰语" "波兰" ;
Romanian = mkNat "罗马尼亚语" "罗马尼亚" ;
Russian = mkNat "俄语" "俄罗斯" ;
Spanish = mkNat "西班牙语" "西班牙" ;
Swedish = mkNat "瑞典语" "瑞典" ;
Chinese = mkNat "汉语" "中国" ;

-- Means of transportation

Bike = mkTransport L.bike_N (mkV "骑") ;
Bus = mkTransport (mkN "公共汽车" ) (mkV "乘") ;
Car = mkTransport L.car_N (mkV "开") ;
Ferry = mkTransport (mkN "渡船") (mkV "乘") ;
Plane = mkTransport L.airplane_N (mkV "坐") ;
Subway = mkTransport (mkN "地铁") (mkV "坐") ;
Taxi = mkTransport (mkN "出租车") (mkV "乘") ;
Train = mkTransport L.train_N  (mkV "乘") ;
Tram = mkTransport (mkN "电车") (mkV "乘") ;

ByFoot = P.mkAdv ("步行") ;

-- Actions: the predication patterns are very often language-dependent.
 

AHasAge p nu = mkCl (lin NP {s = p.name.s ++ nu.s}) (mkV "岁") ; ----
AHasChildren p num = mkCl p.name have_V2 (mkNP num L.child_N) ;
AHasRoom p num = mkCl p.name have_V2
(mkNP (mkNP a_Det (mkN "房间" ) ) (SyntaxChi.mkAdv for_gei_Prep (mkNP num (L.person_N ) ))) ;
AHasTable p num = mkCl p.name have_V2
(mkNP (mkNP a_Det L.table_N ) (SyntaxChi.mkAdv for_gei_Prep (mkNP num (L.person_N ) ))) ;
AHasName p name = mkCl p.name (mkV2 "叫") name ;
-- AHungry p = mkCl p.name (mkA "饿") ;
AHungry p = mkCl p.name (mkV "饿了") ;
-- AIll p = mkCl p.name (mkA "生病" ) ;
AIll p = mkCl p.name (mkV "生病了") ; 
AKnow p = mkCl p.name <lin V L.know_V2 : V> ;
ALike p item = mkCl p.name (L.like_V2 ) item ;
ALive p co = mkCl p.name (mkV2 (mkV "住")) co ;
ALove p q = mkCl p.name L.love_V2 q.name ;
AMarried p = mkCl p.name (mkA "已婚") ;
AReady p = mkCl p.name L.ready_A ;
-- AReady p = mkCl p.name (mkV "准备好了") ;
AScared p = mkCl p.name (mkA "惊慌") ;
ASpeak p lang = mkCl p.name L.speak_V2 lang ;
-- AThirsty p = mkCl p.name (mkA "渴") ;
AThirsty p = mkCl p.name (mkV "渴了") ;
-- ATired p = mkCl p.name (mkA "累") ;
ATired p = mkCl p.name (lin V (mkV "累了")) ;
AUnderstand p = mkCl p.name (lin V (mkV "理解" ) ) ;
AWant p obj = mkCl p.name (mkV2 "要") obj ;
AWantGo p place = mkCl p.name want_VV  (mkVP  L.go_V place.name) ;

-- LangNat l = l.lang  ;  -- ++  "语" ;  
-- miscellaneous

 QWhatName p = lin QS {s = \\_ => p.name.s ++ R.word "贵姓"} ; ---
 QWhatAge p = lin QS {s = \\_ => p.name.s ++ R.word "几岁"} | lin QS {s = \\_ => p.name.s ++ R.word "多大"} ; ---
 HowMuchCost item = lin QS {s = \\_ => item.s ++ R.word "是多少钱"} ;
ItCost item price = mkCl item (mkV2 "是") price ;

PropOpen p = mkCl p.name (mkA "开放" ) ;
PropClosed p = mkCl p.name  closed_A ;
PropOpenDate p d = mkCl p.name (mkVP (mkVP (mkA "开放" ) ) d) ;
PropClosedDate p d = mkCl p.name (mkVP (mkVP closed_A) d) ;
PropOpenDay p d = mkCl p.name (mkVP (mkVP (mkA "开放" ) ) d.habitual) ;
PropClosedDay p d = mkCl p.name (mkVP (mkVP closed_A) d.habitual) ;



-- PropCit c  =  lin A { s = c.s ; lock_A = <>; monoSyl = True }  ;

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

SuperlPlace sup p =  placeNP sup p  ;


-- transports

HowFar place = lin QS {s = \\_ => place.name.s ++ R.word "有多远"} ;




HowFarFrom x y = lin QS {s = \\_ => "从" ++ x.name.s ++ "到" ++ y.name.s ++ R.word "有多远"} ; ----

-- HowFarFromBy x y t =
-- mkQS (mkQCl howFar.how (mkCl (mkNP y.name howFar.far)
-- (lin AP (R.thbind from_Prep (mkNP x.name t))))) ;
-- mkQS (mkQCl howFar.how (mkCl (mkNP y.name howFar.far)
-- (SyntaxChi.mkAdv from_Prep (mkNP x.name t)))) ;



HowFarBy y t = lin QS {s = \\_ =>  t.s ++ "到" ++  y.name.s ++ R.word "有多远" } ; 


WhichTranspPlace trans place =
   mkQS (mkQCl (mkIP which_IDet trans.name)(mkVP (mkV2 "去") place.name)) ; 


IsTranspPlace trans place =  
   mkQS (mkQCl (mkCl (R.mkNP  ( L.go_V.s ++ place.name.s ++ "的" ++ trans.name.s) ))) ;



-- auxiliaries

oper

mkNat : Str -> Str -> NPNationality = \lang, co -> mkNPNationality (mkNP (mkPN lang)) (mkNP (mkPN co)) (mkA co) ;

mkDay : Str -> {name : NP ; point : SyntaxChi.Adv ; habitual : SyntaxChi.Adv} = \d ->
let day = mkNP (mkPN d) in
mkNPDay day (SyntaxChi.mkAdv noPrep day)
(SyntaxChi.mkAdv noPrep (mkNP (mkCN (mkN d)))) ;

mkPlace : N -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p ->
mkCNPlace (mkCN p) at_Prep noPrep ;

placeN : Str -> N = \s -> mkN s "间" ;

closed_A = P.mkA "关闭" ;
closed_or_not_A = P.mkA "不是关闭" ;

xOf : N -> NPPerson -> NPPerson = \f,p ->
{name = mkNP the_Det (mkCN f (SyntaxChi.mkAdv possess_Prep p.name)) ;
isPron = False ; poss = the_Quant} ; ---- poss not used

by_Prep = mkPrep "乘" [] mannerAdvType ;

mkTransport : N -> V -> {name : CN ; by : SyntaxChi.Adv ; way : V } = \n,m -> {
name = mkCN n ;
-- by = SyntaxChi.mkAdv by8means_Prep (mkNP n);
by = SyntaxChi.mkAdv by_Prep (mkNP n) ; 
way = m;
} ;

mkSuperl : A -> Det = \a -> SyntaxChi.mkDet the_Art ({s = ResChi.superlative_s ++ a.s ++ R.word "的那"}) ;  --  (SyntaxChi.mkOrd a) ;

-- mkCurrency : Str -> CN = \s -> mkCN (mkN [] s) ; ---- just a classifier


at_Prep = (mkPrep "在" ) ;
noPrep = mkPrep [] ;
for_gei_Prep = mkPrep "给" ;
--------------------------------------------------
-- New 30/11/2011 AR
--------------------------------------------------

lin
Thai = mkNat "泰国" "泰语" ;
Baht = mkCN (mkN "泰铢") ;

Rice = mkCN (mkN ("米饭")) ;
Pork = mkCN (mkN ("猪肉")) ;
Beef = mkCN (mkN ("牛肉")) ;
Egg = mkCN L.egg_N ;
Noodles = mkCN (mkN "面条") ;
Shrimps = mkCN (mkN "虾") ;
Chili = mkCN (mkN "辣椒") ;
Garlic = mkCN (mkN  "大蒜") ;
Durian = mkCN (mkN "榴莲") ;
Mango = mkCN (mkN  "芒果") ;
Pineapple = mkCN (mkN  "菠萝") ;
Coke = mkCN (mkN ("可乐")) ;
IceCream = mkCN (mkN  "冰激凌") ;
Salad = mkCN (mkN "色拉") ;
OrangeJuice = mkCN (mkN  "橙汁") ;
Lemonade = mkCN (mkN "柠檬汁") ;
Beach = mkPlace (placeN  "海滩") ;

ItsRaining = mkCl (mkVP L.rain_V0) ;
ItsCold = mkCl (mkVP L.cold_A) ;
ItsWarm = mkCl (mkVP L.warm_A) ;
ItsWindy = mkCl (mkVP (P.mkA ("有风"))) ;
SunShine = mkCl (mkNP the_Det L.sun_N) (mkA "很大") ;

Smoke = mkVP (P.mkV ( "吸烟" )) ;

ADoctor = mkProfession (mkN "医生") ;
AProfessor = mkProfession (mkN  "教授") ;
ALawyer = mkProfession (mkN "律师") ;
AEngineer = mkProfession (mkN "工程师") ;
ATeacher = mkProfession (mkN "教师") ;
ACook = mkProfession (mkN "厨师") ;
AStudent = mkProfession (mkN "学生") ;
ABusinessman = mkProfession (mkN "商人") ;

oper
  mkProfession : N -> NPPerson -> Cl = \n,p -> mkCl p.name n ;


}
