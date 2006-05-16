concrete IdiomGer of Idiom = CatGer ** 
  open MorphoGer, ParadigmsGer, Prelude in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause "es" (agrP3 Sg) vp ;
    GenericCl vp = mkClause "man" (agrP3 Sg) vp ;

    ExistNP np = 
      mkClause "es" (agrP3 Sg) 
        (insertObj (\\_ => appPrep geben.c2 np.s) 
          (predV geben)) ;

    ExistIP ip = {
      s = \\t,a,p => 
            let 
              cls = (mkClause "es" (agrP3 Sg)  (predV geben)).s ! t ! a ! p ;
              who = ip.s ! Acc
            in table {
              QDir   => who ++ cls ! Inv ;
              QIndir => who ++ cls ! Sub
              }
      } ;

    ProgrVP = insertAdv "eben" ; ----

  oper
    geben = dirV2 (mkV "geben" "gibt" "gib" "gab" "gäbe" "gegeben") ;
}

