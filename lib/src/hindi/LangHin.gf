--# -path=.:../abstract:../common:../hindustani

concrete LangHin of Lang = 
  GrammarHin,
  LexiconHin
  ** {

flags startcat = Phr ; unlexer=unwords ; lexer=words ;

}
