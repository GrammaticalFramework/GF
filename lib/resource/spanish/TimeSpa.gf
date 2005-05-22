concrete TimeSpa of Time = NumeralsSpa ** 
  open Prelude, MorphoSpa, CategoriesSpa, ParadigmsSpa in {

lincat
Date = SS ;
Weekday = N ;
Hour = SS ;
Minute = SS ;
Time = SS ;

lin
DayDate day = ss (day.s ! singular) ;
DayTimeDate day time = ss (day.s ! singular ++ ["a las"] ++ time.s) ; --- a la una

FormalTime h m = ss (["a las"] ++ h.s ++ "y" ++ m.s) ;
PastTime h m = ss (["a las"] ++ h.s ++ "y" ++ h.s) ;
ToTime h m = ss (["a las"] ++ h.s ++ "menos" ++ m.s) ;
ExactTime h = ss (h.s ++ "exactamente") ;

NumHour n = ss (n.s ! feminine) ;
NumMinute n = ss (n.s ! feminine) ;

monday = regN "lunes" ;
tuesday = regN "martes" ;
wednesday = regN "miércoles" ;
thursday = regN "jueves" ;
friday = regN "viernes" ;
saturday = regN "sábado" ;
sunday = regN "domingo" ;


} ;
