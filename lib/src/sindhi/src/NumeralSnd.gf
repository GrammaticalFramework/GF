concrete NumeralSnd of Numeral = CatSnd ** open ResSnd, Prelude in {
-- By Harald Hammarstroem
-- Modification for Punjabi by Shafqat Virk
 flags coding=utf8 ;



param DForm = unit | ten ;
param DSize = sg | r2 | r3 | r4 | r5 | r6 | r7 | r8 | r9 ;
param Size = singl | less100 | more100 ; 

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
          NOrd =>  Prelude.glue x0.s "Wn" -- (mkOrd x0.s)  need to use mkOrd which will make irregular ordinals but it gives path error
          };
       n = x0.n
    } ;
oper mkOrd : Str -> Str =
 \s -> case s of {
                    "h'k"                  => "ph'ryWn";
                    "B"                  => "ByWn";
                    "Ty"                => "TyWn";
                    "car"                => "cWaT'Wn";
                    _                     =>  s ++ "WN"
                  };
--  {s = \\_ => x0.s ; n = x0.n} ; 


oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \do -> \bis -> \sz ->  
  {s = table {unit => do ; ten => bis } ; 
   size = sz ; n = Pl} ;

lin n2 = mkNum "B" "Wyh'" r2 ;
lin n3 = mkNum "Ty" "Tyh'" r3 ;
lin n4 = mkNum "car" "calyh'" r4 ;
lin n5 = mkNum "pnj" "pnjah'" r5 ;
lin n6 = mkNum "c'h'" "sT!h' " r6 ; 
lin n7 = mkNum "st" "str" r7; 
lin n8 = mkNum "aT! '" "asy" r8;
lin n9 = mkNum "nW" "nWy" r9 ;

oper mkR : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> DSize => Str = \a1 -> \a2 -> \a3 -> \a4 -> \a5 -> \a6 -> \a7 -> \a8 -> \a9 -> table {
  sg => a1 + "nh'n" ;
  r2 => a2 + "yh' " ;
  r3 => a3 + "yh' " ;
  r4 => a4 + "alyh' " ;
  r5 => a5 + "Wnjah' " ;
  r6 => a6 + "h'T!" ;
  r7 => a7 + "tr" ;
  r8 => a8 + "asy" ;
  r9 => a9 + "anWy"
} ;

oper rows : DSize => DSize => Str = table {
  sg => mkR "yar "   "ayk "  "akT"    "aykyt "   "ayk"   "ayk"   "ayk"   "ayk"   "ayk" ; 
  r2 => mkR "Bay "    "BaW"   "BT"      "Bae't"   "Ba"     "Ba"   "Bah' " "Byy"   "Byy" ;
  r3 => mkR "Tyr "    "TyW "  "TyT"     "Tyt"    "Ty"    "Ty"       "Tyh' " "Ty"    "ty" ;
  r4 => mkR "cWD' "    "cWW "  "cWT"     "cWe't "  "cW"    "cW"      "cWh' "  "cWr "  "cWr" ;
  r5 => mkR "pnd'r "  "pnjW "  "pnjT"   "pnjyt"  "pnj"   "pnj"     "pnjh'"  "pnj"   "pnj" ;
  r6 => mkR "sWr "    "c'W"   "c'Ty"    "c'ae't"  "c'a"   "c'a"     "c'ah'"  "c'"    "c'" ;
  r7 => mkR "str"    "staW"   "stT "   "styt"     "st"    "st"      "st"     "st"     "st" ;
  r8 => mkR "arR"    "aT!aW "  "aT!T"   "aT!y"   "aT!"   "aT!"    "aT!a"   "aT!"   "aT!" ; 
  r9 => table {sg => "at'Wyh' " ; r2 => "at'Tyh' " ; r3 => "at'ytalyh' " ; 
               r4 => "at'Wnjah' " ; r5 => "at'h'T! " ; r6 => "at'tr " ; 
               r7 => "at'asy " ; 
               r8 => "at'anWy " ; r9 => "nWanWy" } 
} ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "h'k" ; _ => "dmy" } ; size = sg ; n = Sg} ;
lin pot0 d = d ; 
lin pot110 = {s = "D'h' " ; size = less100 ; n = Pl} ; 
lin pot111 = {s = rows ! sg ! sg ; size = less100 ; n = Pl} ;
lin pot1to19 d = {s = rows ! d.size ! sg ; size = less100 ; n = d.n} ;
lin pot0as1 n = {s = n.s ! unit ; size = table {sg => singl ; _ => less100} ! n.size ; n = n.n } ;

lin pot1 d = {s = d.s ! ten ; size = less100 ; n = d.n} ;
lin pot1plus d e = {s = rows ! e.size ! d.size ; size = less100 ; n = d.n} ;

lin pot1as2 n = {s = n.s ; s2 = "dmy" ; size = n.size ; n = n.n} ;
lin pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "lk' " ; size = more100 ; n = d.n} ;
lin pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "lk' " ++ (mkhazar e.s e.size) ; 
   size = more100 ; n = d.n} ;

lin pot2as3 n = {s = n.s ; n = n.n} ;
lin pot3 n = {s = table { singl => ekhazar ;
                          less100 => n.s ++ "h'zar" ; 
                          more100 => n.s2 } ! n.size ; n = n.n} ;
lin pot3plus n m = 
  {s = table {singl => ekhazar ;
              less100 => n.s ++ "h'zar" ; 
              more100 => n.s2 } ! n.size ++ m.s ; n = n.n} ;

lin D_0 = { s = "N0" ; n = Sg};
lin D_1 = { s = "N1" ; n = Sg};
lin D_2 = { s = "N2" ; n = Pl};
lin D_3 = { s = "N3" ; n = Pl};
lin D_4 = { s = "N4" ; n = Pl};
lin D_5 = { s = "N5" ; n = Pl};
lin D_6 = { s = "N6" ; n = Pl};
lin D_7 = { s = "N7" ; n = Pl};
lin D_8 = { s = "N8" ; n = Pl};
lin D_9 = { s = "N9" ; n = Pl};
lin IDig d = { s = \\_ => d.s ; n = d.n} ;
lin IIDig d dg = { s = \\df => Prelude.glue (dg.s ! df) d.s ; n = Pl }; 

oper ekhazar : Str = variants {"h'zar" ; "h'k" ++ "h'zar"} ; 
oper mkhazar : Str -> Size -> Str = \s -> \sz -> table {singl => ekhazar ; _ => s ++ "h'zar"} ! sz ;
oper mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "h'k" ++ "sW" ; _ => s ++ "sW"} ! sz ;
}
