--# -path=.:../abstract:../common:../../prelude

concrete NumeralRus of Numeral = CatRus ** open ResRus in {

flags  coding=utf8 ;

-- Toiska, 13/8/2000, AR with Arto Mustajoki.
-- Nikita Frolov, 2011

lincat Digit = {s : DForm => Gender => Animacy => Case => Str ; size : Size} ;
lincat Sub10 = {s : Place => DForm => Gender => Animacy =>  Case => Str ; size : Size} ;
lincat Sub100 = {s : Place => Gender => Animacy => Case => Str ; size : Size} ;
lincat Sub1000 = {s : Place => Gender => Animacy => Case => Str ; size : Size} ;
lincat Sub1000000 = {s : Gender => Animacy => Case => Str} ;

lin num x = {s = \\ g,a,c => x.s ! g ! a ! c; n = Pl}; ---- n TODO ; Size? AR 18/12/2007

lin n2  =
  {s = table {unit => \\ g, a, c =>
		case <c, g, a> of {
		  <(Nom|Acc), Fem, Inanimate > => "две";
		  <(Nom|Acc), _, Inanimate   > => "два";
		  <(Nom|Acc), _, Animate     > => "двух";
		  <(Gen|Prepos _), _, _      > => "двух";
		  <Dat, _, _                 > => "двум";
		  <Inst, _, _                > => "двумя"
		};
              teen => nadsat "две" ;
              ten  => n2030 "два" ;
              hund => \\ g, a, c =>
		case <c, g> of {
		  <(Nom|Acc), _  >     => "двести";
		  <Gen, _        >     => "двухсот";
		  <Dat, _        >     => "двумстам";
		  <Inst, _       >     => "двумяюстами";
		  <Prepos _, _   >     => "двухстах"} } ;
   size = sgg} ;
lin n3  =
  {s = table {unit => tri ; 
              teen => nadsat "три" ;
              ten  => n2030 "три" ;
              hund => sta tri} ; 
  size = sgg} ;
lin n4  =
  {s = table {unit => chetyre ; 
              teen => nadsat "четыр" ;
              ten  => \\ g, a, c =>
       		case <c, g> of {
		  <(Nom|Acc), _                > => "сорок";
		  <(Gen|Dat|Inst|Prepos _), _  > => "сорока" } ;
              hund => sta chetyre } ; 
  size = sgg} ;
lin n5  =
  {s = table {unit => n59 "пят" ;
              teen => nadsat "пят" ;
              ten  => n5070 "пят" ;
              hund => sot (n59 "пят")} ;
  size = plg} ;
lin n6  =
  {s = table {unit => n59 "шест" ;
              teen => nadsat "шест" ;
              ten  => n5070 "шест" ;
              hund => sot (n59 "шест")} ;
  size = plg} ;
lin n7  =
  {s = table {unit => n59 "сем" ;
              teen => nadsat "сем" ;
              ten  => n5070 "сем" ;
              hund => sot (n59 "сем") } ; 
  size = plg} ;
lin n8  =
  {s = table {unit => vosem ;
              teen => nadsat "восем" ;
              ten  => \\ g, a, c =>
		case <c, g> of {
		  <(Nom|Acc), _           > => "восемьдесят";
		  <(Gen|Dat|Prepos _), _  > => "восьмидесяти" ;
		  <Inst, _                > => "восемьюдесятью"
		};
              hund => sot vosem 
     } ; 
  size = plg} ;
lin n9  =
  {s = table {unit => n59 "девят" ;
              teen => nadsat "девят" ;
              ten  => \\ g, a, c =>
		case <c, g> of {
		  <(Nom|Acc), _  >               => "девяносто";
		  <(Gen|Dat|Inst|Prepos _), _  > => "девяноста"
		};
              hund => sot (n59 "девят") } ; 
  size = plg} ;

oper n59 : Str -> (Gender => Animacy => Case => Str)  = \ n -> \\ g, a, c =>
		case <c, g> of {
		  <(Nom|Acc), _           > => n + "ь";
		  <(Gen|Dat|Prepos _), _  > => n + "и";
		  <Inst,      _           > => n + "ью"
		};

oper n2030 : Str -> (Gender => Animacy => Case => Str)  = \ n -> \\ g, a, c =>
		case <c, g> of {
		  <(Nom|Acc), _           > => n + "дцать";
		  <(Gen|Dat|Prepos _), _  > => n + "дцати" ;
		  <Inst, _                > => n + "дцатью"
		};

oper n5070 : Str -> (Gender => Animacy => Case => Str)  = \ n -> \\ g, a, c =>
		case <c, g> of {
		  <(Nom|Acc), _           > => n + "ьдесят";
		  <(Gen|Dat|Prepos _), _  > => n + "идесяти" ;
		  <Inst, _                > => n + "ьюдесятью"
		};

oper tri : Gender => Animacy => Case => Str = \\ g, a, c =>
       		case <c, g> of {
		  <(Nom|Acc), _       > => "три";
		  <(Gen|Prepos _), _  > => "трех";
		  <Dat, _             > => "трем";
		  <Inst,      _       > => "тремя"
		};

oper chetyre : Gender => Animacy => Case => Str = \\ g, a, c =>
       		case <c, g> of {
		  <(Nom|Acc), _       > => "четыре";
		  <(Gen|Prepos _), _  > => "четырех";
		  <Dat, _             > => "четырем";
		  <Inst,      _       > => "четырьмя"
		};

oper vosem : Gender => Animacy => Case => Str = \\ g, a, c =>
       		case <c, g> of {
		  <(Nom|Acc), _  >          => "восемь";
		  <(Gen|Dat|Prepos _), _  > => "восьми";
		  <Inst,      _  >          => "восемью"
		};

-- a little tribute to Burgess
oper nadsat : Str -> (Gender => Animacy => Case => Str)  = \ n -> \\ g, a, c =>
		case <c, g> of {
		  <(Nom|Acc), _  >          => n + "надцать";
		  <(Gen|Dat|Prepos _), _  > => n + "надцати";
		  <Inst,      _  >          => n + "надцатью"
		};

oper sta : (Gender => Animacy => Case => Str) -> (Gender => Animacy => Case => Str)  = \ n -> \\ g, a, c =>
		case <c, g> of {
		  <(Nom|Acc), _  >     => n ! Fem ! Animate ! c + "ста";
		  <Gen, _        >     => n ! Fem ! Animate ! c + "сот";
		  <Dat, _        >     => n ! Fem ! Animate ! c + "стам";
		  <Inst, _       >     => n ! Fem ! Animate ! c + "юстами";
		  <Prepos _, _   >     => n ! Fem ! Animate ! c + "стах"
		};

oper sot : (Gender => Animacy => Case => Str) -> (Gender => Animacy => Case => Str)  = \ n -> \\ g, a, c =>
		case <c, g> of {
		  <(Nom|Acc), _  >     => n ! Fem ! Animate ! c + "сот";
		  <Gen, _        >     => n ! Fem ! Animate ! c + "сот";
		  <Dat, _        >     => n ! Fem ! Animate ! c + "стам";
		  <Inst, _       >     => n ! Fem ! Animate ! c + "юстами";
		  <Prepos _, _   >     => n ! Fem ! Animate ! c + "ста"
		};

lin pot01  =
  {s = table {attr => table {hund => \\ g, a, c => 
			       case <g, a, c> of {
				 <_, _, (Nom|Acc)          > => "сто";
				 <_, _, (Gen|Dat|Prepos _) > => "ста";
				 <_, _, Inst               > => "сотней"
			       }; 
			     _ => \\ g, a, c => []} ; 
              _    => table {hund => \\ g, a, c => 
			       case <g, a, c> of {
				 <_, _, (Nom|Acc)          > => "сто";
				 <_, _, (Gen|Dat|Prepos _) > => "ста";
				 -- TODO: case agreement with nouns
				 <_, _, Inst               > => "сотней"
			       }; 
                             _    => \\ g, a, c =>
			       case <g, a, c> of {
				 <Masc, Animate, Acc> => "одного";
				 <Masc, Inanimate, Acc> => "один";
				 <Masc, _, Nom      > => "один";
				 <Masc, _, Gen      > => "одного";
				 <Masc, _, Dat      > => "одному";
				 <Masc, _, Inst     > => "одним";
				 <Masc, _, Prepos _ > => "одном";
				 <Fem, _, Nom       > => "одна";
				 <Fem, _, (Gen|Dat|Inst|Prepos _) > => "одной";
				 <Fem, _, Acc> => "одну";
				 <Neut, _, (Nom|Acc) > => "одно";
				 <Neut, _, Gen       > => "одного";
				 <Neut, _, Dat       > => "одному";
				 <Neut, _, Inst      > => "одним";
				 <Neut, _, Prepos _  > => "одном"}}} ;
   size = nom} ;
lin pot0 d =
  {s = table {_ => d.s} ; size = d.size} ;
lin pot110  =
  {s = \\ p => n59 "десять" ; size = plg} ;
lin pot111  =
  {s = \\ p => nadsat "один" ; size = plg} ; --- 11
lin pot1to19 d =
  {s = table {_ => d.s ! teen} ; size = plg} ;
lin pot0as1 n =
  {s = table {p => n.s ! p ! unit} ; size = n.size} ;
lin pot1 d =
  {s = table {_ => d.s ! ten} ; size = plg} ; ---
lin pot1plus d e =
  {s = table {_ => \\ g, a, c => d.s ! ten ! g ! a ! c ++ e.s ! indep ! unit ! g ! a ! c} ; size = e.size} ;
lin pot1as2 n =
  {s = n.s ; size = n.size} ;
lin pot2 d =
  {s = table {p => d.s ! p ! hund} ; size = plg} ;
lin pot2plus d e =
  {s = \\ p, g, a, c => d.s ! p ! hund ! g ! a ! c ++ e.s ! indep ! g ! a ! c ; size = e.size} ;
lin pot2as3 n =
  {s = n.s ! indep} ;
lin pot3 n =
  {s = \\ g, a, c => n.s ! attr ! Fem ! a ! c ++ mille ! n.size} ;
lin pot3plus n m =
  {s = \\ g, a, c => n.s ! attr ! Fem ! a ! c ++ mille ! n.size ++ m.s ! indep ! g ! a ! c} ;

--- TODO
--- raz/odin

-- numerals as sequences of digits

  lincat 
    Dig = TDigit ;

  lin
    IDig d = {s = d.s ; n = d.n} ;

    IIDig d i = {
      s = d.s ++ i.s ;
      n = Pl
    } ;

    D_0 = mkDig "0" ;
    D_1 = mk3Dig "1" "1" Sg ; ----
    D_2 = mkDig "2" ;
    D_3 = mkDig "3" ;
    D_4 = mkDig "4" ;
    D_5 = mkDig "5" ;
    D_6 = mkDig "6" ;
    D_7 = mkDig "7" ;
    D_8 = mkDig "8" ;
    D_9 = mkDig "9" ;

  oper
    mk2Dig : Str -> Str -> TDigit = \c,o -> mk3Dig c o Pl ;
    mkDig : Str -> TDigit = \c -> mk2Dig c (c + "o") ;

    mk3Dig : Str -> Str -> Number -> TDigit = \c,o,n -> {
      s = c ; ---- gender
      n = n
      } ;

    TDigit = {
      n : Number ;
      s : Str
    } ;

}

