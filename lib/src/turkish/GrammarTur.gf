--# -path=.:../abstract:../common:prelude

concrete GrammarTur of Grammar =
  NounTur,
  VerbTur,
  AdjectiveTur,
  NumeralTur,
  StructuralTur,
  SentenceTur,
  AdverbTur
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
