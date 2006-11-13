concrete ExtraGer of ExtraGerAbs = CatGer ** open ResGer, Coordination in {

  lincat
    VPI   = {s : Str} ;
    [VPI] = {s1,s2 : Str} ;
  lin
    BaseVPI = twoSS ;
    ConsVPI = consrSS comma ;

    MkVPI vp = {s = useInfVP vp} ; ----
    ConjVPI = conjunctSS ;

    ComplVPIVV v vpi = 
        insertInf vpi.s (
            predVGen v.isAux v) ; ----
{-
      insertExtrapos vpi.p3 (
        insertInf vpi.p2 (
          insertObj vpi.p1 (
            predVGen v.isAux v))) ;
-}

} 
