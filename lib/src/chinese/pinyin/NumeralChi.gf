concrete NumeralChi of Numeral = CatChi ** open ResChi, Prelude in {

flags coding = utf8 ;


param Qform = bai  | bai0  | shiwan  | shiwan0  ;
param Bform = shi  | shi0  | wan  | wan0  ;
param Zero = zero  | nozero  ;
oper ling : Zero * Zero => Str =
  table {<zero,z> => "líng" ; 
         <z,zero> => "líng" ; 
         <nozero,nozero> => []} ;
oper Wan : Zero => Str =
  table {zero => "wàn" ; 
         nozero => []} ;

oper mkD : Str -> Str -> Str = \x,_ -> word x ; -- hiding the "formal" version

lincat Digit = {s,p : Str} ;    -- s/p: without/with classifier (er/liang)
lincat Sub10 = {s,p,t : Str} ;  -- t: with "shi wan"
lincat Sub100  = {end0,beg0 : Zero ; s,p : Bform => Str} ;  -- end0: ends with zeros, e.g.  20 ; beg0: begins with zeros, e.g. 02
lincat Sub1000 = {end0,beg0 : Zero ; s,p : Qform => Str} ;  -- end0: ends with zeros, e.g. 210 ; beg0: begins with zeros, e.g. 021
lincat Sub1000000 = {s,p : Str} ;
lin num x0 = x0 ;

-- 一二三四五六七八九十一百千
-- 

lin n2  =
  {s = mkD "èr" "èr" ; p = "liǎng"} ;
lin n3  =
  {s,p = mkD "sān" "sān"} ;
lin n4  =
  {s,p = mkD "sì" "sì"} ;
lin n5  =
  {s,p = mkD "wǔ" "wǔ"} ;
lin n6  =
  {s,p = mkD "liù" "liù"} ;
lin n7  =
  {s,p = mkD "qī" "qī"} ;
lin n8  =
  {s,p = mkD "bā" "bā"} ;
lin n9  =
  {s,p = mkD "jiǔ" "jiǔ"} ;
lin pot01  =
  {s,p = mkD "yī" "yī" ; t = []} ; -- t used in "(*yi) shi wan"
lin pot0 d =
  {s,t = d.s ; p = d.p} ;
lin pot110  =
  {beg0 = nozero ; end0 = zero ; 
   s,p = table {
    shi  => mkD "shí" "shí" ; 
    shi0 => mkD "yīshí" "yīshí" ; 
    wan  => mkD "yīwàn" "yīwàn" ; 
    wan0 => mkD "yīwàn" "yīwàn"
    }} ;
lin pot111  =
  {beg0 = nozero ; end0 = nozero ; 
   s,p = table {
    shi  => mkD "shíyī" "shíyī" ; 
    shi0 => mkD "yīshíyī" "yīshíyī" ; 
    wan  => mkD "yīwànyīqiān" "yīwànyīqiān" ;  -- 11.16 by chenpeng wan => mkD "shíyīwàn" "shíyīwàn" ;
    wan0 => mkD "yīwànyīqiān" "yīwànyīqiān"
    }} ; -- 11.16 by chenpeng wan0 => mkD "shíyīwàn" "shíyīwàn"}} ;
lin pot1to19 d =
  {beg0 = nozero ; end0 = nozero ; 
   s,p = table {
    shi  => mkD "shí" "yīshí" ++ d.s ; 
    shi0 => mkD "yīshí" "yīshí" ++ d.s ; 
    wan  => mkD "yīwàn" "yīwàn" ++ d.s ++ mkD "qiān" "qiān" ; 
    wan0 => mkD "yīwàn" "yīwàn" ++ d.s ++ mkD "qiān" "qiān"
    }} ;
lin pot0as1 n =
  {beg0 = zero ; end0 = nozero ; 
   s = table {
    shi => n.s ; 
    shi0 => n.s ; 
    wan  => n.p ++ mkD "qiān" "qiān" ; 
    wan0 => n.p ++ mkD "qiān" "qiān"
    } ;
   p = table {
    shi => n.p ; 
    shi0 => n.s ; 
    wan  => n.p ++ mkD "qiān" "qiān" ; 
    wan0 => n.p ++ mkD "qiān" "qiān"
    }
  } ;
lin pot1 d =
  {beg0 = nozero ; end0 = zero ; -- inh = nozero ; 
   s,p = table {
    shi => d.s ++ mkD "shí" "shí" ; 
    shi0 => d.s ++ mkD "shí" "shí" ; 
    wan0 => (d.p | d.s) ++ "wàn" ; 
    wan  => (d.p | d.s) ++ "wàn"
    }} ;
lin pot1plus d e =
  {beg0 = nozero ; end0 = nozero ; -- inh = nozero ; 
   s,p = table {
    shi  => d.s ++ mkD "shí" "shí" ++ e.s ; 
    shi0 => d.s ++ mkD "shí" "shí" ++ e.s ; 
    wan  => (d.p | d.s) ++ "wàn" ++ e.s ++ mkD "qiān" "qiān" ; 
    wan0 => (d.p | d.s) ++ "wàn" ++ e.s ++ mkD "qiān" "qiān"
    }} ;
lin pot1as2 n =
  {beg0 = zero ; end0 = n.end0 ; -- inh = zero ; 
   s = table {
    bai     => n.s ! shi ; 
    bai0    => n.s ! shi0 ; 
    shiwan  => n.s ! wan ; 
    shiwan0 => n.s ! wan0
    } ;
   p = table {
    bai     => n.p ! shi ; 
    bai0    => n.s ! shi0 ; 
    shiwan  => n.s ! wan ; 
    shiwan0 => n.s ! wan0
    }} ;
lin pot2 d =
  {beg0 = nozero ; end0 = zero ; -- inh = zero ; 
   s,p = table {
    bai     => (d.p | d.s) ++ mkD "baǐ" "baǐ" ; 
    bai0    => (d.p | d.s) ++ mkD "baǐ" "baǐ" ; 
    shiwan0 => d.t ++ mkD "shíwàn" "shíwàn" ; 
    shiwan  => d.t ++ mkD "shíwàn" "shíwàn"
    }} ;
lin pot2plus d e =
  {beg0 = nozero ; end0 = e.end0 ; -- inh = nozero ; 
   s,p = table {
    bai  => (d.p | d.s) ++ mkD "baǐ" "baǐ" ++ (ling ! <nozero,e.beg0>) ++ e.s ! shi0 ; --why omit "baǐ"? i add it /chenpeng
    bai0 => (d.p | d.s) ++ mkD "baǐ" "baǐ" ++ (ling ! <nozero,e.beg0>) ++ e.s ! shi0 ; --why omit "baǐ"? i add it /chenpeng
    shiwan  => d.t ++ mkD "shí" "shí" ++ (Wan ! (e.end0)) ++ e.s ! wan ; --why omit "shí"? i add it /chenpeng
    shiwan0 => d.t ++ mkD "shí" "shí" ++ (Wan ! (e.end0)) ++ e.s ! wan0
    }} ;--why omit "shí"? i add it /chenpeng
lin pot2as3 n =
  {s = n.s ! bai ; p = n.p ! bai} ;
lin pot3 n =
  {s,p = n.s ! shiwan} ;
lin pot3plus n m =
  {s,p = (n.s ! shiwan0) ++ (ling ! <n.end0,m.beg0>) ++ m.s ! bai0} ;


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
