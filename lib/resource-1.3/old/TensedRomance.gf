incomplete concrete TensedRomance of Tensed = CatRomance ** 
  open ResRomance in {

  flags optimize=all_subs ;

  lin
    UseCl  t a p cl = {s = \\o => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! o} ;
    UseQCl t a p cl = {s = \\q => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! q} ;
    UseRCl t a p cl = 
      {s = \\r,ag => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! r ! ag} ;

}
