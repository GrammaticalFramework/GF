--# -path=.:../abstract:../common:prelude

-- (c) 2010 Markos KG
-- Licensed under LGPL

concrete GrammarAmh of Grammar = 
  NounAmh,
  VerbAmh, 
  AdjectiveAmh,
  AdverbAmh,
  NumeralAmh,
  SentenceAmh,
  QuestionAmh,
  RelativeAmh,
  ConjunctionAmh,
  PhraseAmh,
  TextX,
  StructuralAmh,
  IdiomAmh,
  TenseX 

  ** {

 flags startcat = Phr ; unlexer = text ; lexer = text ;coding=utf8 ;

} ;
