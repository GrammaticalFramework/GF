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
              who = appPrep slash.c2 ip.s
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
              cls = (mkClause (np.s ! Nom) np.a vp).s ! m ! t ! a ! p ;
              why = icomp.s ! np.a
            in table {
              QDir   => why ++ cls ! Inv ;
              QIndir => why ++ cls ! Sub
              }
      } ;

    PrepIP p ip = {
      s = appPrep p ip.s
      } ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      n = ip.n
      } ;
 
{- ---b
    IDetCN idet num ord cn = 
      let 
        g = cn.g ;
        n = idet.n
      in {
      s = \\c => 
           idet.s ! g ! c ++ num.s ++ ord.s ! agrAdj g Weak n c ++ 
           cn.s ! Weak ! n ! c ; 
      n = n
      } ;
-}
    CompIAdv a = {s = \\_ => a.s} ;

}

