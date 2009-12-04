--1 More syntax rules

-- This module defines syntax rules that are not implemented in all
-- languages, but in more than one, so that it makes sense to offer a
-- common API.

abstract Extra = Cat ** {

  fun
    GenNP       : NP -> Quant ;       -- this man's
    ComplBareVS : VS -> S -> VP ;     -- know you go

    StrandRelSlash   : RP -> ClSlash -> RCl ;   -- that he lives in
    EmptyRelSlash    : ClSlash -> RCl ;   -- he lives in
    StrandQuestSlash : IP -> ClSlash -> QCl ;   -- whom does John live with

-- $VP$ conjunction, which has different fragments implemented in
-- different languages - never a full $VP$, though.

  cat
    VPI ;
    [VPI] {2} ;

  fun
    MkVPI : VP -> VPI ;
    ConjVPI : Conj -> [VPI] -> VPI ;
    ComplVPIVV : VV -> VPI -> VP ;

  -- new 4/12/2009
  cat
    VPS ;
    [VPS] {2} ;

  fun
    MkVPS : Temp -> Pol -> VP -> VPS ;
    ConjVPS : Conj -> [VPS] -> VPS ;
    PredVPS : NP -> VPS -> S ;

}
