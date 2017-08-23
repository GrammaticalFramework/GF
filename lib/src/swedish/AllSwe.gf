--# -path=.:../scandinavian:../abstract:../common:../api:../prelude

concrete AllSwe of AllSweAbs = 
  LangSwe - [PassV2],
  IrregSwe,
----  ExtraSwe
  ExtendSwe
  ** {} ;
