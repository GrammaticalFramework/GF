include numerals.Abs.gf ;

param DForm = unit | teen | ten | tenq | chi | chiten ; 
param Size = sg | twotoeight | nine | exten | more10 ;
param S100 = tenpart | chenpart ;

-- Korean
-- Sorry, no hangul transliteration

lincat Numeral = {s : Str} ;
oper LinDigit = {s : DForm => Str ; size : Size } ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ; 
lincat Sub100 = {s : Str ; s2 : S100 => Str; size : Size} ;
lincat Sub1000 = {s : Str ; s2 : Str ; size : Size } ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = "/L" ++ x0.s ++ "L/" } ; -- just makes colons into length bar ontop of char

oper mkNumq : Str -> Str -> Str -> Str -> LinDigit = 
  \twul -> \yelqtwul -> \sumul -> \i -> 
  {s = table {unit => twul ; teen => yelqtwul ; ten => sumul ; tenq => sumul + "q" ; chi => i ; chiten => i ++ "sip"} ; size = twotoeight} ;

oper mkNum : Str -> Str -> Str -> Str -> LinDigit = 
  \twul -> \yelqtwul -> \sumul -> \i -> 
  {s = table {unit => twul ; teen => yelqtwul ; ten => sumul ; tenq => sumul ; chi => i ; chiten => i ++ "sip"} ; size = twotoeight} ;

oper mkNum6 : Str -> Str -> Str -> Str -> LinDigit = 
  \twul -> \yelqtwul -> \sumul -> \i -> 
  {s = table {unit => twul ; teen => yelqtwul ; ten => sumul ; tenq => sumul + "q" ; chi => i ; chiten => (i + "q") ++ "sip"} ; size = twotoeight} ;

oper mkNum9 : Str -> Str -> Str -> Str -> LinDigit = 
  \twul -> \yelqtwul -> \sumul -> \i -> 
  {s = table {unit => twul ; teen => yelqtwul ; ten => sumul ; tenq => sumul + "q" ; chi => i ; chiten => i ++ "sip"} ; size = nine} ;

-- lin n1 = mkNum variants{"hana" ; "han } ; variants {"yelhana" ; "yelhan" }
lin n2 = mkNumq (variants {"twu:l" ; "twu" }) 
               (variants {"yelqtwul" ; "yelqtwu" }) 
               (variants {"sumul" ; "sumu" })
               "i:" ;
lin n3 = mkNum (variants {"se:ys" ;  "se:y" ; "se:k" ; "se:" }) 
               (variants {"yelqseys" ; "yelqsey" ; "yelqsek" ; "yelqse" }) 
               (variants {"seun" ; "sehun" })
               "sam" ;
lin n4 = mkNum (variants {"ne:ys" ;  "ne:y" ; "ne:k" ; "ne:" }) 
               (variants {"yelneys" ; "yelney" ; "yelnek" ; "yelne" }) 
               "mahun" "sa:" ;
lin n5 = mkNum "tases" "yelqtases" "swi:n" "o:";
lin n6 = mkNum6 "yeses" (variants {"yelqyeses" ; "yelyeses"}) "yeyswun" "yuk" ;
lin n7 = mkNum6 "ilkop" (variants {"yelqilkop" ; "yelilkop"}) "ilhun" "chil" ;
lin n8 = mkNum6 "yetel" (variants {"yelqyetel" ; "yelyetel"}) "yetun" "phal" ;
lin n9 = mkNum9 "ahop" "yelahop" "ahun" "kwu" ;

lin pot01  =
  {s = table {unit => variants {"hana" ; "han"} ; 
              ten => variants {"yel" ; "yelq"} ;
              tenq => "dummy" ;  
              teen => variants {"yelhana" ; "yelhan" } ;  
              chi => "il" ; chiten => "sip"} ; 
   size = sg };
lin pot0 d = d ;
lin pot110 = {s = variants {"yel" ; "yelq"} ; 
              s2 = table {tenpart => "il" ++ "man" ; 
                          chenpart => [] } ; 
              size = exten} ;
lin pot111 = {s = variants {"yelhana" ; "yelhan"} ;
              s2 = table {tenpart => "il" ++ "man" ; 
                          chenpart => maybeil sg "il" "chen" } ; 
              size = more10} ;
lin pot1to19 d = {s = d.s ! teen ; 
                  s2 = table {tenpart => "il" ++ "man" ; 
                              chenpart => maybeil d.size (d.s ! chi) "chen" } ;
                  size = more10} ; 
lin pot0as1 n = {s = n.s ! unit ; 
                 s2 = table {tenpart => "man" ; 
                             chenpart => maybeil n.size (n.s ! chi) "chen" } ;
                 size = n.size} ;
lin pot1 d = {s = d.s ! ten ; 
              s2 = table {tenpart => d.s ! chi ++ "man" ; 
                          chenpart => [] } ; 
              size = more10} ;
lin pot1plus d e = 
  {s = table {twotoeight => d.s ! tenq ;
              _ => d.s ! ten } ! e.size ++ e.s ! unit;
   s2 = table {tenpart => d.s ! chi ++ "man"; 
               chenpart => maybeil e.size (e.s ! chi) "chen" } ;
   size = more10} ; 

lin pot1as2 n = {s = n.s ; 
                 s2 = table {more10 => n.s2 ! tenpart ; 
                             exten => (variants {"ma:n" ; "il" ++ "man"}) ; 
                             _ => []} ! n.size ++ n.s2 ! chenpart ; 
                 size = n.size} ;
lin pot2 d = 
  {s = maybeil d.size (d.s ! chi) "payk" ;
   s2 = d.s ! chiten ;  
   size = more10 };
lin pot2plus d e = 
  {s = (maybeil d.size (d.s ! chi) "payk") ++ e.s ;
   s2 = d.s ! chiten ++ e.s2 ! tenpart ++ e.s2 ! chenpart ;
   size = more10 }; 
lin pot2as3 n = {s = n.s } ;
lin pot3 n = {s = n.s2 } ;
lin pot3plus n m = {s = n.s2 ++ m.s } ;

oper maybeil : Size -> Str -> Str -> Str = \sz -> \a -> \chen -> 
  table {twotoeight => a ++ chen ; sg => variants {chen ; "il" ++ chen } ; _ =>  a ++ chen} ! sz ;


