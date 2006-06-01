concrete IdiomSpa of Idiom = CatSpa ** 
  open (P = ParamX), MorphoSpa, ParadigmsSpa, BeschSpa, Prelude in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause [] (agrP3 Masc Sg) vp ;
    GenericCl vp = mkClause "se" (agrP3 Masc Sg) vp ; ---- just Italian ?

    CleftNP np rs = mkClause [] (agrP3 Masc Sg) 
      (insertComplement (\\_ => rs.s ! Indic ! np.a)
        (insertComplement (\\_ => np.s ! Ton rs.c) (predV copula))) ;

    CleftAdv ad s = mkClause [] (agrP3 Masc Sg) 
      (insertComplement (\\_ => conjThat ++ s.s ! Indic)
        (insertComplement (\\_ => ad.s) (predV copula))) ;


    ExistNP np = 
      mkClause [] (agrP3 Masc Sg)
        (insertComplement (\\_ => np.s ! Ton Acc) (predV (verboV (hay_3 "haber")))) ;
    ExistIP ip = {
      s = \\t,a,p,_ =>
        ip.s ! Nom ++ 
        (mkClause [] (agrP3 Masc Sg) (predV (verboV (hay_3 "haber")))).s ! t ! a ! p ! Indic
      } ;

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

    ImpPl1 vp = {s = 
      (mkClause [] {g = Fem ; n = Pl ; p = P1} vp).s ! P.Pres ! Simul ! Pos ! Indic 
      } ;

}
