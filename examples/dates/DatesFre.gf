concrete DatesFre of Dates = open Prelude in {

flags coding = utf8 ;

lincat
  Date, Year, Month, Day, Time, Minute, Weekday = Str ; Hour = PAMPM => Str ; Ampm = {s : Str ; p : PAMPM} ;

lin
  DFull y m d w t = opts w ++ opts ("le" ++ d ++ m) ++ opts (opts "en" ++ y) ++ opts (klo ++ t) ;

  MkYear i = i.s ;

  MJan = "janvier" ;
  MFeb = "février" ;
  MMar = "mars" ;
  MApr = "avril" ; 
  MMay = "mai" ; 
  MJun = "juin" ; 
  MJul = "juillet" ;
  MAug = "août" ;
  MSep = "septembre" ;
  MOct = "octobre" ;
  MNov = "novembre" ;
  MDec = "décembre" ;

  MkDay i = i.s ;

  MkTime ap h m = h ! ap.p ++ opts ("h" ++ m) ++ ap.s ;

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

  WSun = "dimanche" ;
  WMon = "lundi" ;
  WTue = "mardi" ;
  WWed = "mercredi" ;
  WThu = "jeudi" ;
  WFri = "vendredi" ;
  WSat = "samedi" ;

  AM = {s = [] ; p = PAM} ;
  PM = {s = [] ; p = PPM} ;

oper
  opts = optStr ;
  dot = "." ;
  comma = "," ;
  klo = "à" ;

  ampm : Str -> Str -> PAMPM => Str = \a,p -> table {PAM => a ; PPM => p} ;

param
  PAMPM = PAM | PPM ;

lin
  DToday t     = "aujourd'hui" ++ opts (klo ++ t) ;
  DTomorrow t  = "demain" ++ opts (klo ++ t) ;
  DYesterday t = "hier" ++ opts (klo ++ t) ;

}

