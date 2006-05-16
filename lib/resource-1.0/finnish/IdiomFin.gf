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
      mkClause noSubj (agrP3 Sg) (insertObj 
        (\\_,b,_ => "olemassa" ++ np.s ! cas b) (predV olla)) ;

    ExistIP ip = 
      let
        cas : NPForm = NPCase Part ; --- dep on num, pol?
        vp = insertObj (\\_,b,_ => "olemassa") (predV olla) ; 
        cl = mkClause (subjForm (ip ** {isPron = False ; a = agrP3 Sg}) cas) (agrP3 Sg) vp
      in {
        s = \\t,a,p => cl.s ! t ! a ! p ! SDecl
        } ;

    ImpersCl vp = mkClause noSubj (agrP3 Sg) vp ;

    GenericCl vp = mkClause noSubj (agrP3 Sg) {
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

    noSubj : Polarity -> Str = \_ -> [] ;
}

