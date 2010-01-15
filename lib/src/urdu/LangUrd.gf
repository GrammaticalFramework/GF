--# -path=.:../abstract:../common:../prelude

concrete LangUrd of Lang = 
  GrammarUrd,
  LexiconUrd
  ** {

flags startcat = Phr ; unlexer=unwords ; lexer=words ;

}
