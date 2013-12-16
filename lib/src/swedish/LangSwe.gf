--# -path=.:../scandinavian:../abstract:../common:../api

concrete LangSwe of Lang = 
  GrammarSwe,
  LexiconSwe
  ,ConstructionSwe
  ,DocumentationSwe
  ** {

flags startcat = Phr ;  unlexer = text ; lexer = text ;

} ;
