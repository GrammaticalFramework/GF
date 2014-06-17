concrete NamesChi of Names = ConstructionChi ** 

  open ParadigmsChi in {

oper mkLanguage : Str -> PN = \s -> mkPN s ;

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
lin chinese_Language = mkLanguage "中文" ;
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