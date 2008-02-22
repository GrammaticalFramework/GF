concrete QuestionBul of Question = CatBul ** open ResBul, Prelude in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,a,p => 
            let cls = cl.s ! t ! a ! p 
            in table {
              QDir   => cls ! Quest ;
              QIndir => "ако" ++ cls ! Main
              } ---- "whether" in ExtEng
      } ;
      
    QuestVP ip vp = 
      let cl = mkClause (ip.s ! Nom) {gn = ip.gn ; p = P3} vp
      in {s = \\t,a,b,_ => cl.s ! t ! a ! b ! Main} ;

    QuestSlash ip slash = 
      mkQuestion (ss (slash.c2 ++ ip.s ! Acc)) slash ;

    QuestIAdv iadv cl = mkQuestion iadv cl ;

    QuestIComp icomp np = 
      mkQuestion icomp (mkClause (np.s ! Nom) np.a (predV auxBe)) ;

    PrepIP p ip = {s = p.s ++ ip.s ! Nom} ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      gn = ip.gn
      } ;

    IDetCN idet num ord cn = {
      s = \\c => let nf = case <idet.n, num.nonEmpty> of {
                            <Pl,True> => NFPlCount ;
                            _         => NF idet.n Indef
                          }
                 in idet.s ! gennum cn.g idet.n ++                   
                    num.s ! dgenderSpecies cn.g Indef Nom ++
                    ord.s ! aform (gennum cn.g num.n) Indef Nom ++
                    cn.s ! nf ;
      gn = gennum cn.g idet.n
      } ;

    CompIAdv a = a ;

}
