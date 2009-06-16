concrete QuestionIna of Question = CatIna ** open ResIna, Prelude in {

  flags optimize=all_subs ;

  lin
    QuestCl cl = {
      s = \\use_irreg,t,a,p => 
        let cls = cl.s ! use_irreg ! t ! a ! p 
        in table {
          OQuest   => cls ! OQuest ;
          ODir => "an" ++ cls ! ODir
        } 
      } ;

    QuestVP qp vp = 
      let cl = mkClause (qp.s ! Nom) Sp3 vp
      in {s = \\use_irreg,t,a,b,_ => cl.s ! use_irreg ! t ! a ! b ! ODir} ;

    QuestSlash ip slash = 
      mkQuestion (ss (slash.p2 ++ ip.s ! slash.c2)) slash ;

    QuestIAdv iadv cl = mkQuestion iadv cl ;

    QuestIComp icomp np = 
      mkQuestion icomp (mkClause (np.s ! Nom) np.a (predV_ esserV)) ;


    PrepIP p ip = {s = p.s ++ ip.s ! Nom} ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      n = ip.n
      } ;

    IdetCN idet cn = {
      s = \\c => casePrep [] c ++ idet.s ++ cn.s ! idet.n; 
      n = idet.n
      } ;

    IdetIP idet = {
      s = \\c => casePrep [] c ++ idet.s ;
      n = idet.n
      } ;

    IdetQuant iquant num = {
      s = iquant.s ! num.n ++ num.s ;
      n = num.n
      } ;

    CompIAdv a = a ;

    CompIP ip = ss (ip.s ! Nom) ;

}
