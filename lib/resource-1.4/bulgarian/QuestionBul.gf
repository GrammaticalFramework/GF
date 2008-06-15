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
      
    QuestVP ip vp = {
      s = \\t,a,b,qform =>
             (mkClause (ip.s ! RSubj ! (case qform of {QDir=>Indef; QIndir=>Def})) {gn = ip.gn ; p = P3} vp).s ! t ! a ! b ! Main
      } ;

    QuestSlash ip slash = 
      mkQuestion {s = \\spec => slash.c2.s ++ ip.s ! (RObj slash.c2.c) ! spec}
                 {s = slash.s ! (agrP3 ip.gn) } ;

    QuestIAdv iadv cl = mkQuestion iadv cl ;

    QuestIComp icomp np = 
      mkQuestion icomp (mkClause (np.s ! RSubj) np.a (predV verbBe)) ;

    PrepIP p ip = {s = \\spec => p.s ++ ip.s ! RSubj ! spec} ;

    AdvIP ip adv = {
      s = \\role,spec => ip.s ! role ! spec ++ adv.s ;
      gn = ip.gn
      } ;

    CompIAdv a = a ;

    IdetCN idet cn = {
      s = \\_,spec => let nf = case <idet.n, idet.nonEmpty> of {
                                 <Pl,True> => NFPlCount ;
                                 _         => NF idet.n Indef
                               }
                      in idet.s ! cn.g ! spec ++ cn.s ! nf ;
      gn = gennum cn.g idet.n
      } ;

    IdetIP idet = {
      s  = \\_ => idet.s ! DNeut ;
      gn = gennum DNeut idet.n
      } ;

    IdetQuant iquant num = {
      s = \\g,spec => iquant.s ! gennum g num.n ! spec ++
                      num.s ! dgenderSpecies g Indef RSubj ;
      n = num.n ;
      nonEmpty = num.nonEmpty
      } ;

    CompIP ip = {s = ip.s ! RSubj} ;
}
