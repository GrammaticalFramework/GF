--# -path=.:../prelude

concrete TimetableLatex of Timetable = open Prelude, Latex in {

  lincat
    CityList = {s,s2 : Str} ; -- s2 encodes table width

  lin
    MkTable cs ts = 
      ss ("\\documentstyle{article}" ++ inEnv "document" (
          (inEnv "tabular" ("{" ++ cs.s2 ++ "}" ++ "&" ++ cs.s ++ 
          command "hline" ++ ts.s)))) ;
    NilTrain _ = ss [] ;
    ConsTrain cs n t ts = ss (n.s ++ "&" ++ t.s ++ "\\\\" ++ ts.s) ;
    OneCity c = {s = c.s ++ "\\\\" ; s2 = "l|l"} ;
    ConsCity c cs = {s = c.s ++ "&" ++ cs.s ; s2 = "l|" ++ cs.s2} ;

    StopTime t = t ;
    NoStop = ss "---" ;

    LocTrain c s = s ;
    CityTrain c s cs t = ss (s.s ++ "&" ++ t.s) ;

    T i = i ;
    N n = n ; --- ss (fun1 "textbf" n.s) ;
    C s = s ; --- ss (fun1 "textbf" s.s) ;

}
