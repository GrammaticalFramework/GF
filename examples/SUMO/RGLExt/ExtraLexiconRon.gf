--# -path=.:../romance:../common:../abstract:../../prelude

concrete ExtraLexiconRon of ExtraLexicon = CatRon ** 
  open ParadigmsRon,MorphoRon,BeschRon in {

flags 
  optimize=values ; coding=utf8 ;

lin
 value_N = mkN "valoare" "valori" ;
 square_A = regA "patrat" ;
 time_N = mkNR "timp" ;
 element_N = mkN "element" ;
 
 entity_N = mkN "entitate" ;
 abstract_N = mkN "abstract" ;
 attribute_N = mkN "atribut" ; 
 graph_N = mkNR "graf" ; 
 model_N = mkN "model" neuter; 
 process_N = mkN "proces" ;
 task_N = mkN "sarcină" ;
 proposition_N = mkN "propoziție" ;
 quantity_N = mkN "cantitate" ; 
 set_N = mkN "mulțime" ;
 class_N = mkN "clasă" ;
 physical_N = mkN "concret" ; 
 content_N = mkN "conținut" ; 
 object_N = mkN "obiect" ;
 system_N = mkN "sistem" ;
 physical_A = regA "concret" ;



} ;
