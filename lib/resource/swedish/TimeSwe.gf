concrete TimeSwe of Time = NumeralsSwe ** 
  open Prelude, MorphoSwe, CategoriesSwe, ParadigmsSwe in {

lincat
Date = SS ;
Weekday = N ;
Hour = SS ;
Minute = SS ;
Time = SS ;

lin
DayDate day = ss (day.s ! singular ! Indef ! nominative) ;
DayTimeDate day time = ss (day.s ! singular ! Indef ! nominative ++ "klockan" ++ time.s) ;

FormalTime = infixSS "och" ;
PastTime h m = ss (m.s ++ "över" ++ h.s) ;
ToTime h m = ss (m.s ++ "i" ++ h.s) ;
ExactTime h = ss (h.s ++ "prick") ;

NumHour n = {s = n.s ! Neutr} ;
NumMinute n = {s = n.s ! Neutr} ;

monday = regN "måndag" utrum ;
tuesday = regN "tisdag" utrum ;
wednesday = regN "onsdag" utrum ;
thursday = regN "torsdag" utrum ;
friday = regN "fredag" utrum ;
saturday = regN "lördag" utrum ;
sunday = regN "söndag" utrum ;




} ;
