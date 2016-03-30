concrete IdiomSwe of Idiom = CatSwe ** 
  open MorphoSwe, ParadigmsSwe, IrregSwe, Prelude in {

  flags optimize=all_subs ;
    coding=utf8 ;

  oper
    utr = ParadigmsSwe.utrum ;
    neutr = ParadigmsSwe.neutrum ;

  lin
    ImpersCl vp = mkClause "det" (agrP3 neutr Sg) vp ;
    GenericCl vp = mkClause "man" (agrP3 utr Sg) vp ;

    CleftNP np rs = mkClause "det" (agrP3 neutr Sg) 
        (insertObj (\\_ => np.s ! rs.c ++ rs.s ! np.a ! RNom) (predV verbBe)) ;

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

    ExistNPAdv np adv = 
      mkClause "det" (agrP3 neutr Sg) (insertObj
        (\\_ => np.s ! accusative ++ adv.s) (predV (depV finna_V))) ;

    ExistIPAdv ip adv = {
      s = \\t,a,p => 
            let 
              cls = 
               (mkClause "det" (agrP3 neutr Sg) (insertAdv adv.s (predV (depV finna_V)))).s ! t ! a ! p ;
              who = ip.s ! accusative
            in table {
              QDir   => who ++ cls ! Inv ;
              QIndir => who ++ cls ! Sub
              }
      } ;

    ProgrVP vp = 
      insertObj (\\a => "att" ++ infVP vp a) (predV (partV hålla_V "på")) ;

    ImpPl1 vp = {s = ["låt oss"] ++ infVP vp {g = Utr ; n = Pl ; p = P1}} ;

    SelfAdvVP vp = insertObj (\\a => sjalv a.g a.n) vp ;
    SelfAdVVP vp = insertAdVAgr (\\a => sjalv a.g a.n) vp ;
    SelfNP np = {
      s = \\c => np.s ! c ++ sjalv np.a.g np.a.n ;
      a = np.a ;
      isPron = False
      } ;

  oper
    sjalv : Gender -> Number -> Str = \g,n -> case <g,n> of {
      <Utr,Sg> => "själv" ;
      <Neutr,Sg> => "självt" ;
      _ => "själva" 
      } ;


}

