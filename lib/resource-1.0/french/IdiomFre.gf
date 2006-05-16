concrete IdiomFre of Idiom = CatFre ** 
  open PhonoFre, MorphoFre, ParadigmsFre, Prelude in {

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

    ProgrVP vp = 
      insertComplement 
        (\\a => "en" ++ "train" ++ elisDe ++ infVP vp a) 
        (predV copula) ;

}


