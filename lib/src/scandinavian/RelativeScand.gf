incomplete concrete RelativeScand of Relative = 
  CatScand ** open CommonScand, ResScand, Prelude in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\t,a,p,ag,_ => 
            pronSuch ! gennumAgr ag ++ conjThat ++ cl.s ! t ! a ! p ! Sub ;
      c = NPAcc
      } ;

    RelVP rp vp = {
      s = \\t,ant,b,ag,rc => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg g n p => {g = g ; n = n ; p = p}
            } ;
          cl = mkClause (rp.s ! ag.g ! ag.n ! rc) agr vp
        in
        cl.s ! t ! ant ! b ! Sub ;
      c = NPNom
      } ;

-- changed by AR 5/6/2016
-- This rule uses preposition stranding ("huset som hon bor i")
-- Pied piping ("huset i vilket hon bor")
-- and the empty relative ("huset hon bor i") are defined in $ExtraScand$.

    RelSlash rp slash = {
          s = \\t,a,p,ag,_ => 
          rp.s ! ag.g ! ag.n ! RAcc ++ slash.s ! t ! a ! p ! Sub ++ slash.n3 ! ag ++ slash.c2.s ;
      c = NPAcc
      } ;

--- The case here could be genitive.

    FunRP p np rp = {
      s = \\g,n,c => np.s ! nominative ++ p.s ++ rp.s ! g ! n ! RPrep True ;
      a = RAg np.a.g np.a.n np.a.p
      } ;

    IdRP = {s = relPron ; a = RNoAg} ;

}
