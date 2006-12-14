concrete IdiomFre of Idiom = CatFre ** 
  open (P = ParamX), PhonoFre, MorphoFre, ParadigmsFre, Prelude in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause "il" (agrP3 Masc Sg) vp ;
    GenericCl vp = mkClause "on" (agrP3 Masc Sg) vp ;

    ExistNP np = 
      mkClause "il" (agrP3 Masc Sg) 
        (insertClit2 "y" (insertComplement (\\_ => np.s ! Ton Acc) (predV avoir_V))) ;

    ExistIP ip = {
      s = \\t,a,p,_ => 
        ip.s ! Nom ++ 
        (mkClause "il" (agrP3 Masc Sg) (insertClit2 "y" (predV avoir_V))).s ! t ! a ! p ! Indic
      } ;

    CleftNP np rs = mkClause elisCe (agrP3 Masc Sg) 
      (insertComplement (\\_ => rs.s ! Indic ! np.a)
        (insertComplement (\\_ => np.s ! Ton rs.c) (predV copula))) ;

    CleftAdv ad s = mkClause elisCe (agrP3 Masc Sg) 
      (insertComplement (\\_ => conjThat ++ s.s ! Indic)
        (insertComplement (\\_ => ad.s) (predV copula))) ;


    ProgrVP vp = 
      insertComplement 
        (\\a => "en" ++ "train" ++ elisDe ++ infVP vp a) 
        (predV copula) ;

    ImpPl1 vp = {s =
      (mkImperative False P1 vp).s ! Pos ! {n = Pl ; g = Masc} --- fem
      } ;

  oper
    elisCe = elision "c" ;

}


