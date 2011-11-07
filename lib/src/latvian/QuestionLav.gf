concrete QuestionLav of Question = CatLav ** open ResLav, VerbLav, Prelude, ParadigmsVerbsLav in {
  flags 
	optimize=all_subs ;
	coding = utf8;

  lin
    QuestCl cl = {
      s = \\m,p => "vai" ++ cl.s ! m ! p
    } ;
	
	QuestVP ip vp = {
	  s = \\m,p => ip.s ! Nom ++ buildVerb vp.v m p (AgP3 ip.n Masc)
	} ;
	
	QuestSlash ip slash = {
	  s = \\m,p => slash.p.s ++ ip.s ! (slash.p.c ! ip.n) ++ slash.s ! m ! p
	} ;
	
	QuestIAdv iadv cl = {
		s = \\m,p => iadv.s ++ cl.s ! m ! p ;
	};
	
    QuestIComp icomp np = {
		s = \\m,p => icomp.s ++ buildVerb mkVerb_toBe m p np.a ++ np.s ! Nom
	};

	IdetQuant idet num = {
      s = \\g => idet.s ! g ! num.n ++ num.s ! g ! Nom ; 
      n = num.n
    } ;

    AdvIP ip adv = {
      s = \\c => ip.s ! c ++ adv.s ;
      n = ip.n
    } ;

    PrepIP p ip = {s = p.s ++ ip.s ! (p.c ! ip.n)} ;

    IdetCN idet cn = {
      s = \\c => idet.s ! cn.g ++ cn.s ! Def ! idet.n ! c ; 
      n = idet.n
    } ;

    IdetIP idet = {
      s = \\c => (idet.s ! Masc) | (idet.s ! Fem) ; 
      n = idet.n
    } ;

	CompIAdv a = a ;
    CompIP p = ss (p.s ! Nom) ;
}
