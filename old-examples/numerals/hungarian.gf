include numerals.Abs.gf ;

-- by Patrik Jansson, Chalmers

param DForm = ental  | tiotal  ;
param Place = attr  | indep  ;
lincat Numeral = {s : Str} ;
lincat Digit = {s : (DForm*Place) => Str} ;
lincat Sub10 = {s : (DForm*Place) => Str} ;
lincat Sub100 = {s : Place => Str} ;
lincat Sub1000 = {s : Place => Str} ;
lincat Sub1000000 = {s : Str} ;
lin num x0 =
  {s = x0.s} ;
lin n2  =
  {s = table {<ental,indep> => "kettö" ; 
              <tiotal,indep> => "húsz" ; 
              <ental,attr> => "két" ; 
              <tiotal, attr> => "huszon"}} ;
lin n3  =
  {s = table {<ental,p> => "három" ; <tiotal,p> => "harminc"}} ;
lin n4  =
  {s = table {<ental,p> => "négy" ; <tiotal,p> => "negyven"}} ;
lin n5  =
  {s = table {<ental,p> => "öt" ; <tiotal,p> => "ötven"}} ;
lin n6  =
  {s = table {<ental,p> => "hat" ; <tiotal,p> => "hatvan"}} ;
lin n7  =
  {s = table {<ental,p> => "hét" ; <tiotal,p> => "hetven"}} ;
lin n8  =
  {s = table {<ental,p> => "nyolc" ; <tiotal,p> => "nyolcvan"}} ;
lin n9  =
  {s = table {<ental,p> => "kilenc" ; <tiotal,p> => "kilencven"}} ;
lin pot01  =
  {s = table {<f,attr> => [] ; <f,indep> => "egy"}} ;
lin pot0 d =
  {s = table {<f,p> => d.s ! <f,p>}} ;
lin pot110  =
  {s = table {p => "tíz"}} ;
lin pot111  =
  {s = table {p => "tizen" ++ "egy"}} ;
lin pot1to19 d =
  {s = table {p => "tizen" ++ d.s ! <ental,indep>}} ;
lin pot0as1 n =
  {s = table {p => n.s ! <ental,p>}} ;
lin pot1 d =
  {s = table {p => d.s ! <tiotal,indep>}} ;
lin pot1plus d e =
  {s = table {p => (d.s ! <tiotal,attr>) ++ e.s ! <ental,indep>}} ;
lin pot1as2 n =
  {s = table {p => n.s ! p}} ;
lin pot2 d =
  {s = table {p => (d.s ! <ental,attr>) ++ "száz"}} ;
lin pot2plus d e =
  {s = table {p => (d.s ! <ental,attr>) ++ "száz" ++ e.s ! indep}} ;
lin pot2as3 n =
  {s = n.s ! indep} ;
lin pot3 n =
  {s = n.s ! attr ++ "ezer"} ;
lin pot3plus n m =
  {s = n.s ! attr ++ "ezer" ++ m.s ! indep} ;
