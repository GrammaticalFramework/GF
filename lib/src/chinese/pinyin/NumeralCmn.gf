concrete NumeralCmn of Numeral = CatCmn ** open ResCmn, Prelude in {

flags coding = utf8 ;


param Qform = bai  | bai0  | shiwan  | shiwan0  ;
param Bform = shi  | shi0  | wan  | wan0  ;
param Zero = zero  | nozero  ;
oper ling : Zero * Zero => Str =
  table {<zero,z> => "ling2" ; 
         <z,zero> => "ling2" ; 
         <nozero,nozero> => []} ;
oper Wan : Zero => Str =
  table {zero => "wan4" ; 
         nozero => []} ;

oper mkD : Str -> Str -> Str = \x,_ -> word x ; -- hiding the "formal" version

--lincat Numeral = {s : Str} ;
lincat Digit = {s : Str} ;
lincat Sub10 = {s : Str} ;
lincat Sub100 = {inh : Zero ; s : Bform => Str} ;
lincat Sub1000 = {inh : Zero ; s : Qform => Str} ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ;

-- 一二三四五六七八九十一百千
-- 

lin n2  =
  {s = mkD "er4" "er4"} ;
lin n3  =
  {s = mkD "san1" "san1"} ;
lin n4  =
  {s = mkD "si4" "si4"} ;
lin n5  =
  {s = mkD "wu3" "wu3"} ;
lin n6  =
  {s = mkD "liu4" "liu4"} ;
lin n7  =
  {s = mkD "qi1" "qi1"} ;
lin n8  =
  {s = mkD "ba1" "ba1"} ;
lin n9  =
  {s = mkD "jiu3" "jiu3"} ;
lin pot01  =
  {s = mkD "yi1" "yi1"} ;
lin pot0 d =
  {s = d.s} ;
lin pot110  =
  {inh = nozero ; 
   s = table {
    shi => mkD "yi1shi2" "yi1shi2" ; 
    shi0 => mkD "yi1shi2" "yi1shi2" ; 
    wan => mkD "yi1wan4" "yi1wan4" ; 
    wan0 => mkD "yi1wan4" "yi1wan4"}} ;
lin pot111  =
  {inh = nozero ; 
   s = table {
    shi => mkD "shi2yi1" "shi2yi1" ; 
    shi0 => mkD "yi1shi2yi1" "yi1shi2yi1" ; 
    wan => mkD "shi2yi1wan4" "shi2yi1wan4" ; 
    wan0 => mkD "shi2yi1wan4" "shi2yi1wan4"}} ;
lin pot1to19 d =
  {inh = nozero ; 
   s = table {
    shi => mkD "yi1shi2" "yi1shi2" ++ d.s ; 
    shi0 => mkD "yi1shi2" "yi1shi2" ; 
    wan => mkD "yi1wan4" "yi1wan4" ++ d.s ++ mkD "qian1" "qian1" ; 
    wan0 => mkD "yi1wan4" "yi1wan4" ++ d.s ++ mkD "qian1" "qian1"}} ;
lin pot0as1 n =
  {inh = zero ; 
   s = table {
    shi => n.s ; 
    shi0 => n.s ; 
    wan => n.s ++ mkD "qian1" "qian1" ; 
    wan0 => n.s ++ mkD "qian1" "qian1"}} ;
lin pot1 d =
  {inh = zero ; 
   s = table {
    shi => d.s ++ mkD "shi2" "shi2" ; 
    shi0 => d.s ++ mkD "shi2" "shi2" ; 
    wan0 => d.s ++ "wan4" ; 
    wan => d.s ++ "wan4"}} ;
lin pot1plus d e =
  {inh = nozero ; 
   s = table {
    shi => d.s ++ mkD "shi2" "shi2" ++ e.s ; 
    shi0 => d.s ++ mkD "shi2" "shi2" ++ e.s ; 
    wan => d.s ++ "wan4" ++ e.s ++ mkD "qian1" "qian1" ; 
    wan0 => d.s ++ "wan4" ++ e.s ++ mkD "qian1" "qian1"}} ;
lin pot1as2 n =
  {inh = zero ; 
   s = table {
    bai => n.s ! shi ; 
    bai0 => n.s ! shi ; 
    shiwan => n.s ! wan ; 
    shiwan0 => n.s ! wan0}} ;
lin pot2 d =
  {inh = zero ; 
   s = table {
    bai => d.s ++ mkD "bai3" "bai3" ; 
    bai0 => d.s ++ mkD "bai3" "bai3" ; 
    shiwan0 => d.s ++ mkD "shi2wan4" "shi2wan4" ; 
    shiwan => d.s ++ mkD "shi2wan4" "shi2wan4"}} ;
lin pot2plus d e =
  {inh = nozero ; 
   s = table {
    bai => d.s ++ mkD "" "bai3" ++ (ling ! <e.inh,e.inh>) ++ e.s ! shi0 ; 
    bai0 => d.s ++ mkD "" "bai3" ++ (ling ! <e.inh,e.inh>) ++ e.s ! shi0 ; 
    shiwan => d.s ++ mkD "" "shi2" ++ (Wan ! (e.inh)) ++ e.s ! wan ; 
    shiwan0 => d.s ++ mkD "" "shi2" ++ (Wan ! (e.inh)) ++ e.s ! wan0}} ;
lin pot2as3 n =
  {s = n.s ! bai} ;
lin pot3 n =
  {s = n.s ! shiwan} ;
lin pot3plus n m =
  {s = (n.s ! shiwan0) ++ (ling ! <n.inh,m.inh>) ++ m.s ! bai0} ;


-- numerals as sequences of digits

  lincat 
    Dig = SS ;

  lin
    IDig d = d ;

    IIDig d i = ss (d.s ++ i.s) ;

    D_0 = ss "0" ;
    D_1 = ss "1" ;
    D_2 = ss "2" ;
    D_3 = ss "3" ;
    D_4 = ss "4" ;
    D_5 = ss "5" ;
    D_6 = ss "6" ;
    D_7 = ss "7" ;
    D_8 = ss "8" ;
    D_9 = ss "9" ;

}
