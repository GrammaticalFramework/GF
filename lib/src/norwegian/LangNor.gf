--# -path=.:../scandinavian:../abstract:../common:../prelude

concrete LangNor of Lang = 
  GrammarNor,
  LexiconNor
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
