--# -path=.:../abstract:../common:prelude

concrete GrammarTur of Grammar = 
  NumeralTur
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
