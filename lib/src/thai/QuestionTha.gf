concrete QuestionTha of Question = CatTha ** 
  open ResTha, StringsTha, Prelude in {

  flags optimize=all_subs ;

  lin

-- pos. may, neg. chay may - not always the proper forms ---

    QuestCl cl = {s = cl.s ! ClQuest} ; 

---- order of IP and VP to be revisited: Smyth p. 160

    QuestVP qp vp = {s = (mkClause qp vp).s ! ClDecl} ;

    QuestSlash ip slash = {s = \\p => thbind (slash.s ! p) slash.c2 ip.s} ; 

    QuestIAdv iadv cl = {s = \\p => thbind (cl.s ! ClDecl ! p) iadv.s} ; 

    QuestIComp icomp np = {s = \\p => thbind np.s (polStr may_s p) icomp.s} ; 

    PrepIP p ip = thbind p ip ;

    AdvIP ip adv = thbind ip adv ;

    IdetCN det cn = 
      let cnc = if_then_Str det.hasC cn.c []
      in  mkNP (thbind cn.s det.s1 cnc det.s2) ;

    IdetIP idet = mkNP (thbind idet.s1 idet.s2) ;

    IdetQuant iquant num = {
      s1 = num.s ++ iquant.s1 ; --- is num even possible ??
      s2 = iquant.s2 ;
      hasC = iquant.hasC
      } ;

    AdvIAdv i a = thbind i a ;

    CompIAdv a = ss (thbind yuu_s a.s) ;

    CompIP ip = ss (thbind pen_s ip.s) ;

}

