include numerals.Abs.gf ;

-- Thai transliteration, produces thaiU.gf by GF/Text/Thai.hs
-- AR 28/12/2006

lincat 
  Numeral    = {s : Str} ;
  Digit      = {s : DForm => Str} ;
  Sub10      = {s : DForm => Str} ;
  Sub100     = {s : NForm => Str} ;
  Sub1000    = {s : NForm => Str} ;
  Sub1000000 = {s : Str} ;

lin 
  num x = x ;

  pot01 = mkNum "hnvg" "hnvg" "eOMd'" ;

  n2 = mkNum  "s-Og" "y'i:E" "s-Og" ;
  n3 = regNum "s-a:m" ;
  n4 = regNum "s-i:E" ;
  n5 = regNum "ha:E" ; 
  n6 = regNum "ho?k" ;
  n7 = regNum "ecMd'" ;
  n8 = regNum "e:pd'" ; 
  n9 = regNum "eka:" ;


  pot0 d = d ;

  pot110 = {s = sip} ;
  pot111 = {s = table {
    Unit => ["s'ib et"] ; 
    Thousand => ["hnvg hmv:En hnvg p2an"]
    }
  } ;
  pot1to19 d = {s = table {
    Unit => "s'ib" ++ d.s ! After ; 
    Thousand => ["hnvg hmv:En"] ++ d.s ! Indep ++ "p2an"
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


  sip  = table {Unit => "s'ib"  ; Thousand => "hmv:En"} ;
  roy  = table {Unit => "rEOy'" ; Thousand => "se:n"} ;
  phan = table {Unit => []      ; Thousand => "p2an"} ;
