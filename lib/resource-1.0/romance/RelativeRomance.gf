incomplete concrete RelativeRomance of Relative = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\ag,t,a,p,m => pronSuch ! ag ++ conjThat ++ cl.s ! t ! a ! p ! m
      } ;

    RelVP rp vp = {
      s = \\ag =>
        (mkClause
          (rp.s ! False ! {g = ag.g ; n = ag.n} ! Nom)
          (case rp.a of {
             RNoAg => ag ;
             RAg a => a ** {p = P3}
             }) 
          vp).s
      } ;

    RelSlash rp slash = {
      s = \\ag,t,a,p,m => 
          slash.c2.s ++ rp.s ! False ! ag ! slash.c2.c ++ slash.s ! t ! a ! p ! m
      } ;

    FunRP p np rp = {
      s = \\_,a,c => np.s ! Ton Nom ++ p.s ++ rp.s ! True ! a ! p.c ;
      a = RAg {g = np.a.g ; n = np.a.n}
      } ;
    IdRP = {
      s = relPron ; 
      a = RNoAg
      } ;

}
