--1 The construction of verb phrases

abstract Verb = Cat ** {

--2 Complementization rules

-- Verb phrases are constructed from verbs by providing their
-- complements. There is one rule for each verb category.

  fun
    UseV     : V   -> VP ;        -- sleep

    ComplVV  : VV  -> VP -> VP ;  -- want to run
    ComplVS  : VS  -> S  -> VP ;  -- know that she runs
    ComplVQ  : VQ  -> QS -> VP ;  -- wonder if she runs
    ComplVA  : VA  -> AP -> VP ;  -- look red

    SlashV2a : V2        -> VPSlash ;  -- use (it)
    Slash2V3 : V3  -> NP -> VPSlash ;  -- send it (to her)
    Slash3V3 : V3  -> NP -> VPSlash ;  -- send (it) to her

    SlashV2V : V2V -> VP -> VPSlash ;  -- cause (it) to burn
    SlashV2S : V2S -> S  -> VPSlash ;  -- tell (me) that it rains
    SlashV2Q : V2Q -> QS -> VPSlash ;  -- ask (me) who came
    SlashV2A : V2A -> AP -> VPSlash ;  -- paint (it) red

    ComplSlash : VPSlash -> NP -> VP ; -- use it

    SlashVV    : VV  -> VPSlash -> VPSlash ;       -- want to give her
    SlashV2VNP : V2V -> NP -> VPSlash -> VPSlash ; -- want me to give her

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

--- Obsolete

    ComplV2  : V2  -> NP -> VP ;        -- use it
    ComplV3  : V3  -> NP -> NP -> VP ;  -- send a message to her
    ComplV2V : V2V -> NP -> VP -> VP ;  -- cause it to burn
    ComplV2S : V2S -> NP -> S  -> VP ;  -- tell me that it rains
    ComplV2Q : V2Q -> NP -> QS -> VP ;  -- ask me who came
    ComplV2A : V2A -> NP -> AP -> VP ;  -- paint it red

}
