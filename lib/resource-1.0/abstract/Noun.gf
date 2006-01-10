--1 The construction of nouns, noun phrases, and determiners

abstract Noun = Cat ** {

  fun

--2 Noun phrases

-- The three main types of noun phrases are
-- - common nouns with determiners
-- - proper names
-- - pronouns
--
--
    DetCN   : Det -> CN -> NP ;   -- the man
    UsePN   : PN -> NP ;          -- John
    UsePron : Pron -> NP ;        -- he

-- Pronouns are given in the module [Structural Structural.html].


--2 Determiners

-- The determiner has a fine-grained structure, in which four
-- different optional parts can be discerned. The noun phrase
-- "all my first forty books" shows each of these parts.
-- The cardinal numeral is only available for plural determiners.
-- (This is modified from CLE by further dividing their $Num$ into 
-- cardinal and ordinal.)

    DetSg : Predet -> QuantSg ->        Ord -> Det ;
    DetPl : Predet -> QuantPl -> Num -> Ord -> Det ;

-- Pronouns have possessive forms. Genitives of other kinds
-- of noun phrases are not given here, since they are not possible
-- in e.g. Romance languages.

    PossSg : Pron -> QuantSg ;    -- my (house)
    PossPl : Pron -> QuantPl ;    -- my (houses)

-- All parts of the determiner can be empty, except $Quant$, which is
-- the "kernel" of a determiner.

    NoPredet : Predet ;
    NoNum    : Num ;
    NoOrd    : Ord ;

-- $Num$ consists of either digits or numeral words.

    NumInt     : Int -> Num ;     -- 51
    NumNumeral : Numeral -> Num ; -- fifty-one

-- The construction of numerals is defined in [Numeral Numeral.html].

-- $Num$ can  be modified by certain adverbs.

    AdNum : AdN -> Num -> Num ;   -- almost 51

-- $Ord$ consists of either digits or numeral words.

    OrdInt     : Int -> Ord ;     -- 51st
    OrdNumeral : Numeral -> Ord ; -- fifty-first
    
-- Superlative forms of adjectives behave syntactically in the same way as
-- ordinals.

    OrdSuperl : A -> Ord ;        -- largest

-- Definite and indefinite constructions are sometimes realized as
-- neatly distinct words (Spanish "un, unos ; el, los") but also without
-- any particular word (Finnish; Swedish definites).

    DefSg   : QuantSg ;           -- the (house)
    DefPl   : QuantPl ;           -- the (houses)
    IndefSg : QuantSg ;           -- a (house)
    IndefPl : QuantPl ;           -- (houses)

-- Nouns can be used without an article as mass nouns. The resource does
-- not distinguish mass nouns from other common nouns, which can result
-- in semantically odd expressions.

    MassDet : QuantSg ;           -- (beer)

-- Other determiners are defined in [Structural Structural.html].



--2 Common nouns

-- Simple nouns can be used as nouns outright.

    UseN : N -> CN ;              -- house

-- Relational nouns take one or two arguments.

    ComplN2 : N2 -> NP -> CN ;    -- son of the king
    ComplN3 : N3 -> NP -> N2 ;    -- flight from Moscow (to Paris)

-- Relational nouns can also be used without their arguments.
-- The semantics is typically derivative of the relational meaning.

    UseN2 : N2 -> CN ;            -- son
    UseN3 : N3 -> CN ;            -- flight

-- Nouns can be modified by adjectives and relative clauses.

    AdjCN   : AP -> CN -> CN ;    -- big house
    RelCN   : CN -> RS -> CN ;    -- house that John owns

-- Nouns can also be modified by embedded sentences and questions.
-- For some nouns this makes little sense, but we leave this for applications
-- to decide.

    SentCN  : CN -> S  -> CN ;    -- fact that John smokes
    QuestCN : CN -> QS -> CN ;    -- question whether John smokes

} ;
