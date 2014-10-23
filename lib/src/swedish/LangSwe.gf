--# -path=.:../scandinavian:../abstract:../common:../api

concrete LangSwe of Lang = 
  GrammarSwe,
  LexiconSwe
  ,ConstructionSwe
  ,DocumentationSwe --# notpresent
  ,MarkupSwe - [stringMark]
  ** {

flags startcat = Phr ;  unlexer = text ; lexer = text ;

} ;
