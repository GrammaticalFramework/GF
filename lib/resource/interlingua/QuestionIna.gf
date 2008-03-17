concrete QuestionIna of Question = CatIna ** open ResIna, Prelude in {

  flags optimize=all_subs ;

  lin
    QuestCl cl = {
      s = \\t,a,p => 
        let cls = cl.s ! t ! a ! p 
        in table {
          OQuest   => cls ! OQuest ;
          ODir => "an" ++ cls ! ODir
        } 
      } ;

    QuestVP qp vp = 
      let cl = mkClause (qp.s ! Nom) Sp3 vp
      in {s = \\t,a,b,_ => cl.s ! t ! a ! b ! ODir} ;

    QuestSlash ip slash = 
      mkQuestion (ss (slash.p2 ++ ip.s ! slash.c2)) slash ;

    QuestIAdv iadv cl = mkQuestion iadv cl ;

    QuestIComp icomp np = 
      mkQuestion icomp (mkClause (np.s ! Nom) np.a (predV esserV)) ;


    PrepIP p ip = {s = p.s ++ ip.s ! Nom} ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      n = ip.n
      } ;

    IDetCN idet num ord cn = {
      s = \\c => casePrep [] c ++ idet.s ++ num.s ++ ord.s ++ cn.s ! idet.n; 
      n = idet.n
      } ;

    CompIAdv a = a ;

}
