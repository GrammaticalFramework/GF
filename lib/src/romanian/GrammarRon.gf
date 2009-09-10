--# -path=.:../romance:../abstract:../common:prelude

concrete GrammarRon of Grammar = 
  NounRon, 
  VerbRon, 
  AdjectiveRon,
  AdverbRon,
  NumeralRon,
  SentenceRon,
  IdiomRon,
  QuestionRon,
  RelativeRon,
  ConjunctionRon,
  PhraseRon,
  TextX - [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond], Coordination,
   Prelude, MorphoRon, BeschRon,
  StructuralRon
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
