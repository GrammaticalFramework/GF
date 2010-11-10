concrete QuestionAmh of Question = CatAmh ** open ResAmh, ParamX, Prelude in {

  flags optimize=all_subs ; coding = utf8 ;
--
  lin

	QuestCl cl = {
	  s = \\t,p => cl.s ! t ! p  ++ "እንዴ" 
	};

	IdetCN idet cn = {
	s = idet.s ! Nom ++ cn.s ! idet.n ! Indef ! Nom ; 
	n = idet.n
	} ; ---- FIX ME

	IdetQuant idet num = {
	s = \\c => idet.s!Sg ++ num.s ! Indef ! c; 
	n = Sg ---- size of Num
	} ;


	QuestVP qp vp = 
	let cl = mkClause (qp.s) (Per3  qp.n Masc) vp in
	{s = \\t,p => cl.s ! t ! p } ;

	QuestIAdv iadv cl = mkQuestion iadv cl ;


	AdvIP ip adv = {
	s =  adv.s ++ ip.s;
	n = ip.n
	} ;


	  IdetIP idet = {
     	s = idet.s!Nom ; 
      	n = idet.n
      	} ;

	CompIAdv a = a ;
	CompIP p = ss (p.s) ;

	-- PrepIP p ip = {s = p.s ++ ip.s } ;


}
