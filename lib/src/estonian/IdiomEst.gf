concrete IdiomEst of Idiom = CatEst ** 
  open MorphoEst, ParadigmsEst, Prelude in {

  flags optimize=all_subs ; coding=utf8;

  lin
    ExistNP np = 
      let 
        cas : Polarity -> NPForm = \p -> case p of {
          Pos => NPCase Nom ; -- on olemas lammas
          Neg => NPCase Part  -- ei ole olemas lammast
          }
      in
      mkClause noSubj (agrP3 Sg) (insertObj 
        (\\_,b,_ => "olemas" ++ np.s ! cas b) (predV olla)) ;

    ExistIP ip = 
      let
        cas : NPForm = NPCase Nom ; ---- also partitive in Extra
        vp = insertObj (\\_,b,_ => "olemas") (predV olla) ;
        cl = mkClause (subjForm (ip ** {isPron = False ; a = agrP3 ip.n}) cas) (agrP3 Sg) vp
      in {
        s = \\t,a,p => cl.s ! t ! a ! p ! SDecl
        } ;

-- Notice the nominative in the cleft $NP$: "se on Matti josta Liisa pitÃ¤Ã¤"
-- Est: "see on Mati, kellest Liis lugu peab"

    CleftNP np rs = mkClause (\_ -> "see") (agrP3 Sg)
      (insertExtrapos (rs.s ! np.a)
        (insertObj (\\_,_,_ => np.s ! NPCase Nom) (predV olla))) ;

-- This gives the almost forbidden "se on Porissa kun Matti asuu".
-- Est: "see on Toris, kus Mati elab" (?)

    CleftAdv ad s = mkClause (\_ -> "see") (agrP3 Sg)
      (insertExtrapos ("kus" ++ s.s)
        (insertObj (\\_,_,_ => ad.s) (predV olla))) ;

    ImpersCl vp = mkClause noSubj (agrP3 Sg) vp ;

    GenericCl vp = mkClause noSubj (agrP3 Sg) {
      s = \\_ => vp.s ! VIPass ;
      s2 = vp.s2 ;
      adv = vp.adv ;
      p = vp.p ;
      ext = vp.ext ;
      sc = vp.sc ; 
      } ;

    ProgrVP vp = 
      let 
        inf = (vp.s ! VIInf InfMas ! Simul ! Pos ! agrP3 Sg).fin ;
        on  = predV olla
      in {
        s = on.s ;
        s2 = \\b,p,a => vp.s2 ! b ! p ! a ++ inf ;
        adv = vp.adv ;
        p = vp.p ;
        ext = vp.ext ;
        sc = vp.sc ; 
        } ;

-- This gives "otetaan oluet" instead of "ottakaamme oluet".
-- The imperative is not available in a $VP$.

  ImpPl1 vp = 
    let vps = vp.s ! VIPass ! Simul ! Pos ! Ag Pl P1
    in
    {s = vps.fin ++ vps.inf ++ 
         vp.s2 ! True ! Pos ! Ag Pl P1 ++ vp.p ++ vp.ext
    } ;

  oper
    olla = verbOlema ** {sc = NPCase Nom} ;

    noSubj : Polarity -> Str = \_ -> [] ;
}

