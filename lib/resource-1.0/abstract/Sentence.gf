--1 Clauses, imperatives, and sentential complements

abstract Sentence = Cat ** {

--2 Clauses

-- The $NP VP$ predication rule form a clause whose linearization
-- gives a table of all tense variants, positive and negative.
-- Clauses are converted to $S$ (with fixed tense) in [Tensed Tensed.html].

  fun
    PredVP    : NP -> VP -> Cl ;         -- John walks

-- Using an embedded sentence as a subject is treated separately.
-- This can be overgenerating. E.g. "whether you go" as subject
-- is only meaningful for some verb phrases.

    PredSCVP  : SC -> VP -> Cl ;         -- that you go makes me happy

--2 Clauses missing object noun phrases

-- This category is a variant of the 'slash category' $S/NP$ of
-- GPSG and categorial grammars, which in turn replaces
-- movement transformations in the formation of questions
-- and relative clauses. Except $SlashV2$, the construction 
-- rules can be seen as special cases of function composition, in
-- the style of CCG.
-- *Note* the set is not complete and lacks e.g. verbs with more than 2 places.

    SlashV2   : NP -> V2 -> Slash ;      -- (whom) he sees
    SlashVVV2 : NP -> VV -> V2 -> Slash; -- (whom) he wants to see 
    AdvSlash  : Slash -> Adv -> Slash ;  -- (whom) he sees tomorrow
    SlashPrep : Cl -> Prep -> Slash ;    -- (with whom) he walks 

--2 Imperatives

-- An imperative is straightforwardly formed from a verb phrase.
-- It has variation over positive and negative, singular and plural.
-- To fix these parameters, see [Phrase Phrase.html].

    ImpVP     : VP -> Imp ;              -- go

--2 Embedded sentences

-- Sentences, questions, and infinitival phrases can be used as
-- subjects and (adverbial) complements.

    EmbedS    : S  -> SC ;               -- that you go
    EmbedQS   : QS -> SC ;               -- whether you go
    EmbedVP   : VP -> SC ;               -- to go


}
