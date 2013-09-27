concrete ExtraChi of ExtraChiAbs = CatChi ** 
  open ResChi, Coordination, Prelude in {

  lincat 
    Aspect = {s : Str ; a : ResChi.Aspect} ;
    VPS   = {s : Str} ;
    [VPS] = {s1,s2 : Str} ;
    VPI   = {s : Str} ;  --- ???
    [VPI] = {s1,s2 : Str} ; --- ???
    [CN] = {s : Str ; c : Str} ;

  lin
    PassVPSlash vps = insertAdv (mkNP passive_s) vps ;

    MkVPS t p vp = {s = t.s ++ p.s ++ (mkClause [] vp).s ! p.p ! t.t} ;
    ConjVPS c = conjunctDistrSS (c.s ! CSent) ;
    BaseVPS = twoSS ;
    ConsVPS = consrSS duncomma ;

    MkVPI vp = {s = (mkClause [] vp).s ! Pos ! APlain} ; --- ?? almost just a copy of VPS
    ConjVPI c = conjunctDistrSS (c.s ! CSent) ;
    BaseVPI = twoSS ;
    ConsVPI = consrSS duncomma ;

    ConjCN c = conjunctDistrSS (c.s ! CPhr CNPhrase) ** {c = ge_s} ; --- classifier always ge
    BaseCN = twoSS ;
    ConsCN = consrSS duncomma ;

    GenRP nu cn = {s = cn.s ++ relative_s} ; ---- ??


} 
