concrete QuestionFin of Question = CatFin ** open ResFin, Prelude in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,a,p => cl.s ! t ! a ! p ! SQuest
      } ;

    QuestVP ip vp = 
      let 
        cl = mkClause (ip.s ! vp.sc) (agrP3 ip.n) vp
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

    PrepIP p ip = {s = 
      appCompl True Pos p (ip ** {a = agrP3 ip.n ; isPron = False})} ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      n = ip.n
      } ;

-- The computation of $ncase$ is a special case of that in $NounFin.DetCN$,
-- since we don't have possessive suffixes or definiteness. 
--- It could still be nice to have a common oper...

    IDetCN idet num ord cn = let n = idet.n in {
      s = \\c => 
        let 
          k = npform2case c ;
          ncase = case <k,num.isNum> of {
            <Nom,  True> => NCase Sg Part ; -- mitkä kolme kytkintä
            <_,    True> => NCase Sg k ;    -- miksi kolmeksi kytkimeksi
            _            => NCase n  k      -- mitkä kytkimet
            }
        in
        idet.s ! k ++ num.s ! Sg ! k ++ ord.s ! n ! k ++ cn.s ! ncase ; 
      n = n
      } ;

}
