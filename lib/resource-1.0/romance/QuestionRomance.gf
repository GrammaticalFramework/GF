incomplete concrete QuestionRomance of Question = 
  CatRomance ** open CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,a,p => 
            let cls = cl.s ! t ! a ! p 
            in table {
              QDir   => cls ! Indic ;
              QIndir => "si" ++ cls ! Indic ---- subjIf
              }
      } ;

    QuestVP qp vp = {
      s = \\t,a,b,_ => 
        let
          cl = mkClause (qp.s ! Nom) (agrP3 qp.a.g qp.a.n) vp  
        in
        cl.s ! t ! a ! b ! Indic
      } ;   

    QuestSlash ip slash = {
      s = \\t,a,p => 
            let 
              cls = slash.s ! t ! a ! p ! Indic ;
              who = slash.c2.s ++ ip.s ! slash.c2.c
            in table {
              QDir   => who ++ cls ;
              QIndir => partQIndir ++ who ++ cls
              }
      } ;

    QuestIAdv iadv cl = {
      s = \\t,a,p,_ => 
            let 
              cls = cl.s ! t ! a ! p ! Indic ;
              why = iadv.s
            in why ++ cls
      } ;

    QuestIComp icomp np = {
      s = \\t,a,p,_ => 
            let 
              vp  = predV copula ;
              cls = (mkClause (np.s ! Aton Nom) np.a vp).s ! t ! a ! p ! Indic ;
              why = icomp.s ! {g = np.a.g ; n = np.a.n}
            in why ++ cls
      } ;

    PrepIP p ip = {
      s = p.s ++ ip.s ! accusative
      } ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      a = ip.a
      } ;
 
    IDetCN idet num ord cn = 
      let 
        g = cn.g ;
        n = idet.n ;
        a = aagr g n
      in {
      s = \\c => idet.s ! g ! c ++ num.s ! g ++ ord.s ! a ++ cn.s ! n ; 
      a = a
      } ;

    CompIAdv a = {s = \\_  => a.s} ;

}
