concrete IdiomNor of Idiom = CatNor ** 
  open MorphoNor, ParadigmsNor, IrregNor, Prelude in {

  flags optimize=all_subs ;

  lin

    ImpersCl vp = mkClause "det" (agrP3 ParadigmsNor.neutrum Sg) vp ;
    GenericCl vp = mkClause "man" (agrP3 utrum Sg) vp ;

    CleftNP np rs = mkClause "det" (agrP3 ParadigmsNor.neutrum Sg) 
        (insertObj (\\_ => np.s ! rs.c ++ rs.s ! np.a) (predV verbBe)) ;

    CleftAdv ad s = mkClause "det" (agrP3 ParadigmsNor.neutrum Sg) 
      (insertObj (\\_ => ad.s ++ s.s ! Sub) (predV verbBe)) ;

    ExistNP np = 
      mkClause "det" (agrP3 ParadigmsNor.neutrum Sg) (insertObj 
        (\\_ => np.s ! accusative) (predV (depV finne_V))) ;

    ExistIP ip = {
      s = \\t,a,p => 
            let 
              cls = 
               (mkClause "det" (agrP3 ParadigmsNor.neutrum Sg) (predV (depV finne_V))).s ! t ! a ! p ;
              who = ip.s ! accusative
            in table {
              QDir   => who ++ cls ! Inv ;
              QIndir => who ++ cls ! Sub
              }
      } ;

    ProgrVP vp = 
      insertObj (\\a => ["ved å"] ++ infVP vp a) (predV verbBe) ;

    ImpPl1 vp = {s = ["lat oss"] ++ infVP vp {gn = Plg ; p = P1}} ;


}

