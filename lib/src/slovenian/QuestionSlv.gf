concrete QuestionSlv of Question = CatSlv ** open ResSlv,Prelude in {

------AR BEGIN
lin
  QuestVP ip vp = mkClause (ip.s ! Nom) ip.a False vp ;
  QuestCl cl = {s = \\t,a,p => "ali" ++ cl.s ! t ! a ! p} ;
  QuestSlash ip cls = {s = \\t,a,p => cls.c2.s ++ ip.s ! cls.c2.c ++ cls.s ! t ! a ! p} ;
  QuestIAdv iadv cl = {s = \\t,a,p => iadv.s ++ cl.s ! t ! a ! p} ;
  QuestIComp icomp np = mkClause icomp.s np.a np.isPron {s = copula ; s2 = \\_ => [] ; isCop = True ; refl = []} ;
  CompIAdv a = a ;
  CompIP p = ss (p.s ! Nom) ;


------AR END

}
