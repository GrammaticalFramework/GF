--# -path=.:../romance:../abstract:../common:prelude

concrete GrammarIta of Grammar = 
  NounIta, 
  VerbIta, 
  AdjectiveIta,
  AdverbIta,
  NumeralIta,
  SentenceIta,
  QuestionIta,
  RelativeIta,
  ConjunctionIta,
  PhraseIta,
  TextX - [SC,Temp,Tense,Pol,PPos,PNeg,TPres,TPast,TFut,TCond],
  IdiomIta,
  StructuralIta,
  TenseIta

  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
