concrete NumeralAra of Numeral = CatAra ** 
  open Predef, Prelude, ResAra, MorphoAra in {



lincat 

  Digit = {s : DForm => Gender => State => Case => Str ;
           n : Size } ;
  Sub10 = {s : DForm => Gender => State => Case => Str ; 
           n : Size } ;
  Sub100 = {s : Gender => State => Case => Str ; 
            n : Size} ;
  Sub1000 = {s : Gender => State => Case => Str ; 
            n : Size } ;
  Sub1000000 = {s : Gender => State => Case => Str ; 
            n : Size} ;



lin num x = x ;


lin n2 = num2 ** {n = Two };


lin n3 = num3_10   "ثَلاث";  
lin n4 = num3_10  "أَربَع"; 
lin n5 = num3_10    "خَمس";   
lin n6 = num3_10    "سِتّ";   
lin n7 = num3_10    "سَبع";   
lin n8 = num3_10  "ثَمانِي"; 
lin n9 = num3_10    "تِسع";   


lin pot01 = num1_10 "واحِد" ** { n = One } ;

lin pot0 d = d ;

lin pot110 = 
      { s= ((num3_10  "عَشر").s ! unit ) ;
        n = ThreeTen
      };
lin pot111 = 
      { s = \\g,d,_ => 
          case g of {
            Masc => Al ! d + "أَحَدَ" ++ teen ! Masc ;
            Fem => Al ! d + "إِحدَى" ++ teen ! Fem
          };
        n = NonTeen
      };

lin pot1to19 dig = 
      { s = \\g,d,c => 
          case dig.n of {
            Two => Al ! d + num2.s ! unit ! g ! Const ! c ++ teen ! g  ;
            _ => dig.s ! unit ! g ! (toDef d ThreeTen) ! Acc ++ 
              teen ! (genPolarity ! g) 
          };
        n = case dig.n of {
          Two => NonTeen;
          _ => Teen
          }
      };

lin pot0as1 num = 
      { s= num.s ! unit;
        n = num.n
      } ;

lin pot1 dig = 
      { s = dig.s ! ten;
        n = NonTeen
      };

lin pot1plus dig n = {
      s = \\g,d,c => n.s ! unit ! g ! d ! c 
           ++ "وَ" ++ dig.s ! ten ! g ! d ! c ;
      n = NonTeen
      };

lin pot1as2 n = n ;

lin pot2 dig = {
      s = \\g,d,c => 
        case dig.n of {
          One => num100 ! d ! c ;
          Two => num200 ! d ! c ;
          _ => dig.s ! unit ! Masc ! (toDef d ThreeTen) ! c ++ "مِٱَةِ"
        };
      n = Hundreds
      };

lin pot2plus m e = {
      s = \\g,d,c => 
        case m.n of {
          One => num100 ! d ! c;
          Two => num200 ! d ! c;
          _ => m.s ! unit ! Masc ! (toDef d ThreeTen) ! c ++ "مِٱَةٌ"
        } ++ "وَ" ++ e.s ! g ! d ! c ;
      n = e.n 
      };
        

lin pot2as3 n = n ;

lin pot3 m = {
      s = \\g,d,c =>
        case m.n of {
          One => num1000 ! (definite ! d) ! c;
          Two => num2000 ! (definite ! d) ! c;
          _ => m.s ! Fem ! (toDef d ThreeTen) ! c ++ "آلافٌ"
        } ;
      n = m.n 
      };
--lin pot3plus n m = {
--  s = \\c => n.s ! NCard ++ "تهُْسَند" ++ m.s ! c ; n = Pl} ;

}
