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
      let cl = mkClause (ip.s ! RSubj) {gn = ip.gn ; p = P3} vp
      in {s = \\t,a,b,_ => cl.s ! t ! a ! b ! Main} ;

    QuestSlash ip slash = 
      mkQuestion {s1 = slash.c2.s ++ ip.s ! (RObj slash.c2.c); s2 = slash.c2.s ++ ip.s ! (RObj slash.c2.c)} slash ;

    QuestIAdv iadv cl = mkQuestion iadv cl ;

    QuestIComp icomp np = 
      mkQuestion icomp (mkClause (np.s ! RSubj) np.a (predV verbBe)) ;

    PrepIP p ip = {s1 = p.s ++ ip.s ! RSubj; s2 = p.s ++ ip.s ! RSubj} ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      gn = ip.gn
      } ;

    CompIAdv a = a ;

---- FIXME: the rest of this module guessed by AR

    IdetCN idet cn = {
      s = \\c => let nf = case <idet.n, idet.nonEmpty> of {
                            <Pl,True> => NFPlCount ;
                            _         => NF idet.n Indef
                          }
                 in idet.s ! gennum cn.g idet.n ++                   
                    cn.s ! nf ;
      gn = gennum cn.g idet.n
      } ;

    IdetIP idet = let g = DNeut in {
      s  = \\c => idet.s ! gennum g idet.n ;         
      gn = gennum g idet.n
      } ;

    IdetQuant iquant num = {
      s = \\gn => iquant.s ! gn ++                   
                    num.s ! dgenderSpecies (genGenNum gn) Indef RSubj ;
      n = num.n ;
      nonEmpty = num.nonEmpty
      } ;

    ---- what should there be in s1,s2 ? AR
    CompIP ip = {s1 = ip.s ! RSubj ; s2 = []} ;

}
