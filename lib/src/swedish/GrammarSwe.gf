--# -path=.:../scandinavian:../abstract:../common:prelude

concrete GrammarSwe of Grammar = 
  NounSwe, 
  VerbSwe, 
  AdjectiveSwe,
  AdverbSwe,
  NumeralSwe,
  SentenceSwe,
  QuestionSwe,
  RelativeSwe,
  ConjunctionSwe,
  PhraseSwe,
  TextX -[Tense,Temp],
  IdiomSwe,
  StructuralSwe,
  TenseSwe
  ** {

flags startcat = Phr ;  unlexer = text ; lexer = text ;

} ;
