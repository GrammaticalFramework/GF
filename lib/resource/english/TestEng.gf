--# -path=.:../abstract:../../prelude

concrete TestEng of Test = 
  RulesEng, 
  ClauseEng, 
  StructuralEng, 
  MinimalEng
  ** {
} ;
