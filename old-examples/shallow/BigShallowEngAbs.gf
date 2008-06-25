--# -path=.:../big:alltenses:prelude

abstract BigShallowEngAbs = 
  Shallow,
  BigLexEngAbs,
--  IrregEngAbs,
  ExtraEngAbs-[
    ComplBareVS, -- : VS -> S -> VP ;     -- know you go
    MkVPI        -- : VP -> VPI ;
  ]
  ** {} ;
