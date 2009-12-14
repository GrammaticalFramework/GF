--# -path=.:../abstract:../common:../prelude

concrete LangBul of Lang = 
  GrammarBul,
  LexiconBul
  ** {
  flags coding=cp1251 ;


flags startcat = Phr ; unlexer = text ; lexer = text ; coding = cp1251 ;

} ;
