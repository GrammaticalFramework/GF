--1 More syntax rules

-- This module defines syntax rules that are not implemented in all
-- languages, but in more than one, so that it makes sense to offer a
-- common API.

abstract Extra = Cat ** {

  fun
    GenNP       : NP -> Quant ;       -- this man's
    GenIP       : IP -> IQuant ;      -- whose
    GenRP       : Num -> CN -> RP ;   -- whose car
    CompBareCN  : CN -> Comp ;        -- (est) professeur

    PiedPipingRelSlash   : RP -> ClSlash -> RCl ;   -- in which he lives
    StrandRelSlash   : RP -> ClSlash -> RCl ;   -- that he lives in
    EmptyRelSlash    : ClSlash -> RCl ;   -- he lives in
    StrandQuestSlash : IP -> ClSlash -> QCl ;   -- whom does John live with
    PiedPipingQuestSlash : IP -> ClSlash -> QCl ;   -- with whom does John live
 
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

  -- 9/4/2010

  fun
    ProDrop : Pron -> Pron ;  -- unstressed subject pronoun becomes []: "(io) sono stanco"
    ICompAP : AP -> IComp ;   -- "how old"
    IAdvAdv : Adv -> IAdv ;   -- "how often"

    CompIQuant : IQuant -> IComp ; -- which (is it) [agreement to NP]

    PrepCN : Prep -> CN -> Adv ;   -- by accident [Prep + CN without article]

  -- fronted/focal constructions, only for main clauses

  cat
    Foc ;

  fun
    FocObj : NP  -> ClSlash -> Foc ;   -- her I love
    FocAdv : Adv -> Cl      -> Foc ;   -- today I will sleep
    FocAdV : AdV -> Cl      -> Foc ;   -- never will I sleep
    FocAP  : AP  -> NP      -> Foc ;   -- green was the tree
    FocNeg : Cl             -> Foc ;   -- not is he here
    FocVP  : VP  -> NP      -> Foc ;   -- love her I do
    FocVV  : VV -> VP -> NP -> Foc ;   -- to love her I want
    
    UseFoc : Temp -> Pol -> Foc -> Utt ;

  fun
    PartVP : VP -> AP ; -- (the man) looking at Mary
    EmbedPresPart : VP -> SC ; -- looking at Mary (is fun)

-- this is a generalization of Verb.PassV2 and should replace it in the future.

    PassVPSlash : VPSlash -> VP ; -- be forced to sleep

-- the form with an agent may result in a different linearization 
-- from an adverbial modification by an agent phrase.

    PassAgentVPSlash : VPSlash -> NP -> VP ;  -- be begged by her to go

-- In many languages, the passives use past participles.

    PastPartAP      : VPSlash -> AP ;         -- lost (opportunity) ; (opportunity) lost in space
    PastPartAgentAP : VPSlash -> NP -> AP ;   -- (opportunity) lost by the company
   
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

-- to use an AP as CN without CN

    AdjAsCN : AP -> CN ; -- a green one ; en grön (Swe)

-- AR 7/6/2016
-- reflexive noun phrases: a generalization of Verb.ReflVP, which covers just reflexive pronouns
-- This is necessary in languages like Swedish, which have special reflexive possessives.
-- However, it is also needed in application grammars that want to treat "brush one's teeth" as a one-place predicate.

  cat
    RNP ;     -- reflexive noun phrase, e.g. "my family and myself"
    RNPList ; -- list of reflexives to be coordinated, e.g. "my family, myself, everyone"
    
-- Notice that it is enough for one NP in RNPList to be RNP. 

  fun
    ReflRNP : VPSlash -> RNP -> VP ;   -- support my family and myself

    ReflPron : RNP ;  -- myself
    ReflPoss : Num -> CN -> RNP ; -- my family

    PredetRNP : Predet -> RNP -> RNP ; -- all my brothers

    ConjRNP : Conj -> RNPList -> RNP ;  -- my family, John and myself

    Base_rr_RNP : RNP -> RNP -> RNPList ;       -- my family, myself 
    Base_nr_RNP : NP  -> RNP -> RNPList ;       -- John, myself
    Base_rn_RNP : RNP -> NP  -> RNPList ;       -- myself, John
    Cons_rr_RNP : RNP -> RNPList -> RNPList ;   -- my family, myself, John
    Cons_nr_RNP : NP  -> RNPList -> RNPList ;   -- John, my family, myself
----    Cons_rn_RNP : RNP -> ListNP  -> RNPList ;   -- myself, John, Mary

}
