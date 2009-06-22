--# -path=.:../abstract:../common:prelude

concrete LangEng of Lang = 
  GrammarEng,
  LexiconEng
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
