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
          NOrd =>  Prelude.glue x0.s "ون" -- (mkOrd x0.s)  need to use mkOrd which will make irregular ordinals but it gives path error
          };
       n = x0.n
    } ;
oper mkOrd : Str -> Str =
 \s -> case s of {
                    "ھڪ"                  => "پھريون";
                    "ٻ"                  => "ٻيون";
                    "ٽي"                => "ٽيون";
                    "چار"                => "چوٿون";
                    _                     =>  s ++ "وN"
                  };
--  {s = \\_ => x0.s ; n = x0.n} ; 


oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \do -> \bis -> \sz ->  
  {s = table {unit => do ; ten => bis } ; 
   size = sz ; n = Pl} ;

lin n2 = mkNum "ٻ" "ويھ" r2 ;
lin n3 = mkNum "ٽي" "ٽيھ" r3 ;
lin n4 = mkNum "چار" "چاlيھ" r4 ;
lin n5 = mkNum "پنج" "پنجاھ" r5 ;
lin n6 = mkNum "ڇھ" "سٺھ " r6 ; 
lin n7 = mkNum "ست" "ستر" r7; 
lin n8 = mkNum "اٺ '" "اسي" r8;
lin n9 = mkNum "نو" "نوي" r9 ;

oper mkR : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> DSize => Str = \a1 -> \a2 -> \a3 -> \a4 -> \a5 -> \a6 -> \a7 -> \a8 -> \a9 -> table {
  sg => a1 + "نھن" ;
  r2 => a2 + "يھ " ;
  r3 => a3 + "يھ " ;
  r4 => a4 + "اlيھ " ;
  r5 => a5 + "ونجاھ " ;
  r6 => a6 + "ھٺ" ;
  r7 => a7 + "تر" ;
  r8 => a8 + "اسي" ;
  r9 => a9 + "انوي"
} ;

oper rows : DSize => DSize => Str = table {
  sg => mkR "يار "   "ايڪ "  "اڪٽ"    "ايڪيت "   "ايڪ"   "ايڪ"   "ايڪ"   "ايڪ"   "ايڪ" ; 
  r2 => mkR "ٻاي "    "ٻاو"   "ٻٽ"      "ٻا۶ت"   "ٻا"     "ٻا"   "ٻاھ " "ٻيي"   "ٻيي" ;
  r3 => mkR "ٽير "    "ٽيو "  "ٽيٽ"     "ٽيت"    "ٽي"    "ٽي"       "ٽيھ " "ٽي"    "تي" ;
  r4 => mkR "چوڏ "    "چوو "  "چوٽ"     "چو۶ت "  "چو"    "چو"      "چوھ "  "چور "  "چور" ;
  r5 => mkR "پنڌر "  "پنجو "  "پنجٽ"   "پنجيت"  "پنج"   "پنج"     "پنجھ"  "پنج"   "پنج" ;
  r6 => mkR "سور "    "ڇو"   "ڇٽي"    "ڇا۶ت"  "ڇا"   "ڇا"     "ڇاھ"  "ڇ"    "ڇ" ;
  r7 => mkR "ستر"    "ستاو"   "ستٽ "   "ستيت"     "ست"    "ست"      "ست"     "ست"     "ست" ;
  r8 => mkR "ارڙ"    "اٺاو "  "اٺٽ"   "اٺي"   "اٺ"   "اٺ"    "اٺا"   "اٺ"   "اٺ" ; 
  r9 => table {sg => "اڻويھ " ; r2 => "اڻٽيھ " ; r3 => "اڻيتاlيھ " ; 
               r4 => "اڻونجاھ " ; r5 => "اڻھٺ " ; r6 => "اڻتر " ; 
               r7 => "اڻاسي " ; 
               r8 => "اڻانوي " ; r9 => "نوانوي" } 
} ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "ھڪ" ; _ => "دمي" } ; size = sg ; n = Sg} ;
lin pot0 d = d ; 
lin pot110 = {s = "ڏھ " ; size = less100 ; n = Pl} ; 
lin pot111 = {s = rows ! sg ! sg ; size = less100 ; n = Pl} ;
lin pot1to19 d = {s = rows ! d.size ! sg ; size = less100 ; n = d.n} ;
lin pot0as1 n = {s = n.s ! unit ; size = table {sg => singl ; _ => less100} ! n.size ; n = n.n } ;

lin pot1 d = {s = d.s ! ten ; size = less100 ; n = d.n} ;
lin pot1plus d e = {s = rows ! e.size ! d.size ; size = less100 ; n = d.n} ;

lin pot1as2 n = {s = n.s ; s2 = "دمي" ; size = n.size ; n = n.n} ;
lin pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "lک " ; size = more100 ; n = d.n} ;
lin pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "lک " ++ (mkhazar e.s e.size) ; 
   size = more100 ; n = d.n} ;

lin pot2as3 n = {s = n.s ; n = n.n} ;
lin pot3 n = {s = table { singl => ekhazar ;
                          less100 => n.s ++ "ھزار" ; 
                          more100 => n.s2 } ! n.size ; n = n.n} ;
lin pot3plus n m = 
  {s = table {singl => ekhazar ;
              less100 => n.s ++ "ھزار" ; 
              more100 => n.s2 } ! n.size ++ m.s ; n = n.n} ;

lin D_0 = { s = "۰" ; n = Sg};
lin D_1 = { s = "۱" ; n = Sg};
lin D_2 = { s = "۲" ; n = Pl};
lin D_3 = { s = "۳" ; n = Pl};
lin D_4 = { s = "۴" ; n = Pl};
lin D_5 = { s = "۵" ; n = Pl};
lin D_6 = { s = "۶" ; n = Pl};
lin D_7 = { s = "۷" ; n = Pl};
lin D_8 = { s = "۸" ; n = Pl};
lin D_9 = { s = "۹" ; n = Pl};
lin IDig d = { s = \\_ => d.s ; n = d.n} ;
lin IIDig d dg = { s = \\df => Prelude.glue (dg.s ! df) d.s ; n = Pl }; 

oper ekhazar : Str = variants {"ھزار" ; "ھڪ" ++ "ھزار"} ; 
oper mkhazar : Str -> Size -> Str = \s -> \sz -> table {singl => ekhazar ; _ => s ++ "ھزار"} ! sz ;
oper mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "ھڪ" ++ "سو" ; _ => s ++ "سو"} ! sz ;
}
