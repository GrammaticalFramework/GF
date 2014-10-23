--# -path=.:../abstract:../common:../api

concrete LangGer of Lang = 
  GrammarGer,
  LexiconGer
  ,ConstructionGer
  ,DocumentationGer --# notpresent
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
