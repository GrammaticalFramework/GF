incomplete concrete QuestionRomance of Question = 
  CatRomance ** open DiffRomance, ResRomance in {

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
              who = slash.c2 ++ ip.s ! accusative --- stranding in ExtRomance 
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

    PrepIP p ip = {
      s = p.s ++ ip.s ! accusative
      } ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      gn = ip.gn
      } ;
 
    IDetCN idet num ord cn = let g = cn.g in {
      s  = \\c => 
           idet.s ! g ++ num.s ! g ++ ord.s ++ cn.s ! idet.n ! idet.det ! caseNP c ; 
      gn = gennum g idet.n
      } ;

}
