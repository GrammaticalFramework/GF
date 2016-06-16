--# -path=.:../scandinavian:../abstract:../common:../prelude

concrete LangNno of Lang =
  GrammarNno,
  LexiconNno
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
