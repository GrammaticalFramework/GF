--# -path=.:../english:../abstract:../common:prelude

concrete MinimalEng of Minimal = 
  GrammarEng,
  MinLexiconEng
  ** {

flags startcat = Phr ; -- unlexer = text ; lexer = text ;

} ;
