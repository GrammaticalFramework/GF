concrete TenseGrc of Tense = 
  CatGrc [Tense,Temp], TenseX [Ant,Pol,AAnter,ASimul,PNeg,PPos] ** open ResGrc in {

  lin
    TTAnt t a = {s = t.s ++ a.s ; t = t.t ; a = a.a } ;

    TPres = {s = [] ;     t = VPres VInd } ; -- or: VPerf VInd           BR 220
    TPast = {s = [] ;     t = VImpf} ;       -- or: VAor VInd, VPlqm
    TFut  = {s = [] ;     t = VFut FInd} ;   -- and: VFut Opt, Inf, Part
    TCond = {s = "a)'n" ; t = VPres VInd} ;  -- ???

}
