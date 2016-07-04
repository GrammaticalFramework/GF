--# -path=.:../abstract:../common:../prelude

concrete LangRus of Lang = 
  GrammarRus,
  LexiconRus,
  ConstructionRus,
  DocumentationRus
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ; coding=utf8 ;

} ;
