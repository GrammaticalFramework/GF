--# -path=.:../abstract:../common:../prelude

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
  TextX - [CAdv,Temp,TTAnt,Tense,TPres,TPast,TFut,TCond],
  Prelude, MorphoRon, Coordination,
  StructuralRon
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
