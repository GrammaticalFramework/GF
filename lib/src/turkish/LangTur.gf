--# -path=.:../abstract:../common:../prelude

concrete LangTur of Lang = 
  GrammarTur,
  LexiconTur
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ; coding=utf8 ;

} ;
