concrete NumeralCat of Numeral = CatCat ** 
  open CommonRomance, ResRomance, MorphoCat, Prelude in {

--
-- gcc M3.5.1, M3.5.2
--
    
lincat 
  Digit = {s : DForm => CardOrd => Str} ;
  Sub10 = {s : DForm => CardOrd => Str ; n : Number} ;
  Sub100 = {s : CardOrd => Str ; n : Number} ;
  Sub1000 = {s : CardOrd => Str ; n : Number} ;
  Sub1000000 = {s : CardOrd => Str ; n : Number} ;

	
-- Auxiliaries

oper
	-- Use cardinal for big ordinals [M3.5.2]
	cent : Number => CardOrd => Str = \\n,co => case n of {
			Pl => case co of {
				NCard Masc => "-cents" ;
				NCard Fem => "-centes" ;
				_ => variants {} } ;
			Sg => "cent" 
		} ;
	cardOrd1 : CardOrd -> (_,_,_:Str) -> Str  = \co,dos,dues,segon -> case co of {
		NCard Masc => dos ;
		NCard Fem => dues ;
		NOrd Masc Sg => segon ;
		NOrd Fem Sg => segon + "a" ;
		NOrd Masc Pl => segon + "s" ;
		NOrd Fem Pl => segon + "es"
	} ;

	
	cardOrdReg : CardOrd -> Str -> Str -> Str = \co,sis,si -> case co of {
		NCard _ => sis ;
		NOrd Masc Sg => si + "è" ;
		NOrd Fem Sg => si + "ena" ;
		NOrd Masc Pl => si + "ens" ;
		NOrd Fem Pl => si + "enes"
	} ;
		
	cardOrd2 : CardOrd -> Str -> Str = \co,sis -> let si = init sis in
		case (last sis) of {
			"e" => cardOrdReg co sis si ;
			"a" => cardOrdReg co sis si ;
			"u" => cardOrdReg co sis (si + "v") ;
			_ => cardOrdReg co sis sis
	} ;
	
	cardOrd3 : CardOrd -> (m,f:Str) -> Str = \co,dos,dues -> case co of {
		NCard Masc => dos ;
		NCard Fem => dues ;
		NOrd Masc Sg => dos + "è" ;
		NOrd Fem Sg => dos + "ena" ;
		NOrd Masc Pl => dos + "ens" ;
		NOrd Fem Pl => dos + "enes"
	} ;

	
	digitPl1 : (u,t,d,dp:Str) -> (fem,ord:Str) ->  {s: DForm => CardOrd => Str} = \dos,dotze,vint,vinti,dues,segon -> {
	 s = \\df,co =>
		case df of {
			unit => cardOrd1 co dos dues segon ;
			teen => cardOrd2 co dotze ;
			ten => cardOrd2 co vint ;
			tenplus => cardOrd2 co vinti ;
			_ => cardOrd3 co dos dues
			} 
		} ;

	digitPl2 : (u,t,d,dp:Str) -> {s: DForm => CardOrd => Str} = \sis,setze,seixanta,seixantai -> {
	 s = \\df,co => case df of {
			unit => cardOrd2 co sis;
			teen => cardOrd2 co setze ;
			ten => cardOrd2 co seixanta ;
			tenplus => cardOrd2 co seixantai ;
			_ => cardOrd2 co sis 
			}
		} ;


lin
	num x = x ;

	n2 = digitPl1 "dos" "dotze" "vint" "vint-i-" "dues" "segon" ;
	n3 = digitPl1 "tres" "tretze" "trenta" "trenta-" "tres" "tercer" ;
	n4 = digitPl1 "quatre" "catorze" "quaranta" "quaranta-" "quatre" "quart" ;
	n5 = digitPl1 "cinc" "quinze" "cinquanta" "cinquanta-" "cinc" "quint" ;
	n6 = digitPl2 "sis" "setze" "seixanta" "seixanta-" ;
	n7 = digitPl2 "set" "disset" "setanta" "setanta-" ;
	n8 = digitPl2 "vuit" "divuit" "vuitanta" "vuitanta-" ;
	n9 = digitPl2 "nou" "dinou" "noranta" "noranta-" ;

	pot01 = {s= \\df,co =>
		case df of {
			unit => cardOrd1 co "un" "una" "primer" ;
			teen => cardOrd2 co "onze" ;
			ten => cardOrd2 co "deu" ;
			tenplus => variants {} ;
			OrdF => cardOrd2 co "un" ;
			Aunit => [] 
		};
		n= Sg} ;

	pot0 d = d ** {n= Pl} ;
	pot110 = {s= \\co => cardOrdReg co "deu" "des"; n= Pl} ; 
	pot111 = {s= \\co => cardOrd2 co "onze"; n= Pl} ;
	pot1to19 d = {s= \\co => d.s ! teen ! co ; n= Pl} ;
	pot0as1 n = {s= n.s ! unit; n= n.n} ;
	pot1 d = {s= \\co => d.s ! ten ! co; n= Pl} ;
	pot1plus d e =
		{s= \\co => ((d.s ! tenplus ! (NCard Masc)) ++ (e.s ! OrdF ! co)); n= Pl} ;
	pot1as2 n = n ;
	pot2 d = {s= \\co => (d.s ! Aunit ! co) ++ (cent ! (d.n) ! co); n= Pl} ;
	pot2plus d n = {
		s= \\co => (d.s ! Aunit ! co) ++ (cent ! (d.n) ! co) ++ (n.s ! co);
		n= Pl} ;
	pot2as3 n = n ;
	pot3 n = {s= \\co => (table {Sg => []; Pl => (n.s ! co) } ! n.n) ++ "mil"; n= Pl} ;
	pot3plus n m = 
		{s= \\co => (table {Sg => []; Pl => (n.s ! co)} ! n.n) ++ "mil" ++ (m.s !co);
		n= Pl} ;
	

param
	DForm = unit | teen | ten | tenplus | Aunit | OrdF ;

-- numerals as sequences of digits

  lincat 
    Dig = TDigit ;

  lin
    IDig d = d ;

    IIDig d i = {
      s = \\o => d.s ! NCard Masc ++ i.s ! o ;
      n = Pl
    } ;

    D_0 = mkDig "0" ;
    D_1 = mk3Dig "1" "1:o" Sg ; ---- gender
    D_2 = mk2Dig "2" "2:o" ;
    D_3 = mk2Dig "3" "3:o" ;
    D_4 = mkDig "4" ;
    D_5 = mkDig "5" ;
    D_6 = mkDig "6" ;
    D_7 = mkDig "7" ;
    D_8 = mkDig "8" ;
    D_9 = mkDig "9" ;

  oper
    mk2Dig : Str -> Str -> TDigit = \c,o -> mk3Dig c o Pl ;
    mkDig : Str -> TDigit = \c -> mk2Dig c (c + ":o") ;

    mk3Dig : Str -> Str -> Number -> TDigit = \c,o,n -> {
      s = table {NCard _ => c ; NOrd _ _ => o} ; ---- gender
      n = n
      } ;

    TDigit = {
      n : Number ;
      s : CardOrd => Str
    } ;

}
