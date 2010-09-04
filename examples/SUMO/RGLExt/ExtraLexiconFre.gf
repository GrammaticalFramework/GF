--# -path=.:../romance:../common:../abstract:../../prelude

concrete ExtraLexiconFre of ExtraLexicon = CatFre ** 
  open ParadigmsFre,MorphoFre,BeschFre in {

flags 
  optimize=values ; coding=utf8 ;

lin
 value_N = regGenN "valeur" feminine ;
 square_A = regA "carÈ" ;
 time_N = regN "heure" ;
 element_N = mkN "ÈlÈment" ;
 
 entity_N = regGenN "entit√©" feminine;
 abstract_N = mkN "abstrait" ;
 attribute_N = mkN "attribut" ; 
 graph_N = regGenN "graph" masculine ; 
 model_N = regGenN "mod√®le" masculine; 
 process_N = mkN "processus" ;
 task_N = regGenN "t√¢che" feminine;
 proposition_N = regGenN "proposition" feminine ;
 quantity_N = regGenN "quantit√©" feminine; 
 set_N = regGenN "ensemble" masculine;
 class_N = regGenN "classe" feminine;
 physical_N = regGenN "physique" masculine; 
 content_N = mkN "sens" ; 
 object_N = mkN "objet" ;
 system_N = mkN "syst√®me" ;
 physical_A = regA "physique" ;



} ;
