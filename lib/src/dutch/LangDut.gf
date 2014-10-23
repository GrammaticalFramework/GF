--# -path=.:../abstract:../common:../prelude

concrete LangDut of Lang = 
  GrammarDut,
  LexiconDut 
  ,DocumentationDut --# notpresent
  ,ConstructionDut
;
