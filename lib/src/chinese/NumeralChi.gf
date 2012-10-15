concrete NumeralChi of Numeral = CatChi ** open ResChi, Prelude in {

flags coding = utf8 ;


param Qform = bai  | bai0  | shiwan  | shiwan0  ;
param Bform = shi  | shi0  | wan  | wan0  ;
param Zero = zero  | nozero  ;
oper ling : Zero * Zero => Str =
  table {<zero,z> => "零" ; 
         <z,zero> => "零" ; 
         <nozero,nozero> => []} ;
oper Wan : Zero => Str =
  table {zero => "万" ; 
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
  {s = mkD "二" "贰"} ;
lin n3  =
  {s = mkD "三" "叁"} ;
lin n4  =
  {s = mkD "四" "肆"} ;
lin n5  =
  {s = mkD "五" "伍"} ;
lin n6  =
  {s = mkD "六" "陆"} ;
lin n7  =
  {s = mkD "七" "柒"} ;
lin n8  =
  {s = mkD "八" "捌"} ;
lin n9  =
  {s = mkD "九" "玖"} ;
lin pot01  =
  {s = mkD "一" "壹"} ;
lin pot0 d =
  {s = d.s} ;
lin pot110  =
  {inh = nozero ; 
   s = table {
    shi => mkD "一十" "壹拾" ; 
    shi0 => mkD "一十" "壹拾" ; 
    wan => mkD "一万" "壹万" ; 
    wan0 => mkD "一万" "壹万"}} ;
lin pot111  =
  {inh = nozero ; 
   s = table {
    shi => mkD "十一" "拾壹" ; 
    shi0 => mkD "一十一" "壹拾壹" ; 
    wan => mkD "十一万" "拾壹万" ; 
    wan0 => mkD "十一万" "拾壹万"}} ;
lin pot1to19 d =
  {inh = nozero ; 
   s = table {
    shi => mkD "一十" "壹拾" ++ d.s ; 
    shi0 => mkD "一十" "壹拾" ; 
    wan => mkD "一万" "壹万" ++ d.s ++ mkD "千" "仟" ; 
    wan0 => mkD "一万" "壹万" ++ d.s ++ mkD "千" "仟"}} ;
lin pot0as1 n =
  {inh = zero ; 
   s = table {
    shi => n.s ; 
    shi0 => n.s ; 
    wan => n.s ++ mkD "千" "仟" ; 
    wan0 => n.s ++ mkD "千" "仟"}} ;
lin pot1 d =
  {inh = zero ; 
   s = table {
    shi => d.s ++ mkD "十" "拾" ; 
    shi0 => d.s ++ mkD "十" "拾" ; 
    wan0 => d.s ++ "万" ; 
    wan => d.s ++ "万"}} ;
lin pot1plus d e =
  {inh = nozero ; 
   s = table {
    shi => d.s ++ mkD "十" "拾" ++ e.s ; 
    shi0 => d.s ++ mkD "十" "拾" ++ e.s ; 
    wan => d.s ++ "万" ++ e.s ++ mkD "千" "仟" ; 
    wan0 => d.s ++ "万" ++ e.s ++ mkD "千" "仟"}} ;
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
    bai => d.s ++ mkD "百" "佰" ; 
    bai0 => d.s ++ mkD "百" "佰" ; 
    shiwan0 => d.s ++ mkD "十万" "拾万" ; 
    shiwan => d.s ++ mkD "十万" "拾万"}} ;
lin pot2plus d e =
  {inh = nozero ; 
   s = table {
    bai => d.s ++ mkD "" "佰" ++ (ling ! <e.inh,e.inh>) ++ e.s ! shi0 ; 
    bai0 => d.s ++ mkD "" "佰" ++ (ling ! <e.inh,e.inh>) ++ e.s ! shi0 ; 
    shiwan => d.s ++ mkD "" "拾" ++ (Wan ! (e.inh)) ++ e.s ! wan ; 
    shiwan0 => d.s ++ mkD "" "拾" ++ (Wan ! (e.inh)) ++ e.s ! wan0}} ;
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
