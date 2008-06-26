concrete RelativeBul of Relative = CatBul ** open ResBul in {
  flags coding=cp1251 ;


  flags optimize=all_subs ;

  lin
    RelCl cl = {
      s = \\t,a,p,gn => suchRP ! gn ++ "че" ++ cl.s ! t ! a ! p ! Main ; 
      role = RSubj
      } ;

    RelVP rp vp = {
      s = \\t,a,p,gn => 
        let 
          cl = mkClause (rp.s ! gn) {gn=gn; p=P3} vp
        in
        cl.s ! t ! a ! p ! Main ;
      role = RSubj
      } ;

    RelSlash rp slash = {
      s = \\t,a,p,gn => slash.c2.s ++ rp.s ! gn ++ slash.s ! (agrP3 gn) ! t ! a ! p ! Main ;
      role = RObj Acc
      } ;

    FunRP p np rp = {
      s = \\gn => np.s ! RObj Acc ++ p.s ++ (case p.c of {Acc => []; Dat => "на"}) ++ rp.s ! gn ;
      } ;

    IdRP = {
      s = whichRP ;
      } ;
}
