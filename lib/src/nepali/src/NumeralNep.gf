concrete NumeralNep of Numeral = CatNep ** open ResNep, Prelude in {
-- By Harald Hammarstroem
-- Modification for Nepali by Dinesh Simkhada and Shafqat Virk - 2011
 flags coding=utf8 ;


param DForm = unit | ten ;
param DSize = sg | r2 | r3 | r4 | r5 | r6 | r7 | r8 | r9 ;
param Size = singl | less100 | more100 ; 

oper LinDigit = {s : DForm => Str ; size : DSize ; n : Number} ;


lincat Dig = {s:Str ; n : Number} ;
lincat Digit = LinDigit ;
lincat Sub10 = {s : DForm => Str ; size : DSize ; n : Number} ;
lincat Sub100 = {s : Str ; size : Size ; n : Number} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size ; n : Number } ; 
lincat Sub1000000 = {s : Str ; n : Number } ;

lin num x0 = 
    {s = table {
          NCard => x0.s ; 
          NOrd  => Prelude.glue x0.s "wV"  -- need to use mkOrd x0.s but it gives linking error 
          };
       n = x0.n
    } ; 



oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \do -> \bis -> \sz ->  
  {s = table {unit => do ; ten => bis } ; 
   size = sz ; n = Pl} ;

lin n2 = mkNum "duI:" "bIs"     r2 ;
lin n3 = mkNum "tIn"  "tIs"     r3 ;
lin n4 = mkNum "Car"  "CalIs"   r4 ;
lin n5 = mkNum "paVC" "pCas"    r5 ;
lin n6 = mkNum "c"    "saQI"    r6 ; 
lin n7 = mkNum "sat"  "stx:trI" r7 ;  -- सत्तरी
lin n8 = mkNum "AQ"   "HsI"     r8 ;
lin n9 = mkNum "nw"   "nbx:be"  r9 ; 

oper 
  mkR : (a1,_,_,_,_,_,_,_,a9 : Str) -> DSize => Str = 
   \a1,a2,a3,a4,a5,a6,a7,a8,a9 -> table {
     sg => a1 ; 
     r2 => a2 ;
     r3 => a3 ;
     r4 => a4 ;
     r5 => a5 ;
     r6 => a6 ;
     r7 => a7 ;
     r8 => a8 ;
     r9 => a9
    } ; 

  -- REF http://dsal.uchicago.edu/dictionaries/schmidt/
  -- Ordinals from One - Hundred are irregular
  rows : DSize => DSize => Str = table {
    sg => mkR "e:Gar"       "e:kx:kai:s" "e:ktIs"   "e:kCalIs"  "e:kafnx:z=n"   "e:ksQx:QI"  "e:khtx:tr"  "e:kasI"   "e:kanx:z=nbx:be" ;  
    r2 => mkR "bahx:r"      "bai:s"      "btx:tIs"  "byalIs"    "bafnx:z=n"     "bEsQx:QI"   "bhtx:tr"    "byasI"    "byanx:z=nbx:be" ; 
    r3 => mkR "tehx:r"      "tei:s"     "tetx:tIs"  "tx:riCalIs" "tx:ripnx:z=n" "tx:risQx:QI" "tx:rihtx:tr" "tx:riyasI" "tx:riyanx:z=nbx:be" ;
    r4 => mkR "CwD"         "CwbIs"     "CwMtIs"    "CvalIs"    "Cvnx:z=n"      "CwsQx:QI"   "Cwhtx:tr"   "CwrasI"   "Cwranx:z=nbx:be"; 
    r5 => mkR "pnx:Dx:r"    "pCx:CIs"   "pEMtIs"    "pEMtalIs"  "pCpnx:z=n"     "pEMsQx:QI"  "pChtx:tr"   "pCasI"    "pnx:Canx:z=nbx:be" ; 
    r6 => mkR "sohx:r"      "cbx:bIs"   "ctx:tIs"   "cyalIs"    "cpnx:z=n"      "cEMsQx:QI"  "cyhtx:tr"   "cyasI"    "cyanx:z=nbx:be" ; 
    r7 => mkR "stx:r"       "stx:tai:s" "swMtIs"    "stCalIs"   "snx:tafnx:z=n" "stsQx:QI"   "sthtx:tr"   "stasI"    "snx:tanx:z=nbx:be" ; 
    r8 => mkR "HQar"        "HQx:Qai:s" "HQtIs"     "HQtalIs"   "Hnx:Qafnx:z=n" "HQsQx:QI"   "HQhtx:tr"   "HQasI"    "Hnx:Qanx:z=nbx:be" ;
    r9 => mkR "fnx:z=nai:s" "fnnx:tIs"  "fnnx:CalIs" "fnnx:pCas" "fnnx:saQI"    "fnnx:stx:trI" "fnasI"    "fnanx:z=nbx:be" "fnanx:sy"  
  } ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "e:k" ; _ => "dmy" } ; size = sg ; n = Sg} ;
lin pot0 d = d ; 
lin pot110 = {s = "ds" ; size = less100 ; n = Pl} ; 
lin pot111 = {s = rows ! sg ! sg ; size = less100 ; n = Pl} ;
lin pot1to19 d = {s = rows ! d.size ! sg ; size = less100 ; n = d.n} ;
lin pot0as1 n = {s = n.s ! unit ; size = table {sg => singl ; _ => less100} ! n.size ; n = n.n } ;

lin pot1 d = {s = d.s ! ten ; size = less100 ; n = d.n} ;
lin pot1plus d e = {s = rows ! e.size ! d.size ; size = less100 ; n = d.n} ;

lin pot1as2 n = {s = n.s ; s2 = "dmy" ; size = n.size ; n = n.n} ;
lin pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "laK" ; size = more100 ; n = d.n} ;
lin pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "laK" ++ (mkhazar e.s e.size) ; 
   size = more100 ; n = d.n} ;

lin pot2as3 n = {s = n.s ; n = n.n} ;
lin pot3 n = {s = table { singl => ekhazar ;
                          less100 => n.s ++ "hjar" ; 
                          more100 => n.s2 } ! n.size ; n = n.n} ;
lin pot3plus n m = 
  {s = table {singl => ekhazar ;
              less100 => n.s ++ "hjar" ; 
              more100 => n.s2 } ! n.size ++ m.s ; n = n.n} ;

lin D_0 = { s = "0" ; n = Sg};
lin D_1 = { s = "1" ; n = Sg};
lin D_2 = { s = "2" ; n = Pl};
lin D_3 = { s = "3" ; n = Pl};
lin D_4 = { s = "4" ; n = Pl};
lin D_5 = { s = "5" ; n = Pl};
lin D_6 = { s = "6" ; n = Pl};
lin D_7 = { s = "7" ; n = Pl};
lin D_8 = { s = "8" ; n = Pl};
lin D_9 = { s = "9" ; n = Pl};

lin IDig d = { s = \\_ => d.s ; n = d.n} ;

lin IIDig d dg = { s = \\df => Prelude.glue d.s (dg.s ! df) ; n = Pl }; 

oper ekhazar : Str = variants {"e:k" ++ "hjar" ; "hjar"} ; 
oper mkhazar : Str -> Size -> Str = \s -> \sz -> table {singl => ekhazar ; _ => s ++ "hjar"} ! sz ;
oper mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "e:k" ++ "sy" ; _ => s ++ "sy"} ! sz ;
}
