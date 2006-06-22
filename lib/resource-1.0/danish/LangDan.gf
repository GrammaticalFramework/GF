--# -path=.:../scandinavian:../abstract:../common:prelude

concrete LangDan of Lang = 
  GrammarDan,
  LexiconDan
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
