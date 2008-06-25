--# -path=.:../big:alltenses:prelude

concrete BigShallowSwe of BigShallowSweAbs = 
  ShallowSwe,
  BigLexSwe,
  IrregSwe,
  ExtraSwe-[
    ComplBareVS,MkVPI
  ]
  ** {} ;
