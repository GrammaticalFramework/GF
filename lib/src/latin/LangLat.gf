--# -path=.:../abstract:../common:../prelude

concrete LangLat of Lang = 
  GrammarLat,
  LexiconLat
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
