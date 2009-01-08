--# -path=.:../abstract:../common:src/prelude

concrete LangRus of Lang = 
  GrammarRus,
  LexiconRus
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ; coding=utf8 ;

} ;
