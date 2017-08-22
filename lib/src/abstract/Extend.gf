--1 Extensions of core RGL syntax (the Grammar module)

-- This module defines syntax rules that are not yet implemented in all
-- languages, and perhaps never implementable either. But all rules are given
-- a default implementation in common/ExtendFunctor.gf so that they can be included
-- in the library API. The default implementations are meant to be overridden in each
-- xxxxx/ExtendXxx.gf when the work proceeds.
--
-- This module is aimed to replace the original Extra.gf, which is kept alive just
-- for backwardcommon compatibility. It will also replace translator/Extensions.gf
-- and thus eliminate the often duplicated work in those two modules.
--
-- (c) Aarne Ranta 2017-08-20 under LGPL and BSD


abstract Extend = Cat ** {

  fun
    GenNP       : NP -> Quant ;       -- this man's
    GenIP       : IP -> IQuant ;      -- whose
    GenRP       : Num -> CN -> RP ;   -- whose car

-- In case the first two are not available, the following applications should in any case be.

    GenModNP    : Num -> NP -> CN -> NP ; -- this man's car(s)
    GenModIP    : Num -> IP -> CN -> IP ; -- whose car(s)

    CompBareCN  : CN -> Comp ;        -- (est) professeur

    StrandQuestSlash     : IP -> ClSlash -> QCl ;   -- whom does John live with
    StrandRelSlash       : RP -> ClSlash -> RCl ;   -- that he lives in
    EmptyRelSlash        : ClSlash       -> RCl ;   -- he lives in
 

-- $VP$ conjunction, covering both finite and infinitive forms (formerly VPI and VPS).

  cat
    VPS ;
    [VPS] {2} ;

  fun
    MkVPS      : Temp -> Pol -> VP -> VPS ;  -- to sleep / hasn't slept
    ConjVPS    : Conj -> [VPS] -> VPS ;      -- has walked and won't sleep
    PredVPS    : NP   -> VPS -> S ;          -- she [has walked and won't sleep]
    ComplVPSVV : VV   -> VPS -> VP ;         -- want to sleep and to walk

-- in case ComplVPSVV is not available:

    PredVPSVV  : NP -> VV -> VPS -> VP ;     -- she wants to sleep and to walk


  fun
    ProDrop : Pron -> Pron ;  -- unstressed subject pronoun becomes []: "(io) sono stanco"
    
    ICompAP : AP -> IComp ;   -- "how old"
    IAdvAdv : Adv -> IAdv ;   -- "how often"

    CompIQuant : IQuant -> IComp ;   -- which (is it) [agreement to NP]

    PrepCN     : Prep -> CN -> Adv ; -- by accident [Prep + CN without article]

  -- fronted/focal constructions, only for main clauses

  fun
    FocusObj : NP  -> SSlash  -> Utt ;   -- her I love
    FocusAdv : Adv -> S       -> Utt ;   -- today I will sleep
    FocusAdV : AdV -> S       -> Utt ;   -- never will I sleep
    FocusAP  : AP  -> NP      -> Utt ;   -- green was the tree

  -- participle constructions
    PresPartAP    : VP -> AP ;   -- (the man) looking at Mary
    EmbedPresPart : VP -> SC ;   -- looking at Mary (is fun)
    
    PastPartAP      : VPSlash -> AP ;         -- lost (opportunity) ; (opportunity) lost in space
    PastPartAgentAP : VPSlash -> NP -> AP ;   -- (opportunity) lost by the company
   
-- this is a generalization of Verb.PassV2 and should replace it in the future.

    PassVPSlash : VPSlash -> VP ; -- be forced to sleep

-- the form with an agent may result in a different linearization 
-- from an adverbial modification by an agent phrase.

    PassAgentVPSlash : VPSlash -> NP -> VP ;  -- be begged by her to go

-- publishing of the document

    NominalizeVPSlashNP : VPSlash -> NP -> NP ;

-- existential for mathematics

    ExistsNP : NP -> Cl ;  -- there exists a number / there exist numbers

-- infinitive for purpose AR 21/8/2013

    PurposeVP : VP -> Adv ;  -- to become happy

-- object S without "that"

    ComplBareVS  : VS  -> S  -> VP ;       -- say she runs
    SlashBareV2S : V2S -> S  -> VPSlash ;  -- answer (to him) it is good

-- front the extraposed part

    FrontExtPredVP : NP -> VP -> Cl ;      -- I am here, she said
    InvFrontExtPredVP : NP -> VP -> Cl ;   -- I am here, said she

-- to use an AP as CN or NP without CN

    AdjAsCN : AP -> CN ;   -- a green one ; en grön (Swe)
    AdjAsNP : AP -> NP ;   -- green (is good)

-- reflexive noun phrases: a generalization of Verb.ReflVP, which covers just reflexive pronouns
-- This is necessary in languages like Swedish, which have special reflexive possessives.
-- However, it is also needed in application grammars that want to treat "brush one's teeth" as a one-place predicate.

  cat
    RNP ;     -- reflexive noun phrase, e.g. "my family and myself"
    RNPList ; -- list of reflexives to be coordinated, e.g. "my family, myself, everyone"
    
-- Notice that it is enough for one NP in RNPList to be RNP. 

  fun
    ReflRNP : VPSlash -> RNP -> VP ;   -- love my family and myself

    ReflPron : RNP ;                   -- myself
    ReflPoss : Num -> CN -> RNP ;      -- my car(s)

    PredetRNP : Predet -> RNP -> RNP ; -- all my brothers

    ConjRNP : Conj -> RNPList -> RNP ;  -- my family, John and myself

    Base_rr_RNP : RNP -> RNP -> RNPList ;       -- my family, myself 
    Base_nr_RNP : NP  -> RNP -> RNPList ;       -- John, myself
    Base_rn_RNP : RNP -> NP  -> RNPList ;       -- myself, John
    Cons_rr_RNP : RNP -> RNPList -> RNPList ;   -- my family, myself, John
    Cons_nr_RNP : NP  -> RNPList -> RNPList ;   -- John, my family, myself
----    Cons_rn_RNP : RNP -> ListNP  -> RNPList ;   -- myself, John, Mary


--- from Extensions

  ComplGenVV  : VV -> Ant -> Pol -> VP  -> VP ;         -- want not to have slept
  SlashV2V    : V2V -> Ant -> Pol -> VPS -> VPSlash ;   -- force (her) not to have slept

  CompoundN   : N -> N  -> N ;      -- control system / controls system / control-system
  CompoundAP  : N -> A  -> AP ;     -- language independent / language-independent

  GerundCN    : VP -> CN ;          -- publishing of the document (can get a determiner)
  GerundNP    : VP -> NP ;          -- publishing the document (by nature definite)
  GerundAdv   : VP -> Adv ;         -- publishing the document (prepositionless adverb)

  WithoutVP   : VP -> Adv ;         -- without publishing the document  
  ByVP        : VP -> Adv ;         -- by publishing the document  
  InOrderToVP : VP -> Adv ;         -- (in order) to publish the document

  ApposNP : NP -> NP -> NP ;        -- Mr Macron, the president of France,

  AdAdV       : AdA -> AdV -> AdV ;           -- almost always
  UttAdV      : AdV -> Utt ;                  -- always(!)
  PositAdVAdj : A -> AdV ;                    -- (that she) positively (sleeps)

  CompS       : S -> Comp ;                   -- (the fact is) that she sleeps
  CompQS      : QS -> Comp ;                  -- (the question is) who sleeps
  CompVP      : Ant -> Pol -> VP -> Comp ;    -- (she is) to go

-- very language-specific things

-- Eng
  UncontractedNeg : Pol ;      -- do not, etc, as opposed to don't
  UttVPShort : VP -> Utt ;     -- have fun, as opposed to "to have fun"
  ComplSlashPartLast : VPSlash -> NP -> VP ;

-- Romance
  DetNPFem : Det -> NP ;
  
  iFem_Pron      : Pron ; -- je (suis vieille)
  youFem_Pron    : Pron ; -- tu (es vieille)
  weFem_Pron     : Pron ; -- nous (sommes vieilles)
  youPlFem_Pron  : Pron ; -- vous (êtes vieilles)
  theyFem_Pron   : Pron ; -- elles (sont vieilles)
  youPolFem_Pron : Pron ; -- vous (êtes vieille)

-- German
  UttAccNP : NP -> Utt ; -- him (accusative)
  UttDatNP : NP -> Utt ; -- him (dative)
  UttAccIP : NP -> Utt ; -- whom (accusative)
  UttDatIP : NP -> Utt ; -- whom (dative)

}
