--# -path=.:../romance:../abstract:../common:../api

concrete LangIta of Lang = 
  GrammarIta,
  LexiconIta
  ,DocumentationIta
  ,ConstructionIta
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
