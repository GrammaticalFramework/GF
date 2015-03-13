--# -path=.:../abstract:../common:../prelude:

concrete LangMon of Lang = 
  GrammarMon,
  LexiconMon -- to compile faster, use TestLexiconMon (see LangExtraMon.gf)
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ; coding=utf8 ;

} ;
