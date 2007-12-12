--1 The construction of verb phrases

abstract Verb = Cat ** {

--2 Complementization rules

-- Verb phrases are constructed from verbs by providing their
-- complements. There is one rule for each verb category.

  fun
    UseV     : V   -> VP ;              -- sleep
    ComplV2  : V2  -> NP -> VP ;        -- use it
    ComplV3  : V3  -> NP -> NP -> VP ;  -- send a message to her

    ComplVV  : VV  -> VP -> VP ;        -- want to run
    ComplVS  : VS  -> S  -> VP ;        -- know that she runs
    ComplVQ  : VQ  -> QS -> VP ;        -- ask if she runs

    ComplVA  : VA  -> AP -> VP ;        -- look red
    ComplV2A : V2A -> NP -> AP -> VP ;  -- paint the house red

--2 Other ways of forming verb phrases

-- Verb phrases can also be constructed reflexively and from
-- copula-preceded complements.

    ReflV2   : V2 -> VP ;               -- use itself
    UseComp  : Comp -> VP ;             -- be warm

-- Passivization of two-place verbs is another way to use
-- them. In many languages, the result is a participle that
-- is used as complement to a copula ("is used"), but other
-- auxiliary verbs are possible (Ger. "wird angewendet", It.
-- "viene usato"), as well as special verb forms (Fin. "käytetään",
-- Swe. "används").
--
-- *Note*. the rule can be overgenerating, since the $V2$ need not
-- take a direct object.

    PassV2   : V2 -> VP ;               -- be used

-- Adverbs can be added to verb phrases. Many languages make
-- a distinction between adverbs that are attached in the end
-- vs. next to (or before) the verb.

    AdvVP    : VP -> Adv -> VP ;        -- sleep here
    AdVVP    : AdV -> VP -> VP ;        -- always sleep

-- *Agents of passives* are constructed as adverbs with the
-- preposition [Structural Structural.html]$.8agent_Prep$.


--2 Complements to copula

-- Adjectival phrases, noun phrases, and adverbs can be used.

    CompAP   : AP  -> Comp ;            -- (be) small
    CompNP   : NP  -> Comp ;            -- (be) a soldier
    CompAdv  : Adv -> Comp ;            -- (be) here

--2 Coercions

-- Verbs can change subcategorization patterns in systematic ways,
-- but this is very much language-dependent. The following two
-- work in all the languages we cover.

    UseVQ   : VQ -> V2 ;                -- ask (a question)
    UseVS   : VS -> V2 ;                -- know (a secret)

}
