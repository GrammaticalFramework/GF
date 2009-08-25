--# -path=.:../scandinavian:../abstract:../common:../prelude

concrete LangSwe of Lang = 
  GrammarSwe,
  LexiconSwe
  ** {

flags startcat = Phr ;  unlexer = text ; lexer = text ;

} ;
