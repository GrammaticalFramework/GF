concrete RelativeDut of Relative = CatDut ** open ResDut in {


  flags optimize=all_subs ;

  lin

--    RelCl cl = {
--      s = \\m,t,a,b,_ => "derart" ++ conjThat ++ cl.s ! m ! t ! a ! b ! Sub ;
--      c = Nom
--      } ;
--
    RelVP rp vp = {
      s = \\t,ant,b,g,n => 
        let 
          agr = case rp.a of {
            RNoAg   => agrgP3 g n ;
            RAg rn p => {g = Utr ; n = rn ; p = p} ---- g 
            } ;
          cl = mkClause (rp.s ! g ! n) agr vp
        in
        cl.s ! t ! ant ! b ! Sub ;
      c = Nom
      } ;

    RelSlash rp slash = {
      s = \\t,a,p,g,n => 
          appPrep slash.c2 (\\_ => rp.s ! g ! n) ++ slash.s ! t ! a ! p ! Sub ;
      c = slash.c2.c
      } ;

--    FunRP p np rp = {
--      s = \\gn,c => np.s ! c ++ appPrep p (rp.s ! gn) ;
--      a = RAg {n = np.a.n ; p = np.a.p}
--      } ;
--
    IdRP = {s = relPron ; a = RNoAg} ;

  oper
    relPron : Gender => Number => Str = \\g,n =>
      case <g,n> of {
        <Neutr,Sg> => "dat" ;
        _ => "die"
      } ;

}
