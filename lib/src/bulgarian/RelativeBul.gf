--# -coding=cp1251
concrete RelativeBul of Relative = CatBul ** open ResBul in {
  flags coding=cp1251 ;


  flags optimize=all_subs ;

  lin
    RelCl cl = {
      s = \\t,a,p,agr => suchRP ! agr.gn ++ "че" ++ cl.s ! t ! a ! p ! Main
      } ;

    RelVP rp vp = {
      s = \\t,a,p,agr => 
        let
          pp = case agr.p of {
                 P1 => PronP1 ;
                 P2 => PronP2 ;
                 P3 => PronP3
               } ;
          cl = mkClause (rp.s ! agr.gn) agr.gn pp vp
        in
        cl.s ! t ! a ! p ! Main
      } ;

    RelSlash rp slash = {
      s = \\t,a,p,agr => slash.c2.s ++ rp.s ! agr.gn ++ slash.s ! agr ! t ! a ! p ! Main
      } ;

    FunRP p np rp = {
      s = \\gn => np.s ! RObj CPrep ++ linPrep p ++ rp.s ! gn ;
      } ;

    IdRP = {
      s = whichRP ;
      } ;
}
