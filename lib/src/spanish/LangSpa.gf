--# -path=.:../romance:../abstract:../common:../prelude

concrete LangSpa of Lang = 
  GrammarSpa,
  LexiconSpa,
  DocumentationSpa
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
