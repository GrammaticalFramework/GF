concrete ExtraLat of ExtraLatAbs =
	 CatLat,
	 ExtraLexiconLat ** 
  open ResLat, Coordination, Prelude in {
  lin
    UsePronNonDrop p = -- Pron -> NP
      {
	g = p.g ;
	n = p.n ;
	p = p.p ;
	s = p.pers ! PronNonDrop ! PronNonRefl ;
      } ;
} 
