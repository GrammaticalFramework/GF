incomplete concrete RelativeRomance of Relative = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\ag,t,a,p,m => pronSuch ! ag ++ conjThat ++ 
                          cl.s ! DDir ! t ! a ! p ! m ;
      c = Nom
      } ;

    --- more efficient to compile than case inside mkClause; see log.txt
    RelVP rp vp = case rp.hasAgr of {
      True => {s = \\ag =>
          (mkClause
                    (rp.s ! False ! {g = ag.g ; n = ag.n} ! Nom) False
                    {g = rp.a.g ; n = rp.a.n ; p = P3}
                    vp).s ! DDir ; c = Nom} ;
      False => {s = \\ag =>
          (mkClause
                    (rp.s ! False ! {g = ag.g ; n = ag.n} ! Nom) False
                    ag
                    vp).s ! DDir ; c = Nom
         }
      } ;

    RelSlash rp slash = {
      s = \\ag,t,a,p,m => 
          let aag = {g = ag.g ; n = ag.n} 
          in
          slash.c2.s ++ 
          rp.s ! False ! aag ! slash.c2.c ++ 
          slash.s ! DDir ! aag ! t ! a ! p ! m ;    --- ragr
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
