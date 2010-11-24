--# -path=.:../abstract:../common:../hindustani

concrete LangPnb of Lang = 
  GrammarPnb,
  LexiconPnb
  ** {

flags startcat = Phr ; unlexer=unwords ; lexer=words ;

}
