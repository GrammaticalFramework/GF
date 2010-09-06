--# -path=.:../romance:../common:../abstract:../../prelude

concrete ExtraLexiconFre of ExtraLexicon = CatFre ** 
  open ParadigmsFre,MorphoFre,BeschFre in {

flags 
  optimize=values ; coding=utf8 ;

lin
 value_N = regGenN "valeur" feminine ;
 square_A = regA "caré" ;
 time_N = regN "heure" ;
 element_N = mkN "élément" ;
 
 entity_N = regGenN "entité" feminine;
 abstract_N = mkN "abstrait" ;
 attribute_N = mkN "attribut" ; 
 graph_N = regGenN "graph" masculine ; 
 model_N = regGenN "modèle" masculine; 
 process_N = mkN "processus" ;
 task_N = regGenN "tâche" feminine;
 proposition_N = regGenN "proposition" feminine ;
 quantity_N = regGenN "quantité" feminine; 
 set_N = regGenN "ensemble" masculine;
 class_N = regGenN "classe" feminine;
 physical_N = regGenN "physique" masculine; 
 content_N = mkN "sens" ; 
 object_N = mkN "objet" ;
 system_N = mkN "système" ;
 physical_A = regA "physique" ;



} ;
