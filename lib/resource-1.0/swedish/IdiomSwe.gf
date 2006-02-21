concrete IdiomSwe of Idiom = CatSwe ** 
  open MorphoSwe, ParadigmsSwe, IrregSwe, Prelude in {

  flags optimize=all_subs ;

  lin
    ExistNP np = 
      mkClause "det" (agrP3 neutrum Sg) (insertObj 
        (\\_ => np.s ! accusative) (predV (depV finna_V))) ;
    ImpersCl vp = mkClause "det" (agrP3 neutrum Sg) vp ;
    GenericCl vp = mkClause "man" (agrP3 neutrum Sg) vp ;

    ProgrVP vp = 
      insertObj (\\a => "att" ++ infVP vp a) (predV (partV hålla_V "på")) ;

}

