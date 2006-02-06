concrete RelativeFin of Relative = CatFin ** open ResFin in {

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
{-
    RelSlash rp slash = {
      s = \\t,a,p,_ => slash.c2 ++ rp.s ! Acc ++ slash.s ! t ! a ! p ! ODir
      } ;

    FunRP p np rp = {
      s = \\c => np.s ! c ++ p.s ++ rp.s ! Acc ;
      a = RAg np.a
      } ;

    IdRP = mkIP "which" "which" "whose" Sg ** {a = RNoAg} ;
-}
}
