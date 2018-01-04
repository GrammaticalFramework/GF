concrete RelativeDut of Relative = CatDut ** open ResDut in {


  flags optimize=all_subs ;

  lin

    RelCl cl = {
      s = \\t,a,b,_,_ => "zodat" ++ cl.s ! t ! a ! b ! Sub
      } ;

    RelVP rp vp = {
      s = \\t,ant,b,g,n => 
        let 
          agr = case rp.a of {
            RNoAg   => agrgP3 g n ;
            RAg rn p => {g = Utr ; n = rn ; p = p} ---- g 
            } ;
          cl = mkClause (rp.s ! g ! n) agr vp
        in
        cl.s ! t ! ant ! b ! Sub
      } ;

    RelSlash rp slash = {
      s = \\t,a,p,g,n => 
          appPrep slash.c2 (npLite (\\_ => rp.s ! g ! n))
          ++ slash.s ! t ! a ! p ! Sub ;
      c = slash.c2.c
      } ;

    FunRP p np rp = {
      s = \\g,n => np.s ! NPNom ++ appPrep p (npLite (\\_ => rp.s ! g ! n)) ;
      a = RAg np.a.n np.a.p
      } ;

    IdRP = {s = relPron ; a = RNoAg} ;

  oper
    relPron : Gender => Number => Str = \\g,n =>
      case <g,n> of {
        <Neutr,Sg> => "dat" ;
        _ => "die"
      } ;

}
