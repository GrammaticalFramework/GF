concrete ExtraFin of ExtraFinAbs = CatFin ** open ResFin, Prelude in {

  lin
    GenNP np = {
      s1 = \\_,_ => np.s ! NPCase Gen ;
      s2 = [] ;
      isNum  = False ;
      isPoss = False ;
      isDef  = True  --- "Jussin kolme autoa ovat" ; thus "...on" is missing
      } ;

} 
