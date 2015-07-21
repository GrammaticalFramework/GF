--# -path=.:../abstract

concrete ConstructionChi of Construction = CatChi ** 
  open SyntaxChi, ParadigmsChi, (L = LexiconChi), (E = ExtraChi), (G = GrammarChi), (R = ResChi), Prelude in {
flags coding=utf8 ;


lin
  hungry_VP = mkVP (mkV "è") ;
  thirsty_VP = mkVP (mkA "kě") ;
  has_age_VP card = mkVP (lin AdV card) (mkVP (mkV "suì")) ;

  have_name_Cl x y = mkCl (lin NP x) (mkV2 (mkV "jiaò")) (lin NP y) ;
  married_Cl x y = mkCl (lin NP x) L.married_A2 (lin NP y) ;

  what_name_QCl x = mkQCl whatSg_IP (mkClSlash (lin NP x) (mkV2 (mkV "jiaò"))) ;
  how_old_QCl x = {s = \\_,p,a => x.s ++ R.word "jīsuì"} | {s = \\_,p,a => x.s ++ R.word "duōdà"} ; ----
----  how_far_QCl x = mkQCl (E.IAdvAdv (ss "far")) (lin NP x) ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (lin AP ap)) ;
   
  is_right_VP = mkVP (ParadigmsChi.mkA "duì") ; 
  is_wrong_VP = mkVP (ParadigmsChi.mkV "cuò") ; 

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ; ----

lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
lin
  weekdayPunctualAdv w = lin Adv {s = w.s ; advType = timeAdvType} ;
  weekdayHabitualAdv w = lin Adv {s = w.s ; advType = timeAdvType} ;
  weekdayNextAdv w = lin Adv {s = "xià" ++ w.s ; advType = timeAdvType} ;
  weekdayLastAdv w = lin Adv {s = "shàng" ++ w.s ; advType = timeAdvType} ;

  monthAdv m = lin Adv {s = m.s ; advType = timeAdvType} ;
  yearAdv y = lin Adv {s = y.s ++ "nián" ; advType = timeAdvType} ;
  dayMonthAdv d m = lin Adv {s = m.s ++ d.s ++ "rì" ; advType = timeAdvType} ;
  monthYearAdv m y = lin Adv {s = y.s ++ "nián" ++ m.s ; advType = timeAdvType} ;
  dayMonthYearAdv d m y = lin Adv {s = y.s ++ "nián"  ++ m.s ++ d.s ++ "rì" ; advType = timeAdvType} ;

  intYear i = lin NP i ;
  intMonthday i = lin NP i ;

lincat Language = N ;

lin InLanguage l = SyntaxChi.mkAdv (mkPrep "zaì") (mkNP l) ;

oper mkLanguage : Str -> N = \s -> mkN s ; ---- classifier?

lin
  weekdayN w = w ;
  monthN m = m ;

  weekdayPN w = ss w.s ;
  monthPN m = ss m.s ;

  languageNP l = mkNP l ;
  languageCN l = mkCN l ;

lin monday_Weekday = mkN "xīngqīyī" ;
lin tuesday_Weekday = mkN "xīngqīèr" ;
lin wednesday_Weekday = mkN "xīngqīsān" ;
lin thursday_Weekday = mkN "xīngqīsì" ;
lin friday_Weekday = mkN "xīngqīwǔ" ;
lin saturday_Weekday = mkN "xīngqīliù" ;
lin sunday_Weekday = mkN "xīngqīrì" ;

lin january_Month = mkN "yīyuè" ; 
lin february_Month = mkN "èryuè" ; 
lin march_Month = mkN "sānyuè" ; 
lin april_Month = mkN "sìyuè" ;
lin may_Month = mkN "wǔyuè" ;
lin june_Month = mkN "liùyuè" ;
lin july_Month = mkN "qīyuè" ;
lin august_Month = mkN "bāyuèt" ;
lin september_Month = mkN "jiǔyuè" ;
lin october_Month = mkN "shíyuè" ;
lin november_Month = mkN "shíyīyuè" ;
lin december_Month = mkN "shíèryuè" ;

lin afrikaans_Language = mkLanguage "nánfeīyǔ" ;
lin amharic_Language = mkLanguage "āmǔhālāyǔ" ;
lin arabic_Language = mkLanguage "ālābóyǔ" ;
lin bulgarian_Language = mkLanguage "baǒjiālìyàyǔ" ;
--lin catalan_Language = mkLanguage "Catalan" ;
lin chinese_Language = mkLanguage "zhōngwén" | mkLanguage "hànyǔ" ;
--lin danish_Language = mkLanguage "Danish" ;
lin dutch_Language = mkLanguage "hélányǔ" ;
lin english_Language = mkLanguage "yīngyǔ" ;
--lin estonian_Language = mkLanguage "Estonian" ;
lin finnish_Language = mkLanguage "fēnlányǔ" ;
lin french_Language = mkLanguage "fǎyǔ" ;
lin german_Language = mkLanguage "déyǔ" ;
--lin greek_Language = mkLanguage "Greek" ;
--lin hebrew_Language = mkLanguage "Hebrew" ;
lin hindi_Language = mkLanguage "yìndeyǔ" ;
lin japanese_Language = mkLanguage "rìyǔ" ;
lin italian_Language = mkLanguage "yìdàlìyǔ" ;
--lin latin_Language = mkLanguage "Latin" ;
--lin latvian_Language = mkLanguage "Latvian" ;
--lin maltese_Language = mkLanguage "Maltese" ;
--lin nepali_Language = mkLanguage "Nepali" ;
--lin norwegian_Language = mkLanguage "Norwegian" ;
--lin persian_Language = mkLanguage "Persian" ;
--lin polish_Language = mkLanguage "Polish" ;
--lin punjabi_Language = mkLanguage "Punjabi" ;
--lin romanian_Language = mkLanguage "luōmǎníyà" ;
lin russian_Language = mkLanguage "éyǔ" ;
--lin sindhi_Language = mkLanguage "Sindhi" ;
lin spanish_Language = mkLanguage "xībānyáyǔ" ;
--lin swahili_Language = mkLanguage "Swahili" ;
lin swedish_Language = mkLanguage "ruìdiǎnwén" ;
--lin thai_Language = mkLanguage "Thai" ;
--lin turkish_Language = mkLanguage "Turkish" ;
--lin urdu_Language = mkLanguage "Urdu" ;


}
