--# -path=.:../prelude

concrete TimetableHTML of Timetable = open Prelude in {

  lin
    MkTable cs ts = 
      ss ("<table>" ++ "<tr><td></td>"++ cs.s ++ </tr> ++ ts.s ++ "</table>") ;
    NilTrain _ = ss [] ;
    ConsTrain cs n t ts = 
      ss ("<tr>" ++ n.s ++ t.s ++ "</tr>") ;
    OneCity c = ss ("<td>" ++ c ++ "</td>") ;
    ConsCity c cs = ss (c.s ++ "to" ++ cs.s) ;

    StopTime t = t ;
    NoStop = ss ["no stop"] ;

    LocTrain c s = cc2 c s ;
    CityTrain c s cs t = ss (c.s ++ s.s ++ "," ++ t.s) ;

    T i = prefixSS "at" i ;
    N n = prefixSS "train" n ;
    C s = s ;

}
