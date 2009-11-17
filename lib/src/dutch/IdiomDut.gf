concrete IdiomDut of Idiom = CatDut ** 
  open MorphoDut, ParadigmsDut, IrregDut, Prelude in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause "'t" (agrP3 Sg) vp ;
    GenericCl vp = mkClause "men" (agrP3 Sg) vp ;

    CleftNP np rs = mkClause "'t" (agrP3 Sg) 
      (insertExtrapos (rs.s ! np.a.g ! np.a.n) ----
        (insertObj (\\_ => np.s ! NPNom) (predV zijn_V))) ;

    CleftAdv ad s = mkClause "'t" (agrP3 Sg) 
      (insertExtrapos (conjThat ++ s.s ! Sub)
        (insertObj (\\_ => ad.s) (predV zijn_V))) ;

    ExistNP np = 
      mkClause "er" (agrP3 np.a.n) 
        (insertObj (\\_ => np.s ! NPNom) 
          (predV zijn_V)) ;

    ExistIP ip = {
      s = \\t,a,p => 
            let 
              cls = 
                (mkClause "er" (agrP3 ip.n)  (predV zijn_V)).s ! t ! a ! p ;
              who = ip.s ! NPNom
            in table {
              QDir   => who ++ cls ! Inv ;
              QIndir => who ++ cls ! Sub
              }
      } ;

    ProgrVP = insertAdv "even" ; ----

    ImpPl1 vp =
      let 
        v   = laten_V ;
        vpi = infVP True vp ;
        vvp = insertExtrapos vpi.p3 (
                insertInf vpi.p2 (
                  insertObj vpi.p1 (
                    predVGen True v))) ;
      in 
      {s = (mkClause "we" {g = Utr ; n = Pl ; p = P1} vvp).s ! 
                           Pres ! Simul ! Pos ! Inv 
      } ;

}
