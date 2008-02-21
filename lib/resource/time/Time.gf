abstract Time = Numeral ** {

-- Time grammar Abstract syntax. Modified by AR from Karin Cavallin.

cat 

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

WeekdayDate      : Weekday -> Date ; -- Monday
WeekdayTimeDate  : Weekday -> Time -> Date ; -- Monday at twenty past two
MonthDayDate     : MonthName -> Day -> Date ; -- the third of March
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

{-
Add:

era (AD, BC)

twelve hour time (am, pm)

teen-hundred years: "x-teen hundred"

relative weeks: next week, last week, in x weeks, x weeks ago

relative days: today, tomorrow, yesterday, the day before yesterday,
the day after tomorrow, in x days, x days ago

relative time: in x minutes, in x hours

temporal adverbs:

point:

- in 1992
- in July
- in July 1992
- on Monday
- on the first of July
- on the first of July, 1992
- on Monday at two twenty

starting:

- from (all of the above)

ending:

- to (all of the above)

-}

} ;
