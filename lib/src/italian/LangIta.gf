--# -path=.:../romance:../abstract:../common:../prelude

concrete LangIta of Lang = 
  GrammarIta,
  LexiconIta
  ,DocumentationIta
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
