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
{-
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
-}
}
