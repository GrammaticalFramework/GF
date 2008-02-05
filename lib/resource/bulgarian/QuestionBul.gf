concrete QuestionBul of Question = CatBul ** open ResBul, Prelude in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,a,p => 
            let cls = cl.s ! t ! a ! p 
            in table {
              QDir   => cls ! OQuest ;
              QIndir => "ако" ++ cls ! ODir
              } ---- "whether" in ExtEng
      } ;
      
    QuestVP ip vp = 
      let cl = mkClause ip.s {gn = ip.gn ; p = P3} vp
      in {s = \\t,a,b,_ => cl.s ! t ! a ! b ! ODir} ;

    QuestIAdv iadv cl = mkQuestion iadv cl ;

    QuestIComp icomp np = 
      mkQuestion icomp (mkClause (np.s ! Nom) np.a (predV auxBe)) ;

    PrepIP p ip = {s = p.s ++ ip.s} ;

    AdvIP ip adv = {
      s = ip.s ++ adv.s ;
      gn = ip.gn
      } ;

   -- IDetCN idet num ord cn = {
   --   s = \\c => idet.s ++ num.s ++ ord.s ++ cn.s ! idet.n ! c ; 
   --   gn = idet.gn
   --   } ;

    CompIAdv a = a ;

}
