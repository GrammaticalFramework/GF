-- GrammarMlt.gf: common syntax
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2011
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
  TextX - [Utt],
  StructuralMlt,
  IdiomMlt
  ** {

	flags coding=utf8 ;

}
