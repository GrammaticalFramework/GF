--# -path=.:../abstract:../common:prelude

concrete GrammarTha of Grammar = 
  NounTha, 
  VerbTha, 
  AdjectiveTha,
  AdverbTha,
  NumeralTha,
  SentenceTha,
  QuestionTha,
--  RelativeTha,
--  ConjunctionTha,
  PhraseTha,
--  TextX,
  StructuralTha
--  IdiomTha
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
