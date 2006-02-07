concrete RelativeFin of Relative = CatFin ** open Prelude, ResFin, MorphoFin in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\t,a,p,_ => "siten" ++ "että" ++ cl.s ! t ! a ! p ! SDecl
      ---- sellainen
      } ;

    RelVP rp vp = {
      s = \\t,ant,b,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg a => a
            } ;
          cl = mkClause (rp.s ! agr.n ! vp.sc) agr vp
        in
        cl.s ! t ! ant ! b ! SDecl
      } ;

    RelSlash rp slash = {
      s = \\t,a,p,ag => 
            let 
              cls = slash.s ! t ! a ! p ;
              who = appCompl True p slash.c2 (rp2np ag.n rp)
            in
            who ++ cls
      } ;

    FunRP p np rp = {
      s = \\n,c => appCompl True Pos p (rp2np n rp) ++ np.s ! c ; --- is c OK?
      a = RAg np.a
      } ;

    IdRP = {
      s = \\n,c => relPron ! n ! npform2case c ;
      a = RNoAg
      } ;

oper
  rp2np : Number -> {s : Number => NPForm => Str ; a : RAgr} -> NP = \n,rp -> {
    s = rp.s ! n ;
    a = agrP3 Sg ;  -- does not matter (--- at least in Slash)
    isPron = False  -- has no special accusative
    } ;

}
