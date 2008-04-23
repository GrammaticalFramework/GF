incomplete concrete QuestionRomance of Question = 
  CatRomance ** open CommonRomance, ResRomance, Prelude in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,a,p => 
            let cls = cl.s ! DDir ! t ! a ! p ---- DInv? 
            in table {
              QDir   => cls ! Indic ;
              QIndir => subjIf ++ cls ! Indic
              }
      } ;

    QuestVP qp vp = {
      s = \\t,a,b,_ => 
        let
          cl = mkClause (qp.s ! Nom) False (agrP3 qp.a.g qp.a.n) vp  
        in
        cl.s ! DDir ! t ! a ! b ! Indic
      } ;   

    QuestSlash ip slash = {
      s = \\t,a,p => 
            let 
              cls : Direct -> Str = 
                    \d -> slash.s ! d ! ip.a ! t ! a ! p ! Indic ;
              who = slash.c2.s ++ ip.s ! slash.c2.c
            in table {
              QDir   => who ++ cls DInv ;
              QIndir => partQIndir ++ who ++ cls DDir
              }
      } ;

    QuestIAdv iadv cl = {
      s = \\t,a,p,_ => 
            let 
              cls = cl.s ! DInv ! t ! a ! p ! Indic ;
              why = iadv.s
            in why ++ cls
      } ;

    QuestIComp icomp np = {
      s = \\t,a,p,_ => 
            let 
              vp  = predV copula ;
              cls = (mkClause (np.s ! Aton Nom) np.hasClit np.a vp).s ! 
                       DInv ! t ! a ! p ! Indic ;
              why = icomp.s ! {g = np.a.g ; n = np.a.n}
            in why ++ cls
      } ;

    PrepIP p ip = {
      s = p.s ++ ip.s ! p.c
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
