--!
--1 Rules for predication forming clauses
--
-- This module treats predications in a shallow way, without right-branching
-- $VP$ structures, which have the disadvantage of duplicating rules but the
-- advantage of fast parsing due to elimination of discontinuous constituents.
--
-- The principal way of forming sentences ($S$) is by combining a noun phrase
-- with a verb and its complements.

abstract Clause = Categories ** {

fun
  SPredV       : NP -> V  -> Cl ;                 -- "John walks"
  SPredPassV   : NP -> V  -> Cl ;                 -- "John is seen"
  SPredV2      : NP -> V2 -> NP -> Cl ;           -- "John sees Mary"
  SPredV3      : NP -> V3 -> NP -> NP -> Cl ;     -- "John tells Mary everything"
  SPredReflV2  : NP -> V2 -> Cl ;                 -- "John loves himself"
  SPredVS      : NP -> VS -> S  -> Cl ;           -- "John says that Mary runs"
  SPredVV      : NP -> VV -> VPI -> Cl ;          -- "John must walk"
  SPredVQ      : NP -> VQ -> QS -> Cl ;           -- "John asks who will come"
  SPredVA      : NP -> VA -> AP -> Cl ;           -- "John looks ill"
  SPredV2A     : NP -> V2A -> NP ->AP ->Cl ;      -- "John paints the house red"
  SPredSubjV2V : NP -> V2V -> NP ->VPI ->Cl ;     -- "John promises Mary to leave"
  SPredObjV2V  : NP -> V2V  -> NP -> VPI -> Cl ;  -- "John asks me to come"
  SPredV2S     : NP -> V2S  -> NP -> S   -> Cl ;  -- "John told me that it is good"
  SPredV2Q     : NP -> V2Q  -> NP -> QS  -> Cl ;  -- "John asked me if it is good"

  SPredAP      : NP -> AP -> Cl ;                 -- "John is old"
  SPredCN      : NP -> CN -> Cl ;                 -- "John is a man"
  SPredNP      : NP -> NP -> Cl ;                 -- "John is Bill"
  SPredAdv     : NP -> Adv -> Cl ;                -- "John is in France"

  SPredProgVP  : NP -> VPI -> Cl ;                -- "he is eating"

  QPredV       : IP -> V  -> QCl ;                -- "who walks"
  QPredPassV   : IP -> V  -> QCl ;                -- "who is seen"
  QPredV2      : IP -> V2 -> NP -> QCl ;          -- "who sees Mary"
  QPredV3      : IP -> V3 -> NP -> NP -> QCl ;    -- "who gives Mary food"
  QPredReflV2  : IP -> V2 -> QCl ;                -- "who loves himself"
  QPredVS      : IP -> VS -> S  -> QCl ;          -- "who says that Mary runs"
  QPredVV      : IP -> VV -> VPI -> QCl ;         -- "who must walk"
  QPredVQ      : IP -> VQ -> QS -> QCl ;          -- "who asks who will come"
  QPredVA      : IP -> VA -> AP -> QCl ;          -- "who looks ill"
  QPredV2A     : IP -> V2A -> NP ->AP ->QCl ;     -- "who paints the house red"
  QPredSubjV2V : IP -> V2V -> NP ->VPI ->QCl ;    -- "who promises Mary to leave"
  QPredObjV2V  : IP -> V2V  -> NP -> VPI -> QCl ; -- "who asks me to come"
  QPredV2S     : IP -> V2S  -> NP -> S   -> QCl ; -- "who told me that it is good"
  QPredV2Q     : IP -> V2Q  -> NP -> QS  -> QCl ; -- "who asked me if it is good"

  QPredAP      : IP -> AP -> QCl ;                -- "who is old"
  QPredCN      : IP -> CN -> QCl ;                -- "who is a man"
  QPredNP      : IP -> NP -> QCl ;                -- "who is Bill"
  QPredAdv     : IP -> Adv -> QCl ;               -- "who is in France"

  QPredProgVP  : IP -> VPI -> QCl ;               -- "who is eating"

  IPredV       : Ant -> V  -> VPI ;               -- "walk"
  IPredPassV   : Ant -> V  -> VPI ;               -- "be seen"
  IPredV2      : Ant -> V2 -> NP -> VPI ;         -- "see Mary"
  IPredV3      : Ant -> V3 -> NP -> NP -> VPI ;   -- "give Mary food"
  IPredReflV2  : Ant -> V2 -> VPI ;               -- "love himself"
  IPredVS      : Ant -> VS -> S  -> VPI ;         -- "say that Mary runs"
  IPredVV      : Ant -> VV -> VPI -> VPI ;        -- "want to walk"
  IPredVQ      : Ant -> VQ -> QS -> VPI ;         -- "ask who will come"
  IPredVA      : Ant -> VA -> AP -> VPI ;         -- "look ill"
  IPredV2A     : Ant -> V2A -> NP ->AP ->VPI ;    -- "paint the house red"
  IPredSubjV2V : Ant -> V2V -> NP ->VPI ->VPI ;   -- "promise Mary to leave"
  IPredObjV2V  : Ant -> V2V  -> NP -> VPI ->VPI ; -- "ask me to come"
  IPredV2S     : Ant -> V2S  -> NP -> S  -> VPI ; -- "tell me that it is good"
  IPredV2Q     : Ant -> V2Q  -> NP -> QS -> VPI ; -- "ask me if it is good"

  IPredAP      : Ant -> AP -> VPI ;               -- "be old"
  IPredCN      : Ant -> CN -> VPI ;               -- "be a man"
  IPredNP      : Ant -> NP -> VPI ;               -- "be Bill"
  IPredAdv     : Ant -> Adv -> VPI ;              -- "be in France"

  IPredProgVP  : Ant -> VPI -> VPI ;              -- "be eating"


{-
-- These rules *use* verb phrases. 

  PredVP       : NP -> VP -> Cl ;         -- "John walks"
  RelVP        : RP -> VP -> RCl ;        -- "who walks", "who doesn't walk"
  IntVP        : IP -> VP -> QCl ;        -- "who walks"

  PosVP, NegVP : Ant -> VP  -> VPI ;      -- to eat, not to eat

  AdvVP        : VP -> AdV -> VP ;        -- "always walks"
  SubjVP       : VP -> Subj -> S -> VP ;  -- "(a man who) sings when he runs"
-}

} ;
