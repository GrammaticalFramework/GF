concrete NumeralPnb of Numeral = CatPnb ** open ResPnb, Prelude in {
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
          NOrd =>  x0.s ++ "واں" -- (mkOrd x0.s)  need to use mkOrd which will make irregular ordinals but it gives path error
          };
       n = x0.n
    } ;
oper mkOrd : Str -> Str =
 \s -> case s of {
                    "اك"                  => "پیلا";
                    "دو"                  => "دوجا";
                    "تن"                => "دوجا";
                    "چار"                => "چوتھا";
                    _                     =>  s ++ "واں"
                  };
--  {s = \\_ => x0.s ; n = x0.n} ; 


oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \do -> \bis -> \sz ->  
  {s = table {unit => do ; ten => bis } ; 
   size = sz ; n = Pl} ;

lin n2 = mkNum "دو" "وی" r2 ;
lin n3 = mkNum "تن" "تری" r3 ;
lin n4 = mkNum "چار" "چالی" r4 ;
lin n5 = mkNum "پنج" "پنجاہ" r5 ;
lin n6 = mkNum "چھ" "سٹھ" r6 ; 
lin n7 = mkNum "ست" "ستر" r7; 
lin n8 = mkNum "اٹھ" "اسی" r8;
lin n9 = mkNum "نو" "نبے" r9 ;

oper mkR : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> DSize => Str = \a1 -> \a2 -> \a3 -> \a4 -> \a5 -> \a6 -> \a7 -> \a8 -> \a9 -> table {
  sg => a1 + "اں" ;
  r2 => a2 + "ی" ;
  r3 => a3 + "ی" ;
  r4 => a4 + "الی" ;
  r5 => a5 + "نجا" ;
  r6 => a6 + "ٹھ" ;
  r7 => a7 + "تر" ;
  r8 => a8 + "اسی" ;
  r9 => a9 + "انوے"
} ;

oper rows : DSize => DSize => Str = table {
  sg => mkR "گیار" "اكك" "اكت" "اكتا" "اكو" "اكا" "اكہ" "اك" "اكی" ; 
  r2 => mkR "بار" "با" "بت" "بای" "بی" "بو" "بہ" "بی" "ب" ;
  r3 => mkR "تیر" "تی" "تیت" "تنت" "ترت" "ترو" "تیہ" "تیر" "تر" ;
  r4 => mkR "چود" "چوب" "چوت" "چوا" "چوت" "چور" "چوہ" "چور" "چور" ;
  r5 => mkR "پندر" "پنج" "پینت" "پنتا" "پچو" "پین" "پنج" "پنج" "پچ" ;
  r6 => mkR "سول" "چھب" "چھت" "چھی" "چھو" "چھیا" "چھہ" "چھی" "چھی" ;
  r7 => mkR "ستار" "ستا" "سینت" "سنت" "سنت" "ستو" "ست" "ست" "ست" ;
  r8 => mkR "اٹھار" "اٹھا" "اٹھت" "اڑت" "اٹھو" "اٹھا" "اٹھ" "اٹھ" "اٹھ" ; 
  r9 => table {sg => "انی" ; r2 => "انتی" ; r3 => "انتالی" ; 
               r4 => "اناجا" ; r5 => "اناٹھ" ; r6 => "انہتر" ; 
               r7 => "اناسی" ; 
               r8 => "انانوے" ; r9 => "نڑینوے" } 
} ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "اك" ; _ => "دمی" } ; size = sg ; n = Sg} ;
lin pot0 d = d ; 
lin pot110 = {s = "دس" ; size = less100 ; n = Pl} ; 
lin pot111 = {s = rows ! sg ! sg ; size = less100 ; n = Pl} ;
lin pot1to19 d = {s = rows ! d.size ! sg ; size = less100 ; n = d.n} ;
lin pot0as1 n = {s = n.s ! unit ; size = table {sg => singl ; _ => less100} ! n.size ; n = n.n } ;

lin pot1 d = {s = d.s ! ten ; size = less100 ; n = d.n} ;
lin pot1plus d e = {s = rows ! e.size ! d.size ; size = less100 ; n = d.n} ;

lin pot1as2 n = {s = n.s ; s2 = "دمی" ; size = n.size ; n = n.n} ;
lin pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "لكھ" ; size = more100 ; n = d.n} ;
lin pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "لكھ" ++ (mkhazar e.s e.size) ; 
   size = more100 ; n = d.n} ;

lin pot2as3 n = {s = n.s ; n = n.n} ;
lin pot3 n = {s = table { singl => ekhazar ;
                          less100 => n.s ++ "ہزار" ; 
                          more100 => n.s2 } ! n.size ; n = n.n} ;
lin pot3plus n m = 
  {s = table {singl => ekhazar ;
              less100 => n.s ++ "ہزار" ; 
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

oper ekhazar : Str = variants {"ہزار" ; "اك" ++ "ہزار"} ; 
oper mkhazar : Str -> Size -> Str = \s -> \sz -> table {singl => ekhazar ; _ => s ++ "ہزار"} ! sz ;
oper mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "اك" ++ "سو" ; _ => s ++ "سو"} ! sz ;
}
