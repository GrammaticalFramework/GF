--# -path=.:../romance:../abstract:../common:prelude

concrete LangFre of Lang = 
  GrammarFre,
  LexiconFre
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
