--# -path=.:../prelude

concrete NumSwedish of Numerals = open ResNumSwedish, Prelude in {

  flags startcat = Numeral ; lexer=unglue ; unlexer=glue ;

  lincat Digit = {
    s : DForm => Str 
  } ;
  lincat Sub10 = {
    s : DForm => Str 
  } ;
  lin n2 = mkTal "två" "tolv" "tjugo" ;
  lin n3 = mkTal "tre" "tretton" "trettio" ;
  lin n4 = mkTal "fyra" "fjorton" "fyrtio" ;
  lin n5 = regTal "fem" ;
  lin n6 = regTal "sex" ;
  lin n7 = mkTal "sju" "sjutton" "sjuttio" ;
  lin n8 = mkTal "åtta" "arton" "åttio" ;
  lin n9 = mkTal "nio" "nitton" "nittio" ;
  lin num = \x -> x ;
  lin pot0 = \d -> {
    s = table {
      f => d.s ! f 
    }
    } ;
  lin pot01 = {
    s = table {
      f => "ett" 
    }
    } ;
  lin pot0as1 = \n -> ss (n.s ! ental);
  lin pot1 = \ d -> ss (d.s ! tiotal);
  lin pot110 = ss "tio" ;
  lin pot111 = ss "elva" ;
  lin pot1as2 = \ n -> n ;
  lin pot1plus = \ d -> \ e -> ss (glueOpt (d.s ! tiotal) (e.s ! ental)) ;
  lin pot1to19 = \ d -> ss (d.s ! ton);
  lin pot2 = \ d -> ss (glueOpt (d.s ! ental) "hundra") ;
  lin pot2as3 = \ n -> n ;
  lin pot2plus = \ d -> \ e -> ss (glueOpt (glueOpt (d.s ! ental) "hundra") e.s);
  lin pot3 = \ n -> ss (glueOpt n.s  "tusen");
  lin pot3plus = \ n -> \ m -> ss (noglueOpt (glueOpt n.s "tusen") m.s);
  }
