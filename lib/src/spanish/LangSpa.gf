--# -path=.:../romance:../abstract:../common:../api

concrete LangSpa of Lang = 
  GrammarSpa,
  LexiconSpa
  ,DocumentationSpa --# notpresent
  ,ConstructionSpa
  ** {

flags startcat = Phr ;

} ;
