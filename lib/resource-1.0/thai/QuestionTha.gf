concrete QuestionTha of Question = CatTha ** 
  open ResTha, StringsTha, Prelude in {

  flags optimize=all_subs ;

  lin

-- pos. may, neg. chay may - not always the proper forms ---

    QuestCl cl = {s = \\p => cl.s ! Pos ++ polStr chay_s p ++ m'ay_s} ; 

--
--    QuestVP qp vp = 
--      let cl = mkClause (qp.s ! Nom) {n = qp.n ; p = P3} vp
--      in {s = \\t,a,b,_ => cl.s ! t ! a ! b ! ODir} ;
--
--    QuestSlash ip slash = 
--      mkQuestion (ss (slash.c2 ++ ip.s ! Acc)) slash ;
--      --- stranding in ExratTha 
--
--    QuestIAdv iadv cl = mkQuestion iadv cl ;
--
--    QuestIComp icomp np = 
--      mkQuestion icomp (mkClause (np.s ! Nom) np.a (predAux auxBe)) ;
--
--
--    PrepIP p ip = {s = p.s ++ ip.s ! Nom} ;
--
--    AdvIP ip adv = {
--      s = \\c => ip.s ! c ++ adv.s ;
--      n = ip.n
--      } ;
-- 
--    IDetCN idet num ord cn = {
--      s = \\c => idet.s ++ num.s ++ ord.s ++ cn.s ! idet.n ! c ; 
--      n = idet.n
--      } ;
--
--    CompIAdv a = a ;
--
}
