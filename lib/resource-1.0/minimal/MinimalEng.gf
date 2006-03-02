--# -path=.:../english:../abstract:../common:prelude

concrete MinimalEng of Minimal = 
  NounEng, 
  VerbEng, 
  AdjectiveEng,
  AdverbEng,
  NumeralEng,
  SentenceEng,
  QuestionEng,
  RelativeEng,
  ConjunctionEng,
  PhraseEng,
  TextX,
  StructuralEng,
  IdiomEng,
  LexiconEng
  ** {

flags startcat = Phr ; -- unlexer = text ; lexer = text ;

} ;
