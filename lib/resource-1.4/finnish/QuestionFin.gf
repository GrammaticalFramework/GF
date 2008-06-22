concrete QuestionFin of Question = CatFin ** open ResFin, Prelude in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,a,p => cl.s ! t ! a ! p ! SQuest
      } ;

    QuestVP ip vp = 
      let 
        cl = mkClause (subjForm (ip ** {isPron = False ; a = agrP3 ip.n}) vp.sc) (agrP3 ip.n) vp
      in {
        s = \\t,a,p => cl.s ! t ! a ! p ! SDecl
        } ;

    QuestSlash ip slash = {
      s = \\t,a,p => 
            let 
              cls = slash.s ! t ! a ! p ;
              who = appCompl True p slash.c2 (ip ** {a = agrP3 ip.n ; isPron = False})
            in
            who ++ cls
      } ;

    QuestIAdv iadv cl = {
      s = \\t,a,p => iadv.s ++ cl.s ! t ! a ! p ! SDecl
      } ;

    QuestIComp icomp np = {
      s = \\t,a,p => 
        let 
          vp = predV (verbOlla ** {sc = NPCase Nom ; qp = "ko"}) ;
          cl = mkClause (subjForm np vp.sc) np.a vp ;
        in
        icomp.s ! np.a ++ cl.s ! t ! a ! p ! SDecl
      } ;

    PrepIP p ip = {s = 
      appCompl True Pos p (ip ** {a = agrP3 ip.n ; isPron = False})} ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      n = ip.n
      } ;

-- The computation of $ncase$ is a special case of that in $NounFin.DetCN$,
-- since we don't have possessive suffixes or definiteness. 
--- It could still be nice to have a common oper...

    IdetCN idet cn = let n = idet.n in {
      s = \\c => 
        let 
          k = npform2case n c ;
          ncase = case <k,idet.isNum> of {
            <Nom,  True> => NCase Sg Part ; -- mitkä kolme kytkintä
            <_,    True> => NCase Sg k ;    -- miksi kolmeksi kytkimeksi
            _            => NCase n  k      -- mitkä kytkimet
            }
        in
        idet.s ! k ++ cn.s ! ncase ; 
      n = n
      } ;

    IdetIP idet = let n = idet.n in {
      s = \\c => 
        let 
          k = npform2case n c ;
        in
        idet.s ! k ; 
      n = n
      } ;

    IdetQuant idet num = 
      let 
        n = num.n ;
        isn = num.isNum 
      in {
        s = \\k => 
        let 
          ncase = case <k,isn> of {
            <Nom,  True> => NCase Sg Part ; -- mitkä kolme kytkintä
            <_,    True> => NCase Sg k ;    -- miksi kolmeksi kytkimeksi
            _            => NCase n  k      -- mitkä kytkimet
            }
        in
        idet.s ! n ! k ++ num.s ! Sg ! k ; 
      n = n ;
      isNum = isn
      } ;

    CompIAdv a = {s = \\_ => a.s} ;
    CompIP ip = {s = \\_ => ip.s ! NPCase Nom} ;

}
