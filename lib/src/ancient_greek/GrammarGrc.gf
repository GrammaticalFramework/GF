--# -path=.:../abstract:../common:prelude

concrete GrammarGrc of Grammar = 
  NounGrc,
  VerbGrc, 
  AdjectiveGrc,
  AdverbGrc,
  NumeralGrc, 
  SentenceGrc,
  QuestionGrc,
  RelativeGrc,
  ConjunctionGrc,
  PhraseGrc,
  TextX-[Tense,Temp],
  TenseGrc,
  StructuralGrc
--  IdiomGrc
  ** {
} ;
