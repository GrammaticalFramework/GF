--1 Constructors: the Resource Syntax API --# notminimal

incomplete resource Constructors = open Grammar in {  

  flags optimize=noexpand ;  

-- This module gives access to the syntactic constructions of the
-- GF Resource Grammar library. Its main principle is simple:
-- to construct an object of type $C$, use the function $mkC$.
--
-- For example, an object of type $S$ corresponding to the string
--
-- $John loves Mary$
--
-- is written
--
-- $mkS (mkCl (mkNP (mkPN "John")) (mkV2 "love") (mkNP (mkPN "Mary")))$
--
-- This module defines the syntactic constructors, which take trees as arguments.
-- Lexical constructors, which take strings as arguments, are defined in the
-- $Paradigms$ modules separately for each language.
--
-- The recommended usage of this module is via the wrapper module $Syntax$, 
-- which also contains the $Structural$ (structural words). 
-- Together with $Paradigms$, $Syntax$ gives everything that is needed
-- to implement the concrete syntax for a langauge.

--2 Principles of organization --# notminimal

-- To make the library easier to grasp and navigate, we have followed
-- a set of principles when organizing it:
-- + Each category $C$ has an overloaded constructor $mkC$, with value type $C$.
-- + With $mkC$, it is possible to construct any tree of type $C$, except
--   atomic ones, i.e. those that take no arguments, and
--   those whose argument types are exactly the same as in some other instance
-- + To achieve completeness, the library therefore also has
--   for each atomic tree of type $C$, a constant suffixed $C$, and,
--   for other missing constructions, some operation suffixed $C$.
--   These constructors are listed immediately after the $mkC$ group.
-- + Those atomic constructors that are given in $Structural$ are not repeated here.
-- + In addition to the minimally complete set of constructions, many $mkC$ groups
--   include some frequently needed special cases, with two possible logics:
--   default value (to decrease the number of arguments), and
--   direct arguments of an intervening constructor (to flatten the terms).
-- + If such a special case is applied to some category in some rule, it is
--   also applied to all other rules in which the category appears.
-- + The constructors in a group are listed, roughly, 
--   *from the most common to the most general*. This does not of course specify
--   a total order. 
-- + Optional argument types are marked in parentheses. Although parentheses make no
--   difference in the way the GF compiler treats the types, their presence indicates
--   to the reader that the corresponding arguments can be left out; internally, the
--   library has an overload case for each such combination.
-- + Each constructor case is equipped with an example that is built by that
--   case but could not be built with any other one.
--
--

--2 Texts, phrases, and utterances --# notminimal

--3 Text: texts --# notminimal

-- A text is a list of phrases separated by punctuation marks.
-- The default punctuation mark is the full stop, and the default
-- continuation of a text is empty.

  oper   
    mkText : overload { --# notminimal
      mkText : Phr ->                      Text ; -- 1. But John walks. --# notminimal
      mkText : Phr -> (Punct) -> (Text) -> Text ; -- 2. John walks? Yes. --# notminimal

-- A text can also be directly built from utterances, which in turn can
-- be directly built from sentences, present-tense clauses, questions, or
-- positive imperatives. 

      mkText : Utt ->  Text ;  -- 3. John. --# notminimal
      mkText : S   ->  Text ;  -- 4. John walked. --# notminimal
      mkText : Cl  ->  Text ;  -- 5. John walks. --# notminimal
      mkText : QS  ->  Text ;  -- 6. Did John walk? --# notminimal
      mkText : Imp ->  Text ;  -- 7. Walk! --# notminimal

-- Finally, two texts can be combined into a text.

      mkText : Text -> Text -> Text ;  -- 8. Where? When? Here. Now! --# notminimal

      } ; --# notminimal

-- A text can also be empty.

      emptyText :      Text ;  -- 8. (empty text) --# notminimal


--3 Punct: punctuation marks --# notminimal

-- There are three punctuation marks that can separate phrases in a text.

      fullStopPunct  : Punct ;  -- . --# notminimal
      questMarkPunct : Punct ;  -- ? --# notminimal
      exclMarkPunct  : Punct ;  -- ! --# notminimal

--3 Phr: phrases in a text --# notminimal

-- Phrases are built from utterances by adding a phrasal conjunction
-- and a vocative, both of which are by default empty.

    mkPhr : overload { --# notminimal
      mkPhr :            Utt ->          Phr ;  -- 1. why --# notminimal
      mkPhr : (PConj) -> Utt -> (Voc) -> Phr ;  -- 2. but why John --# notminimal


-- A phrase can also be directly built by a sentence, a present-tense
-- clause, a question, or a positive singular imperative. 

      mkPhr : S   ->  Phr ; -- 3. John walked --# notminimal
      mkPhr : Cl  ->  Phr ; -- 4. John walks --# notminimal
      mkPhr : QS  ->  Phr ; -- 5. did John walk --# notminimal
      mkPhr : Imp ->  Phr   -- 6. walk --# notminimal
      } ; --# notminimal

--3 PConj, phrasal conjunctions --# notminimal

-- Any conjunction can be used as a phrasal conjunction.
-- More phrasal conjunctions are defined in $Structural$.

      mkPConj : Conj -> PConj ;  -- 1. and --# notminimal

--3 Voc, vocatives --# notminimal

-- Any noun phrase can be turned into a vocative.
-- More vocatives are defined in $Structural$.

      mkVoc : NP -> Voc ;   -- 1. John --# notminimal

--3 Utt, utterances --# notminimal

-- Utterances are formed from sentences, clauses, questions, and positive singular imperatives.

    mkUtt : overload { --# notminimal
      mkUtt : S   -> Utt ;  -- 1. John walked --# notminimal
      mkUtt : Cl  -> Utt ;  -- 2. John walks --# notminimal
      mkUtt : QS  -> Utt ;  -- 3. did John walk --# notminimal
      mkUtt : QCl -> Utt ;  -- 4. does John walk --# notminimal
      mkUtt : Imp -> Utt ;  -- 5. love yourself --# notminimal

-- Imperatives can also vary in $ImpForm$ (number/politeness) and 
-- polarity.

      mkUtt : (ImpForm) -> (Pol) -> Imp -> Utt ;  -- 5. don't love yourselves --# notminimal

-- Utterances can also be formed from interrogative phrases and
-- interrogative adverbials, noun phrases, adverbs, and verb phrases.

      mkUtt : IP   ->  Utt ;  -- 6. who --# notminimal
      mkUtt : IAdv ->  Utt ;  -- 7. why --# notminimal
      mkUtt : NP   ->  Utt ;  -- 8. John --# notminimal
      mkUtt : Adv  ->  Utt ;  -- 9. here --# notminimal
      mkUtt : VP   ->  Utt    -- 10. to walk --# notminimal
      } ; --# notminimal

-- The plural first-person imperative is a special construction.

      lets_Utt : VP ->  Utt ;  -- 11. let's walk --# notminimal


--2 Auxiliary parameters for phrases and sentences --# notminimal

--3 Pol, polarity --# notminimal

-- Polarity is a parameter that sets a clause to positive or negative
-- form. Since positive is the default, it need never be given explicitly.

      positivePol : Pol ;  -- (John walks) [default] --# notminimal
      negativePol : Pol ;  -- (John doesn't walk) --# notminimal

--3 Ant, anteriority --# notminimal

-- Anteriority is a parameter that presents an event as simultaneous or
-- anterior to some other reference time.
-- Since simultaneous is the default, it need never be given explicitly.

      simultaneousAnt : Ant ;  -- (John walks) [default] --# notminimal
      anteriorAnt     : Ant ;  -- (John has walked)       --# notpresent --# notminimal

--3 Tense, tense --# notminimal

-- Tense is a parameter that relates the time of an event 
-- to the time of speaking about it.
-- Since present is the default, it need never be given explicitly.

      presentTense     : Tense ; -- (John walks) [default] --# notminimal
      pastTense        : Tense ; -- (John walked)           --# notpresent --# notminimal
      futureTense      : Tense ; -- (John will walk)        --# notpresent --# notminimal
      conditionalTense : Tense ; -- (John would walk)       --# notpresent --# notminimal

--3 ImpForm, imperative form --# notminimal

-- Imperative form is a parameter that sets the form of imperative
-- by reference to the person or persons addressed.
-- Since singular is the default, it need never be given explicitly.

      singularImpForm : ImpForm ;  -- (help yourself) [default] --# notminimal
      pluralImpForm   : ImpForm ;  -- (help yourselves) --# notminimal
      politeImpForm   : ImpForm ;  -- (help yourself) (polite singular) --# notminimal


--2 Sentences and clauses --# notminimal

--3 S, sentences --# notminimal

-- A sentence has a fixed tense, anteriority and polarity.

    mkS : overload { --# notminimal
      mkS :                              Cl -> S ;  -- 1. John walks --# notminimal
      mkS : (Tense) -> (Ant) -> (Pol) -> Cl -> S ;  -- 2. John wouldn't have walked --# notminimal

-- Sentences can be combined with conjunctions. This can apply to a pair
-- of sentences, but also to a list of more than two.

      mkS : Conj -> S -> S -> S ;  -- 3. John walks and I run    --# notminimal
      mkS : Conj -> ListS  -> S ;  -- 4. John walks, I run and you sleep --# notminimal

-- A sentence can be prefixed by an adverb.

      mkS : Adv -> S -> S           -- 5. today, John walks --# notminimal
      } ; --# notminimal

--3 Cl, clauses --# notminimal

-- A clause has a variable tense, anteriority and polarity.
-- A clause can be built from a subject noun phrase 
-- with a verb and appropriate arguments.

    mkCl : overload { --# notminimal
      mkCl : NP  -> V  ->             Cl ;  -- 1. John walks --# notminimal
      mkCl : NP  -> V2 -> NP ->       Cl ;  -- 2. John loves her --# notminimal
      mkCl : NP  -> V3 -> NP -> NP -> Cl ;  -- 3. John sends it to her --# notminimal
      mkCl : NP  -> VV -> VP ->       Cl ;  -- 4. John wants to walk  --# notminimal
      mkCl : NP  -> VS -> S  ->       Cl ;  -- 5. John says that it is good --# notminimal
      mkCl : NP  -> VQ -> QS ->       Cl ;  -- 6. John wonders if it is good --# notminimal
      mkCl : NP  -> VA -> AP ->       Cl ;  -- 7. John becomes old --# notminimal
      mkCl : NP  -> V2A -> NP -> AP -> Cl ; -- 8. John paints it red --# notminimal
      mkCl : NP  -> V2S -> NP -> S -> Cl ;  -- 9. John tells her that we are here --# notminimal
      mkCl : NP  -> V2Q -> NP -> QS -> Cl ; -- 10. John asks her who is here --# notminimal
      mkCl : NP  -> V2V -> NP -> VP -> Cl ; -- 11. John forces us to sleep --# notminimal
      mkCl : NP  -> A  ->             Cl ;  -- 12. John is old --# notminimal
      mkCl : NP  -> A  -> NP ->       Cl ;  -- 13. John is older than her --# notminimal
      mkCl : NP  -> A2 -> NP ->       Cl ;  -- 14. John is married to her --# notminimal
      mkCl : NP  -> AP ->             Cl ;  -- 15. John is very old --# notminimal
      mkCl : NP  -> N  ->             Cl ;  -- 16. John is a man --# notminimal
      mkCl : NP  -> CN ->             Cl ;  -- 17. John is an old man --# notminimal
      mkCl : NP  -> NP ->             Cl ;  -- 18. John is the man --# notminimal
      mkCl : NP  -> Adv ->            Cl ;  -- 19. John is here --# notminimal

-- As the general rule, a clause can be built from a subject noun phrase and 
-- a verb phrase.

      mkCl : NP  -> VP -> Cl ;  -- 20. John walks here --# notminimal

-- Subjectless verb phrases are used for impersonal actions.

      mkCl : V   ->  Cl ;  -- 21. it rains --# notminimal
      mkCl : VP  ->  Cl ;  -- 22. it is raining --# notminimal

-- Existentials are a special form of clauses.

      mkCl : N   ->  Cl ;  -- 23. there is a house --# notminimal
      mkCl : CN  ->  Cl ;  -- 24. there is an old houses --# notminimal
      mkCl : NP  ->  Cl ;  -- 25. there are five houses --# notminimal

-- There are also special forms in which a noun phrase or an adverb is
-- emphasized.

      mkCl : NP  -> RS -> Cl ;  -- 26. it is John that walks --# notminimal
      mkCl : Adv -> S  -> Cl    -- 27. it is here John walks --# notminimal
      } ; --# notminimal

-- Generic clauses are one with an impersonal subject.

      genericCl : VP ->  Cl ;   -- 28. one walks               --# notminimal


--2 Verb phrases and imperatives --# notminimal

--3 VP, verb phrases --# notminimal

-- A verb phrase is formed from a verb with appropriate arguments.

    mkVP : overload { --# notminimal
      mkVP : V   ->             VP ;  -- 1. walk --# notminimal
      mkVP : V2  -> NP ->       VP ;  -- 2. love her --# notminimal
      mkVP : V3  -> NP -> NP -> VP ;  -- 3. send it to her --# notminimal
      mkVP : VV  -> VP ->       VP ;  -- 4. want to walk --# notminimal
      mkVP : VS  -> S  ->       VP ;  -- 5. know that she walks --# notminimal
      mkVP : VQ  -> QS ->       VP ;  -- 6. ask if she walks --# notminimal
      mkVP : VA  -> AP ->       VP ;  -- 7. become old --# notminimal
      mkVP : V2A -> NP -> AP -> VP ;  -- 8. paint it red --# notminimal

-- The verb can also be a copula ("be"), and the relevant argument is
-- then the complement adjective or noun phrase.

      mkVP : A   ->      VP ;  --  9. be warm --# notminimal
      mkVP : AP  ->      VP ;  -- 12. be very warm --# notminimal
      mkVP : A  -> NP -> VP ;  -- 10. be older than her --# notminimal
      mkVP : A2 -> NP -> VP ;  -- 11. be married to her --# notminimal
      mkVP : N   ->      VP ;  -- 13. be a man --# notminimal
      mkVP : CN  ->      VP ;  -- 14. be an old man --# notminimal
      mkVP : NP  ->      VP ;  -- 15. be the man --# notminimal
      mkVP : Adv ->      VP ;  -- 16. be here --# notminimal

-- A verb phrase can be modified with a postverbal or a preverbal adverb.

      mkVP : VP  -> Adv -> VP ;  -- 17. sleep here --# notminimal
      mkVP : AdV -> VP  -> VP ;  -- 18. always sleep --# notminimal

-- Objectless verb phrases can be taken to verb phrases in two ways.

      mkVP : VPSlash -> NP -> VP ; -- 19. paint it black --# notminimal
      mkVP : VPSlash -> VP ;       -- 20. paint itself black --# notminimal

      } ; --# notminimal

-- Two-place verbs can be used reflexively.

      reflexiveVP : V2 -> VP ; -- 19. love itself --# notminimal

-- Two-place verbs can also be used in the passive, with or without an agent.

    passiveVP : overload { --# notminimal
      passiveVP : V2 ->       VP ;  -- 20. be loved --# notminimal
      passiveVP : V2 -> NP -> VP ;  -- 21. be loved by her --# notminimal
      } ; --# notminimal

-- A verb phrase can be turned into the progressive form.

      progressiveVP : VP -> VP ;  -- 22. be sleeping --# notminimal

--3 Imp, imperatives --# notminimal

-- Imperatives are formed from verbs and their arguments; as the general
-- rule, from verb phrases.

    mkImp : overload { --# notminimal
      mkImp : V  ->        Imp  ;   -- go --# notminimal
      mkImp : V2 -> NP ->  Imp  ;   -- take it --# notminimal
      mkImp : VP ->        Imp      -- go there now --# notminimal
      } ; --# notminimal


--2 Noun phrases and determiners --# notminimal

--3 NP, noun phrases --# notminimal

-- A noun phrases can be built from a determiner and a common noun ($CN$) .
-- For determiners, the special cases of quantifiers, numerals, integers, 
-- and possessive pronouns are provided. For common nouns, the 
-- special case of a simple common noun ($N$) is always provided.

    mkNP : overload { --# notminimal
      mkNP : Quant   -> N  -> NP ;       --  3. this men --# notminimal
      mkNP : Quant -> (Num) -> CN -> NP ; --  4. these five old men --# notminimal
      mkNP : Det     -> N  -> NP ;       --  5. the first man --# notminimal
      mkNP : Det     -> CN -> NP ;       --  6. the first old man --# notminimal
      mkNP : Numeral -> N  -> NP ;       --  7. twenty men --# notminimal
      mkNP : Numeral -> CN -> NP ;       --  8. twenty old men --# notminimal
      mkNP : Digits  -> N  -> NP ;       --  9. 45 men --# notminimal
      mkNP : Digits  -> CN -> NP ;       -- 10. 45 old men --# notminimal
      mkNP : Card    -> N  -> NP ;       -- 11. almost twenty men --# notminimal
      mkNP : Card    -> CN -> NP ;       -- 12. almost twenty old men --# notminimal
      mkNP : Pron    -> N  -> NP ;       -- 13. my man --# notminimal
      mkNP : Pron    -> CN -> NP ;       -- 14. my old man --# notminimal

-- Proper names and pronouns can be used as noun phrases.

      mkNP : PN    -> NP ;  -- 15. John --# notminimal
      mkNP : Pron  -> NP ;  -- 16. he --# notminimal

-- Determiners alone can form noun phrases.

      mkNP : Quant -> NP ;  -- 17. this --# notminimal
      mkNP : Det   -> NP ;  -- 18. these five --# notminimal

-- Determinesless mass noun phrases.

      mkNP : N ->  NP ; -- 19. beer --# notminimal
      mkNP : CN -> NP ; -- 20. beer --# notminimal

-- A noun phrase once formed can be prefixed by a predeterminer and
-- suffixed by a past participle or an adverb.

      mkNP : Predet -> NP -> NP ;  -- 21. only John --# notminimal
      mkNP : NP ->    V2  -> NP ;  -- 22. John killed --# notminimal
      mkNP : NP ->    Adv -> NP ;  -- 23. John in Paris --# notminimal
      mkNP : NP ->    RS  -> NP ;  -- 24. John, who lives in Paris --# notminimal

-- A conjunction can be formed both from two noun phrases and a longer
-- list of them.

      mkNP : Conj  -> NP -> NP -> NP ; -- 25. John and I --# notminimal
      mkNP : Conj  -> ListNP   -> NP ; -- 26. John, I, and that --# notminimal

      } ; --# notminimal


--3 Det, determiners --# notminimal

-- A determiner is either a singular or a plural one.
-- Both have a quantifier and an optional ordinal; the plural
-- determiner also has an optional numeral.

    mkDet : overload { --# notminimal
      mkDet : Quant ->                 Det ; -- 1. this --# notminimal
      mkDet : Quant ->        (Ord) -> Det ; -- 2. this first --# notminimal
      mkDet : Quant -> Num ->          Det ; -- 3. these --# notminimal
      mkDet : Quant -> Num -> (Ord) -> Det ; -- 4. these five best --# notminimal

-- Quantifiers that have both singular and plural forms are by default used as
-- singular determiners. If a numeral is added, the plural form is chosen.

      mkDet : Quant ->        Det ;  -- 5. this --# notminimal
      mkDet : Quant -> Num -> Det ;  -- 6. these five --# notminimal

-- Numerals, their special cases integers and digits, and possessive pronouns can be
-- used as determiners.

      mkDet : Card        -> Det ;  --  7. almost twenty --# notminimal
      mkDet : Numeral     -> Det ;  --  8. five --# notminimal
      mkDet : Digits      -> Det ;  --  9. 51 --# notminimal
      mkDet : Pron        -> Det ;  -- 10. my (house) --# notminimal
      mkDet : Pron -> Num -> Det    -- 11. my (houses) --# notminimal
      } ; --# notminimal

--3 Quant, quantifiers --# notminimal

-- There are definite and indefinite articles.

      the_Quant : Quant ;   -- the --# notminimal
      a_Quant   : Quant ;   -- a --# notminimal

--3 Num, cardinal numerals  --# notminimal

-- Numerals can be formed from number words ($Numeral$), their special case digits,
-- and from symbolic integers.

    mkNum : overload { --# notminimal
      mkNum : Numeral -> Num ;   -- 1. twenty --# notminimal
      mkNum : Digits  -> Num ;   -- 2. 51 --# notminimal
      mkNum : Card    -> Num ;   -- 3. almost ten --# notminimal

-- A numeral can be modified by an adnumeral.

      mkNum : AdN -> Card -> Num  -- 4. almost ten --# notminimal
      } ; --# notminimal

-- Dummy numbers are sometimes to select the grammatical number of a determiner.

      sgNum : Num ;  -- singular --# notminimal
      plNum : Num ;  -- plural --# notminimal

--3 Ord, ordinal numerals --# notminimal

-- Just like cardinals, ordinals can be formed from number words ($Numeral$)
-- and from symbolic integers.

    mkOrd : overload { --# notminimal
      mkOrd : Numeral -> Ord ;  -- 1. twentieth --# notminimal
      mkOrd : Digits  -> Ord ;  -- 2. 51st --# notminimal

-- Also adjectives in the superlative form can appear on ordinal positions.

      mkOrd : A  -> Ord  -- 3. best --# notminimal
      } ; --# notminimal

--3 AdN, adnumerals --# notminimal

-- Comparison adverbs can be used as adnumerals.

      mkAdN : CAdv -> AdN ;  -- 1. more than --# notminimal

--3 Numeral, number words --# notminimal

-- Digits and some "round" numbers are here given as shorthands.

      n1_Numeral    : Numeral ; -- 1. one --# notminimal
      n2_Numeral    : Numeral ; -- 2. two --# notminimal
      n3_Numeral    : Numeral ; -- 3. three --# notminimal
      n4_Numeral    : Numeral ; -- 4. four --# notminimal
      n5_Numeral    : Numeral ; -- 5. five --# notminimal
      n6_Numeral    : Numeral ; -- 6. six --# notminimal
      n7_Numeral    : Numeral ; -- 7. seven --# notminimal
      n8_Numeral    : Numeral ; -- 8. eight --# notminimal
      n9_Numeral    : Numeral ; -- 9. nine --# notminimal
      n10_Numeral   : Numeral ; -- 10. ten --# notminimal
      n20_Numeral   : Numeral ; -- 11. twenty --# notminimal
      n100_Numeral  : Numeral ; -- 12. hundred --# notminimal
      n1000_Numeral : Numeral ; -- 13. thousand --# notminimal

-- See $Numeral$ for the full set of constructors, and use the category 
-- $Digits$ for other numbers from one million.

   mkDigits : overload { --# notminimal
      mkDigits : Dig -> Digits ;           -- 1. 8  --# notminimal
      mkDigits : Dig -> Digits -> Digits ; -- 2. 876 --# notminimal
      } ; --# notminimal

      n1_Digits    : Digits ; -- 1. 1 --# notminimal
      n2_Digits    : Digits ; -- 2. 2 --# notminimal
      n3_Digits    : Digits ; -- 3. 3 --# notminimal
      n4_Digits    : Digits ; -- 4. 4 --# notminimal
      n5_Digits    : Digits ; -- 5. 5 --# notminimal
      n6_Digits    : Digits ; -- 6. 6 --# notminimal
      n7_Digits    : Digits ; -- 7. 7 --# notminimal
      n8_Digits    : Digits ; -- 8. 8 --# notminimal
      n9_Digits    : Digits ; -- 9. 9 --# notminimal
      n10_Digits   : Digits ; -- 10. 10 --# notminimal
      n20_Digits   : Digits ; -- 11. 20 --# notminimal
      n100_Digits  : Digits ; -- 12. 100 --# notminimal
      n1000_Digits : Digits ; -- 13. 1,000 --# notminimal

--3 Dig, single digits --# notminimal

      n0_Dig    : Dig ; -- 0. 0 --# notminimal
      n1_Dig    : Dig ; -- 1. 1 --# notminimal
      n2_Dig    : Dig ; -- 2. 2 --# notminimal
      n3_Dig    : Dig ; -- 3. 3 --# notminimal
      n4_Dig    : Dig ; -- 4. 4 --# notminimal
      n5_Dig    : Dig ; -- 5. 5 --# notminimal
      n6_Dig    : Dig ; -- 6. 6 --# notminimal
      n7_Dig    : Dig ; -- 7. 7 --# notminimal
      n8_Dig    : Dig ; -- 8. 8 --# notminimal
      n9_Dig    : Dig ; -- 9. 9 --# notminimal

      
--2 Nouns --# notminimal

--3 CN, common noun phrases --# notminimal

    mkCN : overload { --# notminimal

-- The most frequent way of forming common noun phrases is from atomic nouns $N$.

      mkCN : N -> CN ;   -- 1. house --# notminimal

-- Common noun phrases can be formed from relational nouns by providing arguments.

      mkCN : N2 -> NP ->       CN ; -- 2. mother of John --# notminimal
      mkCN : N3 -> NP -> NP -> CN ; -- 3. distance from this city to Paris --# notminimal

-- Relational nouns can also be used without their arguments.

      mkCN : N2 -> CN ;   -- 4. son --# notminimal
      mkCN : N3 -> CN ;   -- 5. flight --# notminimal

-- A common noun phrase can be modified by adjectival phrase. We give special 
-- cases of this, where one or both of the arguments are atomic.

      mkCN : A  -> N   -> CN ;   -- 6. big house --# notminimal
      mkCN : A  -> CN  -> CN ;   -- 7. big blue house --# notminimal
      mkCN : AP -> N   -> CN ;   -- 8. very big house --# notminimal
      mkCN : AP -> CN  -> CN ;   -- 9. very big blue house --# notminimal

-- A common noun phrase can be modified by a relative clause or an adverb.

      mkCN : N  -> RS  -> CN ;   -- 10. house that John loves --# notminimal
      mkCN : CN -> RS  -> CN ;   -- 11. big house that John loves --# notminimal
      mkCN : N  -> Adv -> CN ;   -- 12. house in the city --# notminimal
      mkCN : CN -> Adv -> CN ;   -- 13. big house in the city --# notminimal

-- For some nouns it makes sense to modify them by sentences, 
-- questions, or infinitives. But syntactically this is possible for
-- all nouns.

      mkCN : CN -> S   -> CN ;   -- 14. rule that John walks --# notminimal
      mkCN : CN -> QS  -> CN ;   -- 15. question if John walks --# notminimal
      mkCN : CN -> VP  -> CN ;   -- 16. reason to walk --# notminimal

-- A noun can be used in apposition to a noun phrase, especially a proper name.

      mkCN : N  -> NP  -> CN ;   -- 17. king John --# notminimal
      mkCN : CN -> NP  -> CN     -- 18. old king John --# notminimal
      } ; --# notminimal


--2 Adjectives and adverbs --# notminimal

--3 AP, adjectival phrases --# notminimal

    mkAP : overload { --# notminimal

-- Adjectival phrases can be formed from atomic adjectives by using the positive form or
-- the comparative with a complement

      mkAP : A  ->       AP ;  -- 1. old --# notminimal
      mkAP : A  -> NP -> AP ;  -- 2. older than John --# notminimal

-- Relational adjectives can be used with a complement or a reflexive

      mkAP : A2 -> NP -> AP ;  -- 3. married to her --# notminimal
      mkAP : A2 ->       AP ;  -- 4. married --# notminimal

-- Some adjectival phrases can take as complements sentences, 
-- questions, or infinitives. Syntactically this is possible for
-- all adjectives.

      mkAP : AP -> S  -> AP ;  -- 5. probable that John walks --# notminimal
      mkAP : AP -> QS -> AP ;  -- 6. uncertain if John walks --# notminimal
      mkAP : AP -> VP -> AP ;  -- 7. ready to go --# notminimal

-- An adjectival phrase can be modified by an adadjective.

      mkAP : AdA  -> A  -> AP ;  -- 8. very old --# notminimal
      mkAP : AdA  -> AP -> AP ;  -- 9. very very old --# notminimal

-- Conjunction can be formed from two or more adjectival phrases.

      mkAP : Conj  -> AP -> AP -> AP ; -- 10. old and big --# notminimal
      mkAP : Conj  -> ListAP   -> AP ; -- 11. old, big, and warm --# notminimal

      mkAP : Ord   -> AP ;             -- 12. oldest --# notminimal
      mkAP : CAdv -> AP -> NP -> AP ;  -- 13. as old as John --# notminimal
      } ; --# notminimal

      reflAP   : A2 -> AP ;            -- married to himself --# notminimal
      comparAP : A -> AP ;             -- warmer --# notminimal

--3 Adv, adverbial phrases --# notminimal

    mkAdv : overload { --# notminimal

-- Adverbs can be formed from adjectives.

      mkAdv : A -> Adv  ;   -- 1. warmly --# notminimal

-- Prepositional phrases are treated as adverbs.

      mkAdv : Prep -> NP -> Adv ;  -- 2. with John --# notminimal

-- Subordinate sentences are treated as adverbs.

      mkAdv : Subj -> S -> Adv  ;  -- 3. when John walks --# notminimal

-- An adjectival adverb can be compared to a noun phrase or a sentence.

      mkAdv : CAdv -> A -> NP -> Adv ;  -- 4. more warmly than John --# notminimal
      mkAdv : CAdv -> A -> S  -> Adv ;  -- 5. more warmly than John walks --# notminimal

-- Adverbs can be modified by adadjectives.

      mkAdv : AdA -> Adv -> Adv ;  -- 6. very warmly --# notminimal

-- Conjunction can be formed from two or more adverbial phrases.

      mkAdv : Conj  -> Adv -> Adv -> Adv ; -- 7. here and now --# notminimal
      mkAdv : Conj  -> ListAdv ->    Adv ; -- 8. with John, here and now --# notminimal
      } ; --# notminimal


--2 Questions and relatives --# notminimal

--3 QS, question sentences --# notminimal

    mkQS : overload { --# notminimal

-- Just like a sentence $S$ is built from a clause $Cl$, 
-- a question sentence $QS$ is built from
-- a question clause $QCl$ by fixing tense, anteriority and polarity. 
-- Any of these arguments can be omitted, which results in the 
-- default (present, simultaneous, and positive, respectively).

      mkQS :                              QCl -> QS ;  -- 1. who walks --# notminimal
      mkQS : (Tense) -> (Ant) -> (Pol) -> QCl -> QS ;  -- 2. who wouldn't have walked --# notminimal

-- Since 'yes-no' question clauses can be built from clauses (see below), 
-- we give a shortcut
-- for building a question sentence directly from a clause, using the defaults
-- present, simultaneous, and positive.

      mkQS : Cl -> QS  -- 3. does John walk --# notminimal
      } ; --# notminimal


--3 QCl, question clauses --# notminimal

    mkQCl : overload { --# notminimal

-- 'Yes-no' question clauses are built from 'declarative' clauses.

      mkQCl : Cl -> QCl ;   -- 1. does John walk --# notminimal
 
-- 'Wh' questions are built from interrogative pronouns in subject 
-- or object position. The former uses a verb phrase; we don't give
-- shortcuts for verb-argument sequences as we do for clauses.
-- The latter uses the 'slash' category of objectless clauses 
-- (see below); we give the common special case with a two-place verb.

      mkQCl : IP -> VP ->       QCl ;  -- 2. who walks --# notminimal
      mkQCl : IP -> NP -> V2 -> QCl ;  -- 3. whom does John love --# notminimal
      mkQCl : IP -> ClSlash  -> QCl ;  -- 4. whom does John love today --# notminimal

-- Adverbial 'wh' questions are built with interrogative adverbials, with the
-- special case of prepositional phrases with interrogative pronouns.

      mkQCl : IAdv -> Cl ->       QCl ;   -- 5. why does John walk --# notminimal
      mkQCl : Prep -> IP -> Cl -> QCl ;   -- 6. with who does John walk --# notminimal

-- An interrogative adverbial can serve as the complement of a copula.

      mkQCl : IAdv -> NP -> QCl ;  -- 7. where is John --# notminimal

-- Existentials are a special construction.

      mkQCl : IP -> QCl  -- 8. what is there --# notminimal
      } ; --# notminimal


--3 IP, interrogative pronouns --# notminimal

    mkIP : overload { --# notminimal

-- Interrogative pronouns 
-- can be formed much like noun phrases, by using interrogative quantifiers.

      mkIP : IQuant ->          N  -> IP ; -- 1. which city --# notminimal
      mkIP : IQuant -> (Num) -> CN -> IP ; -- 2. which five big cities --# notminimal

-- An interrogative pronoun can be modified by an adverb.

      mkIP : IP -> Adv -> IP               -- 3. who in Paris --# notminimal
      } ; --# notminimal

-- More interrogative pronouns and determiners can be found in $Structural$.



--3 IAdv, interrogative adverbs. --# notminimal

-- In addition to the interrogative adverbs defined in the $Structural$ lexicon, they
-- can be formed as prepositional phrases from interrogative pronouns.

    mkIAdv : Prep -> IP -> IAdv ;  -- 1. in which city --# notminimal

-- More interrogative adverbs are given in $Structural$.


--3 RS, relative sentences --# notminimal

-- Just like a sentence $S$ is built from a clause $Cl$, 
-- a relative sentence $RS$ is built from
-- a relative clause $RCl$ by fixing the tense, anteriority and polarity. 
-- Any of these arguments
-- can be omitted, which results in the default (present, simultaneous,
-- and positive, respectively).

    mkRS : overload { --# notminimal
      mkRS : RCl ->                              RS ; -- 1. that walk --# notminimal
      mkRS : (Tense) -> (Ant) -> (Pol) -> RCl -> RS ; -- 2. that wouldn't have walked --# notminimal
      mkRS : Conj -> RS -> RS -> RS ;  -- 3. who walks and whom I know    --# notminimal
      mkRS : Conj -> ListRS  -> RS ; -- 4. who walks, whose son runs, and whom I know    --# notminimal
      } ; --# notminimal

--3 RCl, relative clauses --# notminimal

    mkRCl : overload { --# notminimal

-- Relative clauses are built from relative pronouns in subject or object position.
-- The former uses a verb phrase; we don't give
-- shortcuts for verb-argument sequences as we do for clauses.
-- The latter uses the 'slash' category of objectless clauses (see below); 
-- we give the common special case with a two-place verb.

      mkRCl : RP -> VP ->       RCl ;  -- 1. that walk --# notminimal
      mkRCl : RP -> NP -> V2 -> RCl ;  -- 2. which John loves --# notminimal
      mkRCl : RP -> ClSlash  -> RCl ;  -- 3. which John loves today --# notminimal

-- There is a simple 'such that' construction for forming relative 
-- clauses from clauses.

      mkRCl : Cl -> RCl  -- 4. such that John loves her --# notminimal
      } ; --# notminimal

--3 RP, relative pronouns --# notminimal

-- There is an atomic relative pronoun

      which_RP : RP ;   -- 1. which --# notminimal

-- A relative pronoun can be made into a kind of a prepositional phrase.

      mkRP : Prep -> NP -> RP -> RP ;  -- 2. all the houses in which --# notminimal


--3 ClSlash, objectless sentences --# notminimal

    mkClSlash : overload { --# notminimal

-- Objectless sentences are used in questions and relative clauses.
-- The most common way of constructing them is by using a two-place verb
-- with a subject but without an object.

      mkClSlash : NP -> V2 -> ClSlash ;  -- 1. (whom) John loves --# notminimal

-- The two-place verb can be separated from the subject by a verb-complement verb.

      mkClSlash : NP -> VV -> V2 -> ClSlash ;  -- 2. (whom) John wants to see --# notminimal

-- The missing object can also be the noun phrase in a prepositional phrase.

      mkClSlash : Cl -> Prep -> ClSlash ;  -- 3. (with whom) John walks --# notminimal

-- An objectless sentence can be modified by an adverb.

      mkClSlash : ClSlash -> Adv -> ClSlash  -- 4. (whom) John loves today --# notminimal
      } ; --# notminimal


--3 VPSlash, verb phrases missing an object --# notminimal

    mkVPSlash : overload { --# notminimal

-- This is the deep level of many-argument predication, permitting extraction.

      mkVPSlash : V2  -> VPSlash ;        -- 1. (whom) (John) loves --# notminimal
      mkVPSlash : V3  -> NP -> VPSlash ;  -- 2. (whom) (John) gives an apple --# notminimal
      mkVPSlash : V2A -> AP -> VPSlash ;  -- 3. (whom) (John) paints red --# notminimal
      mkVPSlash : V2Q -> QS -> VPSlash ;  -- 4. (whom) (John) asks who sleeps --# notminimal
      mkVPSlash : V2S -> S  -> VPSlash ;  -- 5. (whom) (John) tells that we sleep --# notminimal
      mkVPSlash : V2V -> VP -> VPSlash ;  -- 6. (whom) (John) forces to sleep --# notminimal

      } ; --# notminimal


--2 Lists for coordination --# notminimal

-- The rules in this section are very uniform: a list can be built from two or more
-- expressions of the same category.

--3 ListS, sentence lists --# notminimal

    mkListS : overload { --# notminimal
     mkListS : S -> S ->     ListS ;  -- 1. he walks, I run --# notminimal
     mkListS : S -> ListS -> ListS    -- 2. John walks, I run, you sleep --# notminimal
     } ; --# notminimal

--3 ListAdv, adverb lists --# notminimal

    mkListAdv : overload { --# notminimal
     mkListAdv : Adv -> Adv ->     ListAdv ;  -- 1. here, now --# notminimal
     mkListAdv : Adv -> ListAdv -> ListAdv    -- 2. to me, here, now --# notminimal
     } ; --# notminimal

--3 ListAP, adjectival phrase lists --# notminimal

    mkListAP : overload { --# notminimal
     mkListAP : AP -> AP ->     ListAP ;  -- 1. old, big --# notminimal
     mkListAP : AP -> ListAP -> ListAP    -- 2. old, big, warm --# notminimal
     } ; --# notminimal
  

--3 ListNP, noun phrase lists --# notminimal

    mkListNP : overload { --# notminimal
     mkListNP : NP -> NP ->     ListNP ;  -- 1. John, I --# notminimal
     mkListNP : NP -> ListNP -> ListNP    -- 2. John, I, that --# notminimal
     } ; --# notminimal

--3 ListRS, relative clause lists --# notminimal

    mkListRS : overload { --# notminimal
     mkListRS : RS -> RS ->     ListRS ;  -- 1. who walks, who runs --# notminimal
     mkListRS : RS -> ListRS -> ListRS    -- 2. who walks, who runs, who sleeps --# notminimal
     } ; --# notminimal

--.  --# notminimal
-- Definitions

    mkAP = overload {   
      mkAP : A -> AP           -- warm   
                                         =    PositA   ;   
      mkAP : A -> NP -> AP     -- warmer than Spain   
                                         =    ComparA  ;   
      mkAP : A2 -> NP -> AP    -- divisible by 2 --# notminimal
                                         =    ComplA2  ; --# notminimal
      mkAP : A2 -> AP          -- divisible --# notminimal
                                         =    UseA2   ; --# notminimal
      mkAP : AP -> S -> AP    -- great that she won --# notminimal
                                         =  \ap,s -> SentAP ap (EmbedS s) ; --# notminimal
      mkAP : AP -> QS -> AP    -- great that she won --# notminimal
                                         =  \ap,s -> SentAP ap (EmbedQS s) ; --# notminimal
      mkAP : AP -> VP -> AP    -- great that she won --# notminimal
                                         =  \ap,s -> SentAP ap (EmbedVP s) ; --# notminimal
      mkAP : AdA -> A -> AP   -- very uncertain   
                                         =   \x,y -> AdAP x (PositA y) ;
      mkAP : AdA -> AP -> AP   -- very uncertain   
                                         =    AdAP ;
      mkAP : Conj -> AP -> AP -> AP --# notminimal
                                        = \c,x,y -> ConjAP c (BaseAP x y) ; --# notminimal
      mkAP : Conj -> ListAP -> AP --# notminimal
                                        = \c,xy -> ConjAP c xy ; --# notminimal
      mkAP : Ord   -> AP --# notminimal
        = AdjOrd ; --# notminimal
      mkAP : CAdv -> AP -> NP -> AP  --# notminimal
        = CAdvAP ; --# notminimal
      } ;   

      reflAP = ReflA2 ; --# notminimal
      comparAP = UseComparA ; --# notminimal

    mkAdv = overload {   
      mkAdv : A -> Adv                   -- quickly   
                                         =    PositAdvAdj  ;   
      mkAdv : Prep -> NP -> Adv          -- in the house   
                                         =    PrepNP       ;   
      mkAdv : CAdv -> A -> NP -> Adv   -- more quickly than John --# notminimal
                                         =    ComparAdvAdj   ; --# notminimal
      mkAdv : CAdv -> A -> S -> Adv    -- more quickly than he runs --# notminimal
                                         =    ComparAdvAdjS  ; --# notminimal
      mkAdv : AdA -> Adv -> Adv               -- very quickly --# notminimal
                                         =    AdAdv   ; --# notminimal
      mkAdv : Subj -> S -> Adv                 -- when he arrives --# notminimal
                                         =    SubjS ; --# notminimal
      mkAdv : Conj -> Adv -> Adv -> Adv --# notminimal
                                         = \c,x,y -> ConjAdv c (BaseAdv x y) ; --# notminimal
      mkAdv : Conj -> ListAdv -> Adv --# notminimal
                                         = \c,xy -> ConjAdv c xy ; --# notminimal
      } ;   

    mkCl = overload {   
      mkCl : NP -> VP -> Cl           -- John wants to walk   
                                         =    PredVP  ;   
      mkCl : NP -> V -> Cl           -- John walks   
                                         =    \s,v -> PredVP s (UseV v);   
      mkCl : NP -> V2 -> NP -> Cl    -- John uses it   
                                         =    \s,v,o -> PredVP s (ComplV2 v o);   
      mkCl : NP -> V3 -> NP -> NP -> Cl   
                                         =    \s,v,o,i -> PredVP s (ComplV3 v o i);   

      mkCl : NP  -> VV -> VP -> Cl  --# notminimal
        = \s,v,vp -> PredVP s (ComplVV v vp) ; --# notminimal
      mkCl : NP  -> VS -> S  -> Cl --# notminimal
        = \s,v,p -> PredVP s (ComplVS v p) ; --# notminimal
      mkCl : NP  -> VQ -> QS -> Cl --# notminimal
        = \s,v,q -> PredVP s (ComplVQ v q) ; --# notminimal
      mkCl : NP  -> VA -> AP -> Cl --# notminimal
        = \s,v,q -> PredVP s (ComplVA v q) ; --# notminimal
      mkCl : NP  -> V2A -> NP -> AP -> Cl --# notminimal
        = \s,v,n,q -> PredVP s (ComplV2A v n q) ; --# notminimal
      mkCl : NP  -> V2S -> NP -> S -> Cl          --n14 --# notminimal
        = \s,v,n,q -> PredVP s (ComplSlash (SlashV2S v q) n) ; --# notminimal
      mkCl : NP  -> V2Q -> NP -> QS -> Cl         --n14 --# notminimal
        = \s,v,n,q -> PredVP s (ComplSlash (SlashV2Q v q) n) ; --# notminimal
      mkCl : NP  -> V2V -> NP -> VP -> Cl         --n14 --# notminimal
        = \s,v,n,q -> PredVP s (ComplSlash (SlashV2V v q) n) ; --# notminimal

      mkCl : VP -> Cl          -- it rains --# notminimal
                                         =    ImpersCl   ; --# notminimal
      mkCl : NP  -> RS -> Cl   -- it is you who did it --# notminimal
                                         =    CleftNP    ; --# notminimal
      mkCl : Adv -> S  -> Cl   -- it is yesterday she arrived --# notminimal
                                         =    CleftAdv   ; --# notminimal
      mkCl : N -> Cl           -- there is a house --# notminimal
                                   = \y -> ExistNP (DetArtSg IndefArt (UseN y)) ; --# notminimal
      mkCl : CN -> Cl          -- there is a house --# notminimal
                                         =    \y -> ExistNP (DetArtSg IndefArt y) ; --# notminimal
      mkCl : NP -> Cl          -- there is a house --# notminimal
                                         =    ExistNP    ; --# notminimal
      mkCl : NP -> AP -> Cl    -- John is nice and warm 
	                      =     \x,y -> PredVP x (UseComp (CompAP y)) ; 
      mkCl : NP -> A  -> Cl    -- John is warm   
                      =     \x,y -> PredVP x (UseComp (CompAP (PositA y))) ;   
      mkCl : NP -> A -> NP -> Cl -- John is warmer than Mary   
                    =     \x,y,z -> PredVP x (UseComp (CompAP (ComparA y z))) ; 
      mkCl : NP -> A2 -> NP -> Cl -- John is married to Mary --# notminimal
	            =     \x,y,z -> PredVP x (UseComp (CompAP (ComplA2 y z))) ; --# notminimal
      mkCl : NP -> NP -> Cl    -- John is the man   
                                =    \x,y -> PredVP x (UseComp (CompNP y)) ;   
      mkCl : NP -> CN -> Cl    -- John is a man   
	    =    \x,y -> PredVP x (UseComp (CompNP (DetArtSg IndefArt y))) ;   
      mkCl : NP -> N -> Cl    -- John is a man   
	 =    \x,y -> PredVP x (UseComp (CompNP (DetArtSg IndefArt (UseN y)))) ;   
      mkCl : NP -> Adv -> Cl   -- John is here   
	    =    \x,y -> PredVP x (UseComp (CompAdv y)) ;   
      mkCl : V -> Cl   -- it rains --# notminimal
	    =    \v -> ImpersCl (UseV v) --# notminimal
      } ;   

    genericCl : VP -> Cl = GenericCl ; --# notminimal


    mkNP = overload {   
      mkNP : Art -> Num -> Ord -> CN -> NP   -- the five best men --n14 --# notminimal
          =  \d,nu,ord,cn -> DetCN (DetArtOrd d nu ord) (cn) ; --# notminimal
      mkNP : Art -> Ord -> CN -> NP   -- the best men --n14 --# notminimal
          =  \d,ord,cn -> DetCN (DetArtOrd d sgNum ord) (cn) ; --# notminimal
      mkNP : Art -> Card -> CN -> NP   -- the five men --n14 --# notminimal
          =  \d,nu,cn -> DetCN (DetArtCard d nu) (cn) ; --# notminimal

      mkNP : Art -> Num -> Ord -> N -> NP   -- the five best men --n14 --# notminimal
          =  \d,nu,ord,cn -> DetCN (DetArtOrd d nu ord) (UseN cn) ; --# notminimal
      mkNP : Art -> Ord -> N -> NP   -- the best men --n14 --# notminimal
          =  \d,ord,cn -> DetCN (DetArtOrd d sgNum ord) (UseN cn) ; --# notminimal
      mkNP : Art -> Card -> N -> NP   -- the five men --n14 --# notminimal
          =  \d,nu,cn -> DetCN (DetArtCard d nu) (UseN cn) ; --# notminimal

      mkNP : CN -> NP  -- old beer --n14   
          = MassNP ;   
      mkNP : N -> NP  -- beer --n14   
          = \n -> MassNP (UseN n) ;   

      mkNP : Det -> CN -> NP      -- the old man   
          =  DetCN    ;   
      mkNP : Det -> N -> NP       -- the man   
          =  \d,n -> DetCN d (UseN n)   ;   
      mkNP : Quant -> NP            -- this  --# notminimal
          =  \q -> DetNP (DetQuant q sgNum) ;  --# notminimal
      mkNP : Quant -> Num -> NP            -- this  --# notminimal
          =  \q,n -> DetNP (DetQuant q n) ;  --# notminimal
      mkNP : Det -> NP            -- this --# notminimal
          =  DetNP ; --# notminimal
      mkNP : Card -> CN -> NP     -- forty-five old men   
	  =  \d,n -> DetCN (DetArtCard IndefArt d) n ;   
      mkNP : Card -> N -> NP       -- forty-five men   
	  =  \d,n -> DetCN (DetArtCard IndefArt d) (UseN n) ;   
      mkNP : Quant -> CN -> NP   
          = \q,n -> DetCN (DetQuant q NumSg) n ;   
      mkNP : Quant -> N  -> NP   
          = \q,n -> DetCN (DetQuant q NumSg) (UseN n) ;   
      mkNP : Quant -> Num -> CN -> NP   
          = \q,nu,n -> DetCN (DetQuant q nu) n ;  
      mkNP : Quant -> Num -> N  -> NP   
          = \q,nu,n -> DetCN (DetQuant q nu) (UseN n) ;  

      mkNP : Pron    -> CN -> NP --# notminimal
          = \p,n -> DetCN (DetQuant (PossPron p) NumSg) n ; --# notminimal
      mkNP : Pron    -> N  -> NP  --# notminimal
          = \p,n -> DetCN (DetQuant (PossPron p) NumSg) (UseN n) ; --# notminimal

      mkNP : Numeral -> CN -> NP      -- 51 old men   
	  = \d,n -> DetCN (DetArtCard IndefArt (NumNumeral d)) n ;  

      mkNP : Numeral -> N -> NP       -- 51 men  
	  = \d,n -> DetCN (DetArtCard IndefArt (NumNumeral d)) (UseN n) ;  
      mkNP : Digits -> CN -> NP      -- 51 old men --# notminimal
	  = \d,n -> DetCN (DetArtCard IndefArt (NumDigits d)) n ; --# notminimal

      mkNP : Digits -> N -> NP       -- 51 men --# notminimal
	  = \d,n -> DetCN (DetArtCard IndefArt (NumDigits d)) (UseN n) ; --# notminimal

      mkNP : Digit -> CN -> NP    ---- obsol --# notminimal
	  = \d,n -> DetCN (DetArtCard IndefArt (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d))))))) n ; --# notminimal
      mkNP : Digit -> N -> NP     ---- obsol --# notminimal
	  = \d,n -> DetCN (DetArtCard IndefArt (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d))))))) (UseN n) ; --# notminimal

      mkNP : PN -> NP             -- John  
                                         =    UsePN    ;  
      mkNP : Pron -> NP           -- he  
                                         =    UsePron  ;  
      mkNP : Predet -> NP -> NP  -- only the man  
                                         =    PredetNP  ;  
      mkNP : NP -> V2  -> NP      -- the number squared --# notminimal
                                         =    PPartNP  ; --# notminimal
      mkNP : NP -> Adv -> NP      -- Paris at midnight --# notminimal
                                         =    AdvNP ; --# notminimal
      mkNP : NP -> RS -> NP --# notminimal
            = RelNP ; --# notminimal
      mkNP : Conj -> NP -> NP -> NP --# notminimal
                                        = \c,x,y -> ConjNP c (BaseNP x y) ; --# notminimal
      mkNP : Conj -> ListNP -> NP --# notminimal
                                        = \c,xy -> ConjNP c xy ; --# notminimal
-- backward compat
      mkNP : QuantSg -> CN -> NP  --# notminimal
          = \q,n -> DetCN (DetQuant q NumSg) n ; --# notminimal
      mkNP : QuantPl -> CN -> NP  --# notminimal
          = \q,n -> DetCN (DetQuant q NumPl) n ; --# notminimal

      } ;  

    mkDet = overload {  

      mkDet : Art -> Card -> Det   -- the five men --n14 --# notminimal
          =  \d,nu -> (DetArtCard d nu) ; --# notminimal



      mkDet : Quant ->  Ord -> Det     -- this best man --# notminimal
        = \q,o -> DetQuantOrd q NumSg o  ; --# notminimal
      mkDet : Quant ->  Det       -- this man  
        = \q -> DetQuant q NumSg  ;  
      mkDet : Quant -> Num -> Ord -> Det     -- these five best men --# notminimal
        = DetQuantOrd  ; --# notminimal
      mkDet : Quant -> Num -> Det       -- these five man  
        = DetQuant ;  
      mkDet : Num ->  Det       -- forty-five men  
	= DetArtCard IndefArt ;  
      mkDet : Digits -> Det          -- 51 (men) --# notminimal
	= \d -> DetArtCard IndefArt (NumDigits d) ; --# notminimal
      mkDet : Numeral -> Det  --  
	= \d -> DetArtCard IndefArt (NumNumeral d) ;  
      mkDet : Pron -> Det      -- my (house) --# notminimal
        = \p -> DetQuant (PossPron p) NumSg ; --# notminimal
      mkDet : Pron -> Num -> Det   -- my (houses) --# notminimal
        = \p -> DetQuant (PossPron p) ; --# notminimal
      } ;  


      the_Art : Art = DefArt ;     -- the  
      a_Art   : Art = IndefArt ;   -- a  

    ---- obsol --# notminimal

    mkQuantSg : Quant -> QuantSg = SgQuant ; --# notminimal
    mkQuantPl : Quant -> QuantPl = PlQuant ; --# notminimal

      this_QuantSg : QuantSg = mkQuantSg this_Quant ; --# notminimal
      that_QuantSg : QuantSg = mkQuantSg that_Quant ;  --# notminimal

--      the_QuantPl  : QuantPl = mkQuantPl defQuant ; 
--      a_QuantPl    : QuantPl = mkQuantPl indefQuant ; 
      these_QuantPl : QuantPl = mkQuantPl this_Quant ;  --# notminimal
      those_QuantPl : QuantPl = mkQuantPl that_Quant ;  --# notminimal

    sgNum : Num = NumSg ;  
    plNum : Num = NumPl ;  


    mkCard = overload {  
      mkCard : Numeral -> Card  
        = NumNumeral ;  
      mkCard : Digits -> Card         -- 51  --# notminimal
        = NumDigits ;  --# notminimal
      mkCard : AdN -> Card -> Card --# notminimal
        = AdNum --# notminimal
      } ;

    mkNum = overload {  
      mkNum : Numeral -> Num  
        = \d -> NumCard (NumNumeral d) ;  
      mkNum : Digits -> Num         -- 51 --# notminimal
        = \d -> NumCard (NumDigits d)      ; --# notminimal
      mkNum : Digit -> Num --# notminimal
        = \d -> NumCard (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d)))))) ; --# notminimal

      mkNum : Card -> Num = NumCard ;  
      mkNum : AdN -> Card -> Num = \a,c -> NumCard (AdNum a c) --# notminimal
      } ;  

    singularNum : Num                -- [no num] --# notminimal
                                         =    NumSg       ; --# notminimal
    pluralNum : Num                -- [no num] --# notminimal
                                         =    NumPl       ; --# notminimal

    mkOrd = overload { --# notminimal
      mkOrd : Numeral -> Ord = OrdNumeral ; --# notminimal
      mkOrd : Digits -> Ord         -- 51st --# notminimal
                                         =    OrdDigits      ; --# notminimal
      mkOrd : Digit -> Ord       -- fifth --# notminimal
                                         =    \d ->  --# notminimal
        OrdNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d))))) ; --# notminimal
      mkOrd : A -> Ord           -- largest --# notminimal
                                         =    OrdSuperl --# notminimal
      } ; --# notminimal

    n1_Numeral = num (pot2as3 (pot1as2 (pot0as1 pot01))) ;  
    n2_Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n2)))) ;  
    n3_Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n3)))) ;  
    n4_Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n4)))) ;  
    n5_Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n5)))) ;  
    n6_Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n6)))) ;  
    n7_Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n7)))) ;  
    n8_Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n8)))) ;  
    n9_Numeral = num (pot2as3 (pot1as2 (pot0as1 (pot0 n9)))) ;  
    n10_Numeral = num (pot2as3 (pot1as2 pot110)) ;  
    n20_Numeral = num (pot2as3 (pot1as2 (pot1 n2))) ;  
    n100_Numeral = num (pot2as3 (pot2 pot01)) ;  
    n1000_Numeral = num (pot3 (pot1as2 (pot0as1 pot01))) ;  

    n1_Digits = IDig D_1 ; --# notminimal
    n2_Digits = IDig D_2 ; --# notminimal
    n3_Digits = IDig D_3 ; --# notminimal
    n4_Digits = IDig D_4 ; --# notminimal
    n5_Digits = IDig D_5 ; --# notminimal
    n6_Digits = IDig D_6 ; --# notminimal
    n7_Digits = IDig D_7 ; --# notminimal
    n8_Digits = IDig D_8 ; --# notminimal
    n9_Digits = IDig D_9 ; --# notminimal
    n10_Digits = IIDig D_1 (IDig D_0) ; --# notminimal
    n20_Digits = IIDig D_2 (IDig D_0) ; --# notminimal
    n100_Digits = IIDig D_1 (IIDig D_0 (IDig D_0)) ; --# notminimal
    n1000_Digits = IIDig D_1 (IIDig D_0 (IIDig D_0 (IDig D_0))) ; --# notminimal


    mkAdN : CAdv -> AdN = AdnCAdv ;                  -- more (than five) --# notminimal

   mkDigits = overload { --# notminimal
      mkDigits : Dig -> Digits = IDig ;  --# notminimal
      mkDigits : Dig -> Digits -> Digits = IIDig ;  --# notminimal
      } ; --# notminimal

      n0_Dig = D_0 ; --# notminimal
      n1_Dig = D_1 ; --# notminimal
      n2_Dig    = D_2 ; --# notminimal
      n3_Dig    = D_3 ; --# notminimal
      n4_Dig    = D_4 ; --# notminimal
      n5_Dig    = D_5 ; --# notminimal
      n6_Dig        = D_6 ; --# notminimal
      n7_Dig        = D_7 ; --# notminimal
      n8_Dig        = D_8 ; --# notminimal
      n9_Dig        = D_9 ; --# notminimal




    mkCN = overload {  
      mkCN : N  -> CN            -- house  
                                         =    UseN     ;  
      mkCN : N2 -> NP -> CN      -- son of the king --# notminimal
                                         =    ComplN2  ; --# notminimal
      mkCN : N3 -> NP -> NP -> CN      -- flight from Moscow (to Paris) --# notminimal
                                         =    \f,x -> ComplN2 (ComplN3 f x)  ; --# notminimal
      mkCN : N2 -> CN            -- son --# notminimal
                                         =    UseN2    ; --# notminimal
      mkCN : N3 -> CN            -- flight --# notminimal
                                         =    \n -> UseN2 (Use2N3 n)    ; --# notminimal
      mkCN : AP -> CN  -> CN     -- nice and big blue house  
                                         =    AdjCN    ;  
      mkCN : AP ->  N  -> CN     -- nice and big house  
                                         =    \x,y -> AdjCN x (UseN y) ;  
      mkCN : CN -> AP  -> CN     -- nice and big blue house --# notminimal
                                         =    \x,y -> AdjCN y x    ; --# notminimal
      mkCN :  N -> AP  -> CN     -- nice and big house --# notminimal
                                         =    \x,y -> AdjCN y (UseN x)    ; --# notminimal
      mkCN :  A -> CN  -> CN     -- big blue house  
	                                 =    \x,y -> AdjCN (PositA x) y;  
      mkCN :  A ->  N  -> CN     -- big house  
	                                 =  \x,y -> AdjCN (PositA x) (UseN y);  
      mkCN : CN -> RS  -> CN     -- house that John owns --# notminimal
                                         =    RelCN    ; --# notminimal
      mkCN :  N -> RS  -> CN     -- house that John owns --# notminimal
                                         =    \x,y -> RelCN (UseN x) y   ; --# notminimal
      mkCN : CN -> Adv -> CN     -- house on the hill --# notminimal
                                         =    AdvCN    ; --# notminimal
      mkCN :  N -> Adv -> CN     -- house on the hill --# notminimal
                                         =    \x,y -> AdvCN (UseN x) y  ; --# notminimal
      mkCN : CN -> S   -> CN     -- fact that John smokes --# notminimal
                                         =    \cn,s -> SentCN cn (EmbedS s) ; --# notminimal
      mkCN : CN -> QS  -> CN     -- question if John smokes --# notminimal
                                         =    \cn,s -> SentCN cn (EmbedQS s) ; --# notminimal
      mkCN : CN -> VP  -> CN     -- reason to smoke --# notminimal
                                         =    \cn,s -> SentCN cn (EmbedVP s) ; --# notminimal
      mkCN : CN -> NP  -> CN     -- number x, numbers x and y --# notminimal
                                         =    ApposCN ; --# notminimal
      mkCN :  N -> NP  -> CN     -- number x, numbers x and y --# notminimal
                                         =    \x,y -> ApposCN (UseN x) y --# notminimal
      } ;  


    mkPhr = overload {  
      mkPhr : PConj -> Utt -> Voc -> Phr   -- But go home my friend --# notminimal
                                         =    PhrUtt    ; --# notminimal
      mkPhr : Utt -> Voc -> Phr --# notminimal
                                         =    \u,v -> PhrUtt NoPConj u v ; --# notminimal
      mkPhr : PConj -> Utt -> Phr --# notminimal
                                         =    \u,v -> PhrUtt u v NoVoc ; --# notminimal
      mkPhr : Utt -> Phr   -- Go home  
                                         =    \u -> PhrUtt NoPConj u NoVoc   ;  
      mkPhr : S -> Phr   -- I go home  
         = \s -> PhrUtt NoPConj (UttS s) NoVoc ;  
      mkPhr : Cl -> Phr   -- I go home  
         = \s -> PhrUtt NoPConj (UttS (TUseCl TPres ASimul PPos s)) NoVoc ;  
      mkPhr : QS -> Phr   -- I go home  
                 =    \s -> PhrUtt NoPConj (UttQS s) NoVoc ;  
      mkPhr : Imp -> Phr   -- I go home  
                 =    \s -> PhrUtt NoPConj (UttImpSg PPos s) NoVoc   

      } ;  

    mkPConj : Conj -> PConj = PConjConj ; --# notminimal
    noPConj : PConj = NoPConj ; --# notminimal

    mkVoc   : NP -> Voc  = VocNP ; --# notminimal
    noVoc   : Voc  = NoVoc ; --# notminimal

    positivePol : Pol = PPos ;  
    negativePol : Pol = PNeg ;  

    simultaneousAnt : Ant = ASimul ;  --# notminimal
    anteriorAnt : Ant = AAnter ; --# notpresent --# notminimal

    presentTense     : Tense = TPres ; --# notminimal
    pastTense        : Tense = TPast ; --# notpresent --# notminimal
    futureTense      : Tense = TFut ;  --# notpresent --# notminimal
    conditionalTense : Tense = TCond ; --# notpresent --# notminimal

  param ImpForm = IFSg | IFPl | IFPol ; --# notminimal

  oper --# notminimal
    singularImpForm  : ImpForm = IFSg ; --# notminimal
    pluralImpForm  : ImpForm = IFPl ; --# notminimal
    politeImpForm : ImpForm = IFPol ; --# notminimal

    mkUttImp : ImpForm -> Pol -> Imp -> Utt = \f,p,i -> case f of { --# notminimal
      IFSg  => UttImpSg p i ; --# notminimal
      IFPl  => UttImpPl p i ; --# notminimal
      IFPol => UttImpPol p i --# notminimal
      } ; --# notminimal

    mkUtt = overload {  
      mkUtt : S -> Utt                     -- John walked  
                                         =    UttS      ;  
      mkUtt : Cl -> Utt                     -- John walks  
	                                 =    \c -> UttS (TUseCl TPres ASimul PPos c);  
      mkUtt : QS -> Utt                    -- is it good  
                                         =    UttQS     ;  
      mkUtt : QCl -> Utt                   -- does John walk  
	                                 =    \c -> UttQS (TUseQCl TPres ASimul PPos c);  
      mkUtt : ImpForm -> Pol -> Imp -> Utt -- don't help yourselves --# notminimal
                                         =    mkUttImp  ; --# notminimal
      mkUtt : ImpForm ->        Imp -> Utt -- help yourselves --# notminimal
                                         =  \f -> mkUttImp f PPos ; --# notminimal
      mkUtt : Pol -> Imp -> Utt            -- (don't) help yourself  
                                         =    UttImpSg  ;  
      mkUtt : Imp -> Utt                    -- help yourself  
                                         =    UttImpSg PPos  ;  
      mkUtt : IP   -> Utt                   -- who  
                                         =    UttIP    ;  
      mkUtt : IAdv -> Utt                   -- why  
                                         =    UttIAdv  ;  
      mkUtt : NP   -> Utt                   -- this man  
                                         =    UttNP    ;  
      mkUtt : Adv  -> Utt                   -- here  
                                         =    UttAdv   ;  
      mkUtt : VP   -> Utt                   -- to sleep --# notminimal
                                         =    UttVP  --# notminimal
      } ;  

    lets_Utt : VP -> Utt = ImpPl1 ; --# notminimal

    mkQCl = overload {  

      mkQCl : Cl -> QCl                    -- does John walk  
                                         =    QuestCl      ;  
      mkQCl : IP -> VP -> QCl              -- who walks  
                                         =    QuestVP      ;  
      mkQCl : IP -> ClSlash -> QCl           -- who does John love --# notminimal
                                         =    QuestSlash   ; --# notminimal
      mkQCl : IP -> NP -> V2 -> QCl           -- who does John love --# notminimal
                                         =    \ip,np,v -> QuestSlash ip (SlashVP np (SlashV2a v))  ; --# notminimal
      mkQCl : IAdv -> Cl -> QCl            -- why does John walk  
                                         =    QuestIAdv    ;  
      mkQCl : Prep -> IP -> Cl -> QCl      -- with whom does John walk --# notminimal
                                         =    \p,ip -> QuestIAdv (PrepIP p ip)  ; --# notminimal
      mkQCl : IAdv -> NP -> QCl   -- where is John --# notminimal
                                         =    \a -> QuestIComp (CompIAdv a)   ; --# notminimal
      mkQCl : IP -> QCl         -- which houses are there --# notminimal
                                         =    ExistIP  --# notminimal

      } ;  

    mkIP = overload {  
      mkIP : IDet -> CN -> IP          -- which songs --# notminimal
                                         = IdetCN ; --# notminimal
      mkIP : IDet -> N -> IP      -- which song --# notminimal
                                         =    \i,n -> IdetCN i (UseN n)  ; --# notminimal
      mkIP : IQuant -> CN -> IP          -- which songs  
                     =  \i,n -> IdetCN (IdetQuant i NumSg) n ;  
      mkIP : IQuant -> Num -> CN -> IP          -- which songs --# notminimal
                     =  \i,nu,n -> IdetCN (IdetQuant i nu) n ; --# notminimal
      mkIP : IQuant -> N -> IP      -- which song  
                     =  \i,n -> IdetCN (IdetQuant i NumSg) (UseN n) ;  
      mkIP : IP -> Adv -> IP                  -- who in Europe --# notminimal
                                         =    AdvIP --# notminimal
      } ;  

    mkIDet = overload { 
      mkIDet : IQuant -> Num -> IDet          -- which (songs) --# notminimal
                     =  \i,nu -> IdetQuant i nu ; --# notminimal
      mkIDet : IQuant -> IDet      
                     =  \i -> IdetQuant i NumSg ; 
      } ; 

    whichSg_IDet : IDet = IdetQuant which_IQuant NumSg ; --# notminimal
    whichPl_IDet : IDet = IdetQuant which_IQuant NumPl ; --# notminimal

    what_IP : IP = whatSg_IP ;  
    who_IP : IP = whoSg_IP ;  
    which_IDet : IDet = whichSg_IDet ; --# notminimal

    mkIAdv : Prep -> IP -> IAdv = PrepIP ; --# notminimal

    mkRCl = overload { --# notminimal
      mkRCl : Cl -> RCl              -- such that John loves her --# notminimal
                                         =    RelCl     ; --# notminimal
      mkRCl : RP -> VP -> RCl        -- who loves John --# notminimal
                                         =    RelVP     ; --# notminimal
      mkRCl : RP -> ClSlash -> RCl     -- whom John loves --# notminimal
                                         =    RelSlash ; --# notminimal
      mkRCl : RP -> NP -> V2 -> RCl     -- whom John loves --# notminimal
                                         =  \rp,np,v2 -> RelSlash rp (SlashVP np (SlashV2a v2)) ; --# notminimal
      } ; --# notminimal

    which_RP : RP                        -- which --# notminimal
                                         =    IdRP   ; --# notminimal
    mkRP : Prep -> NP -> RP -> RP    -- all the roots of which --# notminimal
                                         =    FunRP --# notminimal
      ; --# notminimal

    mkClSlash = overload { --# notminimal
      mkClSlash : NP -> V2 -> ClSlash        -- (whom) he sees --# notminimal
               = \np,v2 -> SlashVP np (SlashV2a v2) ; --# notminimal
      mkClSlash : NP -> VV -> V2 -> ClSlash  -- (whom) he wants to see --# notminimal
               = \np,vv,v2 -> SlashVP np (SlashVV vv (SlashV2a v2))  ; --# notminimal
      mkClSlash : ClSlash -> Adv -> ClSlash    -- (whom) he sees tomorrow --# notminimal
                                         =    AdvSlash   ; --# notminimal
      mkClSlash : Cl -> Prep -> ClSlash      -- (with whom) he walks --# notminimal
                                         =    SlashPrep --# notminimal
      } ; --# notminimal

    mkImp = overload {  
      mkImp : VP -> Imp                -- go --# notminimal
                                         =    ImpVP      ; --# notminimal
      mkImp : V  -> Imp  
                                         =    \v -> ImpVP (UseV v)  ;  
      mkImp : V2 -> NP -> Imp  
                                         =    \v,np -> ImpVP (ComplV2 v np)  
      } ;  

    mkS = overload {  
      mkS : Cl  -> S  
                                         =    TUseCl TPres ASimul PPos ;  
      mkS : Tense -> Cl -> S  --# notminimal
	                                 =    \t -> TUseCl t ASimul PPos ; --# notminimal
      mkS : Ant -> Cl -> S --# notminimal
                                         =    \a -> TUseCl TPres a PPos ; --# notminimal
      mkS : Pol -> Cl -> S  
                                         =    \p -> TUseCl TPres ASimul p ;  
      mkS : Tense -> Ant -> Cl -> S --# notminimal
                                         =    \t,a -> TUseCl t a PPos ; --# notminimal
      mkS : Tense -> Pol -> Cl -> S --# notminimal
                                         =    \t,p -> TUseCl t ASimul p ; --# notminimal
      mkS : Ant -> Pol -> Cl -> S --# notminimal
                                         =    \a,p -> TUseCl TPres a p ; --# notminimal
      mkS : Tense -> Ant -> Pol -> Cl  -> S --# notminimal
                                         =    \t,a -> TUseCl t a ; --# notminimal
      mkS : Conj -> S -> S -> S --# notminimal
                                        = \c,x,y -> ConjS c (BaseS x y) ; --# notminimal
      mkS : Conj -> ListS -> S --# notminimal
                                        = \c,xy -> ConjS c xy ; --# notminimal
      mkS : Adv -> S -> S  --# notminimal
                                        = AdvS --# notminimal

      } ;  

    mkQS = overload {  

      mkQS : QCl  -> QS  
                                         =    TUseQCl TPres ASimul PPos ;  
      mkQS : Tense -> QCl -> QS  --# notminimal
	                                 =    \t -> TUseQCl t ASimul PPos ; --# notminimal
      mkQS : Ant -> QCl -> QS --# notminimal
                                         =    \a -> TUseQCl TPres a PPos ; --# notminimal
      mkQS : Pol -> QCl -> QS  
                                         =    \p -> TUseQCl TPres ASimul p ;  
      mkQS : Tense -> Ant -> QCl -> QS --# notminimal
                                         =    \t,a -> TUseQCl t a PPos ; --# notminimal
      mkQS : Tense -> Pol -> QCl -> QS --# notminimal
                                         =    \t,p -> TUseQCl t ASimul p ; --# notminimal
      mkQS : Ant -> Pol -> QCl -> QS --# notminimal
                                         =    \a,p -> TUseQCl TPres a p ; --# notminimal
      mkQS : Tense -> Ant -> Pol -> QCl -> QS --# notminimal
                                         =    TUseQCl  ; --# notminimal
      mkQS : Cl   -> QS                    
	                                 =    \x -> TUseQCl TPres ASimul PPos (QuestCl x)  
      } ;  


    mkRS = overload { --# notminimal

      mkRS : RCl  -> RS --# notminimal
                                         =    TUseRCl TPres ASimul PPos ; --# notminimal
      mkRS : Tense -> RCl -> RS  --# notminimal
	                                 =    \t -> TUseRCl t ASimul PPos ; --# notminimal
      mkRS : Ant -> RCl -> RS --# notminimal
                                         =    \a -> TUseRCl TPres a PPos ; --# notminimal
      mkRS : Pol -> RCl -> RS --# notminimal
                                         =    \p -> TUseRCl TPres ASimul p ; --# notminimal
      mkRS : Tense -> Ant -> RCl -> RS --# notminimal
                                         =    \t,a -> TUseRCl t a PPos ; --# notminimal
      mkRS : Tense -> Pol -> RCl -> RS --# notminimal
                                         =    \t,p -> TUseRCl t ASimul p ; --# notminimal
      mkRS : Ant -> Pol -> RCl -> RS --# notminimal
                                         =    \a,p -> TUseRCl TPres a p ; --# notminimal
      mkRS : Tense -> Ant -> Pol -> RCl -> RS --# notminimal
                                         =    TUseRCl ; --# notminimal
      mkRS : Conj -> RS -> RS -> RS --# notminimal
                                        = \c,x,y -> ConjRS c (BaseRS x y) ; --# notminimal
      mkRS : Conj -> ListRS -> RS --# notminimal
                                        = \c,xy -> ConjRS c xy ; --# notminimal

      } ; --# notminimal

  param Punct = PFullStop | PExclMark | PQuestMark ;  

  oper  
    emptyText : Text = TEmpty ;       -- [empty text] --# notminimal

    fullStopPunct  : Punct = PFullStop ; -- .  
    questMarkPunct : Punct = PQuestMark ; -- ?  
    exclMarkPunct  : Punct = PExclMark ; -- !  


    mkText = overload {  
      mkText : Phr -> Punct -> Text -> Text = --# notminimal
        \phr,punct,text -> case punct of { --# notminimal
          PFullStop => TFullStop phr text ;  --# notminimal
          PExclMark => TExclMark phr text ; --# notminimal
          PQuestMark => TQuestMark phr text --# notminimal
          } ; --# notminimal
      mkText : Phr -> Punct -> Text =  
        \phr,punct -> case punct of {  
          PFullStop => TFullStop phr TEmpty ;  
          PExclMark => TExclMark phr TEmpty ;  
          PQuestMark => TQuestMark phr TEmpty  
          } ;  
      mkText : Phr -> Text            -- John walks. --# notminimal
                                         =    \x -> TFullStop x TEmpty  ; --# notminimal
      mkText : Utt -> Text  
	                                 =    \u -> TFullStop (PhrUtt NoPConj u NoVoc) TEmpty ;  
      mkText : S -> Text  
	                                 =    \s -> TFullStop (PhrUtt NoPConj (UttS s) NoVoc) TEmpty;  
      mkText : Cl -> Text  
	                                 =    \c -> TFullStop (PhrUtt NoPConj (UttS (TUseCl TPres ASimul PPos c)) NoVoc) TEmpty;  
      mkText : QS -> Text  
	                                 =    \q -> TQuestMark (PhrUtt NoPConj (UttQS q) NoVoc) TEmpty ;  
      mkText : Imp -> Text  
	                                =    \i -> TExclMark (PhrUtt NoPConj (UttImpSg PPos i) NoVoc) TEmpty;  
      mkText : Pol -> Imp -> Text  --# notminimal
	                                 =    \p,i -> TExclMark (PhrUtt NoPConj (UttImpSg p i) NoVoc) TEmpty; --# notminimal
      mkText : Phr -> Text -> Text    -- John walks. ... --# notminimal
                                         =    TFullStop ; --# notminimal
      mkText : Text -> Text -> Text  --# notminimal
        = \t,u -> {s = t.s ++ u.s ; lock_Text = <>} ; --# notminimal
      } ;  

    mkVP = overload { 
      mkVP : V   -> VP                -- sleep 
                                         =    UseV      ; 
      mkVP : V2  -> NP -> VP          -- use it 
                                         =    ComplV2   ; 
      mkVP : V3  -> NP -> NP -> VP    -- send a message to her --# notminimal
                                         =    ComplV3   ; --# notminimal
      mkVP : VV  -> VP -> VP          -- want to run --# notminimal
                                         =    ComplVV   ; --# notminimal
      mkVP : VS  -> S  -> VP          -- know that she runs --# notminimal
                                         =    ComplVS   ; --# notminimal
      mkVP : VQ  -> QS -> VP          -- ask if she runs --# notminimal
                                         =    ComplVQ   ; --# notminimal
      mkVP : VA  -> AP -> VP          -- look red --# notminimal
                                         =    ComplVA   ; --# notminimal
      mkVP : V2A -> NP -> AP -> VP    -- paint the house red --# notminimal
                                         =    ComplV2A  ; --# notminimal

      mkVP : V2S -> NP -> S  -> VP          --n14 --# notminimal
        = \v,n,q -> (ComplSlash (SlashV2S v q) n) ; --# notminimal
      mkVP : V2Q -> NP -> QS -> VP         --n14 --# notminimal
        = \v,n,q -> (ComplSlash (SlashV2Q v q) n) ; --# notminimal
      mkVP : V2V -> NP -> VP -> VP         --n14 --# notminimal
        = \v,n,q -> (ComplSlash (SlashV2V v q) n) ; --# notminimal

      mkVP : A -> VP               -- be warm --# notminimal
                                         =    \a -> UseComp (CompAP (PositA a)) ; --# notminimal
      mkVP : A -> NP -> VP -- John is warmer than Mary --# notminimal
	                                =     \y,z -> (UseComp (CompAP (ComparA y z))) ; --# notminimal
      mkVP : A2 -> NP -> VP -- John is married to Mary --# notminimal
	                                =     \y,z -> (UseComp (CompAP (ComplA2 y z))) ; --# notminimal
      mkVP : AP -> VP               -- be warm --# notminimal
                                         =    \a -> UseComp (CompAP a)   ; --# notminimal
      mkVP : NP -> VP               -- be a man --# notminimal
                                         =    \a -> UseComp (CompNP a)   ; --# notminimal
      mkVP : CN -> VP               -- be a man --# notminimal
                             = \y -> (UseComp (CompNP (DetArtSg IndefArt y))) ; --# notminimal
      mkVP : N -> VP               -- be a man --# notminimal
                             = \y -> (UseComp (CompNP (DetArtSg IndefArt (UseN y)))) ; --# notminimal
      mkVP : Adv -> VP               -- be here --# notminimal
                                         =    \a -> UseComp (CompAdv a)   ; --# notminimal
      mkVP : VP -> Adv -> VP          -- sleep here 
                                         =    AdvVP     ; 
      mkVP : AdV -> VP -> VP          -- always sleep --# notminimal
                                         =    AdVVP ; --# notminimal
      mkVP : VPSlash -> NP -> VP          -- always sleep --# notminimal
                                         =    ComplSlash ; --# notminimal
      mkVP : VPSlash -> VP --# notminimal
        = ReflVP --# notminimal
      } ; 

  reflexiveVP   : V2 -> VP = \v -> ReflVP (SlashV2a v) ; --# notminimal

    mkVPSlash = overload { --# notminimal

      mkVPSlash : V2  -> VPSlash         -- 1. (whom) (John) loves --# notminimal
        = SlashV2a ; --# notminimal
      mkVPSlash : V3  -> NP -> VPSlash   -- 2. (whom) (John) gives an apple --# notminimal
        = Slash2V3 ; --# notminimal
      mkVPSlash : V2A -> AP -> VPSlash   -- 3. (whom) (John) paints red --# notminimal
        = SlashV2A ; --# notminimal
      mkVPSlash : V2Q -> QS -> VPSlash   -- 4. (whom) (John) asks who sleeps --# notminimal
        = SlashV2Q ; --# notminimal
      mkVPSlash : V2S -> S  -> VPSlash   -- 5. (whom) (John) tells that we sleep --# notminimal
        = SlashV2S ; --# notminimal
      mkVPSlash : V2V -> VP -> VPSlash   -- 6. (whom) (John) forces to sleep --# notminimal
        = SlashV2V ; --# notminimal
      } ; --# notminimal



  passiveVP = overload { --# notminimal
      passiveVP : V2 ->       VP = PassV2 ; --# notminimal
      passiveVP : V2 -> NP -> VP = \v,np ->  --# notminimal
        (AdvVP (PassV2 v) (PrepNP by8agent_Prep np)) --# notminimal
      } ; --# notminimal
  progressiveVP : VP -> VP = ProgrVP ; --# notminimal


  mkListS = overload { --# notminimal
   mkListS : S -> S -> ListS = BaseS ; --# notminimal
   mkListS : S -> ListS -> ListS = ConsS --# notminimal
   } ; --# notminimal

  mkListAP = overload { --# notminimal
   mkListAP : AP -> AP -> ListAP = BaseAP ; --# notminimal
   mkListAP : AP -> ListAP -> ListAP = ConsAP --# notminimal
   } ; --# notminimal

  mkListAdv = overload { --# notminimal
   mkListAdv : Adv -> Adv -> ListAdv = BaseAdv ; --# notminimal
   mkListAdv : Adv -> ListAdv -> ListAdv = ConsAdv --# notminimal
   } ; --# notminimal

  mkListNP = overload { --# notminimal
   mkListNP : NP -> NP -> ListNP = BaseNP ; --# notminimal
   mkListNP : NP -> ListNP -> ListNP = ConsNP --# notminimal
   } ; --# notminimal

  mkListRS = overload { --# notminimal
   mkListRS : RS -> RS -> ListRS = BaseRS ; --# notminimal
   mkListRS : RS -> ListRS -> ListRS = ConsRS --# notminimal
   } ; --# notminimal


------------ for backward compatibility --# notminimal

    QuantSg : Type = Quant ** {isSg : {}} ; --# notminimal
    QuantPl : Type = Quant ** {isPl : {}} ; --# notminimal
    SgQuant : Quant -> QuantSg = \q -> q ** {isSg = <>} ; --# notminimal
    PlQuant : Quant -> QuantPl = \q -> q ** {isPl = <>} ; --# notminimal

-- Pre-1.4 constants defined

  DetSg : Quant -> Ord -> Det = \q -> DetQuantOrd q NumSg ; --# notminimal
  DetPl : Quant -> Num -> Ord -> Det = DetQuantOrd ; --# notminimal

  ComplV2 : V2 -> NP -> VP = \v,np -> ComplSlash (SlashV2a v) np ;
  ComplV2A : V2A -> NP -> AP -> VP = \v,np,ap -> ComplSlash (SlashV2A v ap) np ; 
  ComplV3 : V3 -> NP -> NP -> VP = \v,o,d -> ComplSlash (Slash3V3 v o) d ; 

    that_NP : NP = DetNP (DetQuant that_Quant sgNum) ; --# notminimal
    this_NP : NP = DetNP (DetQuant this_Quant sgNum) ; --# notminimal
    those_NP : NP = DetNP (DetQuant that_Quant plNum) ; --# notminimal
    these_NP : NP = DetNP (DetQuant this_Quant plNum) ; --# notminimal


{- --# notminimal
-- The definite and indefinite articles are commonly used determiners.

      defSgDet   : Det ;  -- 11. the (house) --# notminimal
      defPlDet   : Det ;  -- 12. the (houses) --# notminimal
      indefSgDet : Det ;  -- 13. a (house) --# notminimal
      indefPlDet : Det ;  -- 14. (houses) --# notminimal


--3 QuantSg, singular quantifiers --# notminimal

-- From quantifiers that can have both forms, this constructor 
-- builds the singular form.

      mkQuantSg : Quant -> QuantSg ;  -- 1. this --# notminimal

-- The mass noun phrase constructor is treated as a singular quantifier.

      massQuant : QuantSg ;  -- 2. (mass terms) --# notminimal

-- More singular quantifiers are available in the $Structural$ module.
-- The following singular cases of quantifiers are often used.

      the_QuantSg  : QuantSg ; -- 3. the --# notminimal
      a_QuantSg    : QuantSg ; -- 4. a --# notminimal
      this_QuantSg : QuantSg ; -- 5. this --# notminimal
      that_QuantSg : QuantSg ; -- 6. that --# notminimal


--3 QuantPl, plural quantifiers --# notminimal

-- From quantifiers that can have both forms, this constructor 
-- builds the plural form.

      mkQuantPl : Quant -> QuantPl ;  -- 1. these --# notminimal

-- More plural quantifiers are available in the $Structural$ module.   
-- The following plural cases of quantifiers are often used.

      the_QuantPl   : QuantPl ; -- 2. the --# notminimal
      a_QuantPl     : QuantPl ; -- 3. (indefinite plural) --# notminimal
      these_QuantPl : QuantPl ; -- 4. these --# notminimal
      those_QuantPl : QuantPl ; -- 5. those --# notminimal
-} --# notminimal

-- export needed, since not in Cat

  ListAdv : Type = Grammar.ListAdv ; --# notminimal
  ListAP : Type = Grammar.ListAP ; --# notminimal
  ListNP : Type = Grammar.ListNP ; --# notminimal
  ListS : Type = Grammar.ListS ; --# notminimal

-- bw to 1.4

    Art : Type = Quant ; 
      the_Art : Art = DefArt ;   -- the --# notminimal
      a_Art : Art  = IndefArt ;   -- a --# notminimal

    the_Quant : Quant = DefArt ;   -- the --# notminimal
    a_Quant : Quant  = IndefArt ;   -- a --# notminimal

    DetArtSg : Art -> CN -> NP = \a -> DetCN (DetQuant a sgNum) ; 
    DetArtPl : Art -> CN -> NP = \a -> DetCN (DetQuant a plNum) ; 

    DetArtOrd : Quant -> Num -> Ord -> Det = DetQuantOrd ; --# notminimal
    DetArtCard : Art -> Card -> Det = \a,c -> DetQuant a (NumCard c) ; 

    TUseCl  : Tense -> Ant -> Pol ->  Cl ->  S = \t,a -> UseCl  (TTAnt t a) ; 
    TUseQCl : Tense -> Ant -> Pol -> QCl -> QS = \t,a -> UseQCl (TTAnt t a) ; 
    TUseRCl : Tense -> Ant -> Pol -> RCl -> RS = \t,a -> UseRCl (TTAnt t a) ; --# notminimal

}  
