--1 Relative clauses and pronouns

abstract Relative = Cat ** {

  fun

-- The simplest way to form a relative clause is from a clause by
-- a pronoun similar to "such that".

    RelCl    : Cl -> RCl ;            -- such that John loves her

-- The more proper ways are from a verb phrase 
-- (formed in [``Verb`` Verb.html]) or a sentence 
-- with a missing noun phrase (formed in [``Sentence`` Sentence.html]).

    RelVP    : RP -> VP -> RCl ;      -- who loves John
    RelSlash : RP -> Slash -> RCl ;   -- whom John loves

-- Relative pronouns are formed from an 'identity element' by prefixing
-- or suffixing (depending on language) prepositional phrases.

    IdRP  : RP ;                      -- which
    FunRP : Prep -> NP -> RP -> RP ;  -- all the roots of which 

}

