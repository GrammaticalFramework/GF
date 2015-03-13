concrete TenseMon of Tense = 
  CatMon [Tense,Temp], TenseX [Ant,Pol,AAnter,ASimul,PNeg,PPos] ** open ResMon in {

lin
 TTAnt t a = {s = t.s ++ a.s ; t = t.t ; a = a.a} ;

 TPres = {s = [] ; t = ClPres } ;
 TPast = {
    s = [] ; 
    t = ClPast (variants {Perf;PresPerf;IndefPast})
    } ;   --# notpresent
 TFut,TCond = {s = [] ; t = ClFut} ;   --# notpresent

}