--# -path=.:../abstract:../common:prelude

concrete LangAra of Lang = 
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
  LexiconAra
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
