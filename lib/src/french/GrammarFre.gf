--# -path=.:../romance:../abstract:../common:prelude

concrete GrammarFre of Grammar = 
  NounFre, 
  VerbFre, 
  AdjectiveFre,
  AdverbFre,
  NumeralFre,
  SentenceFre,
  QuestionFre,
  RelativeFre,
  ConjunctionFre,
  PhraseFre,
  TextX - [SC,Temp,Tense,Pol,PPos,PNeg],
  IdiomFre,
  StructuralFre,
  TenseFre
  ** {

flags startcat = Phr ; 

} ;
