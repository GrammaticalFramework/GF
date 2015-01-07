--2 Implementations of Words, with Jpnlish as example

concrete WordsJpn of Words = SentencesJpn ** 
    open 
      SyntaxJpn, 
      ParadigmsJpn, 
      (L = LexiconJpn), 
      (P = ParadigmsJpn),
      (R = ResJpn), 
--      IrregJpn, 
      ExtraJpn, 
      Prelude in {

flags coding = utf8 ;

  lin

-- Kinds; many of them are in the resource lexicon, others can be built by $mkN$.

    Apple = mkCN L.apple_N ;
    Beer = mkCN L.beer_N ;
    Bread = mkCN L.bread_N ;
    Cheese = mkCN (mkN "チーズ" R.Inanim) ;   -- "chiizu" 
    Chicken = mkCN (mkN "鶏" R.Inanim "切れ" False) ;  -- "tori" "kire"
    Coffee = mkCN (mkN "コーヒー" R.Inanim "杯" False) ;  -- "koohi" "hai" (cups of)
    Fish = mkCN L.fish_N ;
    Meat = mkCN (mkN "肉" R.Inanim "切れ" False) ;  -- "niku" "kire"
    Milk = mkCN L.milk_N ;
    Pizza = mkCN (mkN "ピザ" R.Inanim "枚" False) ;  -- "piza" "mai" (smth flat)
    Salt = mkCN L.salt_N ;
    Tea = mkCN (mkN "お茶" R.Inanim "杯" False) ;  -- "ocha" "hai" (cups of)
    Water = mkCN L.water_N ;
    Wine = mkCN L.wine_N ;

-- Properties; many of them are in the resource lexicon, others can be built by $mkA$.

    Bad = L.bad_A ;
    Boring = mkA "つまらない" ;
    Cheap = mkA "安い" ;  -- "yasui"
    Cold = L.cold_A ;
    Delicious = mkA "美味しい" ;  -- "oishii"
    Expensive = mkA "高い" ;  -- "takai"
    Fresh = mkA "新鮮な" ;  -- "shinsenna"
    Good = L.good_A ;
    Suspect = mkA "怪しい" ;  -- "ayashii"
    Warm = L.warm_A ;

-- Places require different prepositions to express location; in some languages 
-- also the directional preposition varies, but in English we use $to$, as
-- defined by $mkPlace$.

    Airport = mkPlace "空港" "で" ;  -- "kuukou" "de"
    AmusementPark = mkPlace "遊園地" "で" ;  -- "yuuenchi" "de"
    Bank = mkPlace "銀行" "で" ;  -- "ginkou" "de"
    Bar = mkPlace "バー" "で" ;  -- "baa" "de"
    Cafeteria = mkPlace "食堂" "で" ;  -- "shokudou" "de"
    Center = mkPlace "センター" "で" ;  -- "sentaa" "de"
    Cinema = mkPlace "映画館" "で" ;  -- "eigakan" "de"
    Church = mkPlace "教会" "で" ;  -- "kyoukai" "de"
    Disco = mkPlace "ディスコ" "で" ;  -- "disuko" "de"
    Hospital = mkPlace "病院" "で" ;  -- "byouin" "de"
    Hotel = mkPlace "ホテル" "で" ;  -- "hoteru" "de"
    Museum = mkPlace "博物館" "で" ;  -- "hakubutsukan" "de"
    Park = mkPlace "公園" "で" ;  -- "kouen" "de"
    Parking = mkPlace "駐車場" "で" ;  -- "chuushajou" "de"
    Pharmacy = mkPlace "薬局" "で" ;  -- "kyoukai" "de"
    PostOffice = mkPlace "郵便局" "で" ;  -- "yuubinkyoku" "de"
    Pub = mkPlace "パブ" "で" ;  -- "pabu" "de"
    Restaurant = mkPlace "レストラン" "で" ;  -- "resutoran" "de"
    School = mkPlace "学校" "で" ;  -- "gakkou" "de"
    Shop = mkPlace "商店" "で" ;  -- "mise" "de"
    Station = mkPlace "駅" "で" ;  -- "eki" "de"
    Supermarket = mkPlace "スーパー" "で" ;  -- "suupaa" "de"
    Theatre = mkPlace "劇場" "で" ;  -- "gekijou" "de"
    Toilet = mkPlace "お手洗い" "で" ;  -- "otearai" "de"
    University = mkPlace "大学" "で" ;  -- "daigaku" "de"
    Zoo = mkPlace "動物園" "で" ;  -- "doubutsuen" "de"
   
    CitRestaurant cit = mkCNPlace (mkCN cit.prop (mkN "レストラン")) in_Prep to_Prep ;  -- "resutoran"


-- Currencies; $crown$ is ambiguous between Danish and Swedish crowns.

    DanishCrown = mkCur "デンマーク・クローネ" | mkCur "クローナ" ;  -- "denmaaku kuroune"
    Dollar = mkCur "ドル" ;  -- "doru"
    Euro = mkCur "ユーロ" ; -- "yuuro"
    Lei = mkCur "レウ" ;  -- "reu"
    Leva = mkCur "レフ" ;  -- "refu"
    NorwegianCrown = mkCur "ノルウェー・クローネ" | mkCur "クローナ" ;  -- "noruwee kuroune"
    Pound = mkCur "ポンド" ;  -- "pondo"
    Rouble = mkCur "ルーブル" ;  -- "ruuburu"
    Rupee = mkCur "ルピ" ;  -- "rupii"
    SwedishCrown = mkCur "スウェーデン・クローナ" | mkCur "クローナ" ;  -- "Suu~eeden kurouna"
    Zloty = mkCur "ズロティ" ;  -- "zuroti"
    Yuan = mkCur "元" ;  -- "gen"

-- Nationalities

    Belgian = {prop = mkA "ベルギー の" ; citizenship = mkNP (mkN "ベルギー 人")} ;  -- "berugii no"
    Belgium = mkNP (mkPN "ベルギー") ;  -- "berugii"
    Bulgarian = mkNat "ブルガリア" ;  -- "burugaria"
    Catalan = mkNat "カタロニア" ;  -- "kataronia"
    Chinese = mkNat"中国" ;  -- "chuugoku"
    Danish = mkNat "デンマーク" ;  -- "denmaaku"
    Dutch =  mkNat "オランダ" ;  -- "oranda"
    English = mkNPNationality (mkNP (mkPN "英語")) (mkNP (mkPN "イギリス")) -- "eigo"
                              (mkA "イギリスの") (mkNP (mkPN "イギリス人")) ;
    Finnish = mkNat "フィンランド" ;  -- "finrando"
    Flemish = mkNP (mkPN "フラマン 語") ;  -- "furaman go"
    French = mkNat "フランス" ;  -- "furansu" 
    German = mkNat "ドイツ" ;  -- "doitsu"
    Hindi = mkNP (mkPN "ヒンディー語") ;  -- "hindii"
    India = mkNP (mkPN "インド") ;  -- "indo"
    Indian = {prop = mkA "インドの" ; citizenship = mkNP (mkN "インド人")} ;  -- "indo no"
    Italian = mkNat "イタリア" ;  -- "itaria"
    Norwegian = mkNat "ノルウェー" ;  -- "noruwee"
    Polish = mkNat "ポーランド" ;  -- "porando"
    Romanian = mkNat "ルーマニア" ;  -- "ruumania"
    Russian = mkNat "ロシア" ;  -- "roshia"
    Spanish = mkNat "スペイン" ;  -- "supein"
    Swedish = mkNat "スウェーデン" ;  -- "suweeden"

-- Means of transportation 

   Bike = mkTransport L.bike_N ;
   Bus = mkTransport (mkN "バス") ;  -- "basu"
   Car = mkTransport L.car_N ;
   Ferry = mkTransport (mkN "フェリー") ;  -- "ferii"
   Plane = mkTransport L.airplane_N ;
   Subway = mkTransport (mkN "地下鉄") ;  -- "chikatetsu"
   Taxi = mkTransport (mkN "タクシー") ;  -- "takushii"
   Train = mkTransport (mkN "電車") ;  -- "densha"
   Tram = mkTransport (mkN "市電") ;  -- "shiden"

   ByFoot = P.mkAdv "徒歩で" ;  -- "toho de"

-- Actions: the predication patterns are very often language-dependent.

    AHasAge p num = mkCl p.name (mkNP num (mkNounWOCounter "歳")) ;
    AHasChildren p num = mkCl p.name (mkV2 "いる" "が" R.Gr2) (mkNP num L.child_N) ;
    AHasName p name = mkCl (nameOf p) name ;
    AHasRoom p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "部屋")) (SyntaxJpn.mkAdv for_Prep (mkNP num (mkNounWOCounter "人")))) ; -- "heya"
    AHasTable p num = mkCl p.name have_V2 
      (mkNP (mkNP a_Det (mkN "テーブル")) (SyntaxJpn.mkAdv for_Prep (mkNP num (mkNounWOCounter "人")))) ;
    AHungry p = mkCl p.name (P.mkV "お腹が空いている" R.Gr1) ;  -- "onaka ga suite iru"
    AIll p = mkCl p.name (mkA "病気の") ;
    AKnow p = mkCl p.name mkKnow ;
    ALike p item = mkCl p.name (mkA2 "好きな" "が") item ; 
    ALive p co = mkCl p.name (mkVP (mkVP (mkV "住んでいる" R.Gr2)) (SyntaxJpn.mkAdv in_Prep co)) ; -- "sundeiru"
    ALove p q = mkCl p.name (mkV2 "愛している" "を" R.Gr2) q.name ;  -- "aishiteiru"
    AMarried p = mkCl p.name (mkA "結婚している" "既婚の") ;  -- "kekkonshiteiru" "kikonno"
    AReady p = mkCl p.name L.ready_A ;
    AScared p = mkCl p.name (mkA "怖い") ;
    ASpeak p lang = mkCl p.name L.speak_V2 lang ;
    AThirsty p = mkCl p.name (mkA "喉が乾いている" "渇した") ; 
                                      -- "nodo ga kawaiteiru" "kasshita"
    ATired p = mkCl p.name (mkA "疲れている" "疲れた") ; 
                                      -- "tsukareteiru" "tsukareta"
    AUnderstand p = case p.name.meaning of {
      R.SomeoneElse => mkCl p.name (v2toVP L.understand_V2) ;
      R.Me => mkCl p.name (mkV "分かる" R.Gr1) -- "wakaru"
    } ;
    AWant p obj = case (p.name).meaning of {
      R.Me => mkCl p.name (mkA2 "欲しい" "が") obj ;
      R.SomeoneElse => mkCl p.name (mkA2 "欲しがっている" "欲しい" "が") obj
    } ;
    AWantGo p place = mkCl p.name want_VV (mkVP (mkVP L.go_V) place.to) ;

-- miscellaneous

    QWhatName p = mkQS (mkQCl (mkIComp whatSg_IP) (nameOf p)) ;
    QWhatAge p = mkQS (mkQCl howOld_IAdv (mkCl p.name R.mkCopula)) ; 
    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item (mkV "かかる"))) ;
    ItCost item price = mkCl item (mkV2 "かかる" "" R.Gr1) price ;

    PropOpen p = mkCl p.name mkOpen ;
    PropClosed p = mkCl p.name mkClosed ;
    PropOpenDate p d = mkCl p.name (mkVP (mkVP mkOpen) d) ; 
    PropClosedDate p d = mkCl p.name (mkVP (mkVP mkClosed) d) ; 
    PropOpenDay p d = mkCl p.name (mkVP (mkVP mkOpen) d.habitual) ; 
    PropClosedDay p d = mkCl p.name (mkVP (mkVP mkClosed) d.habitual) ; 

-- Building phrases from strings is complicated: the solution is to use
-- mkText : Text -> Text -> Text ;

    PSeeYouDate d = mkText (mkPhrase (mkUtt d)) (lin Text (ss ("会いましょう"))) ;  -- "aimashou" 
    PSeeYouPlace p = mkText (mkPhrase (mkUtt p.at)) (lin Text (ss ("会いましょう"))) ;  -- "aimashou" 
    PSeeYouPlaceDate p d = 
      mkText (mkText (mkPhrase (mkUtt p.at)) (mkPhrase (mkUtt d))) 
             (lin Text (ss ("会いましょう"))) ; -- "aimashou" 

-- Relations are expressed as "my wife" or "my son's wife", as defined by $xOf$
-- below. Languages without productive genitives must use an equivalent of
-- "the wife of my son" for non-pronouns.

    Wife = xOf (mkN "妻" "奥さん" R.Anim "人" False "妻たち") ;  -- "tsuma" "okusan" 
    Husband = xOf (mkN "夫" "ご主人" R.Anim "人" False "夫たち") ; -- "otto" "goshujin"
    Son = xOf (mkN "息子" "息子さん" R.Anim "人" False "息子たち") ;  -- "musuko"
    Daughter = xOf (mkN "娘" "お嬢さん" R.Anim "人" False "娘たち") ;  -- "musume" "ojousan"
    Children = xOf L.child_N ;

-- week days

    Monday = mkDay "月曜日" ;  -- "getsuyoubi"
    Tuesday = mkDay "火曜日" ;  -- "kayoubi"
    Wednesday = mkDay "水曜日" ;  -- "suiyoubi"
    Thursday = mkDay "木曜日" ;  -- "mokuyoubi"
    Friday = mkDay "金曜日" ;  -- "kin'youbi"
    Saturday = mkDay "土曜日" ;  -- "doyoubi"
    Sunday = mkDay "日曜日" ;  -- "nichiyoubi"
 
    Tomorrow = P.mkAdv "明日" ;  -- "ashita"

-- modifiers of places

    TheBest = mkSuperl L.good_A ;
    TheClosest = mkSuperl L.near_A ; 
    TheCheapest = mkSuperl (mkA "安い") ;  -- "yasui"
    TheMostExpensive = mkSuperl (mkA "高い") ;  -- "takai"
    TheMostPopular = mkSuperl (mkA "盛んな") ;  -- "sakanna"
    TheWorst = mkSuperl L.bad_A ;

    SuperlPlace sup p = placeNP sup p ;


-- transports
    
    HowFar place = mkQS (mkQCl howFar_IAdv (mkCl place.name (mkA "遠い"))) ;
    HowFarFrom x y = 
      mkQS (mkQCl howFar_IAdv (mkCl (mkNP y.name (SyntaxJpn.mkAdv from_Prep x.name)) (mkA "遠い"))) ;
    HowFarFromBy x y t = 
      mkQS (mkQCl howFar_IAdv (mkCl 
        (mkNP y.name (SyntaxJpn.mkAdv from_Prep (mkNP x.name t))) (mkA "遠い"))) ;
    HowFarBy y t = mkQS (mkQCl howFar_IAdv (mkCl (mkNP y.name t) (mkA "遠い"))) ;

    WhichTranspPlace trans place = 
      mkQS (mkQCl (mkIP which_IDet trans.name) (mkVP (mkVP L.go_V) place.to)) ;

    IsTranspPlace trans place =
      mkQS (mkQCl (mkCl (mkCN trans.name place.to))) ;



-- auxiliaries

  oper

    mkNat : Str -> NPNationality = \co -> 
      mkNPNationality (mkNP (mkPN (co + "語"))) (mkNP (mkPN co)) 
                      (mkA (co + "の")) (mkNP (mkPN (co + "人"))) ; ---- mkA ...

    mkDay : Str -> {name : NP ; point : Adv ; habitual : Adv} = \d ->
      let day : NP = mkNP (mkPN d) in 
      mkNPDay day (SyntaxJpn.mkAdv in_Prep day) 
        (SyntaxJpn.mkAdv in_Prep (mkNP a_Quant plNum (mkCN (mkN d)))) ;
    
    mkCompoundPlace : Str -> Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \comp, p, i ->
     mkCNPlace (mkCN (P.mkN (comp + p))) (P.mkPrep i) to_Prep ;

    mkPlace : Str -> Str -> {name : CN ; at : Prep ; to : Prep; isPl : Bool} = \p,i -> 
      mkCNPlace (mkCN (mkN p)) (P.mkPrep i) to_Prep ;

   xOf : N -> NPPerson -> NPPerson = \f,p ->
     {name = mkNP the_Det (mkCN f (SyntaxJpn.mkAdv possess_Prep p.name)) ;
     isPron = False ; poss = the_Quant} ; ---- poss not used

    mkOpen : A = mkA "開いている" "開いた" ; -- "aiteiru"
    mkClosed : A = mkA "閉まっている" "閉まった" ; -- "shimatteiru"

    nameOf : NPPerson -> NP = \p -> (xOf (mkN "名前") p).name ;

    mkTransport : N -> {name : CN ; by : Adv} = \n -> {
      name = mkCN n ; 
      by = SyntaxJpn.mkAdv by8means_Prep (mkNP n)
      } ;

    mkSuperl : A -> Det = \a -> SyntaxJpn.mkDet the_Art (SyntaxJpn.mkOrd a) ;
    
    howFar_IAdv : IAdv = lin IAdv {s = \\st => "どのくらい" ; particle = "" ; wh8re = False} ;

    howOld_IAdv : IAdv = lin IAdv {s = \\st => "何歳" ; particle = "" ; wh8re = False} ; 
 
    mkCur : Str -> Currency = \c -> lin Currency (lin CN {
      s = \\n,st => c ;
      anim = R.Inanim ;
      counter = c ;
      counterReplace = True ;
      counterTsu, hasAttr = False ;
      object, prepositive = \\st => "" 
    } ) ;
    
    mkNounWOCounter : Str -> CN = \noun -> lin CN {
      s = \\n,st => noun ;
      anim = R.Inanim ;
      counter = noun ;
      counterReplace = True ;
      counterTsu, hasAttr = False ;
      object, prepositive = \\st => "" 
    } ; 

    mkKnow : V = lin V {
      s = table {
        R.Resp => table {
          (R.TPres|R.TFut) => table {
            R.Pos => "知っています" ;
            R.Neg => "知りません"
            } ;
          R.TPast => table {
            R.Pos => "知っていました" ;
            R.Neg => "知りませんでした"
            }
          } ;
        R.Plain => table {
          (R.TPres|R.TFut) => table {
            R.Pos => "知っている" ;
            R.Neg => "知らない"
            } ;
          R.TPast => table {
            R.Pos => "知っていた" ;
            R.Neg => "知らなかった"
            }
          }
        } ;
      te = table {
        R.Pos => "知って" ;
        R.Neg => "知らないで" 
        } ;
      a_stem = "知ら" ;
      i_stem = "知り" ;
      ba = table {
        R.Pos => "知れば" ;
        R.Neg => "知らなければ"
        } ;
      needSubject = True
      } ;

--------------------------------------------------
-- New 30/11/2011 AR
--------------------------------------------------

  lin
    Thai = mkNat "タイ" ;  -- "tai"
    Baht = mkCur "バーツ" ;  -- "baatsu"

    Rice = mkCN (mkN "ご飯") ;  -- "gohan"
    Pork = mkCN (mkN "豚肉") ;  -- "butaniku"
    Beef = mkCN (mkN "牛肉") ;  -- "gyuuniku"
    Egg = mkCN L.egg_N ;
    Noodles = mkCN (mkN "ヌードル") ;  -- "nuudoru"
    Shrimps = mkCN (mkN "海老") ;  -- "ebi"
    Chili = mkCN (mkN "チリ") ;  -- "chiri"
    Garlic = mkCN (mkN "大蒜") ;  -- "ninniku"
    Durian = mkCN (mkN "ドリアン") ;  -- "dorian"
    Mango = mkCN (mkN "マンゴ") ;  -- "mango"
    Pineapple = mkCN (mkN "パイナップル") ;  -- "painappuru"
    Coke = mkCN (mkN "コーク") ;  -- "kooku"
    IceCream = mkCN (mkN "アイスクリーム") ;  -- "aisukuriimu"
    Salad = mkCN (mkN "サラダ") ;  -- "sarada"
    OrangeJuice = mkCN (mkN "オレンジジュース") ;  -- "orenjijuusu"
    Lemonade = mkCN (mkN "レモネード") ;  -- "remoneedo"

    Beach = mkPlace "beach" "on" ;

    ItsRaining = mkCl (mkVP R.mkRain) ; 
    ItsCold = mkCl (mkVP L.cold_A) ;
    ItsWarm = mkCl (mkVP L.warm_A) ;
    ItsWindy = mkCl (mkVP (P.mkA "風が強い")) ;
    SunShine = mkCl (mkNP L.sun_N) (mkVP (mkV "輝いている" R.Gr2)) ; 
      -- "taiyou wa kagayaite iru"

    Smoke = mkVP (P.mkV "煙草を吸う" R.Gr1) ;  -- "tabako o suu"

    ADoctor = mkProfession (mkN "医者") ;  -- "isha"
    AProfessor = mkProfession (mkN "教授") ;  -- "kyouju"
    ALawyer = mkProfession (mkN "弁護士") ;  -- "bengoshi"
    AEngineer =  mkProfession (mkN "技術者") ;  -- "gijutsusha"
    ATeacher = mkProfession (mkN "先生") ;  -- "sensei"
    ACook = mkProfession (mkN "料理人") ;  -- "ryourinin"
    AStudent = mkProfession (mkN "学生") ;  -- "gakusei"
    ABusinessman = mkProfession (mkN "実業家") ;  -- "jitsugyouka"

  oper
    mkProfession : N -> NPPerson -> Cl = \n,p -> mkCl p.name n ;
}
