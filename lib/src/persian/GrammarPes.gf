--# -path=.:../abstract:../common:../prelude

 concrete GrammarPes of Grammar = 
  NounPes, 
  VerbPes, 
  AdjectivePes,
  AdverbPes,
  NumeralPes,
  SentencePes,
  QuestionPes,
  RelativePes,
  ConjunctionPes,
  
  PhrasePes,
  TextPes - [Adv], 
  StructuralPes,
  TenseX - [Adv],
  IdiomPes 
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

}


