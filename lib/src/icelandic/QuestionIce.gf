concrete QuestionIce of Question = CatIce ** open ResIce, Prelude in {

	lin
		QuestCl cl = {
			s = \\ten,ant,pol => table {
				QDir		=> cl.s ! ten ! ant ! pol ! OQuestion ;
				QIndir		=> "ef" ++ cl.s ! ten ! ant ! pol ! ODir
			}
		} ;

		QuestVP ip vp = 
			let
				cl = mkClause (ip.s ! Masc ! Nom) vp {g = Masc; n = ip.n; p = P3}

			in {s = \\ten,ant,pol,_ => cl.s ! ten ! ant ! pol ! ODir} ;

		QuestSlash ip cls = {
			s = \\ten,ant,pol,_ => ip.s ! Masc ! Nom ++ cls.s ! ten ! ant ! pol ! ODir ++ cls.c2.s
		} ;

		QuestIComp icomp np = 
			let
				cl = mkClause (np.s ! NCase Nom) (predV verbBe) np.a ;
				why = icomp.s ! np.a.n ! np.a.g ! Nom
			in {
				s = \\ten,ant,pol => table {
					QDir	=> why ++ cl.s ! ten ! ant ! pol ! OQuestion ;
					QIndir	=> why ++ cl.s ! ten ! ant ! pol ! ODir
				}
			} ;

		QuestIAdv adv cl = {
			s = \\ten,ant,pol => table {
				QDir		=> adv.s ++ cl.s ! ten ! ant ! pol ! OQuestion ;
				QIndir		=> adv.s ++ "ef" ++ cl.s ! ten ! ant ! pol ! ODir 
			}
		} ;

		IdetCN idet cn = {
			s = \\_,c	=> idet.s ! cn.g ! c ++ cn.s ! idet.n ! Free ! Weak ! c ;
			n = idet.n
		} ;
		
		IdetIP idet = {
			s = \\g,c	=> idet.s ! g ! c ;
			n = idet.n
		} ;

		AdvIP ip adv = {
			s = \\g,c	=> ip.s ! g ! c ++ adv.s ;
			n = ip.n
		} ;

		IdetQuant iquant num = {
			s = \\g,c => iquant.s ! num.n ! g ! c ++ num.s ! g ! c ;
			n = num.n
		} ;

		-- for feminine and neuter version, see Extra
		PrepIP prep ip = {
			s = prep.s ++ ip.s ! Masc ! prep.c
		} ;

		AdvIAdv iadv adv = {s = iadv.s ++ adv.s} ;

		CompIAdv iadv = {s = \\_,_,_ => iadv.s} ;

		CompIP ip = {s = \\_,_,_ => ip.s ! Masc ! Nom} ;

	lincat
		QVP = ResIce.VP ;
	lin
		ComplSlashIP vps ip = {
			s = vps.s ;
			indObj = vps.indObj ;
			dirObj = \\a => ip.s ! a.g ! vps.c2.c ++ vps.dirObj ! a ;
			p = vps.p ;
			a2 = vps.a2 ;
			indShift = vps.indShift ;
			dirShift = vps.dirShift
		} ;

		AdvQVP vp iadv = vp ** {dirObj = \\a => vp.dirObj ! a ++ iadv.s} ;

		AddAdvQVP qvp iadv = qvp ** {dirObj = \\a => qvp.dirObj ! a ++ iadv.s} ;

		QuestQVP ip vp = 
			let
				cl = mkClause (ip.s ! Masc ! Nom) vp {g = Masc; n = ip.n; p = P3}
			in { s = \\ten,ant,pol,_ =>  cl.s ! ten ! ant ! pol ! ODir } ;

}
