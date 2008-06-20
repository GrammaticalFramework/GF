incomplete concrete QuestionScand of Question = 
  CatScand ** open CommonScand, ResScand in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = {
      s = \\t,a,p => 
            let cls = cl.s ! t ! a ! p 
            in table {
              QDir   => cls ! Inv ;
              QIndir => subjIf ++ cls ! Sub
              }
      } ;

    QuestVP qp vp = {
      s = \\t,a,b,q => 
        let 
          somo = case q of {
            QIndir => <"som",Sub> ;
            _      => <[],   Main>
            } ;
          cl = mkClause (qp.s ! nominative ++ somo.p1) {gn = qp.gn ; p = P3} vp  
        in
        cl.s ! t ! a ! b ! somo.p2
      } ;   

    QuestSlash ip slash = {
      s = \\t,a,p => 
            let 
              cls = slash.s ! t ! a ! p ;
              who = slash.c2.s ++ ip.s ! accusative --- stranding in ExtScand 
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
              cls = 
                (mkClause (np.s ! nominative) np.a (predV verbBe)).s ! t ! a ! p ;
              why = icomp.s ! agrAdj np.a.gn DIndef
            in table {
              QDir   => why ++ cls ! Inv ;
              QIndir => why ++ cls ! Sub
              }
      } ;

    PrepIP p ip = {
      s = p.s ++ ip.s ! accusative
      } ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      gn = ip.gn
      } ;

    IdetCN idet cn = let g = cn.g in {
      s  = \\c => 
           idet.s ! g ++ cn.s ! idet.n ! idet.det ! caseNP c ;
      gn = gennum g idet.n
      } ;

    IdetIP idet = 
      let
        g = Neutr ;
      in {
      s  = \\c => idet.s ! g  ;
      gn = (agrP3 g idet.n).gn
      } ;

    IdetQuant idet num = {
      s = \\g => idet.s ! num.n ! g ++ num.s ! g ;
      n = num.n ;
      det = idet.det
      } ;

    CompIAdv a = {s = \\_ => a.s} ;
    CompIP ip = {s = \\_ => ip.s ! nominative} ;

}
