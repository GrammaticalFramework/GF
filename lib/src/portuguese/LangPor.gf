--# -path=.:../romance:../abstract:../common:../api

concrete LangPor of Lang = 
  GrammarPor,
  LexiconPor
  ,DocumentationPor --# notpresent
  ,ConstructionPor
  ** {

flags startcat = Phr ;

} ;
