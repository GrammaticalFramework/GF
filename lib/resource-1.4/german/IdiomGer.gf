concrete IdiomGer of Idiom = CatGer ** 
  open MorphoGer, ParadigmsGer, Prelude in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause "es" (agrP3 Sg) vp ;
    GenericCl vp = mkClause "man" (agrP3 Sg) vp ;

    CleftNP np rs = mkClause "es" (agrP3 Sg) 
      (insertExtrapos (rs.s ! gennum np.a.g np.a.n) ----
        (insertObj (\\_ => np.s ! rs.c) (predV MorphoGer.sein_V))) ;

    CleftAdv ad s = mkClause "es" (agrP3 Sg) 
      (insertExtrapos (conjThat ++ s.s ! Sub)
        (insertObj (\\_ => ad.s) (predV MorphoGer.sein_V))) ;


    ExistNP np = 
      mkClause "es" (agrP3 Sg) 
        (insertObj (\\_ => appPrep geben.c2 np.s) 
          (predV geben)) ;

    ExistIP ip = {
      s = \\m,t,a,p => 
            let 
              cls = 
                (mkClause "es" (agrP3 Sg)  (predV geben)).s ! m ! t ! a ! p ;
              who = ip.s ! Acc
            in table {
              QDir   => who ++ cls ! Inv ;
              QIndir => who ++ cls ! Sub
              }
      } ;

    ProgrVP = insertAdv "eben" ; ----

    ImpPl1 vp = {s = 
      (mkClause "wir" {g = Fem ; n = Pl ; p = P1} vp).s ! 
                           MConjunct ! Pres ! Simul ! Pos ! Inv 
      } ;

  oper
    geben = dirV2 (mk6V "geben" "gibt" "gib" "gab" "gäbe" "gegeben") ;
}

