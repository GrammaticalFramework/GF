--# -path=.:../abstract:../common:../sindhi

concrete LangSnd of Lang = 
  GrammarSnd,
  LexiconSnd
  ** {

flags startcat = Phr ; unlexer=unwords ; lexer=words ;

}
