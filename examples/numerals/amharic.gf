concrete amharic of Numerals = {

flags coding = UTF8;

param DForm = unit | ten  ;
-- Size is Sg or Pl -- 

lincat Numeral =    { s : Str } ;
lincat Digit = 	    {s : DForm => Str}  ;
lincat Sub10 =      {s : DForm => Str} ;
lincat Sub100 =     { s : Str } ;
lincat Sub1000 =    { s : Str } ;
lincat Sub1000000 = { s : Str } ;

oper mkNum : Str -> Str ->{s : DForm => Str}  = 
  \hulet ->  \haya -> 
  {s = table {unit => hulet ; ten => haya}} ;

oper ss : Str -> {s : Str} = \s -> {s = s} ;

lin num x = x ;
lin n2 = mkNum "ሁለት" "ሃያ";
lin n3 = mkNum "ሶስት"  "ሰላሳ" ;
lin n4 = mkNum "አራት" "አርባ" ;
lin n5 = mkNum "አምስት"  "ሃምሳ" ;
lin n6 = mkNum "ስድስት"  "ስድሳ" ;
lin n7 = mkNum "ሰባት"  "ሰባ" ;
lin n8 = mkNum "ስምንት" "ሰማንያ" ;
lin n9 = mkNum "ዘጠኝ"  "ዘጠና" ;

lin pot01 = {s = table {f => "አንድ"}} ;
lin pot0 d = {s = table {f => d.s ! f}} ;
lin pot110 = ss "አስር" ;
lin pot111 = ss "አስራ አንድ" ;
lin pot1to19 d ={s = "አስራ"++ d.s ! unit} ;
lin pot0as1 n = {s = n.s ! unit} ;
lin pot1 d = {s = d.s ! ten} ;
lin pot1plus d e = {s = d.s ! ten ++ e.s ! unit} ;
lin pot1as2 n = n ;
lin pot2 d = {s = d.s ! unit ++ "መቶ"} ;
lin pot2plus d e = {s = d.s ! unit ++ "መቶ" ++ e.s} ;
lin pot2as3 n = n ;
lin pot3 n = {s = n.s ++ "ሺህ"} ;
lin pot3plus n m = {s = n.s ++ "ሺህ" ++ m.s} ;


}
