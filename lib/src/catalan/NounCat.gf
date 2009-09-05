concrete NounCat of Noun = CatCat ** NounRomance - [MassNP] with
  (ResRomance = ResCat) ** {
lin 
	MassNP cn = let
		g = cn.g ;
		n = Sg ;
	  in heavyNP {
		s = \\_ => cn.s ! n ;
		a = agrP3 g n;
		hasClit = False
		} ;

};
