--# -path=.:../chunk:../finnish/stemmed:../finnish:../api

concrete NamesFin of Names = ConstructionFin ** 

  open ParadigmsFin in {

oper mkLanguage : Str -> PN = \s -> mkPN s ;

oper mkWeekday : Str -> Weekday = \d -> 
      lin Weekday {
       noun = mkN d ; 
       habitual = case d of {
         _ + "i" => ParadigmsFin.mkAdv (d + "sin") ; -- tiistaisin
         _ => ParadigmsFin.mkAdv (d + "isin")  -- keskiviikkoisin
         }
      } ; 


lin monday_Weekday = mkWeekday "maanantai" ;
lin tuesday_Weekday = mkWeekday "tiistai" ;
lin wednesday_Weekday = mkWeekday "keskiviikko" ;
lin thursday_Weekday = mkWeekday "torstai" ;
lin friday_Weekday = mkWeekday "perjantai" ;
lin saturday_Weekday = mkWeekday"lauantai" ;
lin sunday_Weekday = mkWeekday "sunnuntai" ;

lin january_Month = mkN "tammikuu" ; 
lin february_Month = mkN "helmikuu" ; 
lin march_Month = mkN "maaliskuu" ; 
lin april_Month = mkN "huhtikuu" ;
lin may_Month = mkN "toukokuu" ;
lin june_Month = mkN "kesäkuu" ;
lin july_Month = mkN "heinäkuu" ;
lin august_Month = mkN "elokuu" ;
lin september_Month = mkN "syyskuu" ;
lin october_Month = mkN "lokakuu" ;
lin november_Month = mkN "marraskuu" ;
lin december_Month = mkN "joulukuu" ;

lin afrikaans_Language = mkLanguage "afrikaans" ;
lin amharic_Language = mkLanguage "amhara" ;
lin arabic_Language = mkLanguage "arabia" ;
lin bulgarian_Language = mkLanguage "bulgaria" ;
lin catalan_Language = mkLanguage "katalaani" ;
lin chinese_Language = mkLanguage "kiina" ;
lin danish_Language = mkLanguage "tanska" ;
lin dutch_Language = mkLanguage "hollanti" ;
lin english_Language = mkLanguage "englanti" ;
lin estonian_Language = mkLanguage "viro" ;
lin finnish_Language = mkPN (mkN "suomi" "suomia") ;
lin french_Language = mkLanguage "ranska" ;
lin german_Language = mkLanguage "saksa" ;
lin greek_Language = mkLanguage "kreikka" ;
lin hebrew_Language = mkLanguage "heprea" ;
lin hindi_Language = mkLanguage "hindi" ;
lin japanese_Language = mkLanguage "japani" ;
lin italian_Language = mkLanguage "italia" ;
lin latin_Language = mkLanguage "latina" ;
lin latvian_Language = mkLanguage "latvia" ;
lin maltese_Language = mkLanguage "malta" ;
lin nepali_Language = mkLanguage "nepali" ;
lin norwegian_Language = mkLanguage "norja" ;
lin persian_Language = mkLanguage "persia" ;
lin polish_Language = mkLanguage "puola" ;
lin punjabi_Language = mkLanguage "punjabi" ;
lin romanian_Language = mkLanguage "romania" ;
lin russian_Language = mkLanguage "venäjä" ;
lin sindhi_Language = mkLanguage "sindhi" ;
lin spanish_Language = mkLanguage "espanja" ;
lin swahili_Language = mkLanguage "swahili" ;
lin swedish_Language = mkLanguage "ruotsi" ;
lin thai_Language = mkLanguage "thai" ;
lin turkish_Language = mkLanguage "turkki" ;
lin urdu_Language = mkLanguage "urdu" ;

}