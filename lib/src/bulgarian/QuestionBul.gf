--# -coding=cp1251
concrete QuestionBul of Question = CatBul ** open ResBul, Prelude in {
  flags coding=cp1251 ;


  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,a,p => 
            let cls = cl.s ! t ! a ! p 
            in table {
              QDir   => cls ! Quest ;
              QIndir => "���" ++ cls ! Main
              } ---- "whether" in ExtEng
      } ;
      
    QuestVP ip vp = {
      s = \\t,a,b,qform =>
             (mkClause (ip.s ! RSubj ! qform) ip.gn (NounP3 Pos) vp).s ! t ! a ! b ! Main
      } ;

    QuestSlash ip slash = 
      mkQuestion {s = \\qform => slash.c2.s ++ case slash.c2.c of {Dat=>"��";_=>[]} ++ ip.s ! (RObj slash.c2.c) ! qform}
                 {s = slash.s ! (agrP3 ip.gn) } ;

    QuestIAdv iadv cl = mkQuestion iadv cl ;

    QuestIComp icomp np = 
      mkQuestion icomp (mkClause (np.s ! RSubj) np.gn np.p (predV verbBe)) ;

    PrepIP p ip = {s = \\qform => p.s ++ case p.c of {Dat=>"��";_=>[]} ++ ip.s ! RSubj ! qform} ;

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
                       in idet.s ! cn.g ! qform ++ cn.s ! nf ;
      gn = gennum cn.g idet.n
      } ;

    IdetIP idet = {
      s  = \\_ => idet.s ! ANeut ;
      gn = gennum ANeut idet.n
      } ;

    IdetQuant iquant num = {
      s = \\g,qform => iquant.s ! gennum g (numnnum num.nn) ! qform ++
                       num.s ! dgenderSpecies g Indef RSubj ;
      n = numnnum num.nn ;
      nonEmpty = num.nonEmpty
      } ;

    AdvIAdv i a = {s = \\q => i.s ! q ++ a.s} ;

    CompIP ip = {s = ip.s ! RSubj} ;
}
