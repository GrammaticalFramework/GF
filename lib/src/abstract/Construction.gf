abstract Construction = Cat ** {

-- started by AR 6/12/2013. (c) Aarne Ranta under LGPL and BSD

-- This module is, in the spirit of construction grammar, "between syntax and lexicon". 
-- So is the module Idiom, but the difference is that the constructions in Idiom 
-- apply to categories in a general way (e.g. existentials) whereas here they
-- are typically about particular predicates such as "NP is hungry" which are found
-- to work differently in different languages. The purpose of this module is hence
-- not so much to widen the scope of string recognition, but to provide trees that
-- are abstract enough to yield correct translations.


-- The first examples are from the MOLTO Phrasebook

cat 
  Weekday ;
  Month ;

fun
  hungry_VP     : VP ;                 -- x is hungry / x a faim (Fre)
  thirsty_VP    : VP ;                 -- x is thirsty / x a soif (Fre)
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

  n_units_AP    : Card -> CN -> A -> AP ;  -- x inches long

--  weekdayN   : Weekday -> N ; --weekdays are already as nouns in Dict
--  monthN     : Month -> N     --months are already as nouns in Dict
  weekdayPunctualAdv : Weekday -> Adv ;
  weekdayHabitualAdv : Weekday -> Adv ;
  weekdayLastAdv : Weekday -> Adv ;
  weekdayNextAdv : Weekday -> Adv ;

  monthAdv   : Month -> Adv ;

  monday_Weekday, tuesday_Weekday, wednesday_Weekday, thursday_Weekday, friday_Weekday, sunday_Weekday : Weekday ;

  january_Month, february_Month, march_Month, april_Month, may_Month, june_Month, july_Month : Month ;
  august_Month, september_Month, october_Month, november_Month, december_Month : Month ;

}
