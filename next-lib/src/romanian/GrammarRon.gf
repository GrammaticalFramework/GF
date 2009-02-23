--# -path=.:../romance:../abstract:../common:prelude

concrete GrammarRon of Grammar = 
  NumeralRon,
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
