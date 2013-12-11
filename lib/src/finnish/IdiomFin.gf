concrete IdiomFin of Idiom = CatFin ** 
  open MorphoFin, StemFin, ParadigmsFin, Prelude in {

  flags optimize=all_subs ; coding=utf8;

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
        cas : NPForm = NPCase Nom ; ---- also partitive in Extra
        vp = insertObj (\\_,b,_ => "olemassa") (predV olla) ; 
        cl = mkClause (subjForm (ip ** {isPron = False ; a = agrP3 ip.n}) cas) (agrP3 ip.n) vp
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

    GenericCl vp = mkClause noSubj (agrP3 Sg) (passVP vp (casePrep nominative)) ;

    ProgrVP vp = 
      let 
        inf = (sverb2verbSep vp.s).s ! Inf Inf3Iness ;
        on  = predV olla
      in {
        s = on.s ;
        s2 = \\b,p,a => inf ++ vp.s2 ! b ! p ! a ;
        adv = vp.adv ;
        ext = vp.ext ;
        vptyp = vp.vptyp ;
        } ;

  ImpPl1 vp = 
    let vps = (sverb2verbSep vp.s).s ! ImperP1Pl
    in
    {s = vps ++
         vp.s2 ! True ! Pos ! Ag Pl P1 ++ vp.adv ! Pos ++ vp.ext
    } ;

  ImpP3 np vp = 
    let vps = (sverb2verbSep vp.s).s ! ImperP3 (verbAgr np.a).n
    in
    {s = np.s ! vp.s.sc ++ vps ++
         vp.s2 ! True ! Pos ! np.a ++ vp.adv ! Pos ++ vp.ext
    } ;

  SelfAdvVP vp = insertAdv (\\_ => "itse") vp ;
  SelfAdVVP vp = insertAdv (\\_ => "itse") vp ;
  SelfNP np = {
      s = \\c => np.s ! c ++ (reflPron np.a).s ! c ;
      a = np.a ;
      isPron = False ;  -- minun toloni --> minun itseni talo
      isNeg = np.isNeg
      } ;

  ExistNPAdv np adv =
      mkClause (\_ -> adv.s) np.a (insertObj 
        (\\_,b,_ => np.s ! NPCase Nom) (predV vpVerbOlla)) ;

  ExistIPAdv ip adv =
      let 
        c  = case ip.n of {Sg => Nom ; Pl => Part} ;
        cl = mkClause (\_ -> ip.s ! NPCase c ++ adv.s) (agrP3 Sg)  -- kuka täällä on ; keitä täällä on
                      (predV vpVerbOlla) ;
      in {
        s = \\t,a,p => cl.s ! t ! a ! p ! SDecl
        } ;

  oper
    olla = vpVerbOlla ;

    noSubj : Polarity -> Str = \_ -> [] ;
}

