concrete TimeEng of Time = NumeralsEng ** 
  open Prelude, ResourceEng, ParadigmsEng in {

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

NumHour n = n ;
NumMinute n = n ;

monday = regN "Monday" ;
tuesday = regN "Tuesday" ;
wednesday = regN "Wednesday" ;
thursday = regN "Thursday" ;
friday = regN "Friday" ;
saturday = regN "Saturday" ;
sunday = regN "Sunday" ;

} ;
