--# -path=.:../scandinavian:../abstract:../common:prelude

concrete AllDan of AllDanAbs = 
  LangDan,
  IrregDan - [fly_V],
  ExtraDan 
  ** {} ;
