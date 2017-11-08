--# -path=.:../romance:../abstract:../common:../api:../prelude

concrete AllFre of AllFreAbs = 
  LangFre,
  IrregFre,
  ExtendFre ---- ExtraFre
  ** {} ;
