concrete IdiomCat of Idiom = CatCat ** 
  open MorphoCat, ParadigmsCat, BeschCat, Prelude in {

  flags optimize=all_subs ;

  lin
    ExistNP np = mkClause [] True (agrP3 Masc Sg) 
        (insertClit3 "hi" (insertComplement (\\_ => (np.s ! Acc).ton) (predV haver_V))) ;
    GenericCl vp = mkClause "hom" True (agrP3 Masc Sg) vp ;
    ImpersCl vp = mkClause [] True (agrP3 Masc Sg) vp ;


    ProgrVP vp = 
      insertComplement 
        (\\agr => 
           let 
             clpr = <vp.clit1,vp.clit2> ; ----e pronArg agr.n agr.p vp.clAcc vp.clDat ;
             obj  = clpr.p2 ++ vp.comp ! agr ++ vp.ext ! Pos ---- pol
           in
           vp.s.s ! VGer ++ clpr.p1 ++ obj
        )
        (predV (verbV (estar_54 "estar"))) ;

----AR, for completeness

    CleftNP np rs = mkClause [] True (agrP3 Masc Sg) 
      (insertComplement (\\_ => rs.s ! Indic ! np.a)
        (insertComplement (\\_ => (np.s ! rs.c).ton) (predV copula))) ;


    ExistIP ip = {
      s = \\t,a,p,_ =>
        ip.s ! Nom ++ 
        (mkClause [] True 
          (agrP3 Masc Sg) 
          (insertClit3 "hi" (insertComplement (\\_ => ip.s ! Acc) (predV haver_V))))
          .s ! DDir ! t ! a ! p ! Indic
      } ;

    ImpPl1 vp = {s =
      (mkImperative False P1 vp).s ! Pos ! Ag Masc Pl P1 ; --- fem
      } ;

    CleftAdv ad s = mkClause [] True (agrP3 Masc Sg) 
      (insertComplement (\\_ => conjThat ++ s.s ! Indic)
        (insertComplement (\\_ => ad.s) (predV copula))) ;

        



}
