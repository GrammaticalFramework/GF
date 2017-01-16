concrete AdjectiveIce of Adjective = CatIce ** open ResIce, Prelude in {

	lin
		PositA a = {
			s = \\n,g,d,c => a.s ! APosit d n g c
		} ;

		ComparA a np = {
			s = \\n,g,d,c => a.s ! ACompar n g c ++ "heldur en" ++ np.s ! NCase Nom
		} ;

		ComplA2 a2 np = {
			s = \\n,g,d,c => a2.s ! APosit d n g c ++ a2.c2.s ++ np.s ! NCase a2.c2.c
		} ;

		ReflA2 a2 = {
			s = \\n,g,d,c => a2.s ! APosit d n g c ++ a2.c2.s ++ reflPron P3 n g a2.c2.c
		} ;

		UseA2 a2 = {
			s = \\n,g,d,c => a2.s ! APosit d n g c
		} ;

		UseComparA a = {
			s = \\n,g,d,c => a.s ! ACompar n g c
		} ;

		CAdvAP cadv ap np = {
			s = \\n,g,d,c => cadv.s ++ ap.s ! n ! g ! d ! c ++ cadv.p ++ np.s ! NCase Nom
		} ;

		AdjOrd ord = {
			s = \\n,g,d,c => ord.s ! d ! n ! g ! c
		} ;

		SentAP ap sc = {
			s = \\n,g,d,c => ap.s ! n ! g ! d ! c ++ sc.s
		} ;

		AdAP ad ap = { 
			s = \\n,g,d,c => ad.s ++ ap.s ! n ! g ! d ! c 
		} ;

		AdvAP ap adv = {
			s = \\n,g,d,c => ap.s ! n ! g ! d ! c ++ adv.s
		} ;
}
