--1 More syntax rules

-- This module defines syntax rules that are not implemented in all
-- languages, but in more than one, so that it makes sense to offer a
-- common API.

abstract Extra = Cat ** {

  fun
    GenNP       : NP -> Quant ;       -- this man's
    EmbedBareS  : S -> SC ;           -- (I know) you go
    ComplBareVS : VS -> S -> VP ;     -- know you go

}