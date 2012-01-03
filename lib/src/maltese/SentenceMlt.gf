-- SentenceMlt.gf: clauses and sentences
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2011
-- Licensed under LGPL

--# -path=.:abstract:common:prelude

concrete SentenceMlt of Sentence = CatMlt ** open
  ResMlt,
  Prelude,
  ResMlt,
  ParamX,
  CommonX in {

  flags optimize=all_subs ;

-- Cl
-- Imp
-- QS
-- RS
-- S
-- SC
-- SSlash

}
