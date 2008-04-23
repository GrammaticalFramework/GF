incomplete concrete ExtraRomance of ExtraRomanceAbs = CatRomance **
  open 
    CommonRomance,
    Coordination,
    ResRomance in {

    lin TPasseSimple = {s = []} ** {t = RPasse} ;   --# notpresent

  lincat
    VPI   = {s : Str} ;
    [VPI] = {s1,s2 : Str} ;
  lin
    BaseVPI = twoSS ;
    ConsVPI = consrSS comma ;

    MkVPI vp = {s = infVP vp (agrP3 Masc Sg)} ;
    ConjVPI = conjunctSS ;
    ComplVPIVV v vpi = 
      insertComplement (\\a => prepCase v.c2.c ++ vpi.s) (predV v) ;

} 
