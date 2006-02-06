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
{-
    QuestSlash ip slash = {
      s = \\t,a,p => 
            let 
              cls = slash.s ! t ! a ! p ;
              who = slash.c2 ++ ip.s ! Acc --- stranding in ExtFin 
            in table {
              QDir   => who ++ cls ! OQuest ;
              QIndir => who ++ cls ! ODir
              }
      } ;
-}
    QuestIAdv iadv cl = {
      s = \\t,a,p => iadv.s ++ cl.s ! t ! a ! p ! SDecl
      } ;

    PrepIP p ip = {s = 
      appCompl True Pos p (ip ** {a = agrP3 ip.n ; isPron = False})} ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      n = ip.n
      } ;
{- 
    IDetCN idet num ord cn = {
      s = \\c => idet.s ++ num.s ++ ord.s ++ cn.s ! idet.n ! c ; 
      n = idet.n
      } ;
-}

}
