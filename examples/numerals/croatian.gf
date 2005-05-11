include numerals.Abs.gf ;
flags coding=latinasupplement ;

param DForm = unit | teen  | ten | hund ;

-- [c^], [s^], [c']


param ThForm = onlyone | lastone | twoorthreeorfour | fiveup ;

oper LinDigit = {s : DForm => Str; o : ThForm ; t : ThForm } ;

lincat Numeral =    { s : Str } ;
lincat Digit =      LinDigit ;
lincat Sub10 =      {s : DForm => Str; o : ThForm ; t : ThForm } ;
lincat Sub100 =     {s : Str; t : ThForm } ;
lincat Sub1000 =    {s : Str; t : ThForm } ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> Str -> Str -> Str -> ThForm -> LinDigit = 
  \dwa -> \dwanascie -> \dwadziescia -> \dwiescie -> \thform ->
  { s = table {unit => dwa ; teen => dwanascie ; ten => dwadziescia ; hund =>
dwiescie  };
    o =  thform ; t = thform
  };

oper mkRegNum : Str -> LinDigit = 
  \sedam -> 
  { s = table { unit => sedam ; teen => sedam + "naest" ; 
                ten => sedam + "deset" ; hund => sedam ++ "stotina"
              };
    o =  fiveup ; t = fiveup
  };

oper mkTh : Str -> ThForm => Str = \attr ->
  table { onlyone => variants {"hiljada" ; "tisuc'a"} ; lastone => attr ++ "hiljada" ;
          twoorthreeorfour => attr ++ "hiljade" ; fiveup => attr ++ "hiljada"
        }; 

oper ss : Str -> ThForm -> {s : Str ; t : ThForm} = \str -> \th -> {s = str; t = th} ;

lin num x = {s = "/L" ++ x.s ++ "L/"} ; -- Latin A Supplement environment

lin n2 = mkNum "dva" "dvanaest" "dvadeset" (variants { "dve" ++ "stotine" ; "dvesta" } ) twoorthreeorfour ;
lin n3 = mkNum "tri" "trinaest" "trideset" (variants { "tri" ++ "stotine" ; "trista" } ) twoorthreeorfour ;
lin n4 = mkNum "c^etiri" "c^etrnaest" "c^etrdeset" ("c^etiri" ++ "stotine") twoorthreeorfour ;
lin n5 = mkNum "pet" "petnaest" "pedeset" ("pet" ++ "stotina") fiveup ;
lin n6 = mkNum "s^est" "s^esnaest" "s^ezdeset" ("s^est" ++ "stotina") fiveup ;
lin n7 = mkRegNum "sedam" ;
lin n8 = mkRegNum "osam" ;
lin n9 = mkNum "devet" "devetnaest" "devedeset" ("devet" ++ "stotina") fiveup;

lin pot01 = { s = table {hund => variants {"sto" ; "stotina" }; f => "jedan" };
              o = onlyone ; t = lastone
            };
lin pot0 d = {s = table {f => d.s ! f} ; o = d.o ; t = d.t} ;
lin pot110 = ss "deset" fiveup ;
lin pot111 = ss "jedanaest" fiveup ;
lin pot1to19 d = {s = d.s ! teen ; t = fiveup} ;
lin pot0as1 n = {s = n.s ! unit ; t = n.o} ;
lin pot1 d = {s = d.s ! ten ; t = fiveup} ;
lin pot1plus d e = {s = d.s ! ten ++ "i" ++ e.s ! unit; t = e.t} ;
lin pot1as2 n = n ;
lin pot2 d = {s = d.s ! hund ; t = fiveup} ;
lin pot2plus d e = { s = d.s ! hund ++ e.s ; 
                     t = table { onlyone => lastone ; f =>  f } ! e.t 
                   } ;

lin pot2as3 n = n ;
lin pot3 n = {s = (mkTh n.s) ! n.t} ;
lin pot3plus n m = {s = (mkTh n.s) ! n.t ++ m.s} ;


