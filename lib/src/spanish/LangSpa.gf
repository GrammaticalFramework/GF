--# -path=.:../romance:../abstract:../common:../api

concrete LangSpa of Lang = 
  GrammarSpa,
  LexiconSpa
  ,DocumentationSpa
  ,ConstructionSpa
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
