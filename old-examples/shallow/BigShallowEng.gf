--# -path=.:../big:alltenses:prelude

concrete BigShallowEng of BigShallowEngAbs = 
  ShallowEng,
  BigLexEng,
--  IrregEng,
  ExtraEng-[
    ComplBareVS,MkVPI
  ]
  ** {} ;
