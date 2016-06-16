--# -path=.:../scandinavian:../abstract:../common:prelude

concrete GrammarNno of Grammar =
  NounNno,
  VerbNno,
  AdjectiveNno,
  AdverbNno,
  NumeralNno,
  SentenceNno,
  QuestionNno,
  RelativeNno,
  ConjunctionNno,
  PhraseNno,
  TextX - [Tense,Temp] ,
  IdiomNno,
  StructuralNno,
  TenseNno
  ** {

flags startcat = Phr ; unlexer = text ; lexer = text ;

} ;
