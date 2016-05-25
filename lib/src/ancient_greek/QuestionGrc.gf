concrete QuestionGrc of Question = CatGrc ** open ResGrc, Prelude in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,pol => 
            let cls = cl.s ! t ! pol
            in table {
              QDir   => cls ! VSO ;         -- Order ok?
              QIndir => "ei)" ++ cls ! VSO  -- Order ok?
              } 
      } ;

    QuestVP qp vp = 
      let cl = mkClause (qp.s ! Nom) (agrP3 qp.n) vp
        in {s = \\t,pol,qf => cl.s ! t ! pol ! SVO } ; -- TODO: ignore qf? Order?

--    QuestSlash ip slash = 
--      mkQuestion (ss (slash.c2 ++ ip.s ! Acc)) slash ;
--      --- stranding in ExratGrc 

--    QuestIAdv iadv cl = mkQuestion iadv cl ;

--    QuestIComp icomp np = 
--      mkQuestion icomp (mkClause (np.s ! Nom) np.a (predAux auxBe)) ;


    PrepIP p ip = {s = p.s ++ ip.s ! Acc} ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      n = ip.n
      } ;

    IdetCN idet cn = { -- (attributive) ti's as IDet inflects for gender 
--      s = \\c => idet.s ! cn.g ! c ++ cn.s ! (Ag cn.g idet.n P3) ! idet.n ! c ; 
      s = \\c => idet.s ! cn.g ! c ++ cn.s ! idet.n ! c ; 
      n = idet.n
      } ;

    IdetIP idet = {
      s = \\c => idet.s ! Neutr ! c ; 
      n = idet.n
      } ;

--    IdetQuant idet num = {
--      s = idet.s ! num.n ++ num.s ; 
--      n = num.n
--      } ;

    CompIAdv a = a ;
    CompIP p = ss (p.s ! Nom) ;

}
