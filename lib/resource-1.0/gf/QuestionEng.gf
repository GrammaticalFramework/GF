concrete QuestionEng of Question = CatEng, SentenceEng ** open ResEng in {

  lin

    QuestCl cl = {
      s = \\t,a,p => 
            let cls = cl.s ! t ! a ! p 
            in table {
              QDir   => cls ! OQuest ;
              QIndir => "if" ++ cls ! ODir
              } ---- "whether" in ExtEng
      } ;

    QuestVP qp vp = {
      s = \\t,a,b,q => 
        let 
          agr   = {n = qp.n ; p = P3} ;
          verb  = vp.s ! t ! a ! b ! ODir ! agr ;
          subj  = qp.s ! Nom ;
          compl = vp.s2 ! agr
        in
        subj ++ verb.fin ++ verb.inf ++ compl
    } ;

    QuestSlash ip slash = {
      s = \\t,a,p => 
            let 
              cls = slash.s ! t ! a ! p ;
              who = slash.c2 ++ ip.s ! Acc --- stranding in ExtEng 
            in table {
              QDir   => who ++ cls ! OQuest ;
              QIndir => who ++ cls ! ODir
              }
      } ;

    QuestIAdv iadv cl = {
      s = \\t,a,p => 
            let 
              cls = cl.s ! t ! a ! p ;
              why = iadv.s
            in table {
              QDir   => why ++ cls ! OQuest ;
              QIndir => why ++ cls ! ODir
              }
      } ;

    PrepIP p ip = {s = p.s ++ ip.s ! Nom} ;

----    FunIP  : N2 -> IP -> IP ;
    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      n = ip.n
      } ;
 
    IDetCN idet num cn = {
      s = \\c => idet.s ++ num.s ++ cn.s ! idet.n ! c ; 
      n = idet.n
      } ;

}
   
