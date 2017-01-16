concrete NounIce of Noun = CatIce ** open MorphoIce, ResIce, Prelude in {

	flags optimize=all_subs ;

	lin
		-- Noun phrases

		DetCN det cn = {
			s = \\c => det.s ! cn.g ! npcaseToCase c
				++ cn.s ! det.n ! det.b ! det.d ! npcaseToCase c
				++ det.pron ! cn.g ! npcaseToCase c
				++ cn.comp ! det.n ! npcaseToCase c ;
			a = gennumperToAgr cn.g det.n P3 ;
			isPron = False
		} ;

		UsePN pn = {
			s = \\c => pn.s ! npcaseToCase c ;
			a = gennumperToAgr pn.g Sg P3 ;
			isPron = False
		} ;

		UsePron p = p ** {isPron = True};

		PredetNP pred np = {
			s = \\c => pred.s ! np.a.n ! np.a.g ! (npcaseToCase c) ++ np.s ! c ;
			a = np.a ;
			isPron = False
		} ;

		PPartNP np v2 = {
			s = \\c => np.s ! c ++ v2.p ! PStrong np.a.n np.a.g (npcaseToCase c) ;
			a = np.a ;
			isPron = False
		} ;

		AdvNP np adv = np ** {s = \\c => np.s ! c ++ adv.s} ;

		ExtAdvNP np adv = np ** {s = \\c => np.s ! c ++ adv.s} ;
	
		RelNP np rs = np ** {s = \\c => np.s ! c ++ rs.s ! np.a} ;

		DetNP det = {
			s = \\c => det.s ! Neutr ! npcaseToCase c ++ det.pron ! Neutr ! npcaseToCase c ;
			a = gennumperToAgr Neutr det.n P3 ;
			isPron = False
		} ;

		-- Determiners

		DetQuant quant num = {
			s = \\g,c => case quant.b of {
				Free => quant.s ! num.n ! g ! c ++ num.s ! g ! c ;
				Suffix => num.s ! g ! c 
			} ;
			pron = \\g,c => case quant.isPron of {
				False	=> [] ;
				True	=> quant.s ! num.n ! g ! c
			} ;
			n = num.n ;
			b = quant.b ;
			d = quant.d
		} ;

		DetQuantOrd quant num ord = {
			s = \\g,c => case quant.b of {
				Free => quant.s ! num.n ! g ! c ++ num.s ! g ! c ++ ord.s ! quant.d ! num.n ! g ! c ;
				Suffix => num.s ! g ! c ++ ord.s ! quant.d ! num.n ! g ! c
			} ;
			pron = \\g,c => case quant.isPron of {
				False	=> [] ;
				True	=> quant.s ! num.n ! g ! c
			} ;
			n = num.n ;
			b = quant.b ;
			d = quant.d ;
		} ;

		NumSg = {s = \\g,c => []; n = Sg ; hasCard = False} ;

		NumPl = {s = \\g,c => []; n = Pl ; hasCard = False} ;

		NumCard n = n ** {hasCard = True} ;

		NumDigits d = {
			s = \\g,c => d.s ! NCard d.n g c;
			n = d.n
		} ;

		NumNumeral d = {
			s = \\g,c => d.s ! NCard Sg g c;
			n = d.n
		} ;

		AdNum adn num = {
				s = \\g,c => adn.s ++ num.s ! g ! c ;
				n = num.n
		} ;

		OrdDigits d = {
			s = \\_,n,g,c => d.s ! NOrd n g c ;
		} ;

		OrdNumeral d = {
			s = \\_,n,g,c => d.s ! NOrd n g c ;
		} ;

		OrdSuperl a = {s = \\d,n,g,c => a.s ! ASuperl d n g c} ;

		OrdNumeralSuperl num a = {s = \\d,n,g,c => num.s ! NOrd n g c ++ a.s ! ASuperl d n g c} ;
		

		DefArt = {
			s = table {
				Sg => table {
					Masc	=> caseList "hinn" "hinn" "hinum" "hins" ;
					Fem 	=> caseList "hin" "hina" "hinni" "hinnar" ;
					Neutr	=> caseList "hið" "hið" "hinu" "hins" 
				} ;
				Pl => table {
					Masc	=> caseList "hinir" "hina" "hinum" "hinna" ;
					Fem 	=> caseList "hinar" "hinar" "hinum" "hinna" ;
					Neutr	=> caseList "hin" "hin" "hinum" "hinna"
				}
			} ;
			b = Suffix;
			d = Weak ;
			isPron = False
		} ;

		IndefArt = {
			s = \\_,_,_ => [] ;
			b = Free ;
			d = Strong ;
			isPron = False
		} ;

		MassNP cn = {
			s = \\c => cn.s ! Sg ! Free ! Strong ! npcaseToCase c ++ cn.comp ! Sg ! npcaseToCase c;
			a = gennumperToAgr cn.g Sg P3 ;
			isPron = False
		} ;

		PossPron p = {
			s = \\n,g,c => p.s ! NPPoss n g c ;
			b = Suffix ;
			d = Weak ;
			isPron = True
		} ;


		-- Common Noun

		UseN, UseN2 = \noun -> {
			s = \\n,s,_,c => noun.s ! n ! s ! c ;
			comp = \\_,_ => [] ;
			g = noun.g
		} ;

		ComplN2 n2 np = {
			s = \\n,s,_,c => n2.s ! n ! Free ! c ++ n2.c2.s ++ np.s ! NCase n2.c2.c ;
			comp = \\_,_ => [] ;
			g = n2.g
		} ;

		ComplN3 n3 np = {
			s = \\n,s,c => n3.s ! n ! s ! c ++ n3.c2.s ++ np.s ! NCase n3.c2.c ;
			g = n3.g ;
			c2 = n3.c3
	
		} ;

		Use2N3 n3 = {
			s = \\n,s,c => n3.s ! n ! s ! c ;
			g = n3.g ;
			c2 = n3.c2
		} ;

		Use3N3 n3 = {
			s = \\n,s,c => n3.s ! n ! s ! c ;
			g = n3.g ;
			c2 = n3.c3
		} ;

		AdjCN ap cn = {
			s = \\n,s,d,c => ap.s ! n ! cn.g ! d ! c ++ cn.s ! n ! s ! d ! c ;
			comp = cn.comp ;
			g = cn.g
		} ;

		RelCN cn rs = cn ** {
			s = \\n,s,d,c => cn.s ! n ! s ! d ! c ;
			comp = \\n,c => cn.comp ! n ! c ++ rs.s ! gennumperToAgr cn.g n P3 
		} ;

		AdvCN cn adv = cn ** {
			s = \\n,s,d,c => cn.s ! n ! s ! d ! c ;
			comp = \\n,c => cn.comp ! n ! c ++ adv.s
		} ;

		SentCN cn sc = {
			s = \\n,s,d,c	=> cn.s ! n ! s ! d ! c ;
			comp = \\n,c => cn.comp ! n ! c ++ sc.s ;
			g = cn.g
		} ;

		-- 2 Apposition

		ApposCN cn np = {
			s = \\n,s,d,c	=>  cn.s ! n ! s ! d ! Nom ; 
			comp = \\n,c	=> cn.comp ! n ! c ++ np.s ! NCase c ;
			g = cn.g
		} ;

		-- 2 Possessive and partitive constructs

		PossNP cn np = {
			s = \\n,s,d,c	=> case np.isPron of {
				True => cn.s ! n ! Suffix ! d ! Nom ++ np.s ! NPPoss n cn.g c ;
				False => cn.s ! n ! Free ! d ! c ++ np.s ! NPPoss n cn.g Gen
			} ;
			comp = cn.comp ;
			g = cn.g
		} ;

		PartNP cn np = {
			s = \\n,s,d,c	=> cn.s ! n ! s ! d ! Nom ;
			comp = \\n,c => cn.comp ! n ! Nom ++ "af" ++ np.s ! NCase Dat ;
			g = cn.g
		} ;

		CountNP det np = {
			s = \\c	=> det.s ! np.a.g ! npcaseToCase c ++ "af" ++  np.s ! NCase Dat ;
			a = np.a ;
			isPron = False
		} ;


		-- 3 Conjoinable determiners and ones with adjectives

		AdjDAP dap ap = {
			s = \\g,c	=> dap.s ! g ! c ++ ap.s ! dap.n ! g ! dap.d ! c ;
			n = dap.n ;
			b = dap.b ;
			d = dap.d
		} ;

		DetDAP det = det ;
}
