--# -path=.:../scandinavian:../abstract:../common:prelude

concrete GrammarNor of Grammar = 
  NounNor, 
  VerbNor, 
  AdjectiveNor,
  AdverbNor,
  NumeralNor,
  SentenceNor,
  QuestionNor,
  RelativeNor,
  ConjunctionNor,
  PhraseNor,
  TextX - [Tense,Temp] ,
  IdiomNor,
  StructuralNor,
  TenseNor
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
