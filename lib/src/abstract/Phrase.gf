--1 Phrase: Phrases and Utterances

abstract Phrase = Cat ** {

-- When a phrase is built from an utterance it can be prefixed
-- with a phrasal conjunction (such as "but", "therefore")
-- and suffixing with a vocative (typically a noun phrase).

  fun
    PhrUtt   : PConj -> Utt -> Voc -> Phr ; -- but come here, my friend

-- Utterances are formed from sentences, questions, and imperatives.

    UttS      : S   -> Utt ;                -- John walks
    UttQS     : QS  -> Utt ;                -- is it good
    UttImpSg  : Pol -> Imp -> Utt;          -- (don't) love yourself
    UttImpPl  : Pol -> Imp -> Utt;          -- (don't) love yourselves
    UttImpPol : Pol -> Imp -> Utt ;         -- (don't) sleep (polite)

-- There are also 'one-word utterances'. A typical use of them is
-- as answers to questions.
-- *Note*. This list is incomplete. More categories could be covered.
-- Moreover, in many languages e.g. noun phrases in different cases
-- can be used.

    UttIP   : IP   -> Utt ;                 -- who
    UttIAdv : IAdv -> Utt ;                 -- why
    UttNP   : NP   -> Utt ;                 -- this man
    UttAdv  : Adv  -> Utt ;                 -- here
    UttVP   : VP   -> Utt ;                 -- to sleep
    UttCN   : CN   -> Utt ;                 -- house

-- The phrasal conjunction is optional. A sentence conjunction
-- can also used to prefix an utterance.

    NoPConj   : PConj ;                      
    PConjConj : Conj -> PConj ;             -- and

-- The vocative is optional. Any noun phrase can be made into vocative,
-- which may be overgenerating (e.g. "I").

    NoVoc   : Voc ;
    VocNP   : NP -> Voc ;                   -- my friend

}
