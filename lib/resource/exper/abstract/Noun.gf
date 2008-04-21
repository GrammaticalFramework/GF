--1 Noun: Nouns, noun phrases, and determiners

abstract Noun = Cat ** {

--2 Noun phrases

-- The three main types of noun phrases are
-- - common nouns with determiners
-- - proper names
-- - pronouns
--
--
  fun
    DetCN   : Det -> CN -> NP ;   -- the man
    UsePN   : PN -> NP ;          -- John
    UsePron : Pron -> NP ;        -- he

-- Pronouns are defined in the module [``Structural`` Structural.html].

-- A noun phrase already formed can be modified by a $Predet$erminer.

    PredetNP : Predet -> NP -> NP; -- only the man 

-- A noun phrase can also be postmodified by the past participle of a
-- verb, by an adverb, or by a relative clause

    PPartNP : NP -> V2  -> NP ;    -- the number squared
    AdvNP   : NP -> Adv -> NP ;    -- Paris at midnight
    RelNP   : NP -> RS  -> NP ;    -- Paris, which is in Europe

--2 Determiners

-- The determiner has a fine-grained structure, in which a 'nucleus'
-- quantifier and two optional parts can be discerned. 
-- The cardinal numeral is only available for plural determiners.
-- (This is modified from CLE by further dividing their $Num$ into 
-- cardinal and ordinal.)

    DetArt   : Art -> Num -> Ord -> Det ;  -- the five best men

-- Notice that $DetPl$ can still result in a singular determiner, because
-- "one" is a numeral: "this one man".

-- Quantifiers can form noun phrases directly.

    DetQuant : Quant -> Num -> Ord -> NP ;  -- these five

-- Quantifiers can also be used in the same way as articles.

    ArtQuant : Quant -> Art ;

-- Pronouns have possessive forms. Genitives of other kinds
-- of noun phrases are not given here, since they are not possible
-- in e.g. Romance languages. They can be found in
-- [``Extra`` ../abstract/Extra.gf].

    PossPron : Pron -> Art ;    -- my (house)

-- All parts of the determiner can be empty, except $Quant$, which is
-- the "kernel" of a determiner.

    NumSg  : Num ;
    NumPl  : Num ;
    NoOrd  : Ord ;

-- $Num$ consists of either digits or numeral words.

    NumDigits  : Digits -> Num ;  -- 51
    NumNumeral : Numeral -> Num ; -- fifty-one

-- The construction of numerals is defined in [Numeral Numeral.html].

-- $Num$ can  be modified by certain adverbs.

    AdNum : AdN -> Num -> Num ;   -- almost 51

-- $Ord$ consists of either digits or numeral words.

    OrdDigits  : Digits  -> Ord ; -- 51st
    OrdNumeral : Numeral -> Ord ; -- fifty-first
    
-- Superlative forms of adjectives behave syntactically in the same way as
-- ordinals.

    OrdSuperl : A -> Ord ; -- largest

-- Ordinals and cardinals can be used as noun phrases alone.

    OrdSuperlNP  : Num -> A -> NP ;  -- the five best
    OrdNumeralNP : Numeral -> NP ;   -- the fiftieth
    NumNumeralNP : Numeral -> NP ;   -- fifty

-- Definite and indefinite constructions are sometimes realized as
-- neatly distinct words (Spanish "un, unos ; el, los") but also without
-- any particular word (Finnish; Swedish definites).

    DefArt   : Art ;       -- the (house), the (houses)
    IndefArt : Art ;       -- a (house), (houses)

-- Nouns can be used without an article as mass nouns. The resource does
-- not distinguish mass nouns from other common nouns, which can result
-- in semantically odd expressions.

    MassDet  : Art ;       -- (beer)

-- Other determiners are defined in [Structural Structural.html].



--2 Common nouns

-- Simple nouns can be used as nouns outright.

    UseN : N -> CN ;              -- house

-- Relational nouns take one or two arguments.

    ComplN2 : N2 -> NP -> CN ;    -- son of the king
    ComplN3 : N3 -> NP -> N2 ;    -- flight from Moscow (to Paris)

-- Relational nouns can also be used without their arguments.
-- The semantics is typically derivative of the relational meaning.

    UseN2   : N2 -> CN ;          -- son
    UseN3   : N3 -> CN ;          -- flight

-- Nouns can be modified by adjectives, relative clauses, and adverbs
-- (the last rule will give rise to many 'PP attachment' ambiguities
-- when used in connection with verb phrases).

    AdjCN   : AP -> CN  -> CN ;   -- big house
    RelCN   : CN -> RS  -> CN ;   -- house that John owns
    AdvCN   : CN -> Adv -> CN ;   -- house on the hill

-- Nouns can also be modified by embedded sentences and questions.
-- For some nouns this makes little sense, but we leave this for applications
-- to decide. Sentential complements are defined in [Verb Verb.html].

    SentCN  : CN -> SC  -> CN ;   -- fact that John smokes, question if he does

--2 Apposition

-- This is certainly overgenerating.

    ApposCN : CN -> NP -> CN ;    -- number x, numbers x and y

} ;
