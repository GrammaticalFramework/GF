--# -path=.:../romance:../abstract:../common:../api

concrete LangCat of Lang = 
  GrammarCat,
  LexiconCat
  ,DocumentationCat --# notpresent
  ,ConstructionCat
  ** {

flags startcat = Phr ;

} ;
