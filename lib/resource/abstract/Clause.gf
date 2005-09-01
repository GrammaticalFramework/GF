--!
--1 Rules for predication forming clauses
--
-- This module treats predications in a shallow way, without right-branching
-- $VP$ structures. This has the disadvantage of duplicating rules but the
-- advantage of fast parsing due to elimination of discontinuous
-- constituents. Also the canonical GF structures (in $.gfc$) files
-- get smaller, because much more pruning of case alternatives can
-- be performed at compile time.
--
-- Each of the rules below has the following structure:
-- 
--  "Subject -> Verb -> Complements -> Clause"
-- 
-- What complements are needed depends on the type of the verb.
-- For instance, $V$ takes no complement, $V2$ takes one $NP$
-- complement, $VS$ takes an $S$ complement, etc. There is an elegant
-- way of expressing this using dependent types:
--
  --  (v : VType) -> Subj -> Verb v -> Compl v -> Clause
--
-- Since there are 12 verb types in our category system, using this
-- rule would be economical. The effect is amplified by another
-- distinction that the rules make: there are separate sets of
-- rules just differing in what type the subject and 
-- the resulting clause have. There are four different types:
--
--* $SPred$ (declarative clause, from $NP$ to $Cl$),
--* $QPred$ (interrogative clause, from $IP$ to $QCl$),
--* $RPred$ (relative clause, from $RP$ to $RCl$),
--* $IPred$ (infinitive clause, from no subject to $VCl$).
--
-- The ultimate dependent type formalization of all the 4x12 rules is
--
  --  (n : NType) -> (v : VType) -> Subj n -> Verb v -> Compl v -> Clause n
--
-- In the following, however, an expanded set of rules with no
-- dependent types is shown.

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
  SPredV2A     : NP -> V2A -> NP -> AP  -> Cl ;   -- "John paints the house red"
  SPredSubjV2V : NP -> V2V -> NP -> VPI -> Cl ;   -- "John promises Mary to leave"
  SPredObjV2V  : NP -> V2V -> NP -> VPI -> Cl ;   -- "John asks me to come"
  SPredV2S     : NP -> V2S -> NP -> S   -> Cl ;   -- "John told me that it is good"
  SPredV2Q     : NP -> V2Q -> NP -> QS  -> Cl ;   -- "John asked me if it is good"

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

  RPredV       : RP -> V  -> RCl ;                -- "who walks"
  RPredPassV   : RP -> V  -> RCl ;                -- "who is seen"
  RPredV2      : RP -> V2 -> NP -> RCl ;          -- "who sees Mary"
  RPredV3      : RP -> V3 -> NP -> NP -> RCl ;    -- "who gives Mary food"
  RPredReflV2  : RP -> V2 -> RCl ;                -- "who loves himself"
  RPredVS      : RP -> VS -> S  -> RCl ;          -- "who says that Mary runs"
  RPredVV      : RP -> VV -> VPI -> RCl ;         -- "who must walk"
  RPredVQ      : RP -> VQ -> QS -> RCl ;          -- "who asks who will come"
  RPredVA      : RP -> VA -> AP -> RCl ;          -- "who looks ill"
  RPredV2A     : RP -> V2A -> NP -> AP -> RCl ;   -- "who paints the house red"
  RPredSubjV2V : RP -> V2V -> NP -> VPI -> RCl ;  -- "who promises Mary to leave"
  RPredObjV2V  : RP -> V2V -> NP -> VPI -> RCl ;  -- "who asks me to come"
  RPredV2S     : RP -> V2S -> NP -> S   -> RCl ;  -- "who told me that it is good"
  RPredV2Q     : RP -> V2Q -> NP -> QS  -> RCl ;  -- "who asked me if it is good"

  RPredAP      : RP -> AP -> RCl ;                -- "who is old"
  RPredCN      : RP -> CN -> RCl ;                -- "who is a man"
  RPredNP      : RP -> NP -> RCl ;                -- "who is Bill"
  RPredAdv     : RP -> Adv -> RCl ;               -- "who is in France"

  RPredProgVP  : RP -> VPI -> RCl ;               -- "who is eating"

  IPredV       : V   -> VCl ;                     -- "walk"
  IPredPassV   : V   -> VCl ;                     -- "be seen"
  IPredV2      : V2  -> NP -> VCl ;               -- "see Mary"
  IPredV3      : V3  -> NP -> NP -> VCl ;         -- "give Mary food"
  IPredReflV2  : V2  -> VCl ;                     -- "love himself"
  IPredVS      : VS  -> S   -> VCl ;              -- "say that Mary runs"
  IPredVV      : VV  -> VPI -> VCl ;              -- "want to walk"
  IPredVQ      : VQ  -> QS -> VCl ;               -- "ask who will come"
  IPredVA      : VA  -> AP -> VCl ;               -- "look ill"
  IPredV2A     : V2A -> NP -> AP  -> VCl ;        -- "paint the house red"
  IPredSubjV2V : V2V -> NP -> VPI -> VCl ;        -- "promise Mary to leave"
  IPredObjV2V  : V2V -> NP -> VPI -> VCl ;        -- "ask me to come"
  IPredV2S     : V2S -> NP -> S   -> VCl ;        -- "tell me that it is good"
  IPredV2Q     : V2Q -> NP -> QS  -> VCl ;        -- "ask me if it is good"

  IPredAP      : AP -> VCl ;                      -- "be old"
  IPredCN      : CN -> VCl ;                      -- "be a man"
  IPredNP      : NP -> VCl ;                      -- "be Bill"
  IPredAdv     : Adv -> VCl ;                     -- "be in France"

  IPredProgVP  : VPI -> VCl ;                     -- "be eating"


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
