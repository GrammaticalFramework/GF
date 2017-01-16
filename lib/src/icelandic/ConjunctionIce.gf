concrete ConjunctionIce of Conjunction = 
  CatIce ** open ResIce, Coordination, Prelude in {

	lin
		ConjS = conjunctDistrSS ;

		ConjRS conj ss = conjunctDistrTable Agr conj ss ** {c = ss.c} ;

		ConjCN co ns = conjunctDistrTable4 Number Species Declension Case co ns ** {comp = \\_,_ => [] ; g = Neutr} ;

		ConjAP co as = conjunctDistrTable4 Number Gender Declension Case co as ;

		ConjNP co ns = conjunctDistrTable NPCase co ns ** {
			a = {g = ns.a.g ; n = conjNumber co.n ns.a.n ; p = ns.a.p} ;
			isPron = ns.isPron
		} ;

		ConjDet co ds = let cds = (conjunctDistrTable2 Gender Case co ds).s in {
			s = cds ;
			pron = \\_,_ => [] ;
			n = ds.n ;
			b = ds.b ;
			d = ds.d ;
		} ;

		ConjAdv = conjunctDistrSS ;

		ConjAdV = conjunctDistrSS ;
		
		ConjIAdv = conjunctDistrSS ;

		-- These are fun's generated from the list cat's.

		BaseS = twoSS ;

		ConsS = consrSS comma ;

		BaseAdV = twoSS ;
		
		ConsAdV = consrSS comma ;

		BaseAdv = twoSS ;

		ConsAdv = consrSS comma ;

		BaseIAdv = twoSS ;

		ConsIAdv = consrSS comma ;

		BaseRS x y = twoTable Agr x y ** {c = y.c} ;

		ConsRS xs x = consrTable Agr comma xs x ** {c = xs.c} ;

		BaseCN = twoTable4 Number Species Declension Case ;

		ConsCN = consrTable4 Number Species Declension Case comma ;

		BaseAP x y = twoTable4 Number Gender Declension Case x y ;

		ConsAP xs x = consrTable4 Number Gender Declension Case comma xs x ;

		BaseNP x y = twoTable NPCase x y ** {
			a = conjAgr x.a y.a ;
			isPron = isBothPron x.isPron y.isPron
		} ;

		ConsNP xs x = consrTable NPCase comma xs x ** {
			a = conjAgr xs.a x.a ;
			isPron = isBothPron xs.isPron x.isPron
		} ;

		BaseDAP x y = twoTable2 Gender Case x y ** {n = y.n ; b = y.b ; d = y.d} ;

		ConsDAP x xs = consrTable2 Gender Case comma x xs ** {n = xs.n ; b = xs.b ; d = xs.d} ;

	lincat
		[S] = {s1,s2 : Str} ;
		[Adv] = {s1,s2 : Str} ;
		[AdV] = {s1,s2 : Str} ;
		[IAdv] = {s1,s2 : Str} ;
		[NP] = {s1,s2 : NPCase => Str ; a : Agr ; isPron : Bool} ;
		[CN] = {s1,s2 : Number => Species => Declension => Case => Str} ;
		[AP] = {s1,s2 : Number => Gender => Declension => Case => Str} ;
		[RS] = {s1,s2 : Agr => Str ; c : NPCase} ;
    		[DAP] = {s1,s2 : Gender => Case => Str ; n : Number ; b : Species ; d : Declension} ;

	oper

		isBothPron : Bool -> Bool -> Bool = \x,y -> case <x,y> of {
			<True,True>	=> True ;
			_		=> False
		} ;
}
