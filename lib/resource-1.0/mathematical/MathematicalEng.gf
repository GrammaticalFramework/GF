--# -path=.:../english:../abstract:../common:prelude

concrete MathematicalEng of Mathematical = 
  NounEng - [ComplN2], --- to avoid ambiguity 
--  VerbEng, 
--  AdjectiveEng,
--  AdverbEng,
  NumeralEng,
--  SentenceEng,
  QuestionEng,
  RelativeEng,
  ConjunctionEng,
  PhraseEng,
  StructuralEng,

  SymbolEng,
  PredicationEng,

  LexiconEng
  ** {

flags startcat = Phr ;

} ;
