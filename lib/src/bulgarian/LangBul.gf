--# -path=.:../abstract:../common:../api

concrete LangBul of Lang = 
  GrammarBul,
  LexiconBul,
  DocumentationBul
  ** {

flags startcat = Phr ;

} ;
