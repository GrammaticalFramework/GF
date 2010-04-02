concrete NumeralUrd of Numeral = CatUrd ** open ResUrd in {
-- By Harald Hammarström
-- Modification for Urdu Shafqat Virk
 flags coding=utf8 ;
--- still old Devanagari coding


param DForm = unit | ten ;
param DSize = sg | r2 | r3 | r4 | r5 | r6 | r7 | r8 | r9 ;
param Size = sing | less100 | more100 ; 

oper LinDigit = {s : DForm => Str ; size : DSize ; n : Number} ;


lincat Dig = { s:Str ; n : Number};
lincat Digit = LinDigit ;
lincat Sub10 = {s : DForm => Str ; size : DSize ; n : Number} ;
lincat Sub100 = {s : Str ; size : Size ; n : Number} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size ; n : Number } ; 
lincat Sub1000000 = { s : Str ; n : Number } ;

lin num x0 = 
    {s = table {
          NCard =>   x0.s ; 
          NOrd =>  x0.s ++ "waN" -- need to use mkOrd which will make irregular ordinals but it gives path error
          };
       n = x0.n
    } ;
oper mkOrd : Str -> Str =
 \s -> case s of {
                    "ek"                  => "phla";
                    "do"                  => "dwsra";
                    "ti:n"                => "tesra";
                    "ca:r"                => "cwth-a";
                    ("cHah"|"cHa"|"cHai") => "ch-Ta";
                    _                     =>  s ++ "waN"
                  };
--  {s = \\_ => x0.s ; n = x0.n} ; 


oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \do -> \bis -> \sz ->  
  {s = table {unit => do ; ten => bis } ; 
   size = sz ; n = Pl} ;

lin n2 = mkNum "dw" "bys" r2 ;
lin n3 = mkNum "tyn" "tys" r3 ;
lin n4 = mkNum "car" "calys" r4 ;
lin n5 = mkNum "panc" "pcas" r5 ;
lin n6 = mkNum "ch-" "sath-" r6 ; 
lin n7 = mkNum "sat" "str" r7; 
lin n8 = mkNum "Ath-" "asy" r8;
lin n9 = mkNum "nw" "nwE" r9 ;

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
  sg => mkR "gyarh" "ikk" "ikat" "ekt" "ikyaw" "ik" "ik" "iky" "iky" ; 
  r2 => mkR "barh" "bay" "bat" "bay" "baw" "ba" "ba" "bay" "b" ;
  r3 => mkR "tyr" "ty" "tyn" "tnt" "trp" "try" "t" "tr" "tr" ;
  r4 => mkR "cwd" "cwb" "cwn" "cwa" "cww" "cwn" "cwh" "cwr" "cwr" ;
  r5 => mkR "pnd" "pcy" "pyn" "pnta" "pcp" "pyn" "ph" "pc" "pc" ;
  r6 => mkR "swl" "ch-b" "ch-t" "ch-y" "ch-p" "ch-ya" "ch-" "ch-y" "ch-y" ;
  r7 => mkR "str" "sta" "syn" "snt" "staw" "sta" "sr" "st" "sta" ;
  r8 => mkR "ath-ar" "ath-ay" "aR" "aRt" "ath-aw" "aR" "ath-" "ath-" "ath-" ; 
  r9 => table {sg => "anys" ; r2 => "antys" ; r3 => "antalys" ; 
               r4 => "ancas" ; r5 => "ansth-" ; r6 => "anhtr" ; 
               r7 => "anasy" ; 
               r8 => "ananwE" ; r9 => "nnanwE" } 
} ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "ayk" ; _ => "dummy" } ; size = sg ; n = Sg} ;
lin pot0 d = d ; 
lin pot110 = {s = "das" ; size = less100 ; n = Pl} ; 
lin pot111 = {s = rows ! sg ! sg ; size = less100 ; n = Pl} ;
lin pot1to19 d = {s = rows ! d.size ! sg ; size = less100 ; n = d.n} ;
lin pot0as1 n = {s = n.s ! unit ; size = table {sg => sing ; _ => less100} ! n.size ; n = n.n } ;

lin pot1 d = {s = d.s ! ten ; size = less100 ; n = d.n} ;
lin pot1plus d e = {s = rows ! e.size ! d.size ; size = less100 ; n = d.n} ;

lin pot1as2 n = {s = n.s ; s2 = "dummy" ; size = n.size ; n = n.n} ;
lin pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "lakh-" ; size = more100 ; n = d.n} ;
lin pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "lakh-" ++ (mkhazar e.s e.size) ; 
   size = more100 ; n = d.n} ;

lin pot2as3 n = {s = n.s ; n = n.n} ;
lin pot3 n = {s = table { sing => ekhazar ;
                          less100 => n.s ++ "hzar" ; 
                          more100 => n.s2 } ! n.size ; n = n.n} ;
lin pot3plus n m = 
  {s = table {sing => ekhazar ;
              less100 => n.s ++ "hzar" ; 
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
lin IIDig d dg = { s = \\df => dg.s ! df ++ d.s ; n = Pl }; -- need to use + rather than ++, but gives error need to discuss

oper ekhazar : Str = variants {"hzar" ; "ayk" ++ "hzar"} ; 
oper mkhazar : Str -> Size -> Str = \s -> \sz -> table {sing => ekhazar ; _ => s ++ "hzar"} ! sz ;
oper mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "sw" ; _ => s ++ "sw"} ! sz ;
}
