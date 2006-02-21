concrete IdiomSpa of Idiom = CatSpa ** 
  open MorphoSpa, ParadigmsSpa, BeschSpa, Prelude in {

  flags optimize=all_subs ;

  lin
    ExistNP np = 
      mkClause [] (agrP3 Masc Sg)
        (insertComplement (\\_ => np.s ! Ton Acc) (predV (verboV (hay_3 "haber")))) ;
    ImpersCl vp = mkClause [] (agrP3 Masc Sg) vp ;
    GenericCl vp = mkClause "se" (agrP3 Masc Sg) vp ; ---- just Italian ?

    ProgrVP vp = 
      insertComplement 
        (\\agr => 
           let 
             clpr = pronArg agr.n agr.p vp.clAcc vp.clDat ;
             obj  = clpr.p2 ++ vp.comp ! agr ++ vp.ext ! Pos ---- pol
           in
           (vp.s ! VPGerund).inf ! (aagr agr.g agr.n) ++ clpr.p1 ++ obj
        )
        (predV (verboV (estar_2 "estar"))) ;

}
