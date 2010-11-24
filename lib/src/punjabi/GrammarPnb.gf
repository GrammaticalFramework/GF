--# -path=.:../abstract:../common:../prelude

 concrete GrammarPnb of Grammar = 
  NounPnb, 
  VerbPnb, 
  AdjectivePnb,
  AdverbPnb,
  NumeralPnb,
  SentencePnb,
  QuestionPnb,
  RelativePnb,
  ConjunctionPnb,
  PhrasePnb,
  TextX - [Adv],
  StructuralPnb,
  TenseX - [Adv],
  IdiomPnb
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

}


