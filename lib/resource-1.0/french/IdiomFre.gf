concrete IdiomFre of Idiom = CatFre ** 
  open PhonoFre, MorphoFre, ParadigmsFre, Prelude in {

  flags optimize=all_subs ;

  lin
    ExistNP np = 
      mkClause "il" (agrP3 Masc Sg) 
        (insertClit2 "y" (insertComplement (\\_ => np.s ! Ton Acc) (predV avoir_V))) ;
    ImpersCl vp = mkClause "il" (agrP3 Masc Sg) vp ;
    GenericCl vp = mkClause "on" (agrP3 Masc Sg) vp ;

    ProgrVP vp = 
      insertComplement 
        (\\a => "en" ++ "train" ++ elisDe ++ infVP vp a) 
        (predV copula) ;

}


