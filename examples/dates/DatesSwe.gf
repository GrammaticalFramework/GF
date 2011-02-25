concrete DatesSwe of Dates = open Prelude in {

flags coding = utf8 ;

lincat
  Date, Year, Month, Day, Time, Minute, Weekday = Str ; Hour = PAMPM => Str ; Ampm = {s : Str ; p : PAMPM} ;

lin
  DFull y m d w t = opts (opts "på" ++ w) ++ opts ("den" ++ d ++ m) ++ opts (opts "år" ++ y) ++ opts (klo ++ t) ;

  MkYear i = i.s ;

  MJan = "januari" ;
  MFeb = "februari" ;
  MMar = "mars" ;
  MApr = "april" ; 
  MMay = "maj" ; 
  MJun = "juni" ; 
  MJul = "juli" ;
  MAug = "augusti" ;
  MSep = "september" ;
  MOct = "oktober" ;
  MNov = "november" ;
  MDec = "december" ;

  MkDay i = i.s ;

  MkTime ap h m = h ! ap.p ++ opts (dot ++ m) ++ ap.s ;

  H01 = ampm "1" "13" ;
  H02 = ampm "2" "14" ;
  H03 = ampm "3" "15" ;
  H04 = ampm "4" "16" ;
  H05 = ampm "5" "17" ;
  H06 = ampm "6" "18" ;
  H07 = ampm "7" "19" ;
  H08 = ampm "8" "20" ;
  H09 = ampm "9" "21" ;
  H10 = ampm "10" "22" ;
  H11 = ampm "11" "23" ;
  H12 = ampm "0" "12" ; -- 12.01 a.m. = 0.01 ; 12.01 p.m. = 13.01 

  MkMinute i = i.s ;

  WSun = "söndag" ;
  WMon = "måndag" ;
  WTue = "tisdag" ;
  WWed = "onsdag" ;
  WThu = "torsdag" ;
  WFri = "fredag" ;
  WSat = "lördag" ;

  AM = {s = [] ; p = PAM} ;
  PM = {s = [] ; p = PPM} ;

oper
  opts = optStr ;
  dot = "." ;
  comma = "," ;
  klo = "kl." | "klockan" ;

  ampm : Str -> Str -> PAMPM => Str = \a,p -> table {PAM => a ; PPM => p} ;

param
  PAMPM = PAM | PPM ;

lin
  DToday t     = "idag" ++ opts (klo ++ t) ;
  DTomorrow t  = "imorgon" ++ opts (klo ++ t) ;
  DYesterday t = "igår" ++ opts (klo ++ t) ;

}

