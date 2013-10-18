concrete RelativeEst of Relative = CatEst ** open Prelude, ResEst, MorphoEst in {

  flags optimize=all_subs ; coding=utf8;

  lin

    RelCl cl = {
      s = \\t,a,p,_ => "nii" ++ "et" ++ cl.s ! t ! a ! p ! SDecl ;
      ---- sellainen
      c = NPCase Nom
      } ;

    RelVP rp vp = {
      s = \\t,ant,b,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg a => a
            } ;
          cl = mkClause 
             (subjForm {s = rp.s ! (complNumAgr agr) ; 
                        a = agr ; isPron = False} vp.sc) agr vp
        in
        cl.s ! t ! ant ! b ! SDecl ;
      c = NPCase Nom
      } ;

    RelSlash rp slash = {
      s = \\t,a,p,ag => 
            let 
              cls = slash.s ! t ! a ! p ;
              who = appCompl True p slash.c2 (rp2np (complNumAgr ag) rp)
            in
            who ++ cls ;
      c = slash.c2.c
      } ;

    FunRP p np rp = {
      s = \\n,c => appCompl True Pos p (rp2np n rp) ++ np.s ! c ; --- is c OK?
      a = RAg np.a
      } ;

    IdRP = {
      s = \\n,c => relPron ! n ! npform2case n c ;
      a = RNoAg
      } ;



}
