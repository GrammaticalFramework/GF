--# -path=.:../abstract:../common:../prelude

concrete AllEst of AllEstAbs = 
  LangEst, --  - [SlashV2VNP,SlashVV, TFut], ---- to speed up linking; to remove spurious parses
  ExtraEst -- - [ProDrop, ProDropPoss, S_OSV, S_VSO, S_ASV] -- to exclude spurious parses
  ** {} ;
