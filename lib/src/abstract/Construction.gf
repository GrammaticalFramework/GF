abstract Construction = Cat ** {
flags coding=utf8 ;

-- started by AR 6/12/2013. (c) Aarne Ranta under LGPL and BSD

-- This module is, in the spirit of construction grammar, "between syntax and lexicon". 
-- So is the module Idiom, but the difference is that the constructions in Idiom 
-- apply to categories in a general way (e.g. existentials) whereas here they
-- are typically about particular predicates such as "NP is hungry" which are found
-- to work differently in different languages. The purpose of this module is hence
-- not so much to widen the scope of string recognition, but to provide trees that
-- are abstract enough to yield correct translations.


-- The first examples are from the MOLTO Phrasebook

fun
  hungry_VP     : VP ;                 -- x is hungry / x a faim (Fre)
  thirsty_VP    : VP ;                 -- x is thirsty / x a soif (Fre)
  tired_VP      : VP ;                 -- x is tired / x estoy cansado (Spa)
  scared_VP     : VP ;                 -- x is scared
  ill_VP        : VP ;                 -- x is ill
  ready_VP      : VP ;                 -- x is ready
  has_age_VP    : Card -> VP ;         -- x is y years old / x a y ans (Fre)

  have_name_Cl  : NP -> NP -> Cl ;     -- x's name is y / x s'appelle y (Fre)
  married_Cl    : NP -> NP -> Cl ;     -- x is married to y / x on naimisissa y:n kanssa (Fin)

  what_name_QCl : NP -> QCl ;          -- what is x's name / wie heisst x (Ger)
  how_old_QCl   : NP -> QCl ;          -- how old is x / quanti anni ha x (Ita)
  how_far_QCl   : NP -> QCl ;          -- how far is x / quanto dista x (Ita)

-- some more things

  weather_adjCl : AP -> Cl ;           -- it is warm / il fait chaud (Fre)

  is_right_VP   : VP ;                 -- he is right / il a raison (Fre) 
  is_wrong_VP   : VP ;                 -- he is wrong / han har fel (Swe)

  n_units_AP    : Card -> CN -> A  -> AP ;  -- x inches long
  n_units_of_NP : Card -> CN -> NP -> NP ;  -- x ounces of this flour


-- containers
  bottle_of_CN : NP -> CN ;       --- bottle of beer / flaska öl (Swe)
  cup_of_CN    : NP -> CN ;       --- cup of tea / kupillinen teetä (Fin)
  glass_of_CN  : NP -> CN ;       --- glass of wine / lasillinen viiniä (Fin)

-- idiomatic expressions
  few_X_short_of_Y : NP -> CN -> CN -> S ; --- NP is a few X's short of a Y / NP:llä ei ole kaikki X:t Y:ssä (Fin) 

{- 
---- postponed  
-- spatial deixis and motion verbs
-- verbs like `walk' or `run' can take both: there or to there

  where_go_QCl   : NP -> QCl ;      --- where did X go / vart gick X (Swe)
  where_come_from_QCl : NP -> QCl ; --- where did X come from / mistä X tuli (Fin)
  
  go_here_VP   : VP ;      --- X went here / X gick hit (Swe)
  come_here_VP : VP ;      --- X came here / X tuli tänne (Fin)
  come_from_here_VP : VP ; --- X came from here / X tuli täältä (Fin)

  go_there_VP   : VP ;      --- X went here / X gick dit (Swe)
  come_there_VP : VP ;      --- X came there / X tuli sinne (Fin)
  come_from_there_VP : VP ; --- X came from there / X tuli sieltä (Fin)

-}

-- time expressions

cat 
  Timeunit ;
  Weekday ;
  Month ;
  Monthday ;
  Year ;

fun
  timeunitAdv     : Card -> Timeunit -> Adv ; -- (for) three hours

  weekdayPunctualAdv : Weekday -> Adv ;  -- on Monday
  weekdayHabitualAdv : Weekday -> Adv ;  -- on Mondays
  weekdayLastAdv : Weekday -> Adv ;      -- last Monday
  weekdayNextAdv : Weekday -> Adv ;      -- next Monday

  monthAdv        : Month -> Adv ;                        -- in June
  yearAdv         : Year -> Adv ;                         -- in 1976
  dayMonthAdv     : Monthday -> Month -> Adv ;            -- on 17 May
  monthYearAdv    : Month -> Year -> Adv ;                -- in May 2013
  dayMonthYearAdv : Monthday -> Month -> Year -> Adv ;    -- on 17 May 2013
  
  intYear     : Int -> Year ;  -- (year) 1963
  intMonthday : Int -> Monthday ; -- 31th (March)


-- languages

cat
  Language ;
fun
  InLanguage : Language -> Adv ; -- in English, auf englisch, englanniksi, etc

-- coercions to RGL categories

  weekdayN   : Weekday -> N ; -- (this) Monday
  monthN     : Month -> N ;   -- (this) November

  weekdayPN  : Weekday -> PN ; -- Monday (is free)
  monthPN    : Month -> PN ;   -- March (is cold)

  languageNP : Language -> NP ;  -- French (is easy)
  languageCN : Language -> CN ;  -- (my) French

----------------------------------------------
---- lexicon of special names

fun second_Timeunit : Timeunit ;
fun minute_Timeunit : Timeunit ;
fun hour_Timeunit : Timeunit ;
fun day_Timeunit : Timeunit ;
fun week_Timeunit : Timeunit ;
fun month_Timeunit : Timeunit ;
fun year_Timeunit : Timeunit ;

fun monday_Weekday : Weekday ;
fun tuesday_Weekday : Weekday ;
fun wednesday_Weekday : Weekday ;
fun thursday_Weekday : Weekday ;
fun friday_Weekday : Weekday ;
fun saturday_Weekday : Weekday ;
fun sunday_Weekday : Weekday ;

fun january_Month : Month ; 
fun february_Month : Month ; 
fun march_Month : Month ; 
fun april_Month : Month ; 
fun may_Month : Month ; 
fun june_Month : Month ; 
fun july_Month : Month ;
fun august_Month : Month ; 
fun september_Month : Month ; 
fun october_Month : Month ; 
fun november_Month : Month ; 
fun december_Month : Month ;


fun afrikaans_Language : Language ;
fun amharic_Language : Language ;
fun arabic_Language : Language ;
fun bulgarian_Language : Language ;
fun catalan_Language : Language ;
fun chinese_Language : Language ;
fun danish_Language : Language ;
fun dutch_Language : Language ;
fun english_Language : Language ;
fun estonian_Language : Language ;
fun finnish_Language : Language ;
fun french_Language : Language ;
fun german_Language : Language ;
fun greek_Language : Language ;
fun hebrew_Language : Language ;
fun hindi_Language : Language ;
fun japanese_Language : Language ;
fun italian_Language : Language ;
fun latin_Language : Language ;
fun latvian_Language : Language ;
fun maltese_Language : Language ;
fun nepali_Language : Language ;
fun norwegian_Language : Language ;
fun persian_Language : Language ;
fun polish_Language : Language ;
fun punjabi_Language : Language ;
fun romanian_Language : Language ;
fun russian_Language : Language ;
fun sindhi_Language : Language ;
fun spanish_Language : Language ;
fun swahili_Language : Language ;
fun swedish_Language : Language ;
fun thai_Language : Language ;
fun turkish_Language : Language ;
fun urdu_Language : Language ;

}
