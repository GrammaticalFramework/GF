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
  TextX  - [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond],
  IdiomIta,
  StructuralIta

  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
