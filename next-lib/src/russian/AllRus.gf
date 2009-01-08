--# -path=.:../abstract:../common:prelude

concrete AllRus of AllRusAbs = 
  LangRus,
  ExtraRus
  ** {flags coding=utf8 ;} ;
