concrete NumeralAra of Numeral = CatAra ** 
  open Predef, Prelude, ResAra, MorphoAra in {



lincat 

  Digit = {s : DForm => CardOrd => Gender => State => Case => Str ;
           n : Size } ;
  Sub10 = {s : DForm => CardOrd => Gender => State => Case => Str ; 
           n : Size } ;
  Sub100 = {s : CardOrd => Gender => State => Case => Str ; 
            n : Size} ;
  Sub1000 = {s : CardOrd => Gender => State => Case => Str ; 
             n : Size } ;
  Sub1000000 = {s : CardOrd => Gender => State => Case => Str ; 
                n : Size} ;
  

  
  lin num x = x ;
      
  lin n2 = num2 ** {n = Two };

  lin n3 = num3_10  "ثَلاث" "ثالِث";  
  lin n4 = num3_10  "أَربَع" "رابِع"; 
  lin n5 = num3_10  "خَمس"  "خامِس";   
  lin n6 = num3_10  "سِتّ"   "سادِس";   
  lin n7 = num3_10  "سَبع"  "سابِع";   
  lin n8 = num3_10  "ثَمانِي" "ثامِن"; 
  lin n9 = num3_10  "تِسع"  "تاسِع";   

  lin pot01 = mkNum "واحِد" "أَوَّل" "أُولى" ** { n = One } ;

  lin pot0 d = d ;

  lin pot110 = { 
        s= ((num3_10  "عَشر" "عاشِر").s ! unit ) ;
        n = ThreeTen
        };

  lin pot111 = { 
        s = \\_,g,d,_ => 
          case g of {
            Masc => Al ! d + "أَحَدَ" ++ teen ! Masc ;
            Fem => Al ! d + "إِحدَى" ++ teen ! Fem
          };
        n = NonTeen
        };
      
  lin pot1to19 dig = { 
       s = \\co,g,d,c => case dig.n of {
         Two => Al ! d + num2.s ! unit ! co ! g ! Const ! c ++ teen ! g ;
         _ => dig.s ! unit ! co ! g ! (toDef d ThreeTen) ! Acc ++ 
           teen ! (genPolarity ! g) 
         };
       n = case dig.n of {
         Two => NonTeen;
         _ => Teen
         }
       };
      
  lin pot0as1 num = { 
        s= num.s ! unit;
        n = num.n
        } ;
      
  lin pot1 dig = { 
        s = dig.s ! ten;
        n = NonTeen
        } ;
      
  lin pot1plus dig n = {
        s = \\co,g,d,c => n.s ! unit ! co ! g ! d ! c 
          ++ "وَ" ++ dig.s ! ten ! co ! g ! d ! c ;
        n = NonTeen
        };

  lin pot1as2 n = n ;

  lin pot2 dig = {
      s = \\co,_,d,c => case dig.n of {
        One => num100 ! d ! c ;
        Two => num200 ! d ! c ;
        _ => dig.s ! unit ! co ! Masc ! (toDef d ThreeTen) ! c ++ "مِٱَةِ"
        };
      n = Hundreds
     };
      
  lin pot2plus m e = {
       s = \\co,g,d,c => case m.n of {
         One => num100 ! d ! c;
         Two => num200 ! d ! c;
         _ => m.s ! unit ! co ! Masc ! (toDef d ThreeTen) ! c ++ "مِٱَةٌ"
         } ++ "وَ" ++ e.s ! co ! g ! d ! c ;
       n = e.n 
       };

  lin pot2as3 n = n ;
      
  lin pot3 m = {
        s = \\co,_,d,c => case m.n of {
          One => num1000 ! (definite ! d) ! c;
          Two => num2000 ! (definite ! d) ! c;
          _ => m.s ! co ! Fem ! (toDef d ThreeTen) ! c ++ "آلافٌ"
          } ;
        n = m.n 
        };
--lin pot3plus n m = {
--  s = \\c => n.s ! NCard ++ "تهُْسَند" ++ m.s ! c ; n = Pl} ;

-- numerals as sequences of digits

  lincat 
    Dig = Digits ;  
--   Numeral,Digits = {s : Gender => State => Case => Str ; 
--               n : Size } ;


  lin
    IDig d = d ;

    IIDig d i = {
      s = d.s ++ i.s;
      n = ThreeTen ;
    } ;

    D_0 = mk1Dig "0" ;
    D_1 = mk2Dig "1" One ;
    D_2 = mk2Dig "2" Two ;
    D_3 = mk1Dig "3" ;
    D_4 = mk1Dig "4" ;
    D_5 = mk1Dig "5" ;
    D_6 = mk1Dig "6" ;
    D_7 = mk1Dig "7" ;
    D_8 = mk1Dig "8" ;
    D_9 = mk1Dig "9" ;

  oper


    mk2Dig : Str -> Size -> Digits = \str,sz -> {
      s = str ;
      n = sz ;
      lock_Digits = <>
      };

    mk1Dig : Str -> Digits = \str -> {
      s = str ;
      n = ThreeTen;
      lock_Digits = <>
      };

}
