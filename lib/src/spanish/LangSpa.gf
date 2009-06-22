--# -path=.:../romance:../abstract:../common:../prelude

concrete LangSpa of Lang = 
  GrammarSpa,
  LexiconSpa
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
