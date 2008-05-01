--# -path=.:../abstract:../common:prelude

concrete LangHin of Lang = 
  GrammarHin,
  LexiconHin
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

}
