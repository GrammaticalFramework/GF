concrete TimeNor of Time = NumeralsNor ** 
  open Prelude, TypesNor, CategoriesNor, ParadigmsNor in {

lincat
Date = SS ;
Weekday = N ;
Hour = SS ;
Minute = SS ;
Time = SS ;

lin
DayDate day = ss (day.s ! singular ! Indef ! nominative) ;
DayTimeDate day time = ss (day.s ! singular ! Indef ! nominative ++ "klokken" ++ time.s) ;

FormalTime = infixSS "og" ;
PastTime h m = ss (m.s ++ "over" ++ h.s) ;
ToTime h m = ss (m.s ++ "på" ++ h.s) ;
ExactTime h = ss (h.s ++ "akkurat") ;

NumHour n = n ;
NumMinute n = n ;

monday = regN "mandag" masculine ;
tuesday = regN "tirsdag" masculine ;
wednesday = regN "onsdag" masculine ;
thursday = regN "torsdag" masculine ;
friday = regN "fredag" masculine ;
saturday = regN "lørdag" masculine ;
sunday = regN "søndag" masculine ;



} ;
