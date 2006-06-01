incomplete concrete RelativeRomance of Relative = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\ag,t,a,p,m => pronSuch ! ag ++ conjThat ++ cl.s ! t ! a ! p ! m ;
      c = Nom
      } ;

    --- more efficient to compile than case inside mkClause; see log.txt
    RelVP rp vp = case rp.hasAgr of {
      True => {s = \\ag =>
          (mkClause
                    (rp.s ! False ! {g = ag.g ; n = ag.n} ! Nom)
                    {g = rp.a.g ; n = rp.a.n ; p = P3}
                    vp).s ; c = Nom} ;
      False => {s = \\ag =>
          (mkClause
                    (rp.s ! False ! {g = ag.g ; n = ag.n} ! Nom)
                    ag
                    vp).s ; c = Nom
         }
      } ;

    RelSlash rp slash = {
      s = \\ag,t,a,p,m => 
          slash.c2.s ++ rp.s ! False ! {g = ag.g ; n = ag.n} ! slash.c2.c ++ 
          slash.s ! t ! a ! p ! m ;
      c = Acc
      } ;

    FunRP p np rp = {
      s = \\_,a,c => np.s ! Ton Nom ++ p.s ++ rp.s ! True ! a ! p.c ;
      a = {g = np.a.g ; n = np.a.n} ; 
      hasAgr = True
      } ;
    IdRP = {
      s = relPron ; 
      a = {g = Masc ; n = Sg} ; 
      hasAgr = False
      } ;

}
