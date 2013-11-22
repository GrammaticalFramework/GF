--# -path=.:../abstract:../common:prelude
--# -coding=cp1251

concrete AllBul of AllBulAbs = 
  LangBul,
  ExtraBul
  ** {
  flags coding=cp1251 ;
} ;
