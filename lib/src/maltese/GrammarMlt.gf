-- GrammarMlt.gf: common syntax
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

--# -path=.:../abstract:../common:../prelude

concrete GrammarMlt of Grammar =
  NounMlt,
  VerbMlt,
  AdjectiveMlt,
  AdverbMlt,
  NumeralMlt,
  SentenceMlt,
  QuestionMlt,
  RelativeMlt,
  ConjunctionMlt,
  PhraseMlt,
  TextX,
  StructuralMlt,
  IdiomMlt,
  TenseX
  ** {

  flags coding=utf8 ;

}
