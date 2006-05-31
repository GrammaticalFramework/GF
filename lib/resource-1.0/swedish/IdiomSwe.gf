concrete IdiomSwe of Idiom = CatSwe ** 
  open MorphoSwe, ParadigmsSwe, IrregSwe, Prelude in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause "det" (agrP3 neutrum Sg) vp ;
    GenericCl vp = mkClause "man" (agrP3 utrum Sg) vp ;

    CleftNP np rs = mkClause "det" (agrP3 neutrum Sg) 
      (insertObj (\\_ => rs.s ! np.a)
        (insertObj (\\_ => np.s ! rs.c) (predV verbBe))) ;

    CleftAdv ad s = mkClause "det" (agrP3 neutrum Sg) 
      (insertObj (\\_ => s.s ! Main)
        (insertObj (\\_ => ad.s) (predV verbBe))) ;


    ExistNP np = 
      mkClause "det" (agrP3 neutrum Sg) (insertObj 
        (\\_ => np.s ! accusative) (predV (depV finna_V))) ;

    ExistIP ip = {
      s = \\t,a,p => 
            let 
              cls = 
               (mkClause "det" (agrP3 neutrum Sg) (predV (depV finna_V))).s ! t ! a ! p ;
              who = ip.s ! accusative
            in table {
              QDir   => who ++ cls ! Inv ;
              QIndir => who ++ cls ! Sub
              }
      } ;


    ProgrVP vp = 
      insertObj (\\a => "att" ++ infVP vp a) (predV (partV hålla_V "på")) ;

    ImpPl1 vp = {s = ["låt oss"] ++ infVP vp {gn = Plg ; p = P1}} ;


}

