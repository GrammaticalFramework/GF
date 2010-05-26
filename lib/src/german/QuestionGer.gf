concrete QuestionGer of Question = CatGer ** open ResGer in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\m,t,a,p => 
            let cls = cl.s ! m ! t ! a ! p 
            in table {
              QDir   => cls ! Inv ;
              QIndir => "ob" ++ cls ! Sub
              }
      } ;

    QuestVP qp vp = {
      s = \\m,t,a,b,q => 
        let 
          cl = (mkClause (qp.s ! Nom) (agrP3 qp.n) vp).s ! m ! t ! a ! b
        in
        case q of {
            QIndir => cl ! Sub ;
            _      => cl ! Main
            }
      } ;

    QuestSlash ip slash = {
      s = \\m,t,a,p => 
            let 
              cls = slash.s ! m ! t ! a ! p ;
              who = appPrep slash.c2 (\\k => usePrepC k (\c -> ip.s ! c)) ;
            in table {
              QDir   => who ++ cls ! Inv ;
              QIndir => who ++ cls ! Sub
              }
      } ;

    QuestIAdv iadv cl = {
      s = \\m,t,a,p => 
            let 
              cls = cl.s ! m ! t ! a ! p ;
              why = iadv.s
            in table {
              QDir   => why ++ cls ! Inv ;
              QIndir => why ++ cls ! Sub
              }
      } ;

    QuestIComp icomp np = {
      s = \\m,t,a,p => 
            let 
              vp  = predV sein_V ;
              cls = (mkClause (np.s ! NPC Nom) np.a vp).s ! m ! t ! a ! p ;
              why = icomp.s ! np.a
            in table {
              QDir   => why ++ cls ! Inv ;
              QIndir => why ++ cls ! Sub
              }
      } ;

    PrepIP p ip = {
      s = appPrep p (\\k => usePrepC k (\c -> ip.s ! c)) ;
      } ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      n = ip.n
      } ;

    IdetCN idet cn = 
      let 
        g = cn.g ;
        n = idet.n
      in {
      s = \\c => idet.s ! g ! c ++ cn.s ! Weak ! n ! c ; 
      n = n
      } ;

    IdetIP idet = 
      let 
        g = Neutr ; ----
        n = idet.n
      in {
      s = idet.s ! g ;
      n = n
      } ;

    IdetQuant idet num = 
      let 
        n = num.n
      in {
      s = \\g,c => idet.s ! n ! g ! c ++ num.s!g!c  ; 
      n = n
      } ;

    AdvIAdv i a = {s = i.s ++ a.s} ;
 
    CompIAdv a = {s = \\_ => a.s} ;

    CompIP ip = {s = \\_ => ip.s ! Nom} ;

}

