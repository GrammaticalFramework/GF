concrete DatesEng of Dates = open Prelude in {

lincat
  Date, Year, Month, Day, Time, Hour, Minute, Weekday, Ampm = Str ;

lin
  DFull y m d w t = opts (opts "on" ++ w ++ comma) ++ opts (bothWays m d ++ opts comma) ++ opts (y ++ opts comma) ++ opts ("at" ++ t) ;

  MkYear i = i.s ;

  MJan = "January" ;
  MFeb = "February" ;
  MMar = "March" ;
  MApr = "April" ; 
  MMay = "May" ; 
  MJun = "June" ; 
  MJul = "July" ;
  MAug = "August" ;
  MSep = "September" ;
  MOct = "October" ;
  MNov = "November" ;
  MDec = "December" ;

  MkDay i = i.s ;

  MkTime ap h m = h ++ opts (dot ++ m) ++ opts ap ;

  H01 = "1" ;
  H02 = "2" ;
  H03 = "3" ;
  H04 = "4" ;
  H05 = "5" ;
  H06 = "6" ;
  H07 = "7" ;
  H08 = "8" ;
  H09 = "9" ;
  H10 = "10" ;
  H11 = "11" ;
  H12 = "12" ;

  MkMinute i = i.s ;

  WSun = "Sunday" ;
  WMon = "Monday" ;
  WTue = "Tuesday" ;
  WWed = "Wednesday" ;
  WThu = "Thursday" ;
  WFri = "Friday" ;
  WSat = "Saturday" ;

  AM = "a.m." ;
  PM = "p.m." ;

oper
  opts = optStr ;
  dot = "." ;
  comma = "," ;

lin
  DToday t     = "today" ++ opts ("at" ++ t) ;
  DTomorrow t  = "tomorrow" ++ opts ("at" ++ t) ;
  DYesterday t = "yesterday" ++ opts ("at" ++ t) ;


}

