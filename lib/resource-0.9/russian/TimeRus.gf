concrete TimeRus of Time = NumeralsRus ** 
  open Prelude, CategoriesRus
--, ParadigmsRus
, MorphoRus in {

flags  coding=utf8 ;

lincat
-- SS does not work for Russian, 
-- например, "первое мая, суббота" - "парад состоялся первоГО мая, в субботУ" : 
Date = N ;
Weekday = N ;
Hour = {s: Case => Str} ;
Minute = {s: Case => Str};
Time = SS ;

lin
DayDate day = day ;
DayTimeDate day time = {s=\\sf => day.s ! sf  ++ "," ++ time.s; g=day.g; anim=day.anim; lock_N=<>} ;

-- The formulation (strings in between) depends on the number
-- например, "один час" - "двенадцать часОВ" 
-- so all the definitions that deal with "Time" are only partially correct:
FormalTime h m = ss (h.s!Nom ++ "часов" ++ m.s!Nom ++ "минут") ;
PastTime h m = ss (m.s!Nom++ "минут"++h.s!Gen) ;
ToTime h m = ss ("без"++m.s!Gen ++ "минут" ++ h.s!Nom) ;
ExactTime h = ss (h.s!Nom ++ "ровно") ;

-- "Numerals.gf" is not refined enough to give the time categories:  
NumHour n = {s = \\_ => n.s ! attr ! Masc} ; 
NumMinute n = {s =\\_ => n.s ! attr ! Fem } ;

monday = ponedelnik ** {lock_N=<>};
tuesday = vtornik ** {lock_N=<>};
wednesday = sreda ** {lock_N=<>};
thursday = chetverg ** {lock_N=<>};
friday = pyatnica ** {lock_N=<>};
saturday = subbota ** {lock_N=<>};
sunday = voskresenje ** {lock_N=<>};

} ;

