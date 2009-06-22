--# -path=.:../abstract:../common:prelude

concrete LangAra of Lang = 
  GrammarAra,
  LexiconAra
  ** {

  flags startcat = Phr ; unlexer = text ; lexer = text ; coding = utf8 ;

}


