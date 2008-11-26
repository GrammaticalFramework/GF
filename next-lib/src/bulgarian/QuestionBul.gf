concrete QuestionBul of Question = CatBul ** open ResBul, Prelude in {
  flags coding=cp1251 ;


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
             (mkClause (ip.s ! RSubj ! qform) {gn = ip.gn ; p = P3} vp).s ! t ! a ! b ! Main
      } ;

    QuestSlash ip slash = 
      mkQuestion {s = \\qform => slash.c2.s ++ case slash.c2.c of {Dat=>"на";_=>[]} ++ ip.s ! (RObj slash.c2.c) ! qform}
                 {s = slash.s ! (agrP3 ip.gn) } ;

    QuestIAdv iadv cl = mkQuestion iadv cl ;

    QuestIComp icomp np = 
      mkQuestion icomp (mkClause (np.s ! RSubj) np.a (predV verbBe)) ;

    PrepIP p ip = {s = \\qform => p.s ++ case p.c of {Dat=>"на";_=>[]} ++ ip.s ! RSubj ! qform} ;

    AdvIP ip adv = {
      s = \\role,qform => ip.s ! role ! qform ++ adv.s ;
      gn = ip.gn
      } ;

    CompIAdv a = a ;

    IdetCN idet cn = {
      s = \\_,qform => let nf = case <idet.n, idet.nonEmpty> of {
                                  <Pl,True> => NFPlCount ;
                                  _         => NF idet.n Indef
                                }
                       in idet.s ! cn.g ! cn.anim ! qform ++ cn.s ! nf ;
      gn = gennum cn.g idet.n
      } ;

    IdetIP idet = {
      s  = \\_ => idet.s ! Neut ! Inanimate ;
      gn = gennum Neut idet.n
      } ;

    IdetQuant iquant num = {
      s = \\g,anim,qform => iquant.s ! gennum g num.n ! qform ++
                            num.s ! dgenderSpecies g anim Indef RSubj ;
      n = num.n ;
      nonEmpty = num.nonEmpty
      } ;

    CompIP ip = {s = ip.s ! RSubj} ;
}
