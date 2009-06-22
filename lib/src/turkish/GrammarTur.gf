--# -path=.:../abstract:../common:prelude

concrete GrammarTur of Grammar = 
  NounTur,
  NumeralTur,
  StructuralTur
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
