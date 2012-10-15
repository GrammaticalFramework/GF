concrete QuestionCmn of Question = CatCmn ** 
  open ResCmn, Prelude in {

  flags optimize=all_subs ;

  lin

    QuestCl cl = {s = \\p,a => cl.s ! p ! a ++ question_s} ; --- plus redup questions

    QuestVP ip vp = {
      s = \\p,a => ip.s ++ vp.prePart ++ useVerb vp.verb ! p ! a ++ vp.compl
      } ;
 
    QuestSlash ip cls =  {
      s =\\p,a => cls.c2.prepPre ++ cls.np ++ cls.c2.prepMain ++ cls.vp ! p ! a ++ 
                  possessive_s ++ di_s ++ ip.s
      } ;       
      
    QuestIAdv iadv cl = {s = \\p,a => cl.np ++ iadv.s ++ cl.vp ! p ! a} ;

    QuestIComp icomp np = {s = \\p,a => np.s ++ icomp.s} ; ---- order

    PrepIP p ip = ss (appPrep p ip.s) ;

    AdvIP ip adv = ss (adv.s ++ possessive_s ++ ip.s) ; ---- adding de

    IdetCN det cn = {s = det.s ++ cn.c ++ cn.s} ; ---- number?

    IdetIP idet = idet ;

    IdetQuant iquant num = ss (iquant.s ++ num.s) ; ---- 

    AdvIAdv i a = ss (a.s ++ i.s) ;

    CompIAdv a = ss (zai_s ++ a.s) ;

    CompIP ip = ss (copula_s ++ ip.s) ;

}

