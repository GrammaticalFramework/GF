--# -path=.:../abstract:../common:../prelude

concrete LangLav of Lang =
  GrammarLav,
  LexiconLav
  ** {

flags
  startcat = Phr ;
  unlexer = text ;
  lexer = text ;

}
