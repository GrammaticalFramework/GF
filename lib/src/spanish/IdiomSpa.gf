concrete IdiomSpa of Idiom = CatSpa ** 
  open (P = ParamX), MorphoSpa, ParadigmsSpa, BeschSpa, Prelude in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause [] True False (agrP3 Masc Sg) vp ;

    GenericCl vp = 
      mkClause [] True False (agrP3 Masc Sg) (insertRefl vp) ; ---- just Italian ?

    CleftNP np rs = mkClause [] True False (agrP3 Masc Sg) 
      (insertComplement (\\_ => rs.s ! Indic ! np.a)
        (insertComplement (\\_ => (np.s ! rs.c).ton) (predV copula))) ;

    CleftAdv ad s = mkClause [] True False (agrP3 Masc Sg) 
      (insertComplement (\\_ => conjThat ++ s.s ! Indic)
        (insertComplement (\\_ => ad.s) (predV copula))) ;


    ExistNP np = 
      mkClause [] True False (agrP3 Masc Sg)
        (insertComplement (\\_ => (np.s ! Acc).ton) (predV (verboV (hay_3 "haber")))) ;
    ExistIP ip = {
      s = \\t,a,p,_ =>
        ip.s ! Nom ++ 
        (mkClause [] True False (agrP3 Masc Sg) (predV (verboV (hay_3 "haber")))).s ! DDir ! t ! a ! p ! Indic
      } ;

    ProgrVP vp = 
      insertComplement 
        (\\agr => 
           let 
             clpr = <vp.clit1,vp.clit2> ; ----e pronArg agr.n agr.p vp.clAcc vp.clDat ;
             obj  = clpr.p2 ++ vp.comp ! agr ++ vp.ext ! Pos ---- pol
           in
           vp.s.s ! VGer ++ clpr.p1 ++ obj
        )
        (predV (verboV (estar_2 "estar"))) ;

    ImpPl1 vp = {s =
      mkImperative False P1 vp ! Pos ! Masc ! Pl ; --- fem
      } ;

}
