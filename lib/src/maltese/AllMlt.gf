-- AllMlt.gf: common grammar plus language-dependent extensions
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

--# -path=.:../prelude:../abstract:../common

concrete AllMlt of AllMltAbs =
  LangMlt,
  DictMlt,
  IrregMlt,
  ExtraMlt
  ** {

} ;
