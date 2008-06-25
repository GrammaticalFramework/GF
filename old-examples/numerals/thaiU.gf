include numerals.Abs.gf ;

-- Thai transliteration, produces thaiU.gf by GF/Text/Thai.hs
-- AR 28/12/2006

flags coding=utf8 ;

lincat 
  Numeral    = {s : Str} ;
  Digit      = {s : DForm => Str} ;
  Sub10      = {s : DForm => Str} ;
  Sub100     = {s : NForm => Str} ;
  Sub1000    = {s : NForm => Str} ;
  Sub1000000 = {s : Str} ;

lin 
  num x = x ;

  pot01 = mkNum "หนึง" "หนึง" "เอ็ด" ;

  n2 = mkNum  "สอง" "ยี่" "สอง" ;
  n3 = regNum "สาม" ;
  n4 = regNum "สี่" ; -- T1 = E48 '
  n5 = regNum "ห้า" ;  -- T2 = E49 9
  n6 = regNum "หก" ;
  n7 = regNum "เจ็ด" ;   -- S  = E47 w
  n8 = regNum "แปด" ; 
  n9 = regNum "เกา" ;


  pot0 d = d ;

  pot110 = {s = sip} ;
  pot111 = {s = table {
    Unit => ["สิบเอ็ด"] ; 
    Thousand => ["หนึงหมื่นหนึงพะน"]
    }
  } ;
  pot1to19 d = {s = table {
    Unit => "สิบ" ++ d.s ! After ; 
    Thousand => ["หนึงหมื่น"] ++ d.s ! Indep ++ "พะน"
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


  sip  = table {Unit => "สิบ"   ; Thousand => "หมื่น"} ;
  roy  = table {Unit => "ร้อย" ; Thousand => "แสน"} ;
  phan = table {Unit => []      ; Thousand => "พะน"} ;
