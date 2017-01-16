concrete NumeralIce of Numeral = CatIce [Numeral,Digits] ** open Prelude, ResIce in {

	param
		DForm = unit | teen | ten ;
		Size = sg | less10 | pl ;

	lincat
		Digit				= {s : DForm => CardOrd => Str} ;
		Sub10 				= {s : DForm => CardOrd => Str ; size : Size} ;
		Sub100, Sub1000, Sub1000000 	= {s : CardOrd => Str ; size : Size} ;

	lin 
		num x = {
			s = \\ngc =>  x.s ! ngc ;
			n = sizeToNumber x.size
		} ;

		n2 = {s = table {
			unit => table {
				NCard _ Masc c => caseList "tveir" "tvo" "tveimur" "tveggja" ! c ;
				NCard _ Fem c => caseList "tvær" "tvær" "tveimur" "tveggja" ! c ;
				NCard _ Neutr c => caseList "tvö" "tvö" "tveimur" "tveggja" ! c ;
				NOrd Sg Masc c => caseList "annar" "annan" "öðrum" "annars" ! c ;
				NOrd Sg Fem c => caseList "önnur" "aðra" "annarri" "annarrar" ! c ;
				NOrd Sg Neutr c => caseList "annað" "annað" "öðru" "annars" ! c ;
				NOrd Pl Masc c => caseList "aðrir" "aðra" "öðrum" "annarra" ! c ;
				NOrd Pl Fem c => caseList "aðrar" "aðrar" "öðrum" "annarra" ! c ;
				NOrd Pl Neutr c => caseList "önnur" "önnur" "öðrum" "annarra" ! c
			} ;
			teen => table {
				NCard _ _ _ => "tólf" ;
				NOrd n g c => (mkRegOrd "tólft" "tólft") ! n ! g ! c
			} ;
			ten => table {
				NCard _ _ _ => "tuttugu" ;
				NOrd n g c => (mkRegOrd "tuttugast" "tuttugust") ! n ! g ! c
			}}};
		n3 = {s = table {
			unit => table {
				NCard _ Masc c => caseList "þrír" "þrjá" "þremur" "þriggja" ! c ;
				NCard _ Fem c => caseList "þrjár" "þrjár" "þremur" "þriggja" ! c ;
				NCard _ Neutr c => caseList "þrjú" "þrjú" "þremur" "þriggja" ! c ;
				NOrd n g c => (mkRegOrd "þriðj" "þriðj") ! n ! g ! c
			} ;
			teen => table {
				NCard _ _ _ => "þrettán" ;
				NOrd n g c => (mkRegOrd "þráttánd" "þrettánd") ! n ! g ! c
			} ;
			ten => table {
				NCard _ _ _ => "þrjátíu" ;
				NOrd n g c => (mkRegOrd "þrítugast" "þrítugust") ! n ! g ! c
			}}};
		n4 = {s = table {
			unit => table {
				NCard _ Masc c => caseList "fjórir" "fjóra" "fjórum" "fjögurra" ! c ;
				NCard _ Fem c => caseList "fjórar" "fjórar" "fjórum" "fjögurra" ! c ;
				NCard _ Neutr c => caseList "fjögur" "fjögur" "fjórum" "fjögurra" ! c ;
				NOrd n g c => (mkRegOrd "fjórð" "fjórð") ! n ! g ! c
			} ;
			teen => table {
				NCard _ _ _ => "fjórtán" ;
				NOrd n g c => (mkRegOrd "fjórtánd" "fjórtánd") ! n ! g ! c
			} ;
			ten => table {
				NCard _ _ _ => "fjörutíu" ;
				NOrd n g c => (mkRegOrd "fertugast" "fertugust") ! n ! g ! c
			}}};
		n5 = mkRegNum "fimm" "fimmtán" "fimmtíu" "fimmti" ;
		n6 = mkRegNum "sex" "sextán" "sextíu" "sjötti" ;
		n7 = mkRegNum "sjö" "sautján" "sjötíu" "sjöundi" ;
		n8 = mkRegNum "átta" "átján" "áttatíu" "áttundi" ;
		n9 = mkRegNum "níu" "nítján" "níutíu" "níundi" ;

		pot01 = {s = table {
				unit =>	table {
					NCard Sg Masc c => caseList "einn" "einn" "einum" "eins" ! c ;
					NCard Sg Fem c => caseList "ein" "eina" "einni" "einnar" ! c ;
					NCard Sg Neutr c => caseList "eitt" "eitt" "einu" "eins" ! c ;
					NCard Pl Masc c => caseList "einir" "eina" "einum" "einna" ! c ;
					NCard Pl Fem c => caseList "einar" "einar" "einum" "einna" ! c ;
					NCard Pl Neutr c => caseList "ein" "ein" "einum" "einna" ! c ;
					NOrd n g c => (mkRegOrd "fyrst" "fyrst") ! n ! g ! c
				} ;
				teen => table {
					NCard _ _ _ => "ellefu" ;
					NOrd n g c => (mkRegOrd "elleft" "elleft") ! n ! g ! c
				} ;
				ten => table {
					NCard _ _ _ => "tíu" ;
					NOrd n g c => (mkRegOrd "tíund" "tíund") ! n ! g ! c
				}
			} ;
			size = sg
		} ;
		pot0 d = d ** {size = less10} ;
		pot110 = {s = pot01.s ! ten ; size = pl} ;
		pot111 = {s = pot01.s ! teen ; size = pl} ;
		pot1to19 d = {s = d.s ! teen ; size = pl} ;
		pot0as1 n = {s = n.s ! unit ; size = n.size} ;
		pot1 d = {s = d.s ! ten ; size = pl} ;
		pot1plus d e = { s = \\ngc => d.s ! ten ! ngc ++ "og" ++ e.s ! unit ! ngc ; size = pl} ;
		pot1as2 n = n ;
		pot2 d = { s = \\ngc => (omitsg (d.s ! unit ! NCard Sg Neutr Nom) d.size) ++ hundrað ! ngc ; size = pl} ;
		pot2plus d e = {
			s = table {
				NCard n g c => (omitsg (d.s ! unit ! NCard Sg Neutr Nom) d.size) ++ "hundrað" ++ (maybeog e.size) ++ e.s ! NCard n g c ;
				NOrd n g c => (omitsg (d.s ! unit ! NCard Sg Neutr Nom) d.size) ++ (omitOrd (hundrað ! NOrd n g c) "hundrað" e.size) ++ e.s ! NOrd n g c
			} ;
			size = pl
		} ;
		pot2as3 n = n ;
		pot3 d = { s = \\ngc => (omitsg (d.s ! NCard Sg Neutr Nom) d.size) ++ þúsund ! ngc ; size = pl} ;
		pot3plus d e = {
			s = table {
				NCard n g c => (omitsg (d.s ! NCard Sg Neutr Nom) d.size) ++ "þúsund" ++ (maybeog e.size) ++ e.s ! NCard n g c ;
				NOrd n g c => (omitsg (d.s ! NCard Sg Neutr Nom) d.size) ++ (omitOrd (þúsund ! NOrd n g c) "þúsund" e.size) ++ e.s ! NOrd n g c
			} ;
			size = pl
		} ;

	oper

		mkRegNum : (_,_,_,_ : Str) -> {s : DForm => CardOrd => Str} = --Digit =
			\sex,sextán,sextíu,sjötti -> {s = table {
				unit => regCardOrd sex sjötti ;
				teen => regCardOrd sextán (sextán + "di") ;
				ten => table {
					NOrd n g c	=> (mkRegOrd (mkTenOrd sex).p1 (mkTenOrd sex).p2) ! n ! g ! c ;
					NCard _ _ _	=> sextíu
				}
			}};

		regCardOrd : (_,_ : Str) -> CardOrd => Str = \sex,sjötti ->
			let
				sjött = init sjötti
			in table {
				NOrd n g c	=> (mkRegOrd sjött sjött) ! n ! g ! c ;
				NCard _ _ _		=> sex
			} ;

		mkRegOrd : (_,_ : Str) -> Number => Gender => Case => Str = \stem,stemu -> table {
			Sg	=> table {
				Masc => caseList (stem + "i") (stem + "a") (stem + "a") (stem + "a") ;
				Fem => caseList (stem + "a") (stemu + "u") (stemu + "u") (stemu + "u") ;
				Neutr => caseList (stem + "a") (stem + "a") (stem + "a") (stem + "a")
			} ;
			Pl	=> table {
				_ => caseList (stemu + "u") (stemu + "u") (stemu + "u") (stemu + "u")
			}
		} ;
		
		mkTenOrd : Str -> Str * Str = \sex -> case sex of {
			"átta"		=> <"átttugast","átttugust"> ;
			"níu"		=> <"nítugast","nítugust"> ;
			_		=> <sex + "tugast",sex + "tugust">
		} ;

		hundrað : CardOrd => Str = table {
			NCard _ _ _ => "hundrað" ;
			NOrd n g c => (mkRegOrd "hundraðast" "hundruðust") ! n ! g ! c 
		} ;

		þúsund : CardOrd => Str = table {
			NCard _ _ _ => "þúsund" ; 
			NOrd n g c => (mkRegOrd "þúsundast" "þúsundust") ! n ! g ! c
		} ;
		
		sizeToNumber : Size -> Number = \size -> case size of {
			sg	=> Sg ;
			_	=> Pl
		} ;

		omitOrd : (_,_ : Str) -> Size -> Str = \ord,card,size -> case size of {
			pl	=> card ;
			_	=> ord
		} ;

		maybeog : Size -> Str = \sz -> table {pl => [] ; _ => "og" } ! sz ;  
		omitsg : Str -> Size -> Str = \s -> \sz -> table {sg => [] ; _ => s } ! sz ;
	lincat
		Dig = TDigit ;
	lin
		-- Dig -> Digits
		IDig d = d ;

		-- Dig -> Digits -> Digits
		IIDig d ds = {
			s = table {
				NCard _ _ _ => d.s ! NCard Sg Masc Nom ++ BIND ++ ds.s ! NCard Sg Masc Nom ;
				NOrd _ _ _ => d.s ! NCard Sg Masc Nom ++ BIND ++ ds.s ! NCard Sg Masc Nom ++ "."
			} ;
			n = Pl
		} ;

		D_0 = mkDig "0" ;
		D_1 = mk3Dig "1" "1." Sg ;
		D_2 = mkDig "2" ;
		D_3 = mkDig "3" ;
		D_4 = mkDig "4" ;
		D_5 = mkDig "5" ;
		D_6 = mkDig "6" ;
		D_7 = mkDig "7" ;
		D_8 = mkDig "8" ;
		D_9 = mkDig "9" ;

	oper

		mkDig : Str -> TDigit = \c -> mk2Dig c (c + ".") ;

		mk2Dig : Str -> Str -> TDigit = \c,o -> mk3Dig c o Pl ;

		mk3Dig : Str -> Str -> Number -> TDigit = \c,o,n -> {
			s = table {
				NCard _ _ _ 	=> c ;
				NOrd _ _ _ 	=> o
			} ;
			n = n
		} ;

		TDigit = {
			s : CardOrd => Str ;
			n : Number 
		} ;
}
