concrete TimeIta of Time = NumeralsIta ** 
  open Prelude, MorphoIta, CategoriesIta, ParadigmsIta in {

lincat
Date = SS ;
Weekday = N ;
Hour = SS ;
Minute = SS ;
Time = SS ;

lin
DayDate day = ss (day.s ! singular) ;
DayTimeDate day time = ss (day.s ! singular ++ "alle" ++ time.s) ;

FormalTime h m = ss ("alle" ++ h.s ++ "e" ++ m.s) ;
PastTime h m = ss ("alle" ++ h.s ++ "e" ++ h.s) ;
ToTime h m = ss ("alle" ++ h.s ++ "meno" ++ m.s) ;
ExactTime h = ss (h.s ++ "esattamento") ;

NumHour n = ss (n.s ! feminine) ;
NumMinute n = ss (n.s ! feminine) ;

monday = regN "lunedì" ;
tuesday = regN "martedì" ;
wednesday = regN "mercoledì" ;
thursday = regN "giovedì" ;
friday = regN "venerdì" ;
saturday = regN "sabato" ;
sunday = regN "domenica" ;


} ;
