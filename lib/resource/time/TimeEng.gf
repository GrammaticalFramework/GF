--# -path=.:present
concrete TimeEng of Time = NumeralEng ** 
  open Prelude, CatEng, ParadigmsEng, ResEng in {

lincat
Date = SS ;
Weekday = N ;
Hour = SS ;
Minute = SS ;
Time = SS ;

lin
DayDate day = ss (day.s ! singular ! nominative) ;
DayTimeDate day time = ss (day.s ! singular ! nominative ++ "at" ++ time.s) ;

FormalTime = infixSS ["hundred and"] ;
PastTime h m = ss (m.s ++ "past" ++ h.s) ;
ToTime h m = ss (m.s ++ "to" ++ h.s) ;
ExactTime h = ss (h.s ++ "sharp") ;

NumHour n = {s = n.s ! NCard} ;
NumMinute n = {s = n.s ! NCard} ;

monday = mkN "Monday" ;
tuesday = mkN "Tuesday" ;
wednesday = mkN "Wednesday" ;
thursday = mkN "Thursday" ;
friday = mkN "Friday" ;
saturday = mkN "Saturday" ;
sunday = mkN "Sunday" ;

} ;
