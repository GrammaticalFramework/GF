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

-- Notice the nominative in the cleft $NP$: "se on Matti josta Liisa pitää"

    CleftNP np rs = mkClause (\_ -> "se") (agrP3 Sg) 
      (insertExtrapos (rs.s ! np.a)
        (insertObj (\\_,_,_ => np.s ! NPCase Nom) (predV olla))) ;

-- This gives the almost forbidden "se on Porissa kun Matti asuu".

    CleftAdv ad s = mkClause (\_ -> "se") (agrP3 Sg) 
      (insertExtrapos ("kun" ++ s.s)
        (insertObj (\\_,_,_ => ad.s) (predV olla))) ;

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

-- This gives "otetaan oluet" instead of "ottakaamme oluet".
-- The imperative is not available in a $VP$.

  ImpPl1 vp = 
    let vps = vp.s ! VIPass ! Simul ! Pos ! {n = Pl ; p = P1}
    in
    {s = vps.fin ++ vps.inf ++ vp.s2 ! True ! Pos ! {n = Pl ; p = P1} ++ vp.ext
    } ;

  oper
    olla = verbOlla ** {sc = NPCase Nom} ;

    noSubj : Polarity -> Str = \_ -> [] ;
}

