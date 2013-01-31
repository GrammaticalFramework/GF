
concrete NumeralAmh of Numeral = CatAmh ** open ResAmh,ParamX in {
flags coding = utf8;
lincat 


  Digit =      {s : DForm => CardOrd => Gender=>Number=>Species=>Case=> Str} ;
  Sub10 =      {s : DForm => CardOrd =>Gender=>Number=>Species=>Case=> Str } ;
  Sub100     = {s : CardOrd => Gender=>Number=>Species=>Case=> Str } ;
  Sub1000    = {s : CardOrd => Gender=>Number=>Species=>Case=> Str } ;
  Sub1000000 = {s : CardOrd => Gender=>Number=>Species=>Case=> Str } ;



lin num x = x ;
lin n2 = mkNum "ሁለት"  "ሃያ" "ሁለተኛ" ;
lin n3 = mkNum "ሶስት"  "ሰላሳ" "ሶስተኛ";
lin n4 = mkNum "አራት"  "አርባ" "አራተኛ";
lin n5 = mkNum "አምስት"  "ሃምሳ" "አምስተኛ";
lin n6 = mkNum "ስድስት"  "ስድሳ" "ስድስተኛ";
lin n7 = mkNum "ሰባት"  "ሰባ" "ሰባተኛ";
lin n8 = mkNum "ስምንት" "ሰማንያ" "ስምንተኛ";
lin n9 = mkNum "ዘጠኝ"  "ዘጠና" "ዘጠነኛ";

lin pot01 = mkNum "አንድ" "አስር" "አንደኛ"  ;
lin pot0 d = d  ;
lin pot110 = regCardOrd "አስር"  ;
lin pot111 = regCardOrd "አስራንድ" ;
lin pot1to19 d = {s = \\o,g,n,s,c =>case c of {
                Gen => ("የአስራ"++ d.s ! unit ! o!g!n! s!c);
		Dat => ("ለአስራ"++ d.s ! unit ! o!g!n! s!c) ; 
		 _   => ( "አስራ"++ d.s ! unit ! o!g!n!s!c) }    } ;
lin pot0as1 n = {s = n.s ! unit};
lin pot1 d = {s = d.s ! ten} ;
lin pot1plus d e = {
   s = \\o,g,n,s,c => case c of { 

 Gen|Dat => d.s ! ten ! NCard !Masc!Sg!Indef! c ++ e.s ! unit ! o!g!n!s! Nom ;
       _ =>d.s ! ten ! NCard !Masc!Sg!Indef! Nom ++ e.s ! unit ! o!g!n!s! c 
        }} ;
lin pot1as2 n = n ;
lin pot2 d = {s = \\o,g,n,s,c => case c of {
	Gen|Dat =>  d.s ! unit ! NCard !Masc!Sg!Indef! c ++ mkCard o "መቶ" !g!n! s!Nom;
	 _      =>  d.s ! unit ! NCard !Masc!Sg! Indef! Nom ++ mkCard o "መቶ" !g!n!s!c}}  ;


lin pot2plus d e = { s = \\o,g,n,s,c => case c of    { 
                                  Gen|Dat =>  d.s ! unit ! NCard !Masc!Sg!Indef! c ++ "መቶ" ++ e.s ! o!g!n!s! Nom  ;
                                   _      =>  d.s ! unit ! NCard!Masc!Sg! Indef! Nom ++ "መቶ" ++ e.s ! o!g!n!s! c  
                    }} ;
lin pot2as3 n = n ;
lin pot3 n = {
  s = \\o,g,n2,s,c => case c of { 
         Gen|Dat => n.s ! NCard !Masc!Sg! Indef! c ++ mkCard o  "ሺህ" !g!n2! s!Nom ;
          _      => n.s ! NCard !Masc!Sg! Indef! Nom ++ mkCard o "ሺህ" !g!n2 ! s!c}} ;

lin pot3plus n m = {
  s = \\o,g,n2,s,c => case c of {
	Gen|Dat => n.s ! NCard !Masc!Sg! Indef!c ++ "ሺህ" ++ m.s ! o!g!n2!s! Nom;
               _=> n.s ! NCard !Masc!Sg! Indef! Nom ++ "ሺህ" ++ m.s ! o!g!n2!s! c}}; 





--numerals as sequences of digits

  lincat
 
    Dig = TDigit ;

  lin
    IDig d = d ** {tail = T1} ;

    IIDig d i = {
      s = \\o,g,n,s,c => case c of {
            Gen|Dat => d.s ! NCard !Masc!Sg!Indef!c ++ commaIf i.tail ++ i.s ! o!g!n!s! Nom ;
         _       => d.s ! NCard !Masc!Sg!Indef! Nom ++ commaIf i.tail ++ i.s ! o!g!n!s! c       };

      tail = inc i.tail
    } ;

    D_0 = mk3Dig "0" "0ኛ" ;
    D_1 = mk3Dig "1" "1ኛ"  ;
    D_2 = mkDig "2";
    D_3 = mkDig "3";
    D_4 = mkDig "4" ;
    D_5 = mkDig "5" ;
    D_6 = mkDig "6" ;
    D_7 = mkDig "7" ;
    D_8 = mkDig "8" ;
    D_9 = mk2Dig "9" "9ኛ";

  oper
    commaIf : DTail -> Str = \t -> case t of {
      T3 => "," ;
      _ => []
      } ;

    inc : DTail -> DTail = \t -> case t of {
      T1 => T2 ;
      T2 => T3 ;
      T3 => T1
      } ;
------------------ :) what a releif 

    mk2Dig : Str -> Str -> TDigit = \c,o -> mk3Dig c o  ;
    mkDig : Str -> TDigit = \c -> mk2Dig c (c + "ተኛ") ;
    mk3Dig : Str -> Str -> TDigit = \c,o -> {
      s = table {NCard => adjaffix c ; NOrd => adjaffix o}
      } ;

    TDigit = {        
         s :  CardOrd => Gender=>Number=>Species=>Case=> Str	   
    	     } ;


-- የማትረሳዋ ምሽት -  ተመስገን አምላኬ! 

}

