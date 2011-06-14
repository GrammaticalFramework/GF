--# -path=.:../abstract:../common

concrete LangNep of Lang = 
  GrammarNep,
  LexiconNep
  ** {

flags startcat = Phr ; unlexer=unwords ; lexer=words ;

}
