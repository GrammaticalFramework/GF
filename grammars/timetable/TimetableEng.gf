--# -path=.:../prelude

concrete TimetableEng of Timetable = open Prelude in {

  lin
    MkTable cs ts = 
      ss (["The following trains run on the line from"] ++ cs.s ++ "." ++ ts.s) ;
    NilTrain _ = ss [] ;
    ConsTrain cs n t ts = ss (n.s ++ ":" ++ t.s ++ "." ++ ts.s) ;
    OneCity c = c ;
    ConsCity c cs = ss (c.s ++ "to" ++ cs.s) ;

    StopTime t = t ;
    NoStop = ss ["no stop"] ;

    LocTrain c s = cc2 c s ;
    CityTrain c s cs t = ss (c.s ++ s.s ++ "," ++ t.s) ;

    T i = prefixSS "at" i ;
    N n = prefixSS "Train" n ;
    C s = s ;

}
