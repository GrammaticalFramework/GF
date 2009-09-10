--# -path=.:../abstract:../common:../prelude

concrete LangRon of Lang = 
  GrammarRon,
  LexiconRon
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
