--# -path=.:../abstract:../common:prelude

concrete LangTha of Lang = 
  GrammarTha,
  LexiconTha
  ** {

flags startcat = Phr ; unlexer = concat ; lexer = text ;

} ;
