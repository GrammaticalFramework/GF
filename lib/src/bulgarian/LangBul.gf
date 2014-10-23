--# -path=.:../abstract:../common:../api

concrete LangBul of Lang = 
  GrammarBul,
  LexiconBul,
  ConstructionBul
  ,DocumentationBul --# notpresent
  ** {

flags startcat = Phr ;

} ;
