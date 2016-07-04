--# -path=.:../abstract:../common:../prelude:../api

concrete AllRus of AllRusAbs = 
  LangRus,
  ExtraRus
  ** {flags coding=utf8 ;} ;
