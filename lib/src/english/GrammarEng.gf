--# -path=.:../abstract:../common:prelude

concrete GrammarEng of Grammar = 
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
  TenseX
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
