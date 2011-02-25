abstract Dates = {

flags startcat = Date ;

cat
  Date ; Year ; Month ; Day ; Time ; Hour ; Minute ; Weekday ; Ampm ;

fun
  DFull : Year -> Month -> Day -> Weekday -> Time -> Date ;
  
  MkYear : Int -> Year ;

  MJan, MFeb, MMar, MApr, MMay, MJun, MJul, MAug, MSep, MOct, MNov, MDec : Month ;

  MkDay : Int -> Day ;

  MkTime : Ampm -> Hour -> Minute -> Time ;

  H01, H02, H03, H04, H05, H06, H07, H08, H09, H10, H11, H12 : Hour ;

  MkMinute : Int -> Minute ;

  WSun, WMon, WTue, WWed, WThu, WFri, WSat : Weekday ;

  AM, PM : Ampm ;

-- noncanonical ways

  DToday, DYesterday, DTomorrow : Time -> Date ;

}

