include numerals.Abs.gf ;
flags coding=devanagari ;

param DForm = unit | ten ;
param DSize = sg | r2 | r3 | r4 | r5 | r6 | r7 | r8 | r9 ;
param Size = sing | less100 | more100 ; 

oper LinDigit = {s : DForm => Str ; size : DSize} ;

lincat Numeral =    { s : Str } ;
lincat Digit = LinDigit ;
lincat Sub10 = {s : DForm => Str ; size : DSize} ;
lincat Sub100 = {s : Str ; size : Size} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size } ; 
lincat Sub1000000 = { s : Str } ;

lin num x0 =
  {s = "/&" ++ x0.s ++ "&/"} ; -- the Devana:gari environment


-- H is for aspiration (h is a sepaarate letter)
-- M is anusvara
-- ~ is candrabindhu
-- c is is Eng. ch in e.g chop 
-- cH is chH
-- _: is length
-- T, D, R are the retroflexes

oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \do -> \bis -> \sz ->  
  {s = table {unit => do ; ten => bis } ; 
   size = sz } ;

-- lin n1 mkNum "ek" "gya:rah" "das" 
lin n2 = mkNum "do" "bi:s" r2 ;
lin n3 = mkNum "ti:n" "ti:s" r3 ;
lin n4 = mkNum "ca:r" "ca:li:s" r4 ;
lin n5 = mkNum "pa:~nc" "paca:s" r5 ;
lin n6 = mkNum (variants {"cHah" ; "cHa;" ; "cHai"}) "sa:TH" r6 ; 
lin n7 = mkNum "sa:t" "sattar" r7; 
lin n8 = mkNum "a:TH" "assi:" r8;
lin n9 = mkNum "nau" (variants {"navve" ; "nabbe" }) r9 ;

oper mkR : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> DSize => Str = \a1 -> \a2 -> \a3 -> \a4 -> \a5 -> \a6 -> \a7 -> \a8 -> \a9 -> table {
  sg => a1 + "ah" ;
  r2 => a2 + "i:s" ;
  r3 => a3 + "ti:s" ;
  r4 => a4 + "a:li:s" ;
  r5 => a5 + "an" ;
  r6 => a6 + "saTH" ;
  r7 => a7 + "hattar" ;
  r8 => a8 + "a:si:" ;
  r9 => a9 + "a:nave"
} ;

oper rows : DSize => DSize => Str = table {
  sg => mkR "gya:r" "ikk" "ikat" "ekt" "ikya:v" "ik" "ik" "iky" "iky" ; 
  r2 => mkR "ba:r" "ba:" "bat" "bay" "ba:v" "ba:" "ba" "bay" "b" ;
  r3 => mkR "ter" "te" "taiM" "taiMt" "tirp" "tir" "ti" "tir" "tir" ;
  r4 => mkR "caud" "caub" "cauM" "cav" "caup" "cauM" "cau" "caur" "caur" ;
  r5 => mkR "paMdr" "pacc" "paiM" "paiMt" "pacp" "paiM" "pac" "pac" "pac" ;
  r6 => mkR "sol" "cHabb" "cHat" "cHiy" "cHapp" "cHiya:" "cHi" "cHiy" "cHiy" ;
  r7 => mkR (variants { "sattr" ; "satr"}) "satta:v" "saiM" "saiMt" "satta:" "sar" "sat" (variants {"satt" ; "sat" }) "satt" ;
  r8 => mkR "aTHa:r" "aTTHa:" "aR" "aRt" "aTTHa:v" "aR" "aTH" (variants { "aTTH" ; "aTH" }) "aTTH" ; 
  r9 => table {sg => "unni:s" ; r2 => "unati:s" ; r3 => "unata:li:s" ; 
               r4 => "unaca:s" ; r5 => "unasaTH" ; r6 => "unahattar" ; 
               r7 => (variants{"unna:si:" ; "unya:si:"}) ; 
               r8 => "nava:si:" ; r9 => "ninya:nave" } 
} ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "ek" ; _ => "dummy" } ; size = sg} ;
lin pot0 d = d ; 
lin pot110 = {s = "das" ; size = less100} ; 
lin pot111 = {s = rows ! sg ! sg ; size = less100} ;
lin pot1to19 d = {s = rows ! d.size ! sg ; size = less100} ;
lin pot0as1 n = {s = n.s ! unit ; size = table {sg => sing ; _ => less100} ! n.size } ;

lin pot1 d = {s = d.s ! ten ; size = less100} ;
lin pot1plus d e = {s = rows ! e.size ! d.size ; size = less100} ;

lin pot1as2 n = {s = n.s ; s2 = "dummy" ; size = n.size } ;
lin pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "la:kH" ; size = more100} ;
lin pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "la:kH" ++ (mkhazar e.s e.size) ; 
   size = more100} ;

lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = table { sing => ekhazar ;
                          less100 => n.s ++ "haza:r" ; 
                          more100 => n.s2 } ! n.size} ;
lin pot3plus n m = 
  {s = table {sing => ekhazar ;
              less100 => n.s ++ "haza:r" ; 
              more100 => n.s2 } ! n.size ++ m.s} ;


oper ekhazar : Str = variants {"haza:r" ; "ek" ++ "haza:r"} ; 
oper mkhazar : Str -> Size -> Str = \s -> \sz -> table {sing => ekhazar ; _ => s ++ "haza:r"} ! sz ;
oper mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "sau" ; _ => s ++ "sau"} ! sz ;
