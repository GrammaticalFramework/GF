--# -path=.:present
concrete TimeEng of Time = NumeralEng ** 
  open Prelude, CatEng, ParadigmsEng, ResEng in {

lincat
Date = SS ;
Year = SS;
Month = SS ;
MonthName = SS ;
Day = SS ;
Weekday = N ;
Hour = SS ;
Minute = SS ;
Time = SS ;

lin
WeekdayDate day = ss (day.s ! singular ! nominative) ;
WeekdayTimeDate day time = ss (day.s ! singular ! nominative ++ "at" ++ time.s) ;
MonthDayDate month day = variants { ss ("the" ++ day.s ++ "of" ++ month.s);
                                    ss (month.s ++ day.s) } ;
YearDate year = ss (year.s) ;
YearMonthDate year month = ss (month.s ++ year.s) ;
YearMonthDayDate year month day = variants { ss ("the" ++ day.s ++ "of" ++ month.s ++ "," ++ year.s); 
					     ss (month.s ++ day.s ++ "," ++ year.s) } ;


NumYear n = {s = n.s ! NCard} ;
DigYear n = {s = n.s ! NCard} ;

NumMonth n = {s = n.s ! NCard} ;
DigMonth n = {s = n.s ! NCard} ;
NameMonth n = { s = n.s } ;

NumDay n = {s = n.s ! NOrd} ;
DigDay n = {s = n.s ! NOrd} ;

FormalTime = infixSS ["hundred and"] ;
PastTime h m = ss (m.s ++ "past" ++ h.s) ;
ToTime h m = ss (m.s ++ "to" ++ h.s) ;
HourTime h = ss (h.s ++ "o'clock") ;
ExactTime h = ss (h.s ++ "sharp") ;

NumHour n = {s = n.s ! NCard} ;
DigHour n = {s = n.s ! NCard} ;
NumMinute n = {s = n.s ! NCard} ;
DigMinute n = {s = n.s ! NCard} ;

january = ss "January" ;
february = ss "February" ;
march = ss "March" ;
april = ss "April" ;
may = ss "May" ;
june = ss "June" ;
july = ss "July" ;
august = ss "August" ;
september = ss "September" ;
october = ss "October" ;
november = ss "November" ;
december = ss "December" ;

monday = mkN "Monday" ;
tuesday = mkN "Tuesday" ;
wednesday = mkN "Wednesday" ;
thursday = mkN "Thursday" ;
friday = mkN "Friday" ;
saturday = mkN "Saturday" ;
sunday = mkN "Sunday" ;

} ;
