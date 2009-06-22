--# -path=.:../abstract:../common:prelude

concrete LangFin of Lang = 
  GrammarFin,
  LexiconFin
  ** {

flags startcat = Phr ; unlexer = text ; lexer = finnish ;

} ;
