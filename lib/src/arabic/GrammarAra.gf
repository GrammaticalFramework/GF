--# -path=.:../abstract:../common:prelude

concrete GrammarAra of Grammar = 
  NounAra, 
  VerbAra, 
  AdjectiveAra,
  AdverbAra,
  NumeralAra,
  SentenceAra,
  QuestionAra,
  RelativeAra,
  ConjunctionAra,
  PhraseAra,
  TextX - [Utt],
  StructuralAra,
  IdiomAra,
  TenseX - [Utt]
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
