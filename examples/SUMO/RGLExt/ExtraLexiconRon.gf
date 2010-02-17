--# -path=.:../romance:../common:../abstract:../../prelude

concrete ExtraLexiconRon of ExtraLexicon = CatRon ** 
  open ParadigmsRon,MorphoRon,BeschRon in {

flags 
  optimize=values ; 

lin
 value_N = mkN "valoare" "valori" ;
 square_A = regA "patrat" ;
 time_N = mkNR "timp" ;
 element_N = mkN "element" ;
 



} ;
