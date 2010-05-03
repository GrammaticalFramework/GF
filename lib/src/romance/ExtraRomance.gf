incomplete concrete ExtraRomance of ExtraRomanceAbs = CatRomance **
  open 
    CommonRomance,
    Coordination,
    ResRomance in {

    lin TPasseSimple = {s = []} ** {t = RPasse} ;   --# notpresent

  lin ComplCN v cn = insertComplement (\\_ => prepCase v.c2.c ++ cn.s ! Sg) (predV v) ;

  lincat
    VPI   = {s : Str} ;
    [VPI] = {s1,s2 : Str} ;
  lin
    BaseVPI = twoSS ;
    ConsVPI = consrSS comma ;

    MkVPI vp = {s = infVP vp (agrP3 Masc Sg)} ;
    ConjVPI = conjunctDistrSS ;
    ComplVPIVV v vpi = 
      insertComplement (\\a => prepCase v.c2.c ++ vpi.s) (predV v) ;

    ProDrop p = {
      s = table {
        Nom => let pn = p.s ! Nom in {c1 = pn.c1 ; c2 = pn.c2 ; comp = [] ; ton = pn.ton} ; 
        c => p.s ! c
        } ;
      a = p.a ;
      poss = p.poss ;
      hasClit = p.hasClit ;
      isPol = p.isPol
      } ;

    CompIQuant iq = {s = \\aa => iq.s ! aa.n ! aa.g ! Nom} ;

    PrepCN prep cn = {s = prep.s ++ prepCase prep.c ++ cn.s ! Sg} ;
    
} 
