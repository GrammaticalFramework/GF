--# -path=.:../abstract:../common:prelude

concrete GrammarTur of Grammar = 
  NounTur,
  AdjectiveTur,
  NumeralTur,
  StructuralTur
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
