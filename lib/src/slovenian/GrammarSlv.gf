--# -path=.:../abstract:../common:prelude

concrete GrammarSlv of Grammar = 
  NounSlv,
  VerbSlv,
  AdjectiveSlv,
  AdverbSlv,
  NumeralSlv,
  SentenceSlv,
  QuestionSlv,
{-  RelativeSlv,-}
  ConjunctionSlv,
  PhraseSlv,
  TextX - [Pol,PPos,PNeg],
  StructuralSlv,
  IdiomSlv,  ----AR
  TenseX
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
