concrete SentenceIce of Sentence = CatIce ** open Prelude, ResIce in {

	flags optimize=all_subs ;

	lin

		PredVP np vp = mkClause (np.s ! NCase Nom) vp np.a ;

	 	PredSCVP sc vp = mkClause sc.s vp {g = Neutr;  n = Sg ; p = P3} ;

		--2 Clauses missing object noun phrases

		SlashVP np vps = mkClause (np.s ! NCase Nom) vps np.a ** {
			c2 = vps.c2
		} ;

		AdvSlash cls adv = {
			s =\\ten,ant,pol,ord => cls.s ! ten ! ant ! pol ! ord ++ adv.s ;
			c2 = cls.c2
		} ;

		SlashPrep cl prep = cl ** {
			c2 = prep
		} ;

		SlashVS np vs ssl = {
			s = \\ten,ant,pol,ord => let cl = mkClause (np.s ! NCase Nom) (predV vs) np.a
				in cl.s ! ten ! ant ! pol ! ord ++ ssl.s ! ord ;
			c2 = ssl.c2
		} ;

		--2 Imperatives

		-- VP -> Imp
		ImpVP vp = {s =\\pol,num =>
			let
				agr = gennumperToAgr Masc num P2 ;
				ind = vp.indObj ! agr ;
				dir = vp.dirObj ! agr ;
				adv = vp.a2 ;
				verb = vp.s ! VPImp ! pol ! agr
			in case <vp.indShift,vp.dirShift> of {
				<False,False>	=> verb.fin ++ verb.a1.p2 ++ ind ++ dir ++ adv ;
				<True,False>	=> verb.fin ++ ind ++ verb.a1.p2 ++ dir ++ adv ;
				<_,True>	=> verb.fin ++ ind ++ dir ++ verb.a1.p2 ++ adv
			} ;
		} ;

		--2 Embedded sentences

		EmbedS ss = {s = "að" ++ ss.s} ;

		EmbedQS qs = {s = qs.s ! QDir} ;

		EmbedVP vp = {s = "að" ++ infVP vp} ;

		--2 Sentences

		UseCl t p cl = {
			s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! ODir
		} ;

		UseRCl t p rcl = {
			s = \\agr => t.s ++ p.s ++ rcl.s ! t.t ! t.a ! p.p ! agr ;
			c = NCase Nom
		} ;

		UseQCl t p qcl = {
			s = \\qf => t.s ++ p.s ++ qcl.s ! t.t ! t.a ! p.p ! qf
		} ;

		UseSlash t p cls = {
			s = \\o => cls.s ! t.t ! t.a ! p.p ! o ;
			c2 = cls.c2
		} ;
		

		AdvS adv s = {s = adv.s ++ s.s} ;

		ExtAdvS adv s = {s = adv.s ++ "," ++ s.s} ;

		SSubjS sx subj sy = {s = sx.s ++ subj.s ++ sy.s} ;

		-- S -> RS -> S
		-- TODO : Add Agr to S and Cl, otherwise RS will always 
		-- have the same gender, person and number.
		-- This is possible only a problem when numbers differ..
		-- just add another function in ExtraIce?
		RelS s rs = { s = s.s ++ rs.s ! gennumperToAgr Neutr Sg P3 } ;
}
