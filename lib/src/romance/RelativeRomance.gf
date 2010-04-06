incomplete concrete RelativeRomance of Relative = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\ag,t,a,p,m => pronSuch ! complAgr ag ++ conjThat ++ 
                          cl.s ! DDir ! t ! a ! p ! m ;
      c = Nom
      } ;

    --- more efficient to compile than case inside mkClause; see log.txt
    RelVP rp vp = case rp.hasAgr of {
      True => {s = \\ag =>
          (mkClause
                    (rp.s ! False ! complAgr ag ! Nom) False False
                    (Ag rp.a.g rp.a.n P3)
                    vp).s ! DDir ; c = Nom} ;
      False => {s = \\ag =>
          (mkClause
                    (rp.s ! False ! complAgr ag ! Nom) False False
                    ag
                    vp).s ! DDir ; c = Nom
         }
      } ;

    RelSlash rp slash = {
      s = \\ag,t,a,p,m => 
          let aag = complAgr ag
          in
          slash.c2.s ++ 
          rp.s ! False ! aag ! slash.c2.c ++ 
          slash.s ! aag ! DDir ! t ! a ! p ! m ;    --- ragr
      c = Acc
      } ;

    FunRP p np rp = {
      s = \\_,a,c => (np.s ! Nom).ton ++ p.s ++ rp.s ! True ! a ! p.c ;
      a = complAgr np.a ; 
      hasAgr = True
      } ;
    IdRP = {
      s = relPron ; 
      a = {g = Masc ; n = Sg} ; 
      hasAgr = False
      } ;

}
