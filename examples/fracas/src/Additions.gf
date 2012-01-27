--# -path=.:alltenses

-- Additions to the resource grammar

abstract Additions = Cat ** {

-- First we start with the contents of the RGL's Extra.gf, as it looked like in October 2011.

fun
  GenNP       : NP -> Quant ;       -- this man's
  ComplBareVS : VS -> S -> VP ;     -- know you go

  StrandRelSlash   : RP -> ClSlash -> RCl ;   -- that he lives in
  EmptyRelSlash    : ClSlash -> RCl ;   -- he lives in

cat
  VPI ;
  [VPI] {2} ;

fun
  MkVPI : VP -> VPI ;
  ConjVPI : Conj -> [VPI] -> VPI ;
  ComplVPIVV : VV -> VPI -> VP ;

cat
  VPS ;
  [VPS] {2} ;

fun
  MkVPS : Temp -> Pol -> VP -> VPS ;
  ConjVPS : Conj -> [VPS] -> VPS ;
  PredVPS : NP -> VPS -> S ;

fun
  PartVP : VP -> AP ; -- (the man) looking at Mary
  EmbedPresPart : VP -> SC ; -- looking at Mary (is fun)

  PassVPSlash : VPSlash -> VP ; -- be forced to sleep

-- And then we give some FraCaS-specific additions to the original Extra.gf.

cat
  [QS]{2} ;
  [Det]{2} ;

fun
  -- NP relative phrases, without comma
  RelNPa : NP -> RS -> NP ;

  -- just to overcome a bug in AdjectiveScand.gf
  UseComparA_prefix : A -> AP ;

  -- s-form passive
  PassV2s : V2 -> VP ;

  -- idiom "so do I", "so did she"
  SoDoI : NP -> Cl ;

  -- as ExtAdvS, but for questions
  ExtAdvQS : Adv -> QS  -> QS ;

  -- question conjunction
  ConjQS : Conj -> [QS] -> QS ;

  -- determiner conjunction
  ConjDet : Conj -> [Det] -> Det ;

  -- -- possible additional functions:
  -- AdVAdv : Adv -> AdV ;
  -- PassV2V : V2V -> VV ;
  -- ComplVPIV2V : V2V -> VPI -> VPSlash ;
  -- ComplVV : VV -> VP -> VP ;
  -- ComparAdvNoun : CAdv -> CN -> NP -> NP ;
  -- ComparAdvNounS : CAdv -> CN -> S -> NP ;
  -- ConjVPSlash : Conj -> VPSlash -> VPSlash -> VPSlash ;

}
