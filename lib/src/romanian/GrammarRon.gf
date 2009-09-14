--# -path=.:../romance:../abstract:../common:prelude

concrete GrammarRon of Grammar = 
  NounRon, 
  VerbRon, 
  AdjectiveRon,
  AdverbRon,
  NumeralRonn,
  SentenceRon,
  IdiomRon,
  QuestionRon,
  RelativeRon,
  ConjunctionRon,
  PhraseRon,
  TextX - [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond],
  Prelude, MorphoRon, Coordination,
  StructuralRon
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
