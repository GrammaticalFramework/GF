concrete RelativeIce of Relative = CatIce ** open ResIce in {

	lin
		RelCl cl = {
			s = \\ten,ant,pol,_ => "þannig að" ++ cl.s ! ten ! ant ! pol ! ODir
		} ;

		RelVP rp vp = {
			s = \\ten,ant,pol,agr => 
				let 
					cl = mkClause rp.s vp agr
				in
					cl.s ! ten ! ant ! pol ! ODir
		} ;

		RelSlash rp cls = {
			s = \\ten,ant,pol,agr => rp.s ++ cls.s ! ten ! ant ! pol ! ODir ++ cls.c2.s
		} ;

		IdRP = {s = "sem" } ;

		FunRP prep np rp = {
			s = prep.s ++ np.s ! NCase prep.c ++ rp.s
		} ;
}
