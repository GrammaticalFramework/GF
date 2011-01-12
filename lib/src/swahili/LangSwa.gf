--# -path=.:../abstract:../common:../prelude

concrete LangSwa of Lang = 
  GrammarSwa,
  LexiconSwa
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
