--# -path=.:../romance:../common:../abstract:../../prelude

concrete ExtraLexiconFre of ExtraLexicon = CatFre ** 
  open ParadigmsFre,MorphoFre,BeschFre in {

flags 
  optimize=values ; 

lin
 value_N = regGenN "valeur" feminine ;
 square_A = regA "caré" ;
 time_N = regN "heure" ;
 element_N = mkN "élément" ;
 



} ;
