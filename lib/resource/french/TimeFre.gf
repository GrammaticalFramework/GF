concrete TimeFre of Time = NumeralsFre ** 
  open Prelude, MorphoFre, ResourceFre, ParadigmsFre in {

lincat
Date = SS ;
Weekday = N ;
Hour = SS ;
Minute = SS ;
Time = SS ;

lin
DayDate day = ss (day.s ! singular) ;
DayTimeDate day time = ss (day.s ! singular ++ "à" ++ time.s) ;

FormalTime = infixSS "heures" ;
PastTime h m = ss (m.s ++ "et" ++ h.s) ;
ToTime h m = ss (h.s ++ "moins" ++ m.s) ;
ExactTime h = ss (h.s ++ "exactement") ;

NumHour n = ss (n.s ! indep) ;
NumMinute n = ss (n.s ! indep) ;

monday = regN "lundi" masculine ;
tuesday = regN "mardi" masculine ;
wednesday = regN "mercredi" masculine ;
thursday = regN "jeudi" masculine ;
friday = regN "vendredi" masculine ;
saturday = regN "samedi" masculine ;
sunday = regN "dimanche" masculine ;




} ;
