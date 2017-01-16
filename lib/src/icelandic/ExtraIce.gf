concrete ExtraIce of ExtraIceAbs = CatIce ** 
  open ResIce, Coordination, Prelude, MorphoIce, ParadigmsIce in {

	lin
		-- Det -> NP
		DetNPMasc det = {
			s = \\c => det.s ! Masc ! c ; 
			a = Ag Masc det.n P3
		} ;

		-- Det -> NP 
		DetNPFem det = {
			s = \\c => det.s ! Fem ! c ; 
			a = Ag Fem det.n P3
		} ;

		QuestVPNeutr ip vp = 
			let
				cl = mkClause (ip.s ! Neutr ! Nom) vp {g = Neutr; n = ip.n; p = P3}

			in {
				s = \\ten,ant,pol => table {
					_ => cl.s ! ten ! ant ! pol ! OQuestion
				}
			} ;

		QuestVPFem ip vp = 
			let
				cl = mkClause (ip.s ! Fem ! Nom) vp {g = Fem; n = ip.n; p = P3}

			in {
				s = \\ten,ant,pol => table {
					_ => cl.s ! ten ! ant ! pol ! OQuestion
				}
			} ;

		PrepIPFem prep ip = {
			s = prep.s ++ ip.s ! Fem ! prep.c
		} ;

		PrepIPNeutr prep ip = {
			s = prep.s ++ ip.s ! Neutr ! prep.c
		} ;

		CompIPFem ip = {s = \\_,_,_ => ip.s ! Neutr ! Nom} ;

		CompIPNeutr ip = {s = \\_,_,_ => ip.s ! Neutr ! Nom} ;
} 
