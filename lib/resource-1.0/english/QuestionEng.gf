concrete QuestionEng of Question = CatEng ** open ResEng, Prelude in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,a,p => 
            let cls = cl.s ! t ! a ! p 
            in table {
              QDir   => cls ! OQuest ;
              QIndir => "if" ++ cls ! ODir
              } ---- "whether" in ExtEng
      } ;

    QuestVP qp vp = 
      let cl = mkClause (qp.s ! Nom) {n = qp.n ; p = P3} vp
      in {s = \\t,a,b,_ => cl.s ! t ! a ! b ! ODir} ;

    QuestSlash ip slash = 
      mkQuestion (ss (slash.c2 ++ ip.s ! Acc)) slash ;
      --- stranding in ExtEng 

    QuestIAdv iadv cl = mkQuestion iadv cl ;

    QuestIComp icomp np = 
      mkQuestion icomp (mkClause (np.s ! Nom) np.a (predAux auxBe)) ;


    PrepIP p ip = {s = p.s ++ ip.s ! Nom} ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      n = ip.n
      } ;
 
    IDetCN idet num ord cn = {
      s = \\c => idet.s ++ num.s ++ ord.s ++ cn.s ! idet.n ! c ; 
      n = idet.n
      } ;

    CompIAdv a = a ;

}
