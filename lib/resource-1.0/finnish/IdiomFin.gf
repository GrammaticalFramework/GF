concrete IdiomFin of Idiom = CatFin ** 
  open MorphoFin, ParadigmsFin, Prelude in {

  flags optimize=all_subs ;

  lin
    ExistNP np = 
      let 
        cas : Polarity -> NPForm = \p -> case p of {
          Pos => NPCase Nom ; -- on olemassa luku
          Neg => NPCase Part  -- ei ole olemassa lukua
          }
      in
      mkClause [] (agrP3 Sg) (insertObj 
        (\\_,b,_ => "olemassa" ++ np.s ! cas b) (predV olla)) ;

    ImpersCl vp = mkClause [] (agrP3 Sg) vp ;

    GenericCl vp = mkClause [] (agrP3 Sg) {
      s = \\_ => vp.s ! VIPass ;
      s2 = vp.s2 ;
      ext = vp.ext ;
      sc = vp.sc
      } ;


    ProgrVP vp = 
      let 
        inf = (vp.s ! VIInf Inf3Iness ! Simul ! Pos ! agrP3 Sg).fin ;
        on  = predV olla
      in {
        s = on.s ;
        s2 = \\b,p,a => inf ++ vp.s2 ! b ! p ! a ;
        ext = vp.ext ;
        sc = vp.sc
        } ;

  oper
    olla = verbOlla ** {sc = NPCase Nom} ;

}

