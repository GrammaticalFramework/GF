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
--   a total order. Often the most common is also the most general.
-- + Each constructor case is equipped with an example that is built by that
--   case but could not be built with any other one.
--
--
-- *NB* the ones marked with $--%$ are currently not implemented.

--2 Texts, phrases, and utterances

--3 Text: texts

-- A text is a list of phrases separated by punctuation marks.
-- The default punctuation mark is the full stop, and the default
-- continuation of a text is empty.

  oper
    mkText : overload {
      mkText : Phr ->                  Text ; -- John walks.
      mkText : Phr ->          Text -> Text ; -- John walks. Yes!
      mkText : Phr -> Punct ->         Text ; -- John walks!
      mkText : Phr -> Punct -> Text -> Text ; -- John walks? Yes!

-- A text can also be directly built from utterances, which in turn can
-- be directly built from sentences, present-tense clauses, questions, or
-- positive imperatives. 

      mkText : Utt ->                  Text ; -- John.
      mkText : S   ->                  Text ; -- John walked.
      mkText : Cl  ->                  Text ; -- John walks.
      mkText : QS  ->                  Text ; -- Did John walk?
      mkText : Imp ->                  Text   -- Walk!
      } ;

-- A text can also be empty.

      emptyText :                      Text ; -- [empty text]


--3 Punct: punctuation marks

-- There are three punctuation marks that can separate phrases in a text.

      fullStopPunct  : Punct ;     -- .
      questMarkPunct : Punct ;     -- ?
      exclMarkPunct  : Punct ;     -- !

--3 Phr: phrases in a text

-- Phrases are built from utterances by adding a phrasal conjunction
-- and a vocative, both of which are by default empty.

    mkPhr : overload {
      mkPhr :          Utt ->        Phr ;  -- why
      mkPhr :          Utt -> Voc -> Phr ;  --% why John
      mkPhr : PConj -> Utt ->        Phr ;  --% but why
      mkPhr : PConj -> Utt -> Voc -> Phr ;  -- but why John


-- A phrase can also be directly built by a sentence, a present-tense
-- clause, a question, or an imperative. Imperatives have by default 
-- positive polarity.

      mkPhr : S   ->                 Phr ; -- John walked
      mkPhr : Cl  ->                 Phr ; -- John walks
      mkPhr : QS  ->                 Phr ; --% Did John walk?
      mkPhr : Imp ->                 Phr   --% Walk!
      } ;

--3 PConj, phrasal conjunctions

-- Any conjunction can be used as a phrasal conjunction.
-- More phrasal conjunctions are defined in $Structural$.

      mkPConj : Conj -> PConj ;            -- and

--3 Voc, vocatives

-- Any noun phrase can be turned into a vocative.
-- More vocatives are defined in $Structural$.

      mkVoc   : NP -> Voc ;                -- John

--3 Utt, utterances

-- Utterances are formed from sentences, questions, and imperatives.

    mkUtt : overload {
      mkUtt : S ->                      Utt ;  -- John walked
      mkUtt : Cl ->                     Utt ;  -- John walks
      mkUtt : QS ->                     Utt ;  -- did John walk

-- Imperatives vary in $ImpForm$ (number/politeness) and 
-- polarity.

      mkUtt :                    Imp -> Utt ;  -- help yourself
      mkUtt :            Pol  -> Imp -> Utt ;  -- don't help yourself
      mkUtt : ImpForm ->         Imp -> Utt ;  -- help yourselves
      mkUtt : ImpForm -> Pol  -> Imp -> Utt ;  -- don't help yourselves

-- Utterances can also be formed from interrogative phrases and
-- interrogative adverbials, noun phrases, adverbs, and verb phrases.

      mkUtt : IP   ->                   Utt ;  -- who
      mkUtt : IAdv ->                   Utt ;  -- why
      mkUtt : NP   ->                   Utt ;  -- this man
      mkUtt : Adv  ->                   Utt ;  -- here
      mkUtt : VP   ->                   Utt    -- to walk
      } ;

-- The plural first-person imperative is a special construction.

      letsUtt : VP ->                   Utt ;  -- let's walk


--2 Auxiliary parameters for phrases and sentences

--3 Pol, polarity

-- Polarity is a parameter that sets a clause to positive or negative
-- form. Since positive is the default, it need never be given explicitly.

      posPol : Pol ;             -- (John walks) [default]
      negPol : Pol ;             -- (John doesn't walk)

--3 Ant, anteriority

-- Anteriority is a parameter that presents an event as simultaneous or
-- anterior to some other reference time.
-- Since simultaneous is the default, it need never be given explicitly.

      simulAnt : Ant ;           -- (John walks) [default]
      anterAnt : Ant ;           -- (John has walked)       --# notpresent

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

      sgImpForm  : ImpForm ;     -- (help yourself) [default]
      plImpForm  : ImpForm ;     -- (help yourselves)
      polImpForm : ImpForm ;     -- (help yourself) [polite singular]


--2 Sentences and clauses

--3 S, sentences

-- A sentence has a fixed tense, anteriority and polarity.

    mkS : overload {
      mkS :                        Cl -> S ;  -- John walks
      mkS :                 Pol -> Cl -> S ;  -- John doesn't walk
      mkS :          Ant ->        Cl -> S ;  -- John has walked
      mkS :          Ant -> Pol -> Cl -> S ;  -- John hasn't walked
      mkS : Tense ->               Cl -> S ;  -- John walked
      mkS : Tense ->        Pol -> Cl -> S ;  -- John didn't walk
      mkS : Tense -> Ant ->        Cl -> S ;  -- John had walked
      mkS : Tense -> Ant -> Pol -> Cl -> S ;  -- John wouldn't have walked

-- Sentences can be combined with conjunctions. This can apply to a pair
-- of sentences, but also to a list of more than two.

      mkS : Conj  ->           S -> S -> S ;  -- John walks and Mary talks   
      mkS : Conj  -> ListS ->            S ;  -- John walks, Mary talks, and Bob runs
      mkS : DConj ->           S -> S -> S ;  -- either John walks or Mary runs
      mkS : DConj -> ListS  ->           S ;  -- either John walks, Mary talks, or Bob runs

-- A sentence can be prefixed by an adverb.

      mkS : Adv -> S                  -> S    -- today, John will walk
      } ;

--3 Cl, clauses

-- A clause has a variable tense, anteriority and polarity.
-- A clause can be built from a subject noun phrase 
-- with a verb and appropriate arguments.

    mkCl : overload {
      mkCl : NP  -> V  ->             Cl ;    -- John walks
      mkCl : NP  -> V2 -> NP ->       Cl ;    -- John loves her
      mkCl : NP  -> V3 -> NP -> NP -> Cl ;    --% John sends it to her
      mkCl : NP  -> AP ->             Cl ;    -- John is nice and warm
      mkCl : NP  -> A  ->             Cl ;    -- John is nice
      mkCl : NP  -> A  -> NP ->       Cl ;    -- John is nicer than Mary
      mkCl : NP  -> A2 -> NP ->       Cl ;    -- John is married to Mary
      mkCl : NP  -> NP ->             Cl ;    -- John is the man
      mkCl : NP  -> CN ->             Cl ;    --% John is an old man
      mkCl : NP  -> N  ->             Cl ;    --% John is a man
      mkCl : NP  -> Adv ->            Cl ;    -- John is here

-- More generally, clause can be built from a subject noun phrase and 
-- a verb phrase.

      mkCl : NP  -> VP ->             Cl ;    -- John wants to walk

-- Subjectless verb phrases are used for impersonal actions.

      mkCl : V   ->                   Cl ;    --% it rains
      mkCl : VP  ->                   Cl ;    -- it is getting warm

-- Existentials are a special form of clauses.

      mkCl : NP  ->                   Cl ;    -- there is a house

-- There are also special forms in which a noun phrase or an adverb is
-- emphasized.

      mkCl : NP  -> RS ->             Cl ;    -- it is John who walks
      mkCl : Adv -> S  ->             Cl      -- it is here John walks
      } ;

-- Generic clauses have an impersonal subject.

      genericCl : VP ->               Cl ;    -- one walks              


--2 Verb phrases and imperatives

--3 VP, verb phrases

-- A verb phrase is formed from a verb with appropriate arguments.

    mkVP : overload {
      mkVP : V   ->             VP ;  -- walk
      mkVP : V2  -> NP ->       VP ;  -- love her
      mkVP : V3  -> NP -> NP -> VP ;  -- send it to her
      mkVP : VV  -> VP ->       VP ;  -- want to walk
      mkVP : VS  -> S  ->       VP ;  -- know that she walks
      mkVP : VQ  -> QS ->       VP ;  -- ask if she walks
      mkVP : VA  -> AP ->       VP ;  -- become warm
      mkVP : V2A -> NP -> AP -> VP ;  -- paint the house red

-- The verb can also be a copula ("be"), and the relevant argument is
-- then the complement adjective or noun phrase.

      mkVP : A   ->             VP ;  --% be warm
      mkVP : AP  ->             VP ;  -- be very warm
      mkVP : N   ->             VP ;  --% be a man
      mkVP : CN  ->             VP ;  --% be an old man
      mkVP : NP  ->             VP ;  -- be the old man
      mkVP : Adv ->             VP ;  -- be here

-- A verb phrase can be modified with a postverbal or a preverbial adverb.

      mkVP : VP  -> Adv ->      VP ;  -- sleep here
      mkVP : AdV -> VP  ->      VP    -- always sleep
      } ;

-- Two-place verbs can be used reflexively.

      reflexiveVP : V2 -> VP ;        -- love itself

-- Two-place verbs can also be used in the passive, with or without an agent.

    passiveVP : overload {
      passiveVP : V2 ->       VP ;    --% be loved
      passiveVP : V2 -> NP -> VP ;    --% be loved by her
      } ;

-- A verb phrase can be turned into the progressive form.

      progressiveVP : VP -> VP ;      -- be sleeping

--3 Imp, imperatives

-- Imperatives are formed from verbs and their arguments; in the general
-- case, from verb phrases.

    mkImp : overload {
      mkImp : V  ->          Imp  ;   -- go
      mkImp : V2 -> NP ->    Imp  ;   -- take it
      mkImp : VP ->          Imp      -- go there now
      } ;



--2 Noun phrases and determiners


    mkNP : overload {
      mkNP : Det -> CN -> NP  ;        -- the old man
      mkNP : Det -> N  -> NP   ;       -- the man
      mkNP : Num -> CN -> NP  ;        -- forty-five old men
      mkNP : Num -> N  -> NP   ;       -- forty-five men
      mkNP : Int -> CN -> NP  ;        -- 51 old men
      mkNP : Int -> N  -> NP   ;       -- 51 men
      mkNP : Digit -> CN -> NP;        -- five old men
      mkNP : Digit -> N -> NP ;        -- five men
      mkNP : PN -> NP         ;        -- John
      mkNP : Pron -> NP       ;        -- he
      mkNP : Predet -> NP -> NP ;      -- all the men
      mkNP : NP -> V2  -> NP  ;        -- the number squared
      mkNP : NP -> Adv -> NP  ;        -- Paris at midnight
      mkNP : Conj -> NP -> NP -> NP ;  -- John and Mary
      mkNP : DConj -> NP -> NP -> NP ; -- both John and Mary
      mkNP : Conj -> ListNP -> NP ;    -- John, Mary, and Bill
      mkNP : DConj -> ListNP -> NP     -- both John, Mary, and Bill

      } ;

    mkDet : overload {
      mkDet : QuantSg ->        Ord -> Det ; -- this best
      mkDet : QuantSg ->               Det ; -- this
      mkDet : QuantPl -> Num -> Ord -> Det ; -- these five best
      mkDet : QuantPl ->               Det ; -- these
      mkDet : Quant ->                 Det ; -- this
      mkDet : Quant ->          Num -> Det ; -- these five
      mkDet : Num ->                   Det ; -- forty-five
      mkDet : Int ->                   Det ; -- 51
      mkDet : Digit ->                 Det ; -- five
      mkDet : Pron  ->                 Det   -- my
      } ;

      mkQuantSg : Quant -> QuantSg ;

      mkQuantPl : Quant -> QuantPl ;


   def_Det   : Det ;   -- the (man)
   indef_Det : Det ;   -- a (man)
   mass_Det  : Det ;   -- (water)

-- More determiners are available in the Structural module
   

--2 Numerals - cardinal and ordinal 

    mkNum : overload {
      mkNum : Numeral    -> Num ;
      mkNum : Digit      -> Num ;
      mkNum : Int        -> Num ;   -- 51
      mkNum : AdN -> Num -> Num 
      } ;

      noNum : Num            ;      -- [no num]

      mkAdN : CAdv -> AdN ;         -- more (than five)


    mkOrd : overload {
      mkOrd : Numeral -> Ord ;
      mkOrd : Digit -> Ord   ;   -- fifth
      mkOrd : Int   -> Ord   ;   -- 51st
      mkOrd : A     -> Ord       -- largest
      } ;

      noOrd : Ord            ;   -- [no ord]



--2 Common nouns

    mkCN : overload {
      mkCN : N  -> CN               ;   -- house
      mkCN : N2 -> NP -> CN         ;   -- son of the king
      mkCN : N3 -> NP -> NP -> CN   ;   -- flight from Moscow (to Paris)
      mkCN : N2 -> CN               ;   -- son
      mkCN : N3 -> CN               ;   -- flight
      mkCN : AP -> CN  -> CN        ;   -- nice and big blue house
      mkCN : AP ->  N  -> CN        ;   -- nice and big house
      mkCN : CN -> AP  -> CN        ;   -- nice and big blue house
      mkCN :  N -> AP  -> CN        ;   -- nice and big house
      mkCN :  A -> CN  -> CN        ;   -- big blue house
      mkCN :  A ->  N  -> CN        ;   -- big house
      mkCN : CN -> RS  -> CN        ;   -- house that John owns
      mkCN :  N -> RS  -> CN        ;   -- house that John owns
      mkCN : CN -> Adv -> CN        ;   -- house on the hill
      mkCN :  N -> Adv -> CN        ;   -- house on the hill
      mkCN : CN -> S   -> CN        ;   -- fact that John smokes
      mkCN : CN -> QS  -> CN        ;   -- question if John smokes
      mkCN : CN -> VP  -> CN        ;   -- reason to smoke
      mkCN : CN -> NP  -> CN        ;   -- number x, numbers x and y
      mkCN :  N -> NP  -> CN            -- number x, numbers x and y
      } ;

--2 Adjectival phrases

    mkAP : overload {
      mkAP : A -> AP        ;         -- warm
      mkAP : A -> NP -> AP  ;         -- warmer than Spain
      mkAP : A2 -> NP -> AP ;         -- divisible by 2
      mkAP : A2 -> AP       ;         -- divisible by itself
      mkAP : AP -> S  -> AP ;         -- great that she won
      mkAP : AP -> QS -> AP ;         -- uncertain if she won
      mkAP : AP -> VP -> AP ;         -- ready to go
      mkAP : AdA -> AP -> AP ;        -- very uncertain
      mkAP : Conj -> AP -> AP -> AP ; -- warm and nice
      mkAP : DConj -> AP -> AP -> AP ;-- both warm and nice
      mkAP : Conj -> ListAP -> AP ;   -- warm, nice, and cheap
      mkAP : DConj -> ListAP -> AP    -- both warm, nice, and cheap

      } ;

--2 Adverbs

    mkAdv : overload {
      mkAdv : A -> Adv               ;    -- quickly
      mkAdv : Prep -> NP -> Adv      ;    -- in the house
      mkAdv : CAdv -> A -> NP -> Adv ;    -- more quickly than John
      mkAdv : CAdv -> A -> S -> Adv  ;    -- more quickly than he runs
      mkAdv : AdA -> Adv -> Adv      ;    -- very quickly
      mkAdv : Subj -> S -> Adv       ;    -- when he arrives
      mkAdv : Conj -> Adv -> Adv -> Adv;  -- here and now
      mkAdv : DConj -> Adv -> Adv -> Adv; -- both here and now
      mkAdv : Conj -> ListAdv -> Adv ;    -- here, now, and with you
      mkAdv : DConj -> ListAdv -> Adv     -- both here, now, and with you
      } ;

--2 Questions and interrogative pronouns

    mkQS : overload {
      mkQS : Tense -> Ant -> Pol -> QCl -> QS ; -- wouldn't John have walked
      mkQS : QCl  -> QS                       ; -- who walks
      mkQS : Cl   -> QS                         -- does John walk
      } ;

    mkQCl : overload {
      mkQCl : Cl -> QCl                ;   -- does John walk
      mkQCl : IP -> VP -> QCl          ;   -- who walks
      mkQCl : IP -> Slash -> QCl       ;   -- who does John love
      mkQCl : IP -> NP -> V2 -> QCl    ;   -- who does John love
      mkQCl : IAdv -> Cl -> QCl        ;   -- why does John walk
      mkQCl : Prep -> IP -> Cl -> QCl  ;   -- with whom does John walk
      mkQCl : IAdv -> NP -> QCl        ;   -- where is John
      mkQCl : IP -> QCl                    -- which houses are there
      } ;

    mkIP : overload {
      mkIP : IDet -> Num -> Ord -> CN -> IP ; -- which five best songs
      mkIP : IDet -> N -> IP              ;   -- which song
      mkIP : IP -> Adv -> IP                  -- who in Europe
      } ;

    mkIAdv : Prep -> IP -> IAdv ;             -- in which city

--2 Relative clauses and relative pronouns

    mkRS : overload {
      mkRS : Tense -> Ant -> Pol -> RCl -> RS ; -- who wouldn't have walked
      mkRS : RCl  -> RS                         -- who walks
      } ;

    mkRCl : overload {
      mkRCl : Cl -> RCl          ;   -- such that John loves her
      mkRCl : RP -> VP -> RCl    ;   -- who loves John
      mkRCl : RP -> Slash -> RCl ;   -- whom John wants to love
      mkRCl : RP -> NP -> V2 -> RCl  -- whom John loves
      } ;

    mkRP : overload {
      mkRP : RP                    ;   -- which
      mkRP : Prep -> NP -> RP -> RP    -- all the roots of which
      } ;

--2 Objectless sentences and sentence complements

    mkSlash : overload {
      mkSlash : NP -> V2 -> Slash    ;    -- (whom) he sees
      mkSlash : NP -> VV -> V2 -> Slash ; -- (whom) he wants to see
      mkSlash : Slash -> Adv -> Slash ;   -- (whom) he sees tomorrow
      mkSlash : Cl -> Prep -> Slash       -- (with whom) he walks
      } ;


--2 Lists for coordination

    mkListS : overload {
     mkListS : S -> S -> ListS ;
     mkListS : S -> ListS -> ListS
     } ;

    mkListAdv : overload {
     mkListAdv : Adv -> Adv -> ListAdv ;
     mkListAdv : Adv -> ListAdv -> ListAdv
     } ;

    mkListAP : overload {
     mkListAP : AP -> AP -> ListAP ;
     mkListAP : AP -> ListAP -> ListAP
     } ;
  
    mkListNP : overload {
     mkListNP : NP -> NP -> ListNP ;
     mkListNP : NP -> ListNP -> ListNP
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
      mkCl : VP -> Cl          -- it rains
                                         =    ImpersCl   ;
      mkCl : NP  -> RS -> Cl   -- it is you who did it
                                         =    CleftNP    ;
      mkCl : Adv -> S  -> Cl   -- it is yesterday she arrived
                                         =    CleftAdv   ;
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
      mkCl : NP -> NP -> Cl    -- John is a man
	                                 =    \x,y -> PredVP x (UseComp (CompNP y)) ;
      mkCl : NP -> Adv -> Cl   -- John is here
	                                 =    \x,y -> PredVP x (UseComp (CompAdv y))
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
      mkNP : Int -> CN -> NP      -- 51 old men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) (NumInt d) NoOrd) n ;
      mkNP : Int -> N -> NP       -- 51 men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) (NumInt d) NoOrd) (UseN n) ;
      mkNP : Digit -> CN -> NP    -- five old men
	                                 =    \d,n -> DetCN (DetPl (PlQuant IndefArt) (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d)))))) NoOrd) n ;
      mkNP : Digit -> N -> NP     -- five men
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
      mkDet : Digit -> Det  -- five (men)
	                                 =    \d -> DetPl (PlQuant IndefArt) (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d)))))) NoOrd ;   

      mkDet : Pron -> Det      -- my (house)
                                         =    \p -> DetSg (SgQuant (PossPron p)) NoOrd
      } ;

    mkQuantSg : Quant -> QuantSg = SgQuant ;
    mkQuantPl : Quant -> QuantPl = PlQuant ;


    def_Det : Det = DetSg (SgQuant DefArt) NoOrd ;   -- the (man)
    indef_Det : Det = DetSg (SgQuant IndefArt) NoOrd ; -- a (man)
    mass_Det : Det = DetSg MassDet NoOrd;  -- (water)


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
      mkPhr : Utt -> Phr   -- Go home
                                         =    \u -> PhrUtt NoPConj u NoVoc   ;
      mkPhr : S -> Phr   -- I go home
                                         =    \s -> PhrUtt NoPConj (UttS s) NoVoc 
      } ;

    mkPConj : Conj -> PConj = PConjConj ;
    noPConj : PConj = NoPConj ;

    mkVoc   : NP -> Voc  = VocNP ;
    noVoc   : Voc  = NoVoc ;

    posPol : Pol = PPos ; 
    negPol : Pol = PNeg ;

    simulAnt : Ant = ASimul ; 
    anterAnt : Ant = AAnter ; --# notpresent

    presentTense     : Tense = TPres ;
    pastTense        : Tense = TPast ; --# notpresent
    futureTense      : Tense = TFut ;  --# notpresent
    conditionalTense : Tense = TCond ; --# notpresent

  param ImpForm = IFSg | IFPl | IFPol ;

  oper
    sgImpForm  : ImpForm = IFSg ;
    plImpForm  : ImpForm = IFPl ;
    polImpForm : ImpForm = IFPol ;

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

    letsUtt : VP -> Utt = ImpPl1 ;

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

    mkRP = overload {
      mkRP : RP                        -- which
                                         =    IdRP   ;
      mkRP : Prep -> NP -> RP -> RP    -- all the roots of which
                                         =    FunRP
      } ;

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
      mkQS : Tense -> Ant -> Pol -> QCl -> QS
                                         =    UseQCl  ;
      mkQS : QCl  -> QS
                                         =    UseQCl TPres ASimul PPos ;
      mkQS : Cl   -> QS                  
	                                 =    \x -> UseQCl TPres ASimul PPos (QuestCl x)
      } ;

    mkRS = overload {
      mkRS : Tense -> Ant -> Pol -> RCl -> RS
                                         =    UseRCl  ;
      mkRS : RCl  -> RS
                                         =    UseRCl TPres ASimul PPos
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
      mkVP : AP -> VP               -- be warm
                                         =    \a -> UseComp (CompAP a)   ;
      mkVP : NP -> VP               -- be a man
                                         =    \a -> UseComp (CompNP a)   ;
      mkVP : Adv -> VP               -- be here
                                         =    \a -> UseComp (CompAdv a)   ;
      mkVP : VP -> Adv -> VP          -- sleep here
                                         =    AdvVP     ;
      mkVP : AdV -> VP -> VP          -- always sleep
                                         =    AdVVP
      } ;

  reflexiveVP   : V2 -> VP = ReflV2 ;
  passiveVP     : V2 -> VP = PassV2 ;
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



}
