concrete IdiomAfr of Idiom = CatAfr ** 
  open MorphoAfr, (P = ParadigmsAfr), IrregAfr, Prelude in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause "dit" (agrP3 Sg) vp ;
    GenericCl vp = mkClause "mens" (agrP3 Sg) vp ;	--afr

    CleftNP np rs = mkClause "dit" (agrP3 Sg) 
      (insertExtrapos (rs.s ! np.a.g ! np.a.n) ----
        (insertObj (\\_ => np.s ! NPNom) (predV zijn_V))) ;

    CleftAdv ad s = mkClause "dit" (agrP3 Sg) 
      (insertExtrapos (conjThat ++ s.s ! Sub)
        (insertObj (\\_ => ad.s) (predV zijn_V))) ;

    ExistNP np = 
      mkClause "daar" (agrP3 np.a.n) 	--afr
        (insertObj (\\_ => np.s ! NPNom) 
          (predV zijn_V)) ;

    ExistIP ip = {
      s = \\t,a,p => 
            let 
              cls = 
                (mkClause "daar" (agrP3 ip.n)  (predV zijn_V)).s ! t ! a ! p ;	--afr
              who = ip.s ! NPNom
            in table {
              QDir   => who ++ cls ! Inv ;
              QIndir => who ++ cls ! Sub
              }
      } ;

    ProgrVP vp = insertAdv ("aan" ++ "die" ++ useInfVP True vp) (predV zijn_V) ;	--afr

    ImpPl1 vp =
      let 
        v   = v2vv (regVerb "laat") ;
        vpi = infVP True vp ;
        vvp = insertExtrapos vpi.p3 (
                insertInf vpi.p2 (
                  insertObj vpi.p1 (
                    predVGen True v))) ;
      in 
      {s = (mkClause "ons" {g = Neutr ; n = Pl ; p = P1} vvp).s ! 
                           Pres ! Simul ! Pos ! Inv 
      } ;

}
