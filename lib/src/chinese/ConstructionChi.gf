--# -path=.:../abstract

concrete ConstructionChi of Construction = CatChi ** 
  open SyntaxChi, ParadigmsChi, (L = LexiconChi), (E = ExtraChi), (G = GrammarChi), (R = ResChi), Prelude in {
flags coding=utf8 ;


lin
  hungry_VP = mkVP (mkV "饿") ;
  thirsty_VP = mkVP (mkA "渴") ;
  tired_VP = mkVP (mkV "累了") ;
  scared_VP = mkVP (mkA "惊慌") ;
  ill_VP = mkVP (mkV "生病了") ;
  ready_VP = mkVP L.ready_A ;

  has_age_VP card = mkVP (lin AdV card) (mkVP (mkV "岁")) ;

  have_name_Cl x y = mkCl (lin NP x) (mkV2 (mkV "叫")) (lin NP y) ;
  married_Cl x y = mkCl (lin NP x) L.married_A2 (lin NP y) ;

  what_name_QCl x = mkQCl whatSg_IP (mkClSlash (lin NP x) (mkV2 (mkV "叫"))) ;
  how_old_QCl x = {s = \\_,p,a => x.s ++ R.word "几岁"} | {s = \\_,p,a => x.s ++ R.word "多大"} ; ----
----  how_far_QCl x = mkQCl (E.IAdvAdv (ss "far")) (lin NP x) ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (lin AP ap)) ;
   
  is_right_VP = mkVP (ParadigmsChi.mkA "对") ; 
  is_wrong_VP = mkVP (ParadigmsChi.mkA "错") ; 

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ; ----

lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
lin
  weekdayPunctualAdv w = lin Adv {s = w.s ; advType = timeAdvType ; hasDe = False} ;
  weekdayHabitualAdv w = lin Adv {s = w.s ; advType = timeAdvType ; hasDe = False} ;
  weekdayNextAdv w = lin Adv {s = "下" ++ w.s ; advType = timeAdvType ; hasDe = False} ;
  weekdayLastAdv w = lin Adv {s = "上" ++ w.s ; advType = timeAdvType ; hasDe = False} ;

  monthAdv m = lin Adv {s = m.s ; advType = timeAdvType ; hasDe = False} ;
  yearAdv y = lin Adv {s = y.s ++ "年" ; advType = timeAdvType ; hasDe = False} ;
  dayMonthAdv d m = lin Adv {s = m.s ++ d.s ++ "日" ; advType = timeAdvType ; hasDe = False} ;
  monthYearAdv m y = lin Adv {s = y.s ++ "年" ++ m.s ; advType = timeAdvType ; hasDe = False} ;
  dayMonthYearAdv d m y = lin Adv {s = y.s ++ "年"  ++ m.s ++ d.s ++ "日" ; advType = timeAdvType ; hasDe = False} ;

  intYear i = lin NP i ;
  intMonthday i = lin NP i ;

lincat Language = N ;

lin InLanguage l = SyntaxChi.mkAdv (mkPrep "在") (mkNP l) ;

oper mkLanguage : Str -> N = \s -> mkN s ; ---- classifier?

lin
  weekdayN w = w ;
  monthN m = m ;

  weekdayPN w = ss w.s ;
  monthPN m = ss m.s ;

  languageNP l = mkNP l ;
  languageCN l = mkCN l ;

lin monday_Weekday = mkN "星期一" ;
lin tuesday_Weekday = mkN "星期二" ;
lin wednesday_Weekday = mkN "星期三" ;
lin thursday_Weekday = mkN "星期四" ;
lin friday_Weekday = mkN "星期五" ;
lin saturday_Weekday = mkN "星期六" ;
lin sunday_Weekday = mkN "星期日" ;

lin january_Month = mkN "一月" ; 
lin february_Month = mkN "二月" ; 
lin march_Month = mkN "三月" ; 
lin april_Month = mkN "四月" ;
lin may_Month = mkN "五月" ;
lin june_Month = mkN "六月" ;
lin july_Month = mkN "七月" ;
lin august_Month = mkN "八月t" ;
lin september_Month = mkN "九月" ;
lin october_Month = mkN "十月" ;
lin november_Month = mkN "十一月" ;
lin december_Month = mkN "十二月" ;

lin afrikaans_Language = mkLanguage "南非語" ;
lin amharic_Language = mkLanguage "阿姆哈拉语" ;
lin arabic_Language = mkLanguage "阿拉伯语" ;
lin bulgarian_Language = mkLanguage "保加利亚语" ;
--lin catalan_Language = mkLanguage "Catalan" ;
lin chinese_Language = mkLanguage "中文" | mkLanguage "汉语" ;
--lin danish_Language = mkLanguage "Danish" ;
lin dutch_Language = mkLanguage "荷蘭語" ;
lin english_Language = mkLanguage "英语" ;
--lin estonian_Language = mkLanguage "Estonian" ;
lin finnish_Language = mkLanguage "芬兰语" ;
lin french_Language = mkLanguage "法语" ;
lin german_Language = mkLanguage "德语" ;
--lin greek_Language = mkLanguage "Greek" ;
--lin hebrew_Language = mkLanguage "Hebrew" ;
lin hindi_Language = mkLanguage "印地语" ;
lin japanese_Language = mkLanguage "日语" ;
lin italian_Language = mkLanguage "意大利语" ;
--lin latin_Language = mkLanguage "Latin" ;
--lin latvian_Language = mkLanguage "Latvian" ;
--lin maltese_Language = mkLanguage "Maltese" ;
--lin nepali_Language = mkLanguage "Nepali" ;
--lin norwegian_Language = mkLanguage "Norwegian" ;
--lin persian_Language = mkLanguage "Persian" ;
--lin polish_Language = mkLanguage "Polish" ;
--lin punjabi_Language = mkLanguage "Punjabi" ;
--lin romanian_Language = mkLanguage "罗马尼亚" ;
lin russian_Language = mkLanguage "俄语" ;
--lin sindhi_Language = mkLanguage "Sindhi" ;
lin spanish_Language = mkLanguage "西班牙语" ;
--lin swahili_Language = mkLanguage "Swahili" ;
lin swedish_Language = mkLanguage "瑞典文" ;
--lin thai_Language = mkLanguage "Thai" ;
--lin turkish_Language = mkLanguage "Turkish" ;
--lin urdu_Language = mkLanguage "Urdu" ;


}
