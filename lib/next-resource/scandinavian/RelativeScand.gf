incomplete concrete RelativeScand of Relative = 
  CatScand ** open CommonScand, ResScand, Prelude in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\t,a,p,ag => pronSuch ! ag.gn ++ conjThat ++ cl.s ! t ! a ! p ! Sub ;
      c = NPAcc
      } ;

    RelVP rp vp = {
      s = \\t,ant,b,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg a => a
            } ;
          cl = mkClause (rp.s ! ag.gn ! RNom) agr vp
        in
        cl.s ! t ! ant ! b ! Sub ;
      c = NPNom
      } ;

-- This rule uses pied piping ("huset i vilket hon bor")
-- Preposition stranding ("huset som hon bor i")
-- and the empty relative ("huset hon bor i") are defined in $ExtraScand$.

    RelSlash rp slash = {
      s = \\t,a,p,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg agg => agg
            }
        in
          slash.c2.s ++ rp.s ! ag.gn ! RPrep slash.c2.hasPrep ++  
          slash.s ! t ! a ! p ! Sub ++ slash.n3 ! agr ;
      c = NPAcc
      } ;

--- The case here could be genitive.

    FunRP p np rp = {
      s = \\gn,c => np.s ! nominative ++ p.s ++ rp.s ! gn ! RPrep True ;
      a = RAg np.a
      } ;

    IdRP = {s = relPron ; a = RNoAg} ;

}
