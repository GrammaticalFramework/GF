include numerals.Abs.gf ;
flags coding=russian ;

-- Toiska, 13/8/2000, AR with Arto Mustajoki.

param DForm = unit  | teen  | ten | hund ;
param Place = attr  | indep  ;
param Size  = nom | sgg | plg ;
param Gen = masc | fem | neut ;
lincat Numeral = {s : Str} ;
lincat Digit = {s : DForm => Gen => Str ; size : Size} ;
lincat Sub10 = {s : Place => DForm => Gen => Str ; size : Size} ;
lincat Sub100 = {s : Place => Gen => Str ; size : Size} ;
lincat Sub1000 = {s : Place => Gen => Str ; size : Size} ;
lincat Sub1000000 = {s : Gen => Str} ;

oper mille : Size => Str = table {
  {nom} => "t1säqa" ;
  {sgg} => "t1säqi" ;
  _     => "t1säq"} ;

oper gg : Str -> Gen => Str = \s -> table {_ => s} ;

lin num x0 =
  {s = "/_" ++ x0.s ! masc ++ "_/"} ;  -- Russian environment

lin n2  =
  {s = table {{unit} => table {{fem} => "dve" ; _ => "dva"} ; 
            {teen} => gg "dvenadcat'" ; 
            {ten}  => gg "dvadcat'" ;
            {hund} => gg "dvesti"} ; 
   size = sgg} ;
lin n3  =
  {s = table {{unit} => gg "tri" ; 
            {teen} => gg "trinadcat'" ; 
            {ten}  => gg "tridcat'" ;
            {hund} => gg "trista"} ; 
  size = sgg} ;
lin n4  =
  {s = table {{unit} => gg "qet1re" ; 
            {teen} => gg "qet1rnadcat'" ; 
            {ten}  => gg "sorok" ;
            {hund} => gg "qet1resta"} ; 
  size = sgg} ;
lin n5  =
  {s = table {{unit} => gg "pät'" ; 
            {teen} => gg "pätnadcat'" ; 
            {ten}  => gg "pät'desät" ;
            {hund} => gg "pät'sot"} ; 
  size = plg} ;
lin n6  =
  {s = table {{unit} => gg "west'" ; 
            {teen} => gg "westnadcat'" ; 
            {ten}  => gg "west'desät" ;
            {hund} => gg "west'sot"} ; 
  size = plg} ;
lin n7  =
  {s = table {{unit} => gg "sem'" ; 
            {teen} => gg "semnadcat'" ; 
            {ten}  => gg "sem'desät" ;
            {hund} => gg "sem'sot"} ; 
  size = plg} ;
lin n8  =
  {s = table {{unit} => gg "vosem'" ; 
            {teen} => gg "vosemnadcat'" ; 
            {ten}  => gg "vosem'desät" ;
            {hund} => gg "vosem'sot"} ; 
  size = plg} ;
lin n9  =
  {s = table {{unit} => gg "devät'" ; 
            {teen} => gg "devätnadcat'" ; 
            {ten}  => gg "devänosto" ;
            {hund} => gg "devät'sot"} ; 
  size = plg} ;


lin pot01  =
  {s = table {{attr} => table {{hund} => gg "sto" ; _ => gg []} ; 
            _ => table {{hund} => gg "sto" ; 
                     _ => table {{masc} => "odin" ; {fem} => "odna" ; _ => "odno"}}} ;
   size = nom} ;
lin pot0 d =
  {s = table {_ => d.s} ; size = d.size} ;
lin pot110  =
  {s = table {_ => gg "desät'"} ; size = plg} ;
lin pot111  =
  {s = table {_ => gg "odinnadcat'"} ; size = plg} ; --- 11
lin pot1to19 d =
  {s = table {_ => d.s ! teen} ; size = plg} ;
lin pot0as1 n =
  {s = table {p => n.s ! p ! unit} ; size = n.size} ;
lin pot1 d =
  {s = table {_ => d.s ! ten} ; size = plg} ; ---
lin pot1plus d e =
  {s = table {_ => 
            table {g => d.s ! ten ! g ++ e.s ! indep ! unit ! g}} ; size = e.size} ;
lin pot1as2 n =
  {s = n.s ; size = n.size} ;
lin pot2 d =
  {s = table {p => d.s ! p ! hund} ; size = plg} ;
lin pot2plus d e =
  {s = table {p => table {g => d.s ! p ! hund ! g ++ e.s ! indep ! g}} ; size = e.size} ;
lin pot2as3 n =
  {s = n.s ! indep} ;
lin pot3 n =
  {s = gg (n.s ! attr ! fem ++ mille ! n.size)} ;
lin pot3plus n m =
  {s = table {g => n.s ! attr ! fem ++ mille ! n.size ++ m.s ! indep ! g}} ;

--- TODO
--- raz/odin

