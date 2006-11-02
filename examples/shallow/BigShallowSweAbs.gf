--# -path=.:../big:alltenses:prelude

abstract BigShallowSweAbs = 
  Shallow,
  BigLexSweAbs,
  IrregSweAbs,
  ExtraSweAbs-[
    ComplBareVS, -- : VS -> S -> VP ;     -- know you go
    MkVPI        -- : VP -> VPI ;
  ]
  ** {} ;
