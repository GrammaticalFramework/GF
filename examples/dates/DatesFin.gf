concrete DatesFin of Dates = open Prelude in {

flags coding = utf8 ;

lincat
  Date, Year, Day, Time, Minute = Str ; 
  Month, Weekday = Case => Str ; 
  Hour = PAMPM => Str ; 
  Ampm = {s : Str ; p : PAMPM} ;

lin
  DFull y m d w t = (opts (w ! Nom) | (w ! Ess)) ++ opts (d ++ dot ++ (m ! Part)) ++ opts (opts "vuonna" ++ y) ++ opts (klo ++ t) ;

  MkYear i = i.s ;

  MJan = mkNoun "tammikuu" ;
  MFeb = mkNoun "helmikuu" ;
  MMar = mkNoun "maaliskuu" ;
  MApr = mkNoun "huhtikuu" ; 
  MMay = mkNoun "toukokuu" ; 
  MJun = mkNoun "kesäkuu" ; 
  MJul = mkNoun "heinäkuu" ;
  MAug = mkNoun "elokuu" ;
  MSep = mkNoun "syyskuu" ;
  MOct = mkNoun "lokakuu" ;
  MNov = mkNoun "marraskuu" ;
  MDec = mkNoun "joulukuu" ;

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

  WSun = mkNoun "sunnuntai" ;
  WMon = mkNoun "maanantai" ;
  WTue = mkNoun "tiistai" ;
  WWed = mkNoun "keskiviikko" ;
  WThu = mkNoun "torstai" ;
  WFri = mkNoun "perjantai" ;
  WSat = mkNoun "lauantai" ;

  AM = {s = [] ; p = PAM} ;
  PM = {s = [] ; p = PPM} ;

oper
  opts = optStr ;
  dot = "." ;
  comma = "," ;
  klo = "klo" | "kello" ;

  ampm : Str -> Str -> PAMPM => Str = \a,p -> table {PAM => a ; PPM => p} ;
  mkNoun : Str -> Case => Str = \w -> table {Nom => w ; Part => w + "ta" ; Ess => w ++ "na"} ;

param
  PAMPM = PAM | PPM ;
  Case = Nom | Part | Ess ;

lin
  DToday t     = "tänään" ++ opts (klo ++ t) ;
  DTomorrow t  = "huomenna" ++ opts (klo ++ t) ;
  DYesterday t = "eilen" ++ opts (klo ++ t) ;

}

