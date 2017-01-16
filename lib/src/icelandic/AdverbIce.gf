concrete AdverbIce of Adverb = CatIce ** open ResIce, Prelude in {
	lin
		PositAdvAdj a = { s = a.adv } ;

		PrepNP p np = { s = p.s ++ np.s ! NCase p.c} ;

		ComparAdvAdjS cadv a s = {
			s = cadv.s ++ a.adv ++ cadv.p ++ s.s
		} ;

		ComparAdvAdj cadv a np = {
			s = cadv.s ++ a.adv ++ cadv.p ++ np.s ! NCase Nom
		} ;

		AdAdv ad adv = { s = ad.s ++ adv.s} ;

		PositAdAAdj a = { s = a.adv } ;

		SubjS sub s = { s = sub.s ++ s.s } ;

		AdnCAdv cadv = { s = cadv.s ++ cadv.p} ;
}
