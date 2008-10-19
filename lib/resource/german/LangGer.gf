--# -path=.:../abstract:../common:prelude

concrete LangGer of Lang = 
  GrammarGer,
  LexiconGer
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;
erasing = on ;
} ;
