concrete QuestionAfr of Question = CatAfr ** open ResAfr in {


  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,a,p => 
            let cls = cl.s ! t ! a ! p 
            in table {
              QDir   => cls ! Inv ;
              QIndir => "of" ++ cls ! Sub
              }
      } ;

    QuestVP qp vp = {
      s = \\t,a,b,q => 
        let 
          cl = (mkClause (qp.s ! NPNom) (agrP3 qp.n) vp).s ! t ! a ! b
        in
        case q of {
            QIndir => cl ! Sub ;
            _      => cl ! Main
            }
      } ;

    QuestSlash ip slash = {
      s = \\t,a,p => 
            let 
              cls = slash.s ! t ! a ! p ;
              who = appPrep slash.c2 ip.s
            in table {
              QDir   => who ++ cls ! Inv ;
              QIndir => who ++ cls ! Sub
              }
      } ;

    QuestIAdv iadv cl = {
      s = \\t,a,p => 
            let 
              cls = cl.s ! t ! a ! p ;
              why = iadv.s
            in table {
              QDir   => why ++ cls ! Inv ;
              QIndir => why ++ cls ! Sub
              }
      } ;

    QuestIComp icomp np = {
      s = \\t,a,p => 
            let 
              vp  = predV zijn_V ;
              cls = (mkClause (np.s ! NPNom) np.a vp).s ! t ! a ! p ;
              why = icomp.s ! np.a
            in table {
              QDir   => why ++ cls ! Inv ;
              QIndir => why ++ cls ! Sub
              }
      } ;

    PrepIP p ip = {
      s = appPrep p.s ip.s
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
      s = \\c => idet.s ! g ++ cn.s ! Weak ! NF n Nom ; 
      n = n
      } ;

    IdetIP idet = 
      let 
        g = Neutr ; ----
        n = idet.n
      in {
        s = \\_ => idet.s ! g ;
        n = n
      } ;

    IdetQuant idet num = 
      let 
        n = num.n
      in {
      s = \\g => idet.s ! n ! g ++ num.s  ; 
      n = n
      } ;

    AdvIAdv i a = {s = i.s ++ a.s} ;
 
    CompIAdv a = {s = \\_ => a.s} ;

    CompIP ip = {s = \\_ => ip.s ! NPNom} ;

}
