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
          NOrd =>  x0.s ++ "واں" -- need to use mkOrd which will make irregular ordinals but it gives path error
          };
       n = x0.n
    } ;
oper mkOrd : Str -> Str =
 \s -> case s of {
                    "عك"                  => "پہلا";
                    "دo"                  => "دوسرا";
                    "تi:ن"                => "تعسرا";
                    "چa:ر"                => "چوتھا";
                    ("چحاہ"|"چحا"|"چحاi") => "چھٹا";
                    _                     =>  s ++ "واں"
                  };
--  {s = \\_ => x0.s ; n = x0.n} ; 


oper mkNum : Str -> Str -> DSize -> LinDigit = 
  \do -> \bis -> \sz ->  
  {s = table {unit => do ; ten => bis } ; 
   size = sz ; n = Pl} ;

lin n2 = mkNum "دو" "بیس" r2 ;
lin n3 = mkNum "تین" "تیس" r3 ;
lin n4 = mkNum "چار" "چالیس" r4 ;
lin n5 = mkNum "پانچ" "پچاس" r5 ;
lin n6 = mkNum "چھ" "ساتھ" r6 ; 
lin n7 = mkNum "سات" "ستر" r7; 
lin n8 = mkNum "آتھ" "اسی" r8;
lin n9 = mkNum "نو" "نوے" r9 ;

oper mkR : Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> Str -> DSize => Str = \a1 -> \a2 -> \a3 -> \a4 -> \a5 -> \a6 -> \a7 -> \a8 -> \a9 -> table {
  sg => a1 + "اہ" ;
  r2 => a2 + "i:س" ;
  r3 => a3 + "تi:س" ;
  r4 => a4 + "a:لi:س" ;
  r5 => a5 + "ان" ;
  r6 => a6 + "ساٹح" ;
  r7 => a7 + "ہاتتار" ;
  r8 => a8 + "a:سi:" ;
  r9 => a9 + "a:ناvع"
} ;

oper rows : DSize => DSize => Str = table {
  sg => mkR "گیارہ" "iكك" "iكات" "عكت" "iكیاو" "iك" "iك" "iكی" "iكی" ; 
  r2 => mkR "بارہ" "بای" "بات" "بای" "باو" "با" "با" "بای" "ب" ;
  r3 => mkR "تیر" "تی" "تین" "تنت" "ترپ" "تری" "ت" "تر" "تر" ;
  r4 => mkR "چود" "چوب" "چون" "چوا" "چوو" "چون" "چوہ" "چور" "چور" ;
  r5 => mkR "پند" "پچی" "پین" "پنتا" "پچپ" "پین" "پہ" "پچ" "پچ" ;
  r6 => mkR "سول" "چھب" "چھت" "چھی" "چھپ" "چھیا" "چھ" "چھی" "چھی" ;
  r7 => mkR "ستر" "ستا" "سین" "سنت" "ستاو" "ستا" "سر" "ست" "ستا" ;
  r8 => mkR "اتھار" "اتھای" "اڑ" "اڑت" "اتھاو" "اڑ" "اتھ" "اتھ" "اتھ" ; 
  r9 => table {sg => "انیس" ; r2 => "انتیس" ; r3 => "انتالیس" ; 
               r4 => "انچاس" ; r5 => "انستھ" ; r6 => "انہتر" ; 
               r7 => "اناسی" ; 
               r8 => "انانوے" ; r9 => "ننانوے" } 
} ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin pot01 = {s = table {unit => "ایك" ; _ => "دuممی" } ; size = sg ; n = Sg} ;
lin pot0 d = d ; 
lin pot110 = {s = "داس" ; size = less100 ; n = Pl} ; 
lin pot111 = {s = rows ! sg ! sg ; size = less100 ; n = Pl} ;
lin pot1to19 d = {s = rows ! d.size ! sg ; size = less100 ; n = d.n} ;
lin pot0as1 n = {s = n.s ! unit ; size = table {sg => sing ; _ => less100} ! n.size ; n = n.n } ;

lin pot1 d = {s = d.s ! ten ; size = less100 ; n = d.n} ;
lin pot1plus d e = {s = rows ! e.size ! d.size ; size = less100 ; n = d.n} ;

lin pot1as2 n = {s = n.s ; s2 = "دuممی" ; size = n.size ; n = n.n} ;
lin pot2 d = {s = (mksau (d.s ! unit) d.size) ; 
              s2 = d.s ! unit ++ "لاكھ" ; size = more100 ; n = d.n} ;
lin pot2plus d e = 
  {s = (mksau (d.s ! unit) d.size) ++ e.s ; 
   s2 = (d.s ! unit) ++ "لاكھ" ++ (mkhazar e.s e.size) ; 
   size = more100 ; n = d.n} ;

lin pot2as3 n = {s = n.s ; n = n.n} ;
lin pot3 n = {s = table { sing => ekhazar ;
                          less100 => n.s ++ "ہزار" ; 
                          more100 => n.s2 } ! n.size ; n = n.n} ;
lin pot3plus n m = 
  {s = table {sing => ekhazar ;
              less100 => n.s ++ "ہزار" ; 
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

oper ekhazar : Str = variants {"ہزار" ; "ایك" ++ "ہزار"} ; 
oper mkhazar : Str -> Size -> Str = \s -> \sz -> table {sing => ekhazar ; _ => s ++ "ہزار"} ! sz ;
oper mksau : Str -> DSize -> Str = \s -> \sz -> table {sg => "سو" ; _ => s ++ "سو"} ! sz ;
}
