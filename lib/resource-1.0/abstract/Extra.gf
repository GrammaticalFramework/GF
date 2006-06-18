--1 More syntax rules

-- This module defines syntax rules that are not implemented in all
-- languages, but in more than one, so that it makes sense to offer a
-- common API.

abstract Extra = Cat ** {

  fun
    GenNP       : NP -> Quant ;       -- this man's
    ComplBareVS : VS -> S -> VP ;     -- know you go

    StrandRelSlash   : RP -> Slash -> RCl ;   -- that he lives in
    EmptyRelSlash    : RP -> Slash -> RCl ;   -- he lives in
    StrandQuestSlash : IP -> Slash -> QCl ;   -- whom does John live with

}
