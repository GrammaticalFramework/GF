concrete NumeralTha of Numeral = CatTha ** open ResTha, StringsTha in {

lincat 
--  Numeral    = {s : Str} ;
  Digit      = {s : DForm => Str} ;
  Sub10      = {s : DForm => Str} ;
  Sub100     = {s : NForm => Str} ;
  Sub1000    = {s : NForm => Str} ;
  Sub1000000 = {s : Str} ;

lin 
  num x = x ;

  pot01 = mkNum nvg_s nvg_s et_s ;

  n2 = mkNum soog_s yii_s soog_s ;
  n3 = regNum saam_s ;
  n4 = regNum sii_s ;
  n5 = regNum haa_s ;
  n6 = regNum hok_s ;
  n7 = regNum cet_s ; 
  n8 = regNum peet_s ;
  n9 = regNum kaaw_s ;


  pot0 d = d ;

  pot110 = {s = sip} ;
  pot111 = {s = table {
    Unit => sip_s ++ et_s ;
    Thousand => nvg_s ++ mvvn_s ++ nvg_s ++ phan_s
    }
  } ;
  pot1to19 d = {s = table {
    Unit => sip_s ++ d.s ! After ; 
    Thousand => nvg_s ++ mvvn_s ++ d.s ! Indep ++ phan_s
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


  sip  = table {Unit => sip_s   ; Thousand => mvvn_s} ;
  roy  = table {Unit => rooy_s ; Thousand => seen_s} ;
  phan = table {Unit => []      ; Thousand => phan_s} ;

}
