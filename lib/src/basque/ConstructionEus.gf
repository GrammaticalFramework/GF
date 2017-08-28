concrete ConstructionEus of Construction = CatEus ** open ParadigmsEus in {
	
lincat
  Timeunit = N ;
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
{-
lin

  timeunitAdv n time = 
  let n_card : Card   = n ;
      n_hours_NP : NP = mkNP n_card time ;
  in  SyntaxEus.mkAdv for_Prep n_hours_NP | mkAdv (n_hours_NP.s ! R.npNom) ;

  weekdayPunctualAdv w = ;         -- on Sunday
  weekdayHabitualAdv w = ;         -- on Sundays
  weekdayNextAdv w =      -- next Sunday
  weekdayLastAdv w =      -- last Sunday

  monthAdv m = mkAdv in_Prep (mkNP m) ;
  yearAdv y = mkAdv in_Prep y ;
  dayMonthAdv d m  =  ; -- on 17 May
  monthYearAdv m y =  ; -- in May 2012
  dayMonthYearAdv d m y =  ; -- on 17 May 2013

  intYear = symb ;
  intMonthday = symb ;

lincat Language = N ;

lin InLanguage l = mkAdv ???_Prep (mkNP l) ;

lin
  weekdayN w = w ;
  monthN m = m ;

  weekdayPN w = mkPN w ;
  monthPN m = mkPN m ;

  languageCN l = mkCN l ;
  languageNP l = mkNP l ;


oper mkLanguage : Str -> N = \s -> mkN s ;

----------------------------------------------
---- lexicon of special names

lin second_Timeunit = mkN "second" ;
lin minute_Timeunit = mkN "minute" ;
lin hour_Timeunit = mkN "hour" ;
lin day_Timeunit = mkN "day" ;
lin week_Timeunit = mkN "week" ;
lin month_Timeunit = mkN "month" ;
lin year_Timeunit = mkN "year" ;

lin monday_Weekday = mkN "Monday" ;
lin tuesday_Weekday = mkN "Tuesday" ;
lin wednesday_Weekday = mkN "Wednesday" ;
lin thursday_Weekday = mkN "Thursday" ;
lin friday_Weekday = mkN "Friday" ;
lin saturday_Weekday = mkN "Saturday" ;
lin sunday_Weekday = mkN "Sunday" ;

lin january_Month = mkN "January" ; 
lin february_Month = mkN "February" ; 
lin march_Month = mkN "March" ; 
lin april_Month = mkN "April" ;
lin may_Month = mkN "May" ;
lin june_Month = mkN "June" ;
lin july_Month = mkN "July" ;
lin august_Month = mkN "August" ;
lin september_Month = mkN "September" ;
lin october_Month = mkN "October" ;
lin november_Month = mkN "November" ;
lin december_Month = mkN "December" ;

lin afrikaans_Language = mkLanguage "Afrikaans" ;
lin amharic_Language = mkLanguage "Amharic" ;
lin arabic_Language = mkLanguage "Arabic" ;
lin bulgarian_Language = mkLanguage "Bulgarian" ;
lin catalan_Language = mkLanguage "Catalan" ;
lin chinese_Language = mkLanguage "Chinese" ;
lin danish_Language = mkLanguage "Danish" ;
lin dutch_Language = mkLanguage "Dutch" ;
lin english_Language = mkLanguage "Euslish" ;
lin estonian_Language = mkLanguage "Estonian" ;
lin finnish_Language = mkLanguage "Finnish" ;
lin french_Language = mkLanguage "French" ;
lin german_Language = mkLanguage "German" ;
lin greek_Language = mkLanguage "Greek" ;
lin hebrew_Language = mkLanguage "Hebrew" ;
lin hindi_Language = mkLanguage "Hindi" ;
lin japanese_Language = mkLanguage "Japanese" ;
lin italian_Language = mkLanguage "Italian" ;
lin latin_Language = mkLanguage "Latin" ;
lin latvian_Language = mkLanguage "Latvian" ;
lin maltese_Language = mkLanguage "Maltese" ;
lin nepali_Language = mkLanguage "Nepali" ;
lin norwegian_Language = mkLanguage "Norwegian" ;
lin persian_Language = mkLanguage "Persian" ;
lin polish_Language = mkLanguage "Polish" ;
lin punjabi_Language = mkLanguage "Punjabi" ;
lin romanian_Language = mkLanguage "Romanian" ;
lin russian_Language = mkLanguage "Russian" ;
lin sindhi_Language = mkLanguage "Sindhi" ;
lin spanish_Language = mkLanguage "Spanish" ;
lin swahili_Language = mkLanguage "Swahili" ;
lin swedish_Language = mkLanguage "Swedish" ;
lin thai_Language = mkLanguage "Thai" ;
lin turkish_Language = mkLanguage "Turkish" ;
lin urdu_Language = mkLanguage "Urdu" ;

—}
}
-}
}
