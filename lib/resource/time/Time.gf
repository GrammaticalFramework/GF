abstract Time = Cat, Numeral ** {

-- Time grammar Abstract syntax. Modified by BB and AR from Karin Cavallin.

-- Dates and times

cat 

DateTime ;

Date ;
Year ;
Month ;
MonthName ;
Day ;

Time ; 
Hour ; 
Minute ; 
Weekday ;

fun

DateTimeDateTime : Date -> Time -> DateTime ;

WeekdayDate      : Weekday -> Date ; -- Monday
MonthDayDate     : MonthName -> Day -> Date ; -- the third of March
MonthDate        : MonthName -> Date ; -- March
YearDate         : Year -> Date ; -- two thousand eight
YearMonthDate    : Year -> MonthName -> Date ; -- March 1995
YearMonthDayDate : Year -> MonthName -> Day -> Date ; -- January 1st, 2006

NumYear    : Numeral -> Year ;
DigYear    : Digits -> Year ;

NumMonth   : Sub100 -> Month ;
DigMonth   : Digits -> Month ;
NameMonth  : MonthName -> Month ;

NumDay     : Sub100 -> Day ;
DigDay     : Digits -> Day ;

FormalTime : Hour -> Minute -> Time ; -- "two twenty"
PastTime   : Hour -> Minute -> Time ; -- "twenty past two"
ToTime     : Hour -> Minute -> Time ; -- "twenty to two"
HourTime   : Hour -> Time ;           -- "two o'clock"
ExactTime  : Hour -> Time ;           -- "sharp"

NumHour     : Numeral -> Hour ;
DigHour     : Digits -> Hour ;
NumMinute   : Numeral -> Minute ;
DigMinute   : Digits -> Minute ;

fun
january   : MonthName ;
february  : MonthName ;
march     : MonthName ;
april     : MonthName ;
may       : MonthName ;
june      : MonthName ;
july      : MonthName ;
august    : MonthName ;
september : MonthName ;
october   : MonthName ;
november  : MonthName ;
december  : MonthName ;

fun
monday : Weekday ;
tuesday : Weekday ;
wednesday : Weekday ;
thursday : Weekday ;
friday : Weekday ;
saturday : Weekday ;
sunday : Weekday ;

-- Date and time adverbs

fun 
  OnDate     : Date -> Adv ;
  AtTime     : Time -> Adv ;

{-
Add:

era (AD, BC)

twelve hour time (am, pm)

teen-hundred years: "x-teen hundred"

relative weeks: next week, last week, in x weeks, x weeks ago

relative days: today, tomorrow, yesterday, the day before yesterday,
the day after tomorrow, in x days, x days ago

relative time: in x minutes, in x hours

-}

} ;
