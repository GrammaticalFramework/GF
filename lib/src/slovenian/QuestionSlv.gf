concrete QuestionSlv of Question = CatSlv ** open ResSlv,Prelude in {

------AR BEGIN
lin
  QuestVP ip vp = mkClause (ip.s ! Nom) ip.a False vp ;
  QuestCl cl = {s = \\t,a,p => "ali" ++ cl.s ! t ! a ! p} ;
  QuestIAdv iadv cl = {s = \\t,a,p => iadv.s ++ cl.s ! t ! a ! p} ;


------AR END

}
