concrete IdiomDan of Idiom = CatDan ** 
  open MorphoDan, ParadigmsDan, IrregDan, Prelude in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause "det" (agrP3 neutrum Sg) vp ;
    GenericCl vp = mkClause "man" (agrP3 utrum Sg) vp ;

    ExistNP np = 
      mkClause "det" (agrP3 neutrum Sg) (insertObj 
        (\\_ => np.s ! accusative) (predV (depV finde_V))) ;

    ExistIP ip = {
      s = \\t,a,p => 
            let 
              cls = 
               (mkClause "det" (agrP3 neutrum Sg) (predV (depV finde_V))).s ! t ! a ! p ;
              who = ip.s ! accusative
            in table {
              QDir   => who ++ cls ! Inv ;
              QIndir => who ++ cls ! Sub
              }
      } ;

    ProgrVP vp = 
      insertObj (\\a => ["ved å"] ++ infVP vp a) (predV verbBe) ;

}

