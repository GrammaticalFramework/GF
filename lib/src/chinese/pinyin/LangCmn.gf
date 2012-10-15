--# -path=.:../abstract:../common:../prelude


concrete LangCmn of Lang = 
  GrammarCmn,
  LexiconCmn
  ** {

flags startcat = Phr ; unlexer = concat ; lexer = text ;

} ;
