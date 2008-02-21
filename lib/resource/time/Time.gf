abstract Time = Numeral ** {

-- Time grammar Abstract syntax. Modified by AR from Karin Cavallin.

cat 

Date ; 
Hour ; 
Minute ; 
Weekday ;

fun

-- The variants: "two twenty", "twenty past two", "twenty to two"

DayDate     : Weekday -> Date ;
DayTimeDate : Weekday -> Time -> Date ;

FormalTime : Hour -> Minute -> Time ;
PastTime   : Hour -> Minute -> Time ;
ToTime     : Hour -> Minute -> Time ;
ExactTime  : Hour -> Time ;

-- These range from 1 to 99 and are thus overgenerating.

NumHour    : Sub100 -> Hour ;
NumMinute  : Sub100 -> Minute ;

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

years

dates: the x:th of y

relative weeks: next week, last week, in x weeks, x weeks ago

relative days: today, tomorrow, yesterday, the day before yesterday,
the day after tomorrow, in x days, x days ago

relative time: in x minutes, in x hours

-}

} ;
