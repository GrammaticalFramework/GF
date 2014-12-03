--# -path=.:../romance:../abstract:../common:../api

concrete AllCat of AllCatAbs = 
  LangCat,
  IrregCat,
  ExtraCat 
  ** {} ;
