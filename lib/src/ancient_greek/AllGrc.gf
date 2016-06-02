-- --# -path=.:../../gf/lib/src/abstract:../common:../prelude
--# -path=.:../abstract:../common:../prelude

concrete AllGrc of AllGrcAbs = 
  LangGrc,
  ExtraGrc,
  BornemannGrc -- added HL
  ** {} ;
