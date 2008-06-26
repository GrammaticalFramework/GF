--# -path=.:alltenses

concrete DemoEng of Demo = 
  NounEng - [AdvCN], 
--  VerbEng, 
  ClauseEng, --
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

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
