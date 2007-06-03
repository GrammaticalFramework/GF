--1 Constructors: the Resource Syntax API

incomplete resource Constructors = open Grammar in {

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
-- $mkS (mkCl (mkPN "John") (mkV2 "love") (mkPN "Mary"))$
--
-- This module defines the syntactic constructors, which take trees as arguments.
-- Lexical constructors, which take strings as arguments, are defined in the
-- $Paradigms$ modules separately for each language.
--
-- The recommended usage of this module is via the wrapper module $Syntax$, 
-- which also contains the $Structural$ (structural words). 
-- Together with $Paradigms$, $Syntax$ gives everything that is needed
-- to implement the concrete syntax for a langauge.

--2 Principles of organization

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

--2 Texts, phrases, and utterances

--3 Text: texts

-- A text is a list of phrases separated by punctuation marks.
-- The default punctuation mark is the full stop, and the default
-- continuation of a text is empty.

  oper
    mkText : overload {
      mkText : Phr ->                      Text ; -- 1. But John walks.
      mkText : Phr -> (Punct) -> (Text) -> Text ; -- 2. John walks? Yes.

-- A text can also be directly built from utterances, which in turn can
-- be directly built from sentences, present-tense clauses, questions, or
-- positive imperatives. 

      mkText : Utt ->  Text ;  -- 3. John.
      mkText : S   ->  Text ;  -- 4. John walked.
      mkText : Cl  ->  Text ;  -- 5. John walks.
      mkText : QS  ->  Text ;  -- 6. Did John walk?
      mkText : Imp ->  Text    -- 7. Walk!
      } ;

-- A text can also be empty.

      emptyText :      Text ;  -- 8. [empty text]


--3 Punct: punctuation marks

-- There are three punctuation marks that can separate phrases in a text.

      fullStopPunct  : Punct ;  -- .
      questMarkPunct : Punct ;  -- ?
      exclMarkPunct  : Punct ;  -- !

--3 Phr: phrases in a text

-- Phrases are built from utterances by adding a phrasal conjunction
-- and a vocative, both of which are by default empty.

    mkPhr : overload {
      mkPhr :            Utt ->          Phr ;  -- 1. why
      mkPhr : (PConj) -> Utt -> (Voc) -> Phr ;  -- 2. but why John


-- A phrase can also be directly built by a sentence, a present-tense
-- clause, a question, or a positive singular imperative. 

      mkPhr : S   ->  Phr ; -- 3. John walked
      mkPhr : Cl  ->  Phr ; -- 4. John walks
      mkPhr : QS  ->  Phr ; -- 5. did John walk
      mkPhr : Imp ->  Phr   -- 6. walk
      } ;

--3 PConj, phrasal conjunctions

-- Any conjunction can be used as a phrasal conjunction.
-- More phrasal conjunctions are defined in $Structural$.

      mkPConj : Conj -> PConj ;  -- 1. and

--3 Voc, vocatives

-- Any noun phrase can be turned into a vocative.
-- More vocatives are defined in $Structural$.

      mkVoc : NP -> Voc ;   -- 1. John

--3 Utt, utterances

-- Utterances are formed from sentences, clauses, questions, and positive singular imperatives.

    mkUtt : overload {
      mkUtt : S   -> Utt ;  -- 1. John walked
      mkUtt : Cl  -> Utt ;  -- 2. John walks
      mkUtt : QS  -> Utt ;  -- 3. did John walk
      mkUtt : Imp -> Utt ;  -- 4. love yourself

-- Imperatives can also vary in $ImpForm$ (number/politeness) and 
-- polarity.

      mkUtt : (ImpForm) -> (Pol) -> Imp -> Utt ;  -- 5. don't love yourselves

-- Utterances can also be formed from interrogative phrases and
-- interrogative adverbials, noun phrases, adverbs, and verb phrases.

      mkUtt : IP   ->  Utt ;  -- 6. who
      mkUtt : IAdv ->  Utt ;  -- 7. why
      mkUtt : NP   ->  Utt ;  -- 8. John
      mkUtt : Adv  ->  Utt ;  -- 9. here
      mkUtt : VP   ->  Utt    -- 10. to walk
      } ;

-- The plural first-person imperative is a special construction.

      lets_Utt : VP ->  Utt ;  -- 11. let's walk


--2 Auxiliary parameters for phrases and sentences

--3 Pol, polarity

-- Polarity is a parameter that sets a clause to positive or negative
-- form. Since positive is the default, it need never be given explicitly.

      positivePol : Pol ;  -- (John walks) [default]
      negativePol : Pol ;  -- (John doesn't walk)

--3 Ant, anteriority

-- Anteriority is a parameter that presents an event as simultaneous or
-- anterior to some other reference time.
-- Since simultaneous is the default, it need never be given explicitly.

      simultaneousAnt : Ant ;  -- (John walks) [default]
      anteriorAnt     : Ant ;  -- (John has walked)       --# notpresent

--3 Tense, tense

-- Tense is a parameter that relates the time of an event 
-- to the time of speaking about it.
-- Since present is the default, it need never be given explicitly.

      presentTense     : Tense ; -- (John walks) [default]
      pastTense        : Tense ; -- (John walked)           --# notpresent
      futureTense      : Tense ; -- (John will walk)        --# notpresent
      conditionalTense : Tense ; -- (John would walk)       --# notpresent

--3 ImpForm, imperative form

-- Imperative form is a parameter that sets the form of imperative
-- by reference to the person or persons addressed.
-- Since singular is the default, it need never be given explicitly.

      singularImpForm : ImpForm ;  -- (help yourself) [default]
      pluralImpForm   : ImpForm ;  -- (help yourselves)
      politeImpForm   : ImpForm ;  -- (help yourself) [polite singular]


--2 Sentences and clauses

--3 S, sentences

-- A sentence has a fixed tense, anteriority and polarity.

    mkS : overload {
      mkS :                              Cl -> S ;  -- 1. John walks
      mkS : (Tense) -> (Ant) -> (Pol) -> Cl -> S ;  -- 2. John wouldn't have walked

-- Sentences can be combined with conjunctions. This can apply to a pair
-- of sentences, but also to a list of more than two.

      mkS : Conj  -> S -> S -> S ;  -- 3. John walks and I run   
      mkS : Conj  -> ListS  -> S ;  -- 4. John walks, I run and you sleep
      mkS : DConj -> S -> S -> S ;  -- 5. either John walk or I run
      mkS : DConj -> ListS  -> S ;  -- 6. either John walks, I run or you sleep

-- A sentence can be prefixed by an adverb.

      mkS : Adv -> S -> S    -- 7. today, John walks
      } ;

--3 Cl, clauses

-- A clause has a variable tense, anteriority and polarity.
-- A clause can be built from a subject noun phrase 
-- with a verb and appropriate arguments.

    mkCl : overload {
      mkCl : NP  -> V  ->             Cl ;  -- 1. John walks
      mkCl : NP  -> V2 -> NP ->       Cl ;  -- 2. John loves her
      mkCl : NP  -> V3 -> NP -> NP -> Cl ;  -- 3. John sends it to her
      mkCl : NP  -> VV -> VP ->       Cl ;  -- 4. John wants to walk 
      mkCl : NP  -> VS -> S  ->       Cl ;  -- 5. John says that it is good
      mkCl : NP  -> VQ -> QS ->       Cl ;  -- 6. John wonders if it is good
      mkCl : NP  -> VA -> AP ->       Cl ;  -- 7. John becomes old
      mkCl : NP  -> V2A ->NP -> AP -> Cl ;  -- 8. John paints it red
      mkCl : NP  -> A  ->             Cl ;  -- 9. John is old
      mkCl : NP  -> A  -> NP ->       Cl ;  -- 10. John is older than her
      mkCl : NP  -> A2 -> NP ->       Cl ;  -- 11. John is married to her
      mkCl : NP  -> AP ->             Cl ;  -- 12. John is very old
      mkCl : NP  -> N  ->             Cl ;  -- 13. John is a man
      mkCl : NP  -> CN ->             Cl ;  -- 14. John is an old man
      mkCl : NP  -> NP ->             Cl ;  -- 15. John is the man
      mkCl : NP  -> Adv ->            Cl ;  -- 16. John is here

-- As the general rule, a clause can be built from a subject noun phrase and 
-- a verb phrase.

      mkCl : NP  -> VP -> Cl ;  -- 17. John walks here

-- Subjectless verb phrases are used for impersonal actions.

      mkCl : V   ->  Cl ;  -- 18. it rains
      mkCl : VP  ->  Cl ;  -- 19. it is raining

-- Existentials are a special form of clauses.

      mkCl : N   ->  Cl ;  -- 20. there is a house
      mkCl : CN  ->  Cl ;  -- 21. there is an old houses
      mkCl : NP  ->  Cl ;  -- 22. there are five houses

-- There are also special forms in which a noun phrase or an adverb is
-- emphasized.

      mkCl : NP  -> RS -> Cl ;  -- 23. it is John that walks
      mkCl : Adv -> S  -> Cl    -- 24. it is here John walks
      } ;

-- Generic clauses are one with an impersonal subject.

      genericCl : VP ->  Cl ;   -- 25. one walks              


--2 Verb phrases and imperatives

--3 VP, verb phrases

-- A verb phrase is formed from a verb with appropriate arguments.

    mkVP : overload {
      mkVP : V   ->             VP ;  -- 1. walk
      mkVP : V2  -> NP ->       VP ;  -- 2. love her
      mkVP : V3  -> NP -> NP -> VP ;  -- 3. send it to her
      mkVP : VV  -> VP ->       VP ;  -- 4. want to walk
      mkVP : VS  -> S  ->       VP ;  -- 5. know that she walks
      mkVP : VQ  -> QS ->       VP ;  -- 6. ask if she walks
      mkVP : VA  -> AP ->       VP ;  -- 7. become old
      mkVP : V2A -> NP -> AP -> VP ;  -- 8. paint it red

-- The verb can also be a copula ("be"), and the relevant argument is
-- then the complement adjective or noun phrase.

      mkVP : A   ->      VP ;  --  9. be warm
      mkVP : AP  ->      VP ;  -- 12. be very warm
      mkVP : A  -> NP -> VP ;  -- 10. be older than her
      mkVP : A2 -> NP -> VP ;  -- 11. be married to her
      mkVP : N   ->      VP ;  -- 13. be a man
      mkVP : CN  ->      VP ;  -- 14. be an old man
      mkVP : NP  ->      VP ;  -- 15. be the man
      mkVP : Adv ->      VP ;  -- 16. be here

-- A verb phrase can be modified with a postverbal or a preverbal adverb.

      mkVP : VP  -> Adv -> VP ;  -- 17. sleep here
      mkVP : AdV -> VP  -> VP    -- 18. always sleep
      } ;

-- Two-place verbs can be used reflexively.

      reflexiveVP : V2 -> VP ; -- 19. love itself

-- Two-place verbs can also be used in the passive, with or without an agent.

    passiveVP : overload {
      passiveVP : V2 ->       VP ;  -- 20. be loved
      passiveVP : V2 -> NP -> VP ;  -- 21. be loved by her
      } ;

-- A verb phrase can be turned into the progressive form.

      progressiveVP : VP -> VP ;  -- 22. be sleeping

--3 Imp, imperatives

-- Imperatives are formed from verbs and their arguments; as the general
-- rule, from verb phrases.

    mkImp : overload {
      mkImp : V  ->        Imp  ;   -- go
      mkImp : V2 -> NP ->  Imp  ;   -- take it
      mkImp : VP ->        Imp      -- go there now
      } ;



--2 Noun phrases and determiners

--3 NP, noun phrases

-- A noun phrases can be built from a determiner and a common noun ($CN$) .
-- For determiners, the special cases of quantifiers, numerals, integers, 
-- and possessive pronouns are provided. For common nouns, the 
-- special case of a simple common noun ($N$) is always provided.

    mkNP : overload {
      mkNP : Det     -> N  -> NP ;       --  1. the first man
      mkNP : Det     -> CN -> NP ;       --  2. the first old man
      mkNP : QuantSg -> N  -> NP ;       --  3. this man
      mkNP : QuantSg -> CN -> NP ;       --  4. this old man
      mkNP : QuantPl -> N  -> NP ;       --  5. these men
      mkNP : QuantPl -> CN -> NP ;       --  6. these old men
      mkNP : Numeral -> N  -> NP ;       --  7. twenty men
      mkNP : Numeral -> CN -> NP ;       --  8. twenty old men
      mkNP : Int     -> N  -> NP ;       --  9. 45 men
      mkNP : Int     -> CN -> NP ;       -- 10. 45 old men
      mkNP : Num     -> N  -> NP ;       -- 11. almost twenty men
      mkNP : Num     -> CN -> NP ;       -- 12. almost twenty old men
      mkNP : Pron    -> N  -> NP ;       -- 13. my man
      mkNP : Pron    -> CN -> NP;        -- 14. my old man

-- Proper names and pronouns can be used as noun phrases.

      mkNP : PN    -> NP ;  -- 15. John
      mkNP : Pron  -> NP ;  -- 16. he

-- A noun phrase once formed can be prefixed by a predeterminer and
-- suffixed by a past participle or an adverb.

      mkNP : Predet -> NP -> NP ;  -- 17. only John
      mkNP : NP ->    V2  -> NP ;  -- 18. John killed
      mkNP : NP ->    Adv -> NP ;  -- 19. John in Paris

-- A conjunction can be formed both from two noun phrases and a longer
-- list of them.

      mkNP : Conj  -> NP -> NP -> NP ; -- 20. John and I
      mkNP : Conj  -> ListNP ->   NP ; -- 21. John, I, and that
      mkNP : DConj -> NP -> NP -> NP ; -- 22. either John or I
      mkNP : DConj -> ListNP ->   NP   -- 23. either John, I, or that

      } ;


--3 Det, determiners

-- A determiner is either a singular or a plural one.
-- Both have a quantifier and an optional ordinal; the plural
-- determiner also has an optional numeral.

    mkDet : overload {
      mkDet : QuantSg ->                   Det ; -- 1. this
      mkDet : QuantSg ->          (Ord) -> Det ; -- 2. this first
      mkDet : QuantPl ->                   Det ; -- 3. these
      mkDet : QuantPl -> (Num) -> (Ord) -> Det ; -- 4. these five best

-- Quantifiers that have both singular and plural forms are by default used as
-- singular determiners. If a numeral is added, the plural form is chosen.

      mkDet : Quant ->        Det ;  -- 5. this
      mkDet : Quant -> Num -> Det ;  -- 6. these five

-- Numerals, their special cases integers and digits, and possessive pronouns can be
-- used as determiners.

      mkDet : Num     ->  Det ;  --  7. almost twenty
      mkDet : Numeral ->  Det ;  --  8. five
      mkDet : Int     ->  Det ;  --  9. 51
      mkDet : Pron    ->  Det    -- 10. my
      } ;

-- The definite and indefinite articles are commonly used determiners.

      defSgDet   : Det ;  -- 11. the (house)
      defPlDet   : Det ;  -- 12. the (houses)
      indefSgDet : Det ;  -- 13. a (house)
      indefPlDet : Det ;  -- 14. (houses)


--3 Quant, QuantSg, and QuantPl, quantifiers

-- Definite and indefinite articles have both singular and plural forms (even though the
-- plural indefinite is empty in most languages).

      defQuant   : Quant ;  -- 1. the
      indefQuant : Quant ;  -- 2. a

-- From quantifiers that can have both forms, these constructors build the singular and
-- the plural forms.

      mkQuantSg : Quant -> QuantSg ;  -- 1. this
      mkQuantPl : Quant -> QuantPl ;  -- 1. these

-- The mass noun phrase constructor is treated as a singular quantifier.

      massQuant : QuantSg ;  -- 2. (mass terms)

-- More quantifiers are available in the $Structural$ module.
   

--3 Num, cardinal numerals 

-- Numerals can be formed from number words ($Numeral$), their special case digits,
-- and from symbolic integers.

    mkNum : overload {
      mkNum : Numeral -> Num ;   -- twenty
      mkNum : Int     -> Num ;   -- 51

-- A numeral can be modified by an adnumeral.

      mkNum : AdN -> Num -> Num  -- almost ten
      } ;

--3 Ord, ordinal numerals

-- Just like cardinals, ordinals can be formed from number words ($Numeral$), their special case digits,
-- and from symbolic integers.

    mkOrd : overload {
      mkOrd : Numeral -> Ord ;  -- sixtieth
      mkOrd : Int     -> Ord ;  -- 51st

-- Also adjectives in the superlative form can appear on ordinal positions.

      mkOrd : A  -> Ord  -- best
      } ;

--3 AdN, adnumerals

-- Comparison adverbs can be used as adnumerals.

      mkAdN : CAdv -> AdN ;  -- more (than five)

--3 Numeral, number words

-- Digits and some "round" numbers are here given as shorthands.

      n1_Numeral    : Numeral ; -- one
      n2_Numeral    : Numeral ; -- two
      n3_Numeral    : Numeral ; -- three
      n4_Numeral    : Numeral ; -- four
      n5_Numeral    : Numeral ; -- five
      n6_Numeral    : Numeral ; -- six
      n7_Numeral    : Numeral ; -- seven
      n8_Numeral    : Numeral ; -- eight
      n9_Numeral    : Numeral ; -- nine
      n10_Numeral   : Numeral ; -- ten
      n20_Numeral   : Numeral ; -- twenty
      n100_Numeral  : Numeral ; -- hundred
      n1000_Numeral : Numeral ; -- thousand

-- See $Numeral$ for the full set of constructors, or use $Int$ for other numbers.


--2 Nouns

--3 CN, common noun phrases

    mkCN : overload {

-- The most frequent way of forming common noun phrases is from atomic nouns $N$.

      mkCN : N -> CN ;   -- house

-- Common noun phrases can be formed from relational nouns by providing arguments.

      mkCN : N2 -> NP ->       CN ;   -- son of the king
      mkCN : N3 -> NP -> NP -> CN ;   -- flight from Moscow to Paris

-- Relational nouns can also be used without their arguments.

      mkCN : N2 -> CN ;   -- son
      mkCN : N3 -> CN ;   -- flight

-- A common noun phrase can be modified by adjectival phrase. We give special 
-- cases of this, where one or both of the arguments are atomic.

      mkCN : AP -> CN  -> CN ;   -- very big blue house
      mkCN : A  -> CN  -> CN ;   -- big blue house
      mkCN : AP -> N   -> CN ;   -- very big house
      mkCN : A  -> N   -> CN ;   -- big house

-- A common noun phrase can be modified by a relative clause or an adverb.

      mkCN : CN -> RS  -> CN ;   -- big house that John loves
      mkCN : N  -> RS  -> CN ;   -- house that John loves
      mkCN : CN -> Adv -> CN ;   -- big house on the mountain
      mkCN : N  -> Adv -> CN ;   -- house on the mountain

-- For some nouns it makes sense to modify them by sentences, questions, or infinitives.

      mkCN : CN -> S   -> CN ;   -- fact that John walks
      mkCN : CN -> QS  -> CN ;   -- question if John smokes
      mkCN : CN -> VP  -> CN ;   -- reason to smoke

-- A noun can be used in apposition to a noun phrase, especially a proper name.

      mkCN : CN -> NP  -> CN ;   -- old king John
      mkCN : N  -> NP  -> CN     -- king John
      } ;


--2 Adjectives and adverbs

--3 AP, adjectival phrases

    mkAP : overload {

-- Adjectival phrases can be formed from atomic adjectives by using the positive form or
-- the comparative with a complement

      mkAP : A  -> AP ;        -- old
      mkAP : A  -> NP -> AP ;  -- older than John

-- Relational adjectives can be used with a complement or a reflexive

      mkAP : A2 -> NP -> AP ;  -- married to her
      mkAP : A2 ->       AP ;  -- married to himself

-- Some adjectival phrases can take as complements sentences, questions, or infinitives.

      mkAP : AP -> S  -> AP ;  -- great that she won
      mkAP : AP -> QS -> AP ;  -- uncertain if she won
      mkAP : AP -> VP -> AP ;  -- ready to go

-- An adjectival phrase can be modified by an adadjective.

      mkAP : AdA  -> AP -> AP ;  -- very big

-- Conjunction can be formed from two or more adjectival phrases.

      mkAP : Conj  -> AP -> AP -> AP ; -- warm and big
      mkAP : Conj  -> ListAP   -> AP ; -- warm, big, and cheap
      mkAP : DConj -> AP -> AP -> AP ; -- both warm and big
      mkAP : DConj -> ListAP ->   AP   -- both warm, big, and cheap

      } ;

--3 Adv, adverbial phrases

    mkAdv : overload {

-- Adverbs can be formed from adjectives.

      mkAdv : A -> Adv  ;   -- quickly

-- Prepositional phrases are treated as adverbs.

      mkAdv : Prep -> NP -> Adv ;  -- in the house

-- Subordinate sentences are treated as adverbs.

      mkAdv : Subj -> S -> Adv  ;  -- when he arrives

-- An adjectival adverb can be compared to a noun phrase or a sentence.

      mkAdv : CAdv -> A -> NP -> Adv ;  -- more slowly than John
      mkAdv : CAdv -> A -> S  -> Adv ;  -- more slowly than he runs

-- Adverbs can be modified by adadjectives.

      mkAdv : AdA -> Adv -> Adv ;  -- very quickly

-- Conjunction can be formed from two or more adverbial phrases.

      mkAdv : Conj  -> Adv -> Adv -> Adv ; -- here and now
      mkAdv : Conj  -> ListAdv ->    Adv ; -- here, now, and with you
      mkAdv : DConj -> Adv -> Adv -> Adv ; -- both here and now
      mkAdv : DConj -> ListAdv ->    Adv   -- both here, now, and with you
      } ;

--2 Questions and relatives

--3 QS, question sentences

    mkQS : overload {

-- Just like a sentence $S$ is built from a clause $Cl$, a question sentence $QS$ is built from
-- a question clause $QCl$ by fixing tense, anteriority and polarity. Any of these arguments
-- can be omitted, which results in the default (present, simultaneous, and positive, respectively).

      mkQS :                              QCl -> QS ;  -- who walks
      mkQS : (Tense) -> (Ant) -> (Pol) -> QCl -> QS ;  -- wouldn't John have walked

-- Since 'yes-no' question clauses can be built from clauses (see below), we give a shortcus
-- for building a question sentence directly from a clause, using the defaults
-- present, simultaneous, and positive.

      mkQS : Cl -> QS  -- does John walk
      } ;


--3 QCl, question clauses

    mkQCl : overload {

-- 'Yes-no' question clauses are built from 'declarative' clauses.

      mkQCl : Cl -> QCl ;   -- does John walk
 
-- 'Wh' questions are built from interrogative pronouns in subject or object position.
-- The latter uses the 'slash' category of objectless clauses (see below); we give the
-- common special case with a two-place verb.

      mkQCl : IP -> VP ->       QCl ;  -- who walks
      mkQCl : IP -> Slash ->    QCl ;  -- who does John love
      mkQCl : IP -> NP -> V2 -> QCl ;  -- who does John love

-- Adverbial 'wh' questions are built with interrogative adverbials, with the
-- special case of prepositional phrases with interrogative pronouns.

      mkQCl : IAdv -> Cl ->       QCl ;   -- why does John walk
      mkQCl : Prep -> IP -> Cl -> QCl ;   -- with whom does John walk

-- An interrogative adverbial can serve as the complement of a copula.

      mkQCl : IAdv -> NP -> QCl ;  -- where is John

-- Existentials are a special construction.

      mkQCl : IP -> QCl  -- which houses are there
      } ;

--3 IP, interrogative pronouns

    mkIP : overload {

-- In addition to the interrogative pronouns defined in the $Structural$ lexicon, they
-- can be formed much like noun phrases, by using interrogative determiners.

      mkIP : IDet ->                   N  -> IP ; -- which song
      mkIP : IDet -> (Num) -> (Ord) -> CN -> IP ; -- which five best songs

-- An interrogative pronoun can be modified by an adverb.

      mkIP : IP -> Adv -> IP  -- who in Europe
      } ;


--3 IAdv, interrogative adverbs.

-- In addition to the interrogative adverbs defined in the $Structural$ lexicon, they
-- can be formed as prepositional phrases from interrogative pronouns.

    mkIAdv : Prep -> IP -> IAdv ;             -- in which city


--3 RS, relative sentences

-- Just like a sentence $S$ is built from a clause $Cl$, a relative sentence $RS$ is built from
-- a relative clause $RCl$ by fixing the tense, anteriority and polarity. Any of these arguments
-- can be omitted, which results in the default (present, simultaneous, and positive, respectively).

    mkRS : overload {
      mkRS : RCl ->                              RS ; -- who walks
      mkRS : (Tense) -> (Ant) -> (Pol) -> RCl -> RS   -- who wouldn't have walked
      } ;

--3 RCl, relative clauses

    mkRCl : overload {

-- Relative clauses are built from relative pronouns in subject or object position.
-- The latter uses the 'slash' category of objectless clauses (see below); we give the
-- common special case with a two-place verb.

      mkRCl : RP -> VP ->       RCl ;  -- who loves John
      mkRCl : RP -> NP -> V2 -> RCl ;  -- whom John loves
      mkRCl : RP -> Slash ->    RCl ;  -- whom John wants to love

-- There is a simple 'such that' construction for forming relative clauses from clauses.

      mkRCl : Cl -> RCl    -- such that John loves her
      } ;

--3 RP, relative pronouns

-- There is an atomic relative pronoun

      which_RP : RP ;   -- which

-- A relative pronoun can be made into a kind of a prepositional phrase.

      mkRP : Prep -> NP -> RP -> RP ;  -- all the houses in which


--3 Slash, objectless sentences

    mkSlash : overload {

-- Objectless sentences are used in questions and relative clauses.
-- The most common way of constructing them is by using a two-place verb
-- with a subject but without an object.

      mkSlash : NP -> V2       -> Slash ;  -- (whom) he sees

-- The two-place verb can be separated from the subject by a verb-complement verb.

      mkSlash : NP -> VV -> V2 -> Slash ;  -- (whom) he wants to see

-- The missing object can also be the noun phrase in a prepositional phrase.

      mkSlash : Cl -> Prep -> Slash ;  -- (with whom) he walks

-- An objectless sentence can be modified by an adverb.

      mkSlash : Slash -> Adv -> Slash    -- (whom) he sees tomorrow
      } ;


--2 Lists for coordination

-- The rules in this section are very uniform: a list can be built from two or more
-- expressions of the same category.

--3 ListS, sentence lists

    mkListS : overload {
     mkListS : S -> S ->     ListS ;  -- he walks, she runs
     mkListS : S -> ListS -> ListS    -- I sleep, he walks, she runs
     } ;

--3 ListAdv, adverb lists

    mkListAdv : overload {
     mkListAdv : Adv -> Adv ->     ListAdv ;  -- here, now
     mkListAdv : Adv -> ListAdv -> ListAdv    -- to me, here, now
     } ;

--3 ListAP, adjectival phrase lists

    mkListAP : overload {
     mkListAP : AP -> AP ->     ListAP ;  -- big, old
     mkListAP : AP -> ListAP -> ListAP    -- warm, big, old
     } ;
  

--3 ListNP, noun phrase lists

    mkListNP : overload {
     mkListNP : NP -> NP ->     ListNP ;  -- John, Mary
     mkListNP : NP -> ListNP -> ListNP    -- you, John, Mary
     } ;


--. 
-- Definitions

    mkAP = overload {
      mkAP : A -> AP           -- warm
                                         =    PositA   ;
      mkAP : A -> NP -> AP     -- warmer than Spain
                                         =    ComparA  ;
      mkAP : A2 -> NP -> AP    -- divisible by 2
                                         =    ComplA2  ;
      mkAP : A2 -> AP          -- divisible by itself
                                         =    ReflA2   ;
      mkAP : AP -> S -> AP    -- great that she won
                                         =  \ap,s -> SentAP ap (EmbedS s) ;
      mkAP : AP -> QS -> AP    -- great that she won
                                         =  \ap,s -> SentAP ap (EmbedQS s) ;
      mkAP : AP -> VP -> AP    -- great that she won
                                         =  \ap,s -> SentAP ap (EmbedVP s) ;
      mkAP : AdA -> AP -> AP   -- very uncertain
                                         =    AdAP ;
      mkAP : Conj -> AP -> AP -> AP
                                        = \c,x,y -> ConjAP c (BaseAP x y) ;
      mkAP : DConj -> AP -> AP -> AP
                                        = \c,x,y -> DConjAP c (BaseAP x y) ;
      mkAP : Conj -> ListAP -> AP
                                        = \c,xy -> ConjAP c xy ;
      mkAP : DConj -> ListAP -> AP
                                        = \c,xy -> DConjAP c xy

      } ;

    mkAdv = overload {
      mkAdv : A -> Adv                   -- quickly
                                         =    PositAdvAdj  ;
      mkAdv : Prep -> NP -> Adv          -- in the house
                                         =    PrepNP       ;
      mkAdv : CAdv -> A -> NP -> Adv   -- more quickly than John
                                         =    ComparAdvAdj   ;
      mkAdv : CAdv -> A -> S -> Adv    -- more quickly than he runs
                                         =    ComparAdvAdjS  ;
      mkAdv : AdA -> Adv -> Adv               -- very quickly
                                         =    AdAdv   ;
      mkAdv : Subj -> S -> Adv                 -- when he arrives
                                         =    SubjS ;
      mkAdv : Conj -> Adv -> Adv -> Adv
                                        = \c,x,y -> ConjAdv c (BaseAdv x y) ;
      mkAdv : DConj -> Adv -> Adv -> Adv
                                        = \c,x,y -> DConjAdv c (BaseAdv x y) ;
      mkAdv : Conj -> ListAdv -> Adv
                                        = \c,xy -> ConjAdv c xy ;
      mkAdv : DConj -> ListAdv -> Adv
                                        = \c,xy -> DConjAdv c xy

      } ;

    mkCl = overload {
      mkCl : NP -> VP -> Cl           -- John wants to walk walks
                                         =    PredVP  ;
      mkCl : NP -> V -> Cl           -- John walks
                                         =    \s,v -> PredVP s (UseV v);
      mkCl : NP -> V2 -> NP -> Cl    -- John uses it
                                         =    \s,v,o -> PredVP s (ComplV2 v o);
      mkCl : NP -> V3 -> NP -> NP -> Cl
                                         =    \s,v,o,i -> PredVP s (ComplV3 v o i);

      mkCl : NP  -> VV -> VP -> Cl = \s,v,vp -> PredVP s (ComplVV v vp) ;
      mkCl : NP  -> VS -> S  -> Cl = \s,v,p -> PredVP s (ComplVS v p) ;
      mkCl : NP  -> VQ -> QS -> Cl = \s,v,q -> PredVP s (ComplVQ v q) ;
      mkCl : NP  -> VA -> AP -> Cl = \s,v,q -> PredVP s (ComplVA v q) ;
      mkCl : NP  -> V2A ->NP -> AP -> Cl = \s,v,n,q -> PredVP s (ComplV2A v n q) ;



      mkCl : VP -> Cl          -- it rains
                                         =    ImpersCl   ;
      mkCl : NP  -> RS -> Cl   -- it is you who did it
                                         =    CleftNP    ;
      mkCl : Adv -> S  -> Cl   -- it is yesterday she arrived
                                         =    CleftAdv   ;
      mkCl : N -> Cl          -- there is a house
                                         =    \y -> ExistNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) (UseN y)) ;
      mkCl : CN -> Cl          -- there is a house
                                         =    \y -> ExistNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) y) ;
      mkCl : NP -> Cl          -- there is a house
                                         =    ExistNP    ;
      mkCl : NP -> AP -> Cl    -- John is nice and warm
	                                =     \x,y -> PredVP x (UseComp (CompAP y)) ;
      mkCl : NP -> A  -> Cl    -- John is warm
	                                =     \x,y -> PredVP x (UseComp (CompAP (PositA y))) ;
      mkCl : NP -> A -> NP -> Cl -- John is warmer than Mary
	                                =     \x,y,z -> PredVP x (UseComp (CompAP (ComparA y z))) ;
      mkCl : NP -> A2 -> NP -> Cl -- John is married to Mary
	                                =     \x,y,z -> PredVP x (UseComp (CompAP (ComplA2 y z))) ;
      mkCl : NP -> NP -> Cl    -- John is the man
	                                 =    \x,y -> PredVP x (UseComp (CompNP y)) ;
      mkCl : NP -> CN -> Cl    -- John is a man
	                                 =    \x,y -> PredVP x (UseComp (CompNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) y))) ;
      mkCl : NP -> N -> Cl    -- John is a man
	                                 =    \x,y -> PredVP x (UseComp (CompNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) (UseN y)))) ;
      mkCl : NP -> Adv -> Cl   -- John is here
	                                 =    \x,y -> PredVP x (UseComp (CompAdv y)) ;
      mkCl : V -> Cl   -- it rains
	                                 =    \v -> ImpersCl (UseV v)
      } ;

    genericCl : VP -> Cl = GenericCl ;

    mkNP = overload {
      mkNP : Det -> CN -> NP      -- the old man
                                         =    DetCN    ;
      mkNP : Det -> N -> NP       -- the man
                                         =    \d,n -> DetCN d (UseN n)   ;
      mkNP : Num -> CN -> NP      -- forty-five old men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) d NoOrd) n ;
      mkNP : Num -> N -> NP       -- forty-five men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) d NoOrd) (UseN n) ;

      mkNP : QuantSg -> CN -> NP = \q,n -> DetCN (DetSg q NoOrd) n ;
      mkNP : QuantSg -> N  -> NP = \q,n -> DetCN (DetSg q NoOrd) (UseN n) ;
      mkNP : QuantPl -> CN -> NP = \q,n -> DetCN (DetPl q NoNum NoOrd) n ;
      mkNP : QuantPl -> N  -> NP = \q,n -> DetCN (DetPl q NoNum NoOrd) (UseN n) ;

      mkNP : Pron    -> CN -> NP = \p,n -> DetCN (DetSg (SgQuant (PossPron p)) NoOrd) n ;
      mkNP : Pron    -> N  -> NP = \p,n -> DetCN (DetSg (SgQuant (PossPron p)) NoOrd) (UseN n) ;

      mkNP : Numeral -> CN -> NP      -- 51 old men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) (NumNumeral d) NoOrd) n ;
      mkNP : Numeral -> N -> NP       -- 51 men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) (NumNumeral d) NoOrd) (UseN n) ;
      mkNP : Int -> CN -> NP      -- 51 old men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) (NumInt d) NoOrd) n ;
      mkNP : Int -> N -> NP       -- 51 men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) (NumInt d) NoOrd) (UseN n) ;
      mkNP : Digit -> CN -> NP    ---- obsol
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d)))))) NoOrd) n ;
      mkNP : Digit -> N -> NP     ---- obsol
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d)))))) NoOrd) (UseN n) ;



      mkNP : PN -> NP             -- John
                                         =    UsePN    ;
      mkNP : Pron -> NP           -- he
                                         =    UsePron  ;
      mkNP : Predet -> NP -> NP  -- only the man
                                         =    PredetNP  ;
      mkNP : NP -> V2  -> NP      -- the number squared
                                         =    PPartNP  ;
      mkNP : NP -> Adv -> NP      -- Paris at midnight
                                         =    AdvNP ;
      mkNP : Conj -> NP -> NP -> NP
                                        = \c,x,y -> ConjNP c (BaseNP x y) ;
      mkNP : DConj -> NP -> NP -> NP
                                        = \c,x,y -> DConjNP c (BaseNP x y) ;
      mkNP : Conj -> ListNP -> NP
                                        = \c,xy -> ConjNP c xy ;
      mkNP : DConj -> ListNP -> NP
                                        = \c,xy -> DConjNP c xy
      } ;

    mkDet = overload {
      mkDet : QuantSg ->        Ord -> Det     -- this best man
                                         =    DetSg     ;
      mkDet : QuantSg ->  Det       -- this man
                                         =    \q -> DetSg q NoOrd  ;
      mkDet : QuantPl -> Num -> Ord -> Det     -- these five best men
                                         =    DetPl     ;
      mkDet : QuantPl -> Det     -- these men
                                         =    \q -> DetPl q NoNum NoOrd   ;
      mkDet : Quant ->  Det       -- this man
                                         =    \q -> DetSg (SgQuant q) NoOrd  ;
      mkDet : Quant -> Num -> Det       -- these five man
                                         =    \q,nu -> DetPl (PlQuant q) nu NoOrd  ;
      mkDet : Num ->  Det       -- forty-five men
                                         =    \n -> DetPl (PlQuant IndefArt) n NoOrd  ;
      mkDet : Int -> Det          -- 51 (men)
                                         =    \n -> DetPl (PlQuant IndefArt) (NumInt n) NoOrd  ;
      mkDet : Digit -> Det  ---- obsol
	                                 =    \d -> DetPl (PlQuant IndefArt) (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d)))))) NoOrd ;   
      mkDet : Numeral -> Det  --
	                                 =    \d -> DetPl (PlQuant IndefArt) (NumNumeral d) NoOrd ;   

      mkDet : Pron -> Det      -- my (house)
                                         =    \p -> DetSg (SgQuant (PossPron p)) NoOrd
      } ;


      defSgDet   : Det  = DetSg (SgQuant DefArt) NoOrd ;   -- the (man)
      defPlDet   : Det  = DetPl (PlQuant DefArt) NoNum NoOrd ;   -- the (man)
      indefSgDet : Det  = DetSg (SgQuant IndefArt) NoOrd ;   -- the (man)
      indefPlDet : Det  = DetPl (PlQuant IndefArt) NoNum NoOrd ;   -- the (man)

    ---- obsol
    def_Det : Det = DetSg (SgQuant DefArt) NoOrd ;   -- the (man)
    indef_Det : Det = DetSg (SgQuant IndefArt) NoOrd ; -- a (man)
    mass_Det : Det = DetSg MassDet NoOrd;  -- (water)

    mkQuantSg : Quant -> QuantSg = SgQuant ;
    mkQuantPl : Quant -> QuantPl = PlQuant ;

    defQuant = DefArt ;
    indefQuant = IndefArt ;   

    massQuant : QuantSg = MassDet  ;



    mkNum = overload {
      mkNum : Numeral -> Num = NumNumeral ;
      mkNum : Int -> Num         -- 51
                                         =    NumInt      ;
      mkNum : Digit -> Num
                                         =    \d -> 
        NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d))))) ;

      mkNum : AdN -> Num -> Num = AdNum
      } ;

      noNum : Num                -- [no num]
                                         =    NoNum       ;

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


    mkAdN : CAdv -> AdN = AdnCAdv ;                  -- more (than five)

    mkOrd = overload {
      mkOrd : Numeral -> Ord = OrdNumeral ;
      mkOrd : Int -> Ord         -- 51st
                                         =    OrdInt      ;
      mkOrd : Digit -> Ord       -- fifth
                                         =    \d -> 
        OrdNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d))))) ;
      mkOrd : A -> Ord           -- largest
                                         =    OrdSuperl
      } ;

      noOrd : Ord                -- [no ord]
                                         =    NoOrd       ;


    mkCN = overload {
      mkCN : N  -> CN            -- house
                                         =    UseN     ;
      mkCN : N2 -> NP -> CN      -- son of the king
                                         =    ComplN2  ;
      mkCN : N3 -> NP -> NP -> CN      -- flight from Moscow (to Paris)
                                         =    \f,x -> ComplN2 (ComplN3 f x)  ;
      mkCN : N2 -> CN            -- son
                                         =    UseN2    ;
      mkCN : N3 -> CN            -- flight
                                         =    UseN3    ;
      mkCN : AP -> CN  -> CN     -- nice and big blue house
                                         =    AdjCN    ;
      mkCN : AP ->  N  -> CN     -- nice and big house
                                         =    \x,y -> AdjCN x (UseN y)   ;
      mkCN : CN -> AP  -> CN     -- nice and big blue house
                                         =    \x,y -> AdjCN y x    ;
      mkCN :  N -> AP  -> CN     -- nice and big house
                                         =    \x,y -> AdjCN y (UseN x)    ;
      mkCN :  A -> CN  -> CN     -- big blue house
	                                 =    \x,y -> AdjCN (PositA x) y;
      mkCN :  A ->  N  -> CN     -- big house
	                                 =    \x,y -> AdjCN (PositA x) (UseN y);
      mkCN : CN -> RS  -> CN     -- house that John owns
                                         =    RelCN    ;
      mkCN :  N -> RS  -> CN     -- house that John owns
                                         =    \x,y -> RelCN (UseN x) y   ;
      mkCN : CN -> Adv -> CN     -- house on the hill
                                         =    AdvCN    ;
      mkCN :  N -> Adv -> CN     -- house on the hill
                                         =    \x,y -> AdvCN (UseN x) y  ;
      mkCN : CN -> S   -> CN     -- fact that John smokes
                                         =    \cn,s -> SentCN cn (EmbedS s) ;
      mkCN : CN -> QS  -> CN     -- question if John smokes
                                         =    \cn,s -> SentCN cn (EmbedQS s) ;
      mkCN : CN -> VP  -> CN     -- reason to smoke
                                         =    \cn,s -> SentCN cn (EmbedVP s) ;
      mkCN : CN -> NP  -> CN     -- number x, numbers x and y
                                         =    ApposCN ;
      mkCN :  N -> NP  -> CN     -- number x, numbers x and y
                                         =    \x,y -> ApposCN (UseN x) y
      } ;


    mkPhr = overload {
      mkPhr : PConj -> Utt -> Voc -> Phr   -- But go home my friend
                                         =    PhrUtt    ;
      mkPhr : Utt -> Voc -> Phr
                                         =    \u,v -> PhrUtt NoPConj u v ;
      mkPhr : PConj -> Utt -> Phr
                                         =    \u,v -> PhrUtt u v NoVoc ;
      mkPhr : Utt -> Phr   -- Go home
                                         =    \u -> PhrUtt NoPConj u NoVoc   ;
      mkPhr : S -> Phr   -- I go home
                                         =    \s -> PhrUtt NoPConj (UttS s) NoVoc ; 
      mkPhr : Cl -> Phr   -- I go home
                                         =    \s -> PhrUtt NoPConj (UttS (UseCl TPres ASimul PPos s)) NoVoc ; 
      mkPhr : QS -> Phr   -- I go home
                                         =    \s -> PhrUtt NoPConj (UttQS s) NoVoc ;
      mkPhr : Imp -> Phr   -- I go home
                                         =    \s -> PhrUtt NoPConj (UttImpSg PPos s) NoVoc 

      } ;

    mkPConj : Conj -> PConj = PConjConj ;
    noPConj : PConj = NoPConj ;

    mkVoc   : NP -> Voc  = VocNP ;
    noVoc   : Voc  = NoVoc ;

    positivePol : Pol = PPos ; 
    negativePol : Pol = PNeg ;

    simultaneousAnt : Ant = ASimul ; 
    anteriorAnt : Ant = AAnter ; --# notpresent

    presentTense     : Tense = TPres ;
    pastTense        : Tense = TPast ; --# notpresent
    futureTense      : Tense = TFut ;  --# notpresent
    conditionalTense : Tense = TCond ; --# notpresent

  param ImpForm = IFSg | IFPl | IFPol ;

  oper
    singularImpForm  : ImpForm = IFSg ;
    pluralImpForm  : ImpForm = IFPl ;
    politeImpForm : ImpForm = IFPol ;

    mkUttImp : ImpForm -> Pol -> Imp -> Utt = \f,p,i -> case f of {
      IFSg  => UttImpSg p i ;
      IFPl  => UttImpPl p i ;
      IFPol => UttImpPol p i
      } ;

    mkUtt = overload {
      mkUtt : S -> Utt                     -- John walked
                                         =    UttS      ;
      mkUtt : Cl -> Utt                     -- John walks
	                                 =    \c -> UttS (UseCl TPres ASimul PPos c);
      mkUtt : QS -> Utt                    -- is it good
                                         =    UttQS     ;
      mkUtt : ImpForm -> Pol -> Imp -> Utt -- don't help yourselves
                                         =    mkUttImp  ;
      mkUtt : ImpForm ->        Imp -> Utt -- help yourselves
                                         =  \f -> mkUttImp f PPos ;
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
      mkUtt : VP   -> Utt                   -- to sleep
                                         =    UttVP 
      } ;

    lets_Utt : VP -> Utt = ImpPl1 ;

    mkQCl = overload {

      mkQCl : Cl -> QCl                    -- does John walk
                                         =    QuestCl      ;
      mkQCl : IP -> VP -> QCl              -- who walks
                                         =    QuestVP      ;
      mkQCl : IP -> Slash -> QCl           -- who does John love
                                         =    QuestSlash   ;
      mkQCl : IP -> NP -> V2 -> QCl           -- who does John love
                                         =    \ip,np,v -> QuestSlash ip (SlashV2 np v)  ;
      mkQCl : IAdv -> Cl -> QCl            -- why does John walk
                                         =    QuestIAdv    ;
      mkQCl : Prep -> IP -> Cl -> QCl      -- with whom does John walk
                                         =    \p,ip -> QuestIAdv (PrepIP p ip)  ;
      mkQCl : IAdv -> NP -> QCl   -- where is John
                                         =    \a -> QuestIComp (CompIAdv a)   ;
      mkQCl : IP -> QCl         -- which houses are there
                                         =    ExistIP 

      } ;

    mkIP = overload {
      mkIP : IDet -> Num -> Ord -> CN -> IP   -- which five best songs
                                         =    IDetCN   ;
      mkIP : IDet -> Ord -> CN -> IP   -- which five best songs
                                         = \i ->   IDetCN i NoNum  ;
      mkIP : IDet -> Num -> CN -> IP   -- which five best songs
                                         = \i,n ->   IDetCN i n NoOrd  ;
      mkIP : IDet -> N -> IP      -- which song
                                         =    \i,n -> IDetCN i NoNum NoOrd (UseN n)  ;
      mkIP : IP -> Adv -> IP                  -- who in Europe
                                         =    AdvIP
      } ;

    mkIAdv : Prep -> IP -> IAdv = PrepIP ;

    mkRCl = overload {
      mkRCl : Cl -> RCl              -- such that John loves her
                                         =    RelCl     ;
      mkRCl : RP -> VP -> RCl        -- who loves John
                                         =    RelVP     ;
      mkRCl : RP -> Slash -> RCl     -- whom John loves
                                         =    RelSlash ;
      mkRCl : RP -> NP -> V2 -> RCl     -- whom John loves
                                         =  \rp,np,v2 -> RelSlash rp (SlashV2 np v2)
      } ;

    which_RP : RP                        -- which
                                         =    IdRP   ;
    mkRP : Prep -> NP -> RP -> RP    -- all the roots of which
                                         =    FunRP
      ;

    mkSlash = overload {
      mkSlash : NP -> V2 -> Slash        -- (whom) he sees
                                         =    SlashV2    ;
      mkSlash : NP -> VV -> V2 -> Slash  -- (whom) he wants to see
                                         =    SlashVVV2  ;
      mkSlash : Slash -> Adv -> Slash    -- (whom) he sees tomorrow
                                         =    AdvSlash   ;
      mkSlash : Cl -> Prep -> Slash      -- (with whom) he walks
                                         =    SlashPrep
      } ;

    mkImp = overload {
      mkImp : VP -> Imp                -- go
                                         =    ImpVP      ;
      mkImp : V  -> Imp
                                         =    \v -> ImpVP (UseV v)  ;
      mkImp : V2 -> NP -> Imp
                                         =    \v,np -> ImpVP (ComplV2 v np)
      } ;

    mkS = overload {
      mkS : Cl  -> S
                                         =    UseCl TPres ASimul PPos ;
      mkS : Tense -> Cl -> S 
	                                 =    \t -> UseCl t ASimul PPos ;
      mkS : Ant -> Cl -> S
                                         =    \a -> UseCl TPres a PPos ;
      mkS : Pol -> Cl -> S
                                         =    \p -> UseCl TPres ASimul p ;
      mkS : Tense -> Ant -> Cl -> S
                                         =    \t,a -> UseCl t a PPos ;
      mkS : Tense -> Pol -> Cl -> S
                                         =    \t,p -> UseCl t ASimul p ;
      mkS : Ant -> Pol -> Cl -> S
                                         =    \a,p -> UseCl TPres a p ;
      mkS : Tense -> Ant -> Pol -> Cl  -> S
                                         =    UseCl   ;
      mkS : Conj -> S -> S -> S
                                        = \c,x,y -> ConjS c (BaseS x y) ;
      mkS : DConj -> S -> S -> S
                                        = \c,x,y -> DConjS c (BaseS x y) ;
      mkS : Conj -> ListS -> S
                                        = \c,xy -> ConjS c xy ;
      mkS : DConj -> ListS -> S
                                        = \c,xy -> DConjS c xy ;
      mkS : Adv -> S -> S 
                                        = AdvS

      } ;

    mkQS = overload {

      mkQS : QCl  -> QS
                                         =    UseQCl TPres ASimul PPos ;
      mkQS : Tense -> QCl -> QS 
	                                 =    \t -> UseQCl t ASimul PPos ;
      mkQS : Ant -> QCl -> QS
                                         =    \a -> UseQCl TPres a PPos ;
      mkQS : Pol -> QCl -> QS
                                         =    \p -> UseQCl TPres ASimul p ;
      mkQS : Tense -> Ant -> QCl -> QS
                                         =    \t,a -> UseQCl t a PPos ;
      mkQS : Tense -> Pol -> QCl -> QS
                                         =    \t,p -> UseQCl t ASimul p ;
      mkQS : Ant -> Pol -> QCl -> QS
                                         =    \a,p -> UseQCl TPres a p ;
      mkQS : Tense -> Ant -> Pol -> QCl -> QS
                                         =    UseQCl  ;
      mkQS : Cl   -> QS                  
	                                 =    \x -> UseQCl TPres ASimul PPos (QuestCl x)
      } ;


    mkRS = overload {

      mkRS : RCl  -> RS
                                         =    UseRCl TPres ASimul PPos ;
      mkRS : Tense -> RCl -> RS 
	                                 =    \t -> UseRCl t ASimul PPos ;
      mkRS : Ant -> RCl -> RS
                                         =    \a -> UseRCl TPres a PPos ;
      mkRS : Pol -> RCl -> RS
                                         =    \p -> UseRCl TPres ASimul p ;
      mkRS : Tense -> Ant -> RCl -> RS
                                         =    \t,a -> UseRCl t a PPos ;
      mkRS : Tense -> Pol -> RCl -> RS
                                         =    \t,p -> UseRCl t ASimul p ;
      mkRS : Ant -> Pol -> RCl -> RS
                                         =    \a,p -> UseRCl TPres a p ;
      mkRS : Tense -> Ant -> Pol -> RCl -> RS
                                         =    UseRCl  
      } ;

  param Punct = PFullStop | PExclMark | PQuestMark ;

  oper
    emptyText : Text = TEmpty ;       -- [empty text]

    fullStopPunct  : Punct = PFullStop ; -- .
    questMarkPunct : Punct = PQuestMark ; -- ?
    exclMarkPunct  : Punct = PExclMark ; -- !


    mkText = overload {
      mkText : Phr -> Punct -> Text -> Text =
        \phr,punct,text -> case punct of {
          PFullStop => TFullStop phr text ; 
          PExclMark => TExclMark phr text ;
          PQuestMark => TQuestMark phr text
          } ;
      mkText : Phr -> Punct -> Text =
        \phr,punct -> case punct of {
          PFullStop => TFullStop phr TEmpty ; 
          PExclMark => TExclMark phr TEmpty ;
          PQuestMark => TQuestMark phr TEmpty
          } ;
      mkText : Phr -> Text            -- John walks.
                                         =    \x -> TFullStop x TEmpty  ;
      mkText : Utt -> Text
	                                 =    \u -> TFullStop (PhrUtt NoPConj u NoVoc) TEmpty ;
      mkText : S -> Text
	                                 =    \s -> TFullStop (PhrUtt NoPConj (UttS s) NoVoc) TEmpty;
      mkText : Cl -> Text
	                                 =    \c -> TFullStop (PhrUtt NoPConj (UttS (UseCl TPres ASimul PPos c)) NoVoc) TEmpty;
      mkText : QS -> Text
	                                 =    \q -> TQuestMark (PhrUtt NoPConj (UttQS q) NoVoc) TEmpty ;
      mkText : Imp -> Text
	                                 =    \i -> TExclMark (PhrUtt NoPConj (UttImpSg PPos i) NoVoc) TEmpty;
      mkText : Pol -> Imp -> Text 
	                                 =    \p,i -> TExclMark (PhrUtt NoPConj (UttImpSg p i) NoVoc) TEmpty;
      mkText : Phr -> Text -> Text    -- John walks. ...
                                         =    TFullStop
      } ;

    mkVP = overload {
      mkVP : V   -> VP                -- sleep
                                         =    UseV      ;
      mkVP : V2  -> NP -> VP          -- use it
                                         =    ComplV2   ;
      mkVP : V3  -> NP -> NP -> VP    -- send a message to her
                                         =    ComplV3   ;
      mkVP : VV  -> VP -> VP          -- want to run
                                         =    ComplVV   ;
      mkVP : VS  -> S  -> VP          -- know that she runs
                                         =    ComplVS   ;
      mkVP : VQ  -> QS -> VP          -- ask if she runs
                                         =    ComplVQ   ;
---      mkVP : VS  -> NP -> VP = \v -> ComplV2 (UseVS v) ;
---      mkVP : VQ  -> NP -> VP = \v -> ComplV2 (UseVQ v) ;
      mkVP : VA  -> AP -> VP          -- look red
                                         =    ComplVA   ;
      mkVP : V2A -> NP -> AP -> VP    -- paint the house red
                                         =    ComplV2A  ;
      mkVP : A -> VP               -- be warm
                                         =    \a -> UseComp (CompAP (PositA a)) ;
      mkVP : A -> NP -> VP -- John is warmer than Mary
	                                =     \y,z -> (UseComp (CompAP (ComparA y z))) ;
      mkVP : A2 -> NP -> VP -- John is married to Mary
	                                =     \y,z -> (UseComp (CompAP (ComplA2 y z))) ;
      mkVP : AP -> VP               -- be warm
                                         =    \a -> UseComp (CompAP a)   ;
      mkVP : NP -> VP               -- be a man
                                         =    \a -> UseComp (CompNP a)   ;
      mkVP : CN -> VP               -- be a man
                             = \y -> (UseComp (CompNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) y))) ;
      mkVP : N -> VP               -- be a man
                             = \y -> (UseComp (CompNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) (UseN y)))) ;
      mkVP : Adv -> VP               -- be here
                                         =    \a -> UseComp (CompAdv a)   ;
      mkVP : VP -> Adv -> VP          -- sleep here
                                         =    AdvVP     ;
      mkVP : AdV -> VP -> VP          -- always sleep
                                         =    AdVVP
      } ;

  reflexiveVP   : V2 -> VP = ReflV2 ;
  passiveVP = overload {
      passiveVP : V2 ->       VP = PassV2 ;
      passiveVP : V2 -> NP -> VP = \v,np -> 
        (AdvVP (PassV2 v) (PrepNP by8agent_Prep np))
      } ;
  progressiveVP : VP -> VP = ProgrVP ;


  mkListS = overload {
   mkListS : S -> S -> ListS = BaseS ;
   mkListS : S -> ListS -> ListS = ConsS
   } ;

  mkListAP = overload {
   mkListAP : AP -> AP -> ListAP = BaseAP ;
   mkListAP : AP -> ListAP -> ListAP = ConsAP
   } ;

  mkListAdv = overload {
   mkListAdv : Adv -> Adv -> ListAdv = BaseAdv ;
   mkListAdv : Adv -> ListAdv -> ListAdv = ConsAdv
   } ;

  mkListNP = overload {
   mkListNP : NP -> NP -> ListNP = BaseNP ;
   mkListNP : NP -> ListNP -> ListNP = ConsNP
   } ;


    mkInt : Str -> {s : Str ; size : Predef.Ints 1 ; last : Predef.Ints 9 ; lock_Int : {}} = \s -> {
      s = s ;
      last = case s of {
        _ + "0" => 0 ;
        _ + "1" => 1 ;
        _ + "2" => 2 ;
        _ => 3 ----
        } ;
      size = case s of {
        "1" => 0 ;
        _ => 1
        } ;
      lock_Int = <>
      } ;

}
