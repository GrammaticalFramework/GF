abstract ResourceDemo = Lexicon, Numeral, Grammar [

-- the "mini" resource of GF book, chapter 9

-- cat
    S,     -- sentence
    Cl,    -- clause
    NP,    -- noun phrase
    VP,    -- verb phrase
    AP,    -- adjectival phrase
    CN,    -- common noun
    Det,   -- determiner
    N,     -- noun
    A,     -- adjective
    V,     -- verb (one-place, intransitive)
    V2,    -- two-place verb (two-place, transitive or prepositional)
    AdA,   -- ad-adjective
    Tense, -- tense
    Pol,   -- polarity
    Conj,  -- conjunction
    Pron, 
    Numeral,
    Interj,
    Phr,

--  fun
    UseCl  , -- Tense -> Pol -> Cl -> S,
    PredVP , -- NP -> VP -> Cl,
---    ComplV2, -- V2 -> NP -> VP,
    DetCN  , -- Det -> CN -> NP,
    UsePron,
---    ModCN  , -- AP -> CN -> CN,

---    CompAP , -- AP -> VP,
    AdAP   , -- AdA -> AP -> AP,

---    ConjS  , -- Conj -> S  -> S  -> S,
---    ConjAP , -- Conj -> AP -> AP -> AP,
---    ConjNP , -- Conj -> NP -> NP -> NP,

    UseV   , -- V -> VP,
    UseN   , -- N -> CN,
    PositA, -- A -> AP,

---    a_Det, the_Det, 
    every_Det, -- Det,
---    this_Det, these_Det, -- Det,
---    that_Det, those_Det, -- Det,
---    i_NP, youSg_NP, he_NP, she_NP, we_NP, youPl_NP, they_NP, -- NP,
    very_AdA, -- AdA,

    TTAnt, -- Tense -> Ant -> Temp ;
    PPos, PNeg, -- Pol,
    TPres, TPast, TFut, TCond, -- Tense,
    ASimul, AAnter,

    and_Conj, or_Conj, -- Conj,

-- extension of the mini grammar

--  cat
    Utt,     -- utterance (sentence or question) e.g. "does she walk"
    QS,      -- question (fixed tense)           e.g. "who doesn't walk"
    QCl,     -- question clause (variable tense) e.g. "who walks"
    ClSlash, -- clause missing noun phrase       e.g. "she walks with"
    Adv,     -- adverb                           e.g. "here"
    Prep,    -- preposition (and/or case)        e.g. "with"
    VS,      -- sentence-complement verb         e.g. "know"
    VQ,      -- question-complement verb         e.g. "wonder"
    VV,      -- verb-phrase-complement verb      e.g. "want"
    IP,      -- interrogative pronoun            e.g. "who"
    PN,      -- proper name                      e.g. "John"
    Subj,    -- subjunction                      e.g. "because"
    IAdv,    -- interrogative adverb             e.g. "why"
    IComp,

    ListAP,
    ListNP,
    ListS,
    Temp,
    Comp,
    Ant,
    Imp,

--  fun
    UttS , -- S -> Utt,
    UttQS, -- QS -> Utt,
    UttNP,
    UttCN,
    UttAdv,
    UttVP,
    UttImp,
    UttIP,
    UttIAdv,
    UttInterj,

    UseQCl, -- Tense -> Pol -> QCl -> QS,
    
    QuestCl   , -- Cl -> QCl,             -- does she walk
    QuestVP   , -- IP -> VP -> QCl,       -- who walks
    QuestSlash, -- IP -> ClSlash -> QCl,  -- who does she walk with
    QuestIAdv , -- IAdv -> Cl -> QCl,     -- why does she walk
    QuestIComp,
    CompIAdv,

    UseRCl,   -- Tense -> Pol -> RCl -> RS,
    RelVP   , -- RP -> VP -> QCl,       -- who walks
    RelSlash, -- RP -> ClSlash -> QCl,  -- who does she walk with
    RelCN, -- CN -> RS -> CN 
    IdRP, -- RP

    SubjCl, -- Cl -> Subj -> S -> Cl,     -- she walks because we run

    PrepNP , -- Prep -> NP -> Adv, -- in the house

    ComplVS, -- VS -> S  -> VP,  -- know that she walks
    ComplVQ, -- VQ -> QS -> VP,  -- wonder who walks
    ComplVV, -- VV -> VP -> VP,  -- want to walk

---    SlashV2  , -- NP -> V2 -> ClSlash,   -- she loves
---    SlashPrep, -- Cl -> Prep -> ClSlash, -- she walks with

    AdvVP, -- VP -> Adv -> VP, -- walk in the city

    UsePN, -- PN -> NP,        -- John
---    AdvNP, -- NP -> Adv -> NP, -- the man in the city

    whoSg_IP , -- IP,
    here_Adv, -- Adv,
    by_Prep, in_Prep, of_Prep, with_Prep, -- Prep,
    can_VV, must_VV, want_VV, -- VV,
    although_Subj, because_Subj, when_Subj, if_Subj, -- Subj,
    when_IAdv, where_IAdv, why_IAdv, -- IAdv,
    have_V2

] ** {

flags startcat = Phr ;


-- functions with different type

fun
   PhrUtt  : Utt -> Phr ;

   TextS   : S  -> Text ; -- with .
   TextQS  : QS -> Text ; -- with ?
   TextImp : VP -> Text ; -- with !

   ComplV2 : V2 -> NP -> VP ;
   ModCN   : AP -> CN -> CN ;
   CompAP  : AP -> VP ;
   CompCN  : CN -> VP ;
   CompNP  : NP -> VP ;
   CompAdv : Adv -> VP ;
   RConjS  : Conj -> S  -> S  -> S ;
   RConjAP : Conj -> AP -> AP -> AP ;
   RConjNP : Conj -> NP -> NP -> NP ;
   a_Det, the_Det, aPl_Det, thePl_Det : Det ; 
   this_Det, these_Det : Det ;
   that_Det, those_Det : Det ;
   possDet : Pron -> Det ;
   numeralDet : Numeral -> Det ;
   i_Pron, youSg_Pron, youPol_Pron, he_Pron, she_Pron, we_Pron, youPl_Pron, they_Pron : Pron ;
   RSubjS   : Subj -> S -> S -> S ;     -- if she walks we run
   SlashV2 : NP -> V2 -> ClSlash ;   -- she loves
   SlashPrep : Cl -> Prep -> ClSlash ; -- she walks with
   RAdvCN : CN -> Prep -> NP -> CN ; -- man in the city


}

