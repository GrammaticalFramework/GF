--# -path=.:../abstract

concrete ConstructionTha of Construction = CatTha ** 
  open SyntaxTha, ParadigmsTha, (L = LexiconTha), (G = GrammarTha), (R = ResTha), Prelude in {
flags coding=utf8 ;


lin
  hungry_VP = mkVP (mkA (R.thword "หิว" "ข้าว")) ;
  thirsty_VP = mkVP (mkA (R.thword "กระ" "หาย" "น้ำ")) ;
  tired_VP = mkVP (mkA "เหนื่อย") ;
  scared_VP = mkVP (mkA "กลัว") ;
  ill_VP = mkVP (mkA (R.thword "เจ็บ" "ปวย")) ;
  ready_VP = mkVP L.ready_A ;

  has_age_VP card = mkVP (mkNP (mkNP card L.year_N) (ParadigmsTha.mkAdv (R.thword "อา" "ยุ"))) ;

  have_name_Cl x y = mkCl x (mkV2 "ชื่อ") y ;
  married_Cl x y = mkCl x (mkAP L.married_A2 y) ;

  what_name_QCl x = mkQCl whatSg_IP x (mkV2 "ชื่อ") ;
  how_old_QCl x = mkQCl (mkIComp how8much_IAdv) (mkNP x (ParadigmsTha.mkAdv (R.thword "อา" "ยุ"))) ;
  how_far_QCl x = mkQCl (lin IComp (ss ("ไกล" + "เท่า" + "ไร"))) (lin NP x) ;

-- some more things
----  weather_adjCl ap = mkCl (mkVP (lin AP ap)) ;
   
----  is_right_VP = mkVP (ParadigmsTha.mkA "对") ; 
----  is_wrong_VP = mkVP (ParadigmsTha.mkV "错") ; 

----  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ; ----

lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
lin
  weekdayPunctualAdv w = SyntaxTha.mkAdv (mkPrep []) (mkNP w) ;
  weekdayHabitualAdv w = SyntaxTha.mkAdv (mkPrep []) (mkNP a_Quant plNum (mkCN w)) ;
----  weekdayNextAdv w = lin Adv {s = "下" ++ w.s ; advType = timeAdvType} ;
----  weekdayLastAdv w = lin Adv {s = "上" ++ w.s ; advType = timeAdvType} ;
{-
  monthAdv m = lin Adv {s = m.s ; advType = timeAdvType} ;
  yearAdv y = lin Adv {s = y.s ++ "年" ; advType = timeAdvType} ;
  dayMonthAdv d m = lin Adv {s = m.s ++ d.s ++ "日" ; advType = timeAdvType} ;
  monthYearAdv m y = lin Adv {s = y.s ++ "年" ++ m.s ; advType = timeAdvType} ;
  dayMonthYearAdv d m y = lin Adv {s = y.s ++ "年"  ++ m.s ++ d.s ++ "日" ; advType = timeAdvType} ;

  intYear i = lin NP i ;
  intMonthday i = lin NP i ;
-}

lincat Language = CN ;

---- lin InLanguage l = SyntaxTha.mkAdv (mkPrep "在") (mkNP l) ;

oper mkLanguage : Str -> CN = \s -> mkCN (mkA s) L.language_N ;

lin
  weekdayN w = w ;
  monthN m = m ;

  weekdayPN w = ss w.s ;
  monthPN m = ss m.s ;

  languageNP l = mkNP l ;
  languageCN l = mkCN l ;

    monday_Weekday = mkN (R.thword "วัน" "จั" "นท" "ร์") ;
    tuesday_Weekday = mkN (R.thword "วัน" "อัง" "คาร") ;
    wednesday_Weekday = mkN (R.thword "วัน" "พุธ") ;
    thursday_Weekday = mkN (R.thword "วัน" "พฤ" "หัส" "บดี") ;
    friday_Weekday = mkN (R.thword "วัน" "ศุกร์") ;
    saturday_Weekday = mkN (R.thword "วัน" "เสาร์") ;
    sunday_Weekday = mkN (R.thword "วัน" "อา" "ทิตย์") ;


{-
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
-}


----lin afrikaans_Language = mkLanguage "南非語" ;
----lin amharic_Language = mkLanguage "阿姆哈拉语" ;
----lin arabic_Language = mkLanguage "阿拉伯语" ;
lin bulgarian_Language = mkLanguage (R.thword "บัล" "แก" "เรียน") ;
lin catalan_Language = mkLanguage (R.thword "คะ" "ตะ" "ลัน") ;
--lin chinese_Language = mkLanguage 
lin danish_Language = mkLanguage (R.thword "เดน" "นิช") ;
lin dutch_Language = mkLanguage (R.thword "ดัทช์") ;
lin english_Language = mkLanguage (R.thword "อัง" "กฤษ") ;
--lin estonian_Language = mkLanguage "Estonian" ;
lin finnish_Language = mkLanguage (R.thword "ฟิน" "นิช") ;
lin french_Language = mkLanguage (R.thword "ฝรั่ง" "เศส") ; 
lin german_Language = mkLanguage (R.thword "เยอร" "มัน") ;
--lin greek_Language = mkLanguage "Greek" ;
--lin hebrew_Language = mkLanguage "Hebrew" ;
--lin hindi_Language = mkLanguage "印地语" ;
--lin japanese_Language = mkLanguage "日语" ;
lin italian_Language = mkLanguage (R.thword "อิ" "ตา" "เลียน") ;
--lin latin_Language = mkLanguage "Latin" ;
--lin latvian_Language = mkLanguage "Latvian" ;
--lin maltese_Language = mkLanguage "Maltese" ;
--lin nepali_Language = mkLanguage "Nepali" ;
--lin norwegian_Language = mkLanguage "Norwegian" ;
--lin persian_Language = mkLanguage "Persian" ;
--lin polish_Language = mkLanguage "Polish" ;
--lin punjabi_Language = mkLanguage "Punjabi" ;
--lin romanian_Language = mkLanguage "罗马尼亚" ;
lin russian_Language = mkLanguage (R.thword "รัส" "เซียน") ;
--lin sindhi_Language = mkLanguage "Sindhi" ;
lin spanish_Language = mkLanguage (R.thword "สแปน" "นิช") ;
--lin swahili_Language = mkLanguage "Swahili" ;
lin swedish_Language = mkLanguage (R.thword "สวี" "ดิช") ;
lin thai_Language = mkLanguage "ไทย" ;
--lin turkish_Language = mkLanguage "Turkish" ;
--lin urdu_Language = mkLanguage "Urdu" ;

}
