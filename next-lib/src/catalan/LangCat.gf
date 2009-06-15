--# -path=.:../romance:../abstract:../common:../prelude

concrete LangCat of Lang = 
  GrammarCat,
  LexiconCat
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
