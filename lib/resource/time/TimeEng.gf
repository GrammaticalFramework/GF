--# -path=.:present
concrete TimeEng of Time = CatEng, NumeralEng ** 
  open Prelude, CatEng, ParadigmsEng, ResEng in {

param DateType = YearMonthType | DayType ;

lincat
DateTime = SS ;

Date = { s : Str; t : DateType } ;
Year = SS;
Month = SS ;
MonthName = SS ;
Day = SS ;
Weekday = N ;
Hour = SS ;
Minute = SS ;
Time = SS ;

lin

DateTimeDateTime date time = { s = date.s ++ "at" ++ time.s };

WeekdayDate day = { s = day.s ! singular ! nominative; t = DayType } ;
MonthDayDate month day = { s = variants { "the" ++ day.s ++ "of" ++ month.s;
					  month.s ++ day.s } ;
			   t = DayType } ;
MonthDate month = { s = month.s ; t = YearMonthType } ;
YearDate year = { s = year.s ; t = YearMonthType } ;
YearMonthDate year month = { s = month.s ++ year.s; t = YearMonthType } ;
YearMonthDayDate year month day = { s = variants { "the" ++ day.s ++ "of" ++ month.s ++ "," ++ year.s; 
						   month.s ++ day.s ++ "," ++ year.s }; 
				    t = DayType } ;


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


OnDate date = let prep = case date.t of {
                           YearMonthType => "in";
			   DayType       => "on"
		    }
	       in { s = prep ++ date.s } ;

AtTime time = { s = "at" ++ time.s } ;

} ;
