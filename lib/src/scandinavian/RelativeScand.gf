incomplete concrete RelativeScand of Relative = 
  CatScand ** open CommonScand, ResScand, Prelude in {

  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\t,a,p,ag => 
            pronSuch ! gennumAgr ag ++ conjThat ++ cl.s ! t ! a ! p ! Sub ;
      c = NPAcc
      } ;

    RelVP rp vp = {
      s = \\t,ant,b,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg g n p => {g = g ; n = n ; p = p}
            } ;
          cl = mkClause (rp.s ! ag.g ! ag.n ! RNom) agr vp
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
            RAg g n pr => {g = g ; n = n ; p = pr}
            }
        in
          slash.c2.s ++ rp.s ! ag.g ! ag.n ! RPrep slash.c2.hasPrep ++  
          slash.s ! t ! a ! p ! Sub ++ slash.n3 ! agr ;
      c = NPAcc
      } ;

--- The case here could be genitive.

    FunRP p np rp = {
      s = \\g,n,c => np.s ! nominative ++ p.s ++ rp.s ! g ! n ! RPrep True ;
      a = RAg np.a.g np.a.n np.a.p
      } ;

    IdRP = {s = relPron ; a = RNoAg} ;

}
