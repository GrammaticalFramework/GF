--1 Topological structure of Scandinavian sentences.
--
-- This is an alternative, more 'native' analysis than $Clause$ and
-- $Verbphrase$, due to Diderichsen.
--
-- Sources:
--   N. Jörgensen & J. Svensson, "Nusvensk grammatik" (Gleerups, 2001);
--   R. Zola Christensen, "Dansk grammatik for svenskere"
--   (Studentlitteratur 1999).

abstract Sats = Categories ** {

-- Idea: form primarily a $Sats$, which can then be lifted to a $Cl$
-- and used elsewhere in grammar.

  cat Sats ;

  fun
  ClSats : Sats -> Cl ;

-- There will be $Sats$-forming functions for all subcategorization
-- patterns of verbs.

  SatsV   : NP -> V  -> Sats ;
  SatsV2  : NP -> V2 -> NP -> Sats ;
  SatsV3  : NP -> V3 -> NP -> NP -> Sats ;
  SatsReflV2 : NP -> V2 -> Sats ;
  SatsVS  : NP -> VS -> S -> Sats ;
  SatsVQ  : NP -> VQ -> QS -> Sats ;
  SatsV2S : NP -> V2S -> NP -> S -> Sats ;
  SatsV2Q : NP -> V2Q -> NP -> QS -> Sats ;

  SatsAP  : NP -> AP -> Sats ;
  SatsCN  : NP -> CN -> Sats ;
  SatsNP  : NP -> NP -> Sats ;
  SatsAdv : NP -> Adv -> Sats ;

-- To a $Sats$, you can insert a sentence adverbial ($AdV$, e.g. "ändå") or
-- 'TSR' adverbial ($Adv$, e.g. "nu"; the name TSR is from Jörgensen
-- and Svensson).

  AdVSats : Sats -> AdV -> Sats ;
  AdvSats : Sats -> Adv -> Sats ;

-- We can also insert a verb-complement verb.

  VVSats  : Sats -> VV -> Sats ;

}
