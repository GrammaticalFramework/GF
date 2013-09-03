--# -path=.:../abstract:../common:../prelude

concrete LangLat of Lang = 
  GrammarLat,
  ParadigmsLat,
  ConjunctionLat,
  LexiconLat
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
