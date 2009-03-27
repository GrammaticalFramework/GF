--# -path=.:../abstract:../common:prelude

concrete GrammarTur of Grammar = 
  NumeralTur,
  StructuralTur
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
