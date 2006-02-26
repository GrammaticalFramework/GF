concrete IdiomGer of Idiom = CatGer ** 
  open MorphoGer, ParadigmsGer, Prelude in {

  flags optimize=all_subs ;

  lin
    ExistNP np = 
      let geben = dirV2 (mkV "geben" "gibt" "gib" "gab" "gäbe" "gegeben")
      in
      mkClause "es" (agrP3 Sg) 
        (insertObj (\\_ => appPrep geben.c2 np.s) 
          (predV geben)) ;
    ImpersCl vp = mkClause "es" (agrP3 Sg) vp ;
    GenericCl vp = mkClause "man" (agrP3 Sg) vp ;

    ProgrVP = insertAdv "eben" ; ----

}

