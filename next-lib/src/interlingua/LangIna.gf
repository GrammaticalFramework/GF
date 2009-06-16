--# -path=.:../abstract:../common:../prelude

concrete LangIna of Lang = 
  GrammarIna,
  LexiconIna
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} 

