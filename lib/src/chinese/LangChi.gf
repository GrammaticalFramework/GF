--# -path=.:../abstract:../common:../prelude


concrete LangChi of Lang = 
  GrammarChi,
  LexiconChi
  ** {

flags startcat = Phr ; unlexer = concat ; lexer = text ;

} ;
