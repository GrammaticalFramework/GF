concrete IdiomIta of Idiom = CatIta ** 
  open PhonoIta, MorphoIta, ParadigmsIta, Prelude in {

  flags optimize=all_subs ;

  lin
    ExistNP np = 
      mkClause [] (agrP3 np.a.g np.a.n) 
        (insertClit2 (elision "ci" "c'" "ci") 
          (insertComplement (\\_ => np.s ! Ton Nom) 
            (predV copula))) ;
    ImpersCl vp = mkClause [] (agrP3 Masc Sg) vp ;
    GenericCl vp = mkClause "si" (agrP3 Masc Sg) vp ; ---- se ci fanno cose

    ProgrVP vp = 
      insertComplement 
        (\\agr => 
           let 
             clpr = pronArg agr.n agr.p vp.clAcc vp.clDat ;
             obj  = clpr.p2 ++ vp.comp ! agr ++ vp.ext ! Pos ---- pol
           in
           (vp.s ! VPGerund).inf ! (aagr agr.g agr.n) ++ clpr.p1 ++ obj
        )
        (predV (essereV (regV "stare"))) ;

}

