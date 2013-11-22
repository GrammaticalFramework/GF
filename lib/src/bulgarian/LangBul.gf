--# -path=.:../abstract:../common:../prelude
--# -coding=cp1251

concrete LangBul of Lang = 
  GrammarBul,
  LexiconBul
  ** {
  flags coding=cp1251 ;


flags startcat = Phr ; unlexer = text ; lexer = text ; coding = cp1251 ;

} ;
