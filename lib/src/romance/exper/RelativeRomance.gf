incomplete concrete RelativeRomance of Relative = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin

    RelCl cl = cl ** {c = Nom ; rp = \\aag => pronSuch ! aag ++ conjThat} ; 
{-
let cl = oldClause ncl in {
      s = \\ag,t,a,p,m => pronSuch ! complAgr ag ++ conjThat ++ 
                          cl.s ! DDir ! t ! a ! p ! m ;
      c = Nom
      } ;
-}

    RelVP rp vp = {
      np = heavyNP {s = rp.s ! False ! {g = Masc ; n = Sg} ; a = Ag rp.a.g rp.a.n P3} ;  ---- agr,agr
      vp = vp ; 
      rp = \\_ => [] ;
      c  = Nom
      } ;
{-
    --- more efficient to compile than case inside mkClause; see log.txt
case rp.hasAgr of {
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
-}

    RelSlash rp slash = slash ** {rp = \\aag => rp.s ! False ! aag ! slash.c2.c ; c = Acc} ;

{-
      s = \\ag,t,a,p,m => 
          let 
             aag = complAgr ag ;
             cl = oldClause slash
          in
          slash.c2.s ++ 
          rp.s ! False ! aag ! slash.c2.c ++ 
          cl.s    !       DDir ! t ! a ! p ! m ;    --- ragr
----      slash.s ! aag ! DDir ! t ! a ! p ! m ;    --- ragr
      c = Acc
-}

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
