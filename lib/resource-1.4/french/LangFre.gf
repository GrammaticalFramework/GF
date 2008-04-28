--# -path=.:../romance:../abstract:../common

concrete LangFre of Lang = 
  GrammarFre,
  LexiconFre
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
