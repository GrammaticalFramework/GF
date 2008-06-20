concrete IdiomSwe of Idiom = CatSwe ** 
  open MorphoSwe, ParadigmsSwe, IrregSwe, Prelude in {

  flags optimize=all_subs ;

  oper
    utr = ParadigmsSwe.utrum ;
    neutr = ParadigmsSwe.neutrum ;

  lin
    ImpersCl vp = mkClause "det" (agrP3 neutr Sg) vp ;
    GenericCl vp = mkClause "man" (agrP3 utr Sg) vp ;

    CleftNP np rs = mkClause "det" (agrP3 neutr Sg) 
        (insertObj (\\_ => np.s ! rs.c ++ rs.s ! np.a) (predV verbBe)) ;

    CleftAdv ad s = mkClause "det" (agrP3 neutr Sg) 
      (insertObj (\\_ => ad.s ++ s.s ! Sub) (predV verbBe)) ;

    ExistNP np = 
      mkClause "det" (agrP3 neutr Sg) (insertObj 
        (\\_ => np.s ! accusative) (predV (depV finna_V))) ;

    ExistIP ip = {
      s = \\t,a,p => 
            let 
              cls = 
               (mkClause "det" (agrP3 neutr Sg) (predV (depV finna_V))).s ! t ! a ! p ;
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

