--# -path=.:../prelude

concrete TimetableHTML of Timetable = open Prelude, HTML in {

  lin
    MkTable cs ts = 
      ss (intagAttr "table" 
            "border=ON" (intag "tr" (intag "td" [] ++ cs.s) ++ ts.s)) ;
    NilTrain _ = ss [] ;
    ConsTrain cs n t ts = ss (intag "tr" (intag "td" n.s ++ t.s) ++ ts.s) ;
    OneCity c = ss (intag "td" c.s) ;
    ConsCity c cs = ss (intag "td" c.s ++ cs.s) ;

    StopTime t = ss (intag "td" t.s) ;
    NoStop = ss (intag "td" "-") ;

    LocTrain c s = s ;
    CityTrain c s cs t = ss (s.s ++ t.s) ;

    T i = i ;
    N n = ss (intag "b" n.s) ;
    C s = ss (intag "b" s.s) ;

}
