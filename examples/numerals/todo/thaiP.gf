concrete thaiP of Numerals = {
-- include numerals.Abs.gf ;

-- Thai pronunciation (mostly following Smyth's Essential Grammar) 
-- AR 28/12/2006

-- flags coding=utf8 ;

lincat 
  Numeral    = {s : Str} ;
  Digit      = {s : DForm => Str} ;
  Sub10      = {s : DForm => Str} ;
  Sub100     = {s : NForm => Str} ;
  Sub1000    = {s : NForm => Str} ;
  Sub1000000 = {s : Str} ;

lin 
  num x = x ;

  pot01 = mkNum "nỳng" "nỳng" "èt" ;

  n2 = mkNum  "söong" "yîi" "söong" ;
  n3 = regNum "säam" ;
  n4 = regNum "sìi" ;
  n5 = regNum "hâa" ; 
  n6 = regNum "hòk" ;
  n7 = regNum "cèt" ;
  n8 = regNum "pèet" ; 
  n9 = regNum "kâaw" ;


  pot0 d = d ;

  pot110 = {s = sip} ;
  pot111 = {s = table {
    Unit => ["sìp èt"] ; 
    Thousand => ["nỳng mỳyn nỳng phan"]
    }
  } ;
  pot1to19 d = {s = table {
    Unit => "sìp" ++ d.s ! After ; 
    Thousand => ["nỳng mỳyn"] ++ d.s ! Indep ++ "phan"
    }
  } ;
  pot0as1 d = {s = \\n => d.s ! Indep ++ phan ! n} ;
  pot1 d = {s = \\n => d.s ! ModTen ++ sip ! n} ;
  pot1plus d e = {
    s = \\n => d.s ! ModTen ++ sip ! n ++ e.s ! After ++ phan ! n
  } ;
  pot1as2 n = n ;
  pot2 d = {s = \\n => d.s ! Indep ++ roy ! n} ;
  pot2plus d e = {s = \\n => d.s ! Indep ++ roy ! n ++ e.s ! n} ;
  pot2as3 n = {s = n.s ! Unit} ;
  pot3 n = {s = n.s ! Thousand} ;
  pot3plus n m = {s = n.s ! Thousand ++ m.s ! Unit} ;

param 
  DForm = Indep | ModTen | After ;
  NForm = Unit | Thousand ;

oper 
  mkNum : Str -> Str -> Str -> {s : DForm => Str} = \x,y,z ->
    {s = table {Indep => x ; ModTen => y ; After => z}} ;
  regNum : Str -> {s : DForm => Str} = \x -> 
    mkNum x x x ;


  sip  = table {Unit => "sìp"  ; Thousand => "mỳyn"} ;
  roy  = table {Unit => "róoy" ; Thousand => "sëen"} ;
  phan = table {Unit => []      ; Thousand => "phan"} ;

}
