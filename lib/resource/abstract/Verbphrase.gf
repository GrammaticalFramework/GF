--!
--1 Rules for verbs and verb phrases
--
-- This module treats predications by means of deep right-branching
-- $VP$ structures, which have the advantage of conciseness but the
-- disadvantage of slow parsing due to discontinuous constituents.
--
-- The principal way of forming sentences ($S$) is by combining a noun phrase
-- with a verb phrase (the $PredVP$ rule below). In addition to this, verb
-- phrases have uses in relative clauses and questions. Verb phrases already
-- have (or have not) a negation, but they are formed from verbal groups
-- ($VG$), which have both positive and negative forms.

abstract Verbphrase = Categories ** {

-- These rules produce verb phrases.

  fun
  UseV         : V  -> VP ;               -- "walks"
  UsePassV     : V  -> VP ;               -- "is seen"
  ComplV2      : V2 -> NP -> VP ;         -- "sees Mary"
  ComplReflV2  : V2 -> VP ;               -- "loves himself"
  ComplVS      : VS -> S -> VP ;          -- "says that Mary runs"
  ComplVV      : VV -> VPI -> VP ;        -- "must walk"
  ComplVQ      : VQ -> QS -> VP ;         -- "asks who will come"
  ComplVA      : VA -> AP -> VP ;         -- "looks ill"
  ComplV2A     : V2A -> NP -> AP -> VP ;  -- "paints the house red"
  ComplSubjV2V : V2V -> NP -> VPI -> VP ; -- "promises Mary to leave"
  ComplObjV2V  : V2V -> NP -> VPI -> VP ; -- "asked him to go"
  ComplV2S     : V2S -> NP -> S   -> VP ; -- "told me that you came" 
  ComplV2Q     : V2Q -> NP -> QS  -> VP ; -- "asks me if you come"

  PredAP       : AP -> VP ;               -- "is old"
  PredSuperl   : ADeg -> VP ;             -- "is the oldest"
  PredCN       : CN -> VP ;               -- "is a man"
  PredNP       : NP -> VP ;               -- "is Bill"
  PredPP       : PP -> VP ;               -- "is in France"
  PredAV       : AV  -> VPI -> VP   ;     -- "is eager to leave"
  PredObjA2V   : A2V -> NP -> VPI -> VP ; -- "is easy for us to convince"

-- These rules *use* verb phrases. 

  PredVP       : NP -> VP -> Cl ;         -- "John walks"
  RelVP        : RP -> VP -> RCl ;        -- "who walks", "who doesn't walk"
  IntVP        : IP -> VP -> QCl ;        -- "who walks"

  PosVP, NegVP : Ant -> VP  -> VPI ;      -- to eat, not to eat

  AdvVP        : VP -> AdV -> VP ;        -- "always walks"
  SubjVP       : VP -> Subj -> S -> VP ;  -- "(a man who) sings when he runs"

}
