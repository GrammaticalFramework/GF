--1 Constructors: the Resource Syntax API 

incomplete resource Constructors = open Grammar in {  --%

  flags optimize=noexpand ;  --%

-- For developers: this document is tagged to support GF-Doc and synopsis    --%
-- generation:    --%
--  --% ignore this line in documentation    --%  
--  --: this is a ground constructor  --%
-- Moreover, follow the format  --%
--   oper : Typ                 --%
--   = def ; --%                --%
--
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
-- to implement the concrete syntax for a language.

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
    mkText = overload {  --%
      mkText : Phr -> (Punct) -> (Text) -> Text  -- Does she sleep? Yes. --:
        = \phr,punct,text -> case punct of {  --%
          PFullStop => TFullStop phr text ;   --%
          PExclMark => TExclMark phr text ;   --%
          PQuestMark => TQuestMark phr text   --%
          } ;  --%
      mkText : Phr -> Text -> Text  -- But she sleeps. Yes!  --%
        =    \x,t -> TFullStop x t  ;  --%
      mkText : Phr -> Punct -> Text   --%
        = \phr,punct -> case punct of {   --%
          PFullStop => TFullStop phr TEmpty ;   --%
          PExclMark => TExclMark phr TEmpty ;   --%
          PQuestMark => TQuestMark phr TEmpty   --%
          } ;   --%
      mkText : Phr -> Text  -- But she sleeps.  --%
        =    \x -> TFullStop x TEmpty  ;  --%


-- A text can also be directly built from utterances, which in turn can
-- be directly built from sentences, present-tense clauses, questions, or
-- positive imperatives. 

      mkText : Utt ->  Text    -- Yes. 
        = \u -> TFullStop (PhrUtt NoPConj u NoVoc) TEmpty ;  --%  
      mkText : S   ->  Text    -- She slept. 
        = \s -> TFullStop (PhrUtt NoPConj (UttS s) NoVoc) TEmpty ; --%  
      mkText : Cl  ->  Text    -- She sleeps. 
        = \c -> TFullStop (PhrUtt NoPConj (UttS (TUseCl TPres ASimul PPos c)) NoVoc) TEmpty ; --%  
      mkText : QS  ->  Text    -- Did she sleep? 
        = \q -> TQuestMark (PhrUtt NoPConj (UttQS q) NoVoc) TEmpty ;  --%
      mkText : (Pol) -> Imp ->  Text    -- Don't sleep!
        = \p,i -> TExclMark (PhrUtt NoPConj (UttImpSg p i) NoVoc) TEmpty; --%  
      mkText : Imp ->  Text    -- Sleep! --%
        = \i -> TExclMark (PhrUtt NoPConj (UttImpSg PPos i) NoVoc) TEmpty; --%  

-- Finally, two texts can be combined into a text.

      mkText : Text -> Text -> Text  -- Where? Here. When? Here. Now! 
        = \t,u -> {s = t.s ++ u.s ; lock_Text = <>} ; --%
      } ; --%

-- A text can also be empty.

      emptyText : Text  -- (empty text)  --:
        = TEmpty ; --%

--3 Punct: punctuation marks 

-- There are three punctuation marks that can separate phrases in a text.

      fullStopPunct  : Punct   -- .   --:
        = PFullStop ; --%  
      questMarkPunct : Punct   -- ?   --:
        = PQuestMark ; --%
      exclMarkPunct  : Punct   -- !   --:
        = PExclMark ; --%

-- Internally, they are handled with a parameter type. --%

  param Punct = PFullStop | PExclMark | PQuestMark ;  --%

  oper --%

--3 Phr: phrases in a text 

-- Phrases are built from utterances by adding a phrasal conjunction
-- and a vocative, both of which are by default empty.

    mkPhr = overload { --%
      mkPhr : (PConj) -> Utt -> (Voc) -> Phr   -- but sleep, my friend  --: 
      = PhrUtt ; --%
      mkPhr : Utt -> Voc -> Phr -- come here John --%
      = \u,v -> PhrUtt NoPConj u v ; --% 
      mkPhr : PConj -> Utt -> Phr -- but come here --%
      = \u,v -> PhrUtt u v NoVoc ; --%
      mkPhr : Utt -> Phr   -- come here --%
      = \u -> PhrUtt NoPConj u NoVoc   ;  --%

-- A phrase can also be directly built by a sentence, a present-tense
-- clause, a question, or a positive singular imperative. 

      mkPhr : S -> Phr   -- she won't sleep
         = \s -> PhrUtt NoPConj (UttS s) NoVoc ; --%  
      mkPhr : Cl -> Phr   -- she sleeps
         = \s -> PhrUtt NoPConj (UttS (TUseCl TPres ASimul PPos s)) NoVoc ; --%  
      mkPhr : QS -> Phr   -- would she sleep  
         =    \s -> PhrUtt NoPConj (UttQS s) NoVoc ;  --%
      mkPhr : Imp -> Phr  -- sleep
         =  \s -> PhrUtt NoPConj (UttImpSg PPos s) NoVoc --%   
      } ; --%


--3 PConj, phrasal conjunctions 

-- Any conjunction can be used as a phrasal conjunction.
-- More phrasal conjunctions are defined in $Structural$.

      mkPConj : Conj -> PConj   -- and   --:
        = PConjConj ; --%
      noPConj : PConj --: --% 
        = NoPConj ; --%


--3 Voc, vocatives 

-- Any noun phrase can be turned into a vocative.
-- More vocatives are defined in $Structural$.

    mkVoc : NP -> Voc  -- my friend   --:
      = VocNP ; --% 
    noVoc : Voc --% 
      = NoVoc ; --% 


--3 Utt, utterances 

-- Utterances are formed from sentences, clauses, questions, and imperatives.

    mkUtt = overload { 
      mkUtt : S -> Utt                     -- she slept   --:  
      = UttS ; --%  
      mkUtt : Cl -> Utt                    -- she sleeps  
      = \c -> UttS (TUseCl TPres ASimul PPos c) ; --%  
      mkUtt : QS -> Utt                    -- who didn't sleep   --:
      = UttQS   ; --%  
      mkUtt : QCl -> Utt                   -- who sleeps  
      = \c -> UttQS (TUseQCl TPres ASimul PPos c) ; --%  
      mkUtt : (ImpForm) -> (Pol) -> Imp -> Utt  -- don't be men   --: 
      = mkUttImp  ; --%
      mkUtt : ImpForm -> Imp -> Utt -- be men --% 
      = \f -> mkUttImp f PPos ; --% 
      mkUtt : Pol -> Imp -> Utt  -- don't be men --% 
      = UttImpSg  ;  --%
      mkUtt : Imp -> Utt  -- love yourself --%  
      = UttImpSg PPos  ;  --%

-- Utterances can also be formed from interrogative phrases and
-- interrogative adverbials, noun phrases, adverbs, and verb phrases.

      mkUtt : IP   -> Utt     -- who   --:
      = UttIP    ; --%  
      mkUtt : IAdv -> Utt     -- why   --:
      = UttIAdv  ; --%  
      mkUtt : NP   -> Utt     -- this man  --: 
      = UttNP    ; --%  
      mkUtt : Adv  -> Utt     -- here   --:
      = UttAdv   ; --%  
      mkUtt : VP   -> Utt     -- to sleep  --:
      = UttVP ; --%  
      mkUtt : CN   -> Utt     -- beer      --:
      =    UttCN ; --% 
      mkUtt : AP   -> Utt     -- good   --:
      =    UttAP ; --%    
      mkUtt : Card -> Utt     -- five   --:
      =    UttCard ; --%  
    } ; --%

-- The plural first-person imperative is a special construction.

      lets_Utt : VP ->  Utt  -- let's sleep    --:
      = ImpPl1 ; --%


--2 Auxiliary parameters for phrases and sentences 

--3 Pol, polarity 

-- Polarity is a parameter that sets a clause to positive or negative
-- form. Since positive is the default, it need never be given explicitly.

      positivePol : Pol   -- she sleeps [default]   --: 
        = PPos ; --%
      negativePol : Pol   -- she doesn't sleep    --:
        = PNeg ; --%

--3 Ant, anteriority 

-- Anteriority is a parameter that presents an event as simultaneous or
-- anterior to some other reference time.
-- Since simultaneous is the default, it need never be given explicitly.

      simultaneousAnt : Ant   -- she sleeps [default]   --: 
        = ASimul ; --%
      anteriorAnt : Ant   -- she has slept       --# notpresent  --: 
        = AAnter ; --# notpresent --%

--3 Tense, tense 

-- Tense is a parameter that relates the time of an event 
-- to the time of speaking about it.
-- Since present is the default, it need never be given explicitly.

      presentTense     : Tense  -- she sleeps [default]   --:
        = TPres ; --% 
      pastTense        : Tense  -- she slept           --# notpresent  --: 
        = TPast ; --# notpresent --% 
      futureTense      : Tense  -- she will sleep        --# notpresent  --:
        = TFut ; --# notpresent --% 
      conditionalTense : Tense  -- she would sleep       --# notpresent   --:
        = TCond ; --# notpresent --% 

--3 Temp, temporal and aspectual features

-- Temp is a combination of Tense and Ant. In extra modules for some
-- languages, it can also involve aspect and other things.

      mkTemp : Tense -> Ant -> Temp -- e.g. past + anterior
        = TTAnt ; --%

--3 ImpForm, imperative form 

-- Imperative form is a parameter that sets the form of imperative
-- by reference to the person or persons addressed.
-- Since singular is the default, it need never be given explicitly.

      singularImpForm : ImpForm   -- be a man [default]   --:
      = IFSg ;  --%
      pluralImpForm   : ImpForm   -- be men  --:
      = IFPl ;  --%
      politeImpForm   : ImpForm   -- be a man [polite singular]  --:
      = IFPol ;  --%

-- This is how imperatives are implemented internally. --%

  param ImpForm = IFSg | IFPl | IFPol ; --%

  oper --%
  mkUttImp : ImpForm -> Pol -> Imp -> Utt --%
  = \f,p,i -> case f of { --%
      IFSg  => UttImpSg p i ; --%
      IFPl  => UttImpPl p i ; --%
      IFPol => UttImpPol p i --%
      } ; --%


--2 Sentences and clauses 

--3 S, sentences 

-- A sentence has a fixed tense, anteriority and polarity.

    mkS = overload {  --%
      mkS : Cl  -> S  --%  
      = TUseCl TPres ASimul PPos ;   --%    
      mkS : Tense -> Cl -> S    --%  
      = \t -> TUseCl t ASimul PPos ;   --%  
      mkS : Ant -> Cl -> S   --%  
      = \a -> TUseCl TPres a PPos ;   --%   
      mkS : Pol -> Cl -> S    --%  
      = \p -> TUseCl TPres ASimul p ;   --%    
      mkS : Tense -> Ant -> Cl -> S   --%  
      = \t,a -> TUseCl t a PPos ;   --%  
      mkS : Tense -> Pol -> Cl -> S   --%  
      = \t,p -> TUseCl t ASimul p ;   --%  
      mkS : Ant -> Pol -> Cl -> S   --%  
      = \a,p -> TUseCl TPres a p ;   --%  
      mkS : (Tense) -> (Ant) -> (Pol) -> Cl  -> S -- she wouldn't have slept
      = \t,a -> TUseCl t a ;   --%  
      mkS : Temp -> Pol -> Cl -> S -- she wouldn't have slept  --:
      = UseCl ; --%

-- Sentences can be combined with conjunctions. This can apply to a pair
-- of sentences, but also to a list of more than two.

      mkS : Conj -> S -> S -> S   -- she sleeps and I run    
      = \c,x,y -> ConjS c (BaseS x y) ; --% 
      mkS : Conj -> ListS  -> S   -- she sleeps, I run and you walk  --:
      = \c,xy -> ConjS c xy ; --% 

-- A sentence can be prefixed by an adverb.

      mkS : Adv -> S -> S           -- today, she sleeps   --:
      = AdvS ; --%
      } ; 

--3 Cl, clauses 

-- A clause has a variable tense, anteriority and polarity.
-- A clause can be built from a subject noun phrase 
-- with a verb, adjective, or noun, and appropriate arguments.

    mkCl = overload { 

      mkCl : NP -> V -> Cl                -- she sleeps   
      = \s,v -> PredVP s (UseV v); --%   
      mkCl : NP -> V2 -> NP -> Cl         -- she loves him
      = \s,v,o -> PredVP s (ComplV2 v o); --%   
      mkCl : NP -> V3 -> NP -> NP -> Cl   -- she sends it to him
      = \s,v,o,i -> PredVP s (ComplV3 v o i); --%   
      mkCl : NP  -> VV -> VP -> Cl        -- she wants to sleep
        = \s,v,vp -> PredVP s (ComplVV v vp) ; --% 
      mkCl : NP  -> VS -> S  -> Cl        -- she says that she sleeps
        = \s,v,p -> PredVP s (ComplVS v p) ; --% 
      mkCl : NP  -> VQ -> QS -> Cl        -- she wonders who sleeps
        = \s,v,q -> PredVP s (ComplVQ v q) ; --% 
      mkCl : NP  -> VA -> A -> Cl         -- she becomes old
        = \s,v,q -> PredVP s (ComplVA v (PositA q)) ; --% 
      mkCl : NP  -> VA -> AP -> Cl        -- she becomes very old
        = \s,v,q -> PredVP s (ComplVA v q) ; --% 
      mkCl : NP  -> V2A -> NP -> A -> Cl  -- she paints it red
        = \s,v,n,q -> PredVP s (ComplV2A v n (PositA q)) ; --% 
      mkCl : NP  -> V2A -> NP -> AP -> Cl -- she paints it very red
        = \s,v,n,q -> PredVP s (ComplV2A v n q) ; --% 
      mkCl : NP  -> V2S -> NP -> S -> Cl          -- she answers to him that we sleep
        = \s,v,n,q -> PredVP s (ComplSlash (SlashV2S v q) n) ; --% 
      mkCl : NP  -> V2Q -> NP -> QS -> Cl         -- she asks him who sleeps 
        = \s,v,n,q -> PredVP s (ComplSlash (SlashV2Q v q) n) ; --% 
      mkCl : NP  -> V2V -> NP -> VP -> Cl         -- she begs him to sleep
        = \s,v,n,q -> PredVP s (ComplSlash (SlashV2V v q) n) ; --% 
      mkCl : NP -> A  -> Cl    -- she is old
        = \x,y -> PredVP x (UseComp (CompAP (PositA y))) ; --%   
      mkCl : NP -> A -> NP -> Cl -- she is older than him   
        = \x,y,z -> PredVP x (UseComp (CompAP (ComparA y z))) ; --% 
      mkCl : NP -> A2 -> NP -> Cl -- she is married to him 
	= \x,y,z -> PredVP x (UseComp (CompAP (ComplA2 y z))) ; --% 
      mkCl : NP -> AP -> Cl    -- she is very old 
	= \x,y -> PredVP x (UseComp (CompAP y)) ; --% 
      mkCl : NP -> NP -> Cl    -- she is the woman   
        = \x,y -> PredVP x (UseComp (CompNP y)) ; --%   
      mkCl : NP -> N -> Cl    -- she is a woman   
        = \x,y -> PredVP x (UseComp (CompCN (UseN y))) ; --% 
      mkCl : NP -> CN -> Cl    -- she is an old woman   
	= \x,y -> PredVP x (UseComp (CompCN y)) ; --%   
      mkCl : NP -> Adv -> Cl   -- she is here   
	= \x,y -> PredVP x (UseComp (CompAdv y)) ; --%   

-- As the general rule, a clause can be built from a subject noun phrase and 
-- a verb phrase.

      mkCl : NP -> VP -> Cl   -- she always sleeps   --:
      = PredVP  ; --%

-- Existentials are a special form of clauses.

      mkCl : N -> Cl           -- there is a house 
      = \y -> ExistNP (DetArtSg IndefArt (UseN y)) ; --% 
      mkCl : CN -> Cl          -- there is an old house 
      = \y -> ExistNP (DetArtSg IndefArt y) ; --% 
      mkCl : NP -> Cl          -- there are many houses   --:
      = ExistNP ; --% 

-- There are also special forms in which a noun phrase or an adverb is
-- emphasized.

      mkCl : NP  -> RS -> Cl   -- it is she who sleeps   --: 
      = CleftNP    ; --% 
      mkCl : Adv -> S  -> Cl   -- it is here that she sleeps    --:
      = CleftAdv   ; --% 

-- Subjectless verb phrases are used for impersonal actions.

      mkCl : V -> Cl   -- it rains 
      = \v -> ImpersCl (UseV v) ; --%
      mkCl : VP -> Cl  -- it is raining    --:
      = ImpersCl   ;  --%
      mkCl : SC -> VP -> Cl  -- that she sleeps is good --:
      = PredSCVP ; --%

      } ; 

-- Generic clauses are those with an impersonal subject.

      genericCl : VP ->  Cl    -- one sleeps               
      = GenericCl ; --%

--2 Verb phrases and imperatives 

--3 VP, verb phrases 

-- A verb phrase is formed from a verb with appropriate arguments.

    mkVP = overload { 
      mkVP : V   -> VP                -- sleep --:
      = UseV      ; --% 
      mkVP : V2  -> NP -> VP          -- love him 
      = ComplV2   ; --% 
      mkVP : V3  -> NP -> NP -> VP    -- send a message to him 
      = ComplV3   ; --% 
      mkVP : VV  -> VP -> VP          -- want to sleep  --:
      = ComplVV   ; --% 
      mkVP : VS  -> S  -> VP          -- know that she sleeps  --: 
      = ComplVS   ; --% 
      mkVP : VQ  -> QS -> VP          -- wonder if she sleeps  --:
      = ComplVQ   ; --% 
      mkVP : VA  -> AP -> VP          -- become red  --:
      = ComplVA   ; --% 
      mkVP : V2A -> NP -> AP -> VP    -- paint it red 
      = ComplV2A  ; --% 
      mkVP : V2S -> NP -> S  -> VP         -- answer to him that we sleep 
        = \v,n,q -> (ComplSlash (SlashV2S v q) n) ; --% 
      mkVP : V2Q -> NP -> QS -> VP         -- ask him who sleeps
        = \v,n,q -> (ComplSlash (SlashV2Q v q) n) ; --% 
      mkVP : V2V -> NP -> VP -> VP         -- beg him to sleep
        = \v,n,q -> (ComplSlash (SlashV2V v q) n) ; --% 

-- The verb can also be a copula ("be"), and the relevant argument is
-- then the complement adjective or noun phrase.

      mkVP : A -> VP               -- be warm 
      = \a -> UseComp (CompAP (PositA a)) ; --% 
      mkVP : A -> NP -> VP         -- be older than him 
      = \y,z -> (UseComp (CompAP (ComparA y z))) ; --% 
      mkVP : A2 -> NP -> VP        -- be married to him 
      = \y,z -> (UseComp (CompAP (ComplA2 y z))) ; --% 
      mkVP : AP -> VP              -- be warm 
      = \a -> UseComp (CompAP a)   ; --% 
      mkVP : N -> VP               -- be a man 
      = \y -> UseComp (CompCN (UseN y)) ; --% 
      mkVP : CN -> VP              -- be an old man 
      = \y -> UseComp (CompCN y) ; --% 
      mkVP : NP -> VP              -- be the man 
      = \a -> UseComp (CompNP a)   ; --% 
      mkVP : Adv -> VP             -- be here 
      = \a -> UseComp (CompAdv a)   ; --% 

-- A verb phrase can be modified with a postverbal or a preverbal adverb.

      mkVP : VP -> Adv -> VP          -- sleep here   --: 
      = AdvVP     ; --% 
      mkVP : AdV -> VP -> VP          -- always sleep   --:
      = AdVVP ; --% 

-- Objectless verb phrases can be taken to verb phrases in two ways.

      mkVP : VPSlash -> NP -> VP      -- paint it black  --:
      = ComplSlash ; --% 
      mkVP : VPSlash -> VP            -- paint itself black --:
        = ReflVP ; --%

      mkVP : Comp -> VP               -- be warm --:
        = UseComp ; --%

      } ; --% 

-- Two-place verbs can be used reflexively, and VPSlash more generally.
    reflexiveVP = overload { --%
      reflexiveVP : V2 -> VP        -- love itself 
      = \v -> ReflVP (SlashV2a v) ; --% 
      reflexiveVP : VPSlash -> VP   -- paint itself black
        = ReflVP ; --%
      } ; --%


-- Two-place verbs can also be used in the passive, with or without an agent.

    passiveVP = overload { --%
      passiveVP : V2 ->       VP   -- be loved
      = PassV2 ; --%  
      passiveVP : V2 -> NP -> VP   -- be loved by her 
      = \v,np -> (AdvVP (PassV2 v) (PrepNP by8agent_Prep np)) ; --%
      -- passiveVP : VPSlash -> VP --: --%

      } ; --% 

-- A verb phrase can be turned into the progressive form.

      progressiveVP : VP -> VP   -- be sleeping 
      = ProgrVP ; --%

--3 Comp, verb phrase complements

   mkComp = overload { --%
     mkComp : AP -> Comp -- very old --:
     = CompAP ; --%
     mkComp : NP -> Comp -- this man --:
     = CompNP ; --%
     mkComp : Adv -> Comp -- here --:
     = CompAdv ; --%
     } ; --%

--3 SC, embedded sentence

   mkSC = overload { --%
     mkSC : S -> SC -- that he sleeps --:
     = EmbedS ; --%
     mkSC : QS -> SC -- whether he sleeps --:
     = EmbedQS ; --%
     mkSC : VP -> SC -- to sleep --:
     = EmbedVP ; --%
     } ; --%


--3 Imp, imperatives 

-- Imperatives are formed from verbs and their arguments; as the general
-- rule, from verb phrases.

    mkImp = overload {  --%
      mkImp : VP -> Imp                -- come to my house
      = ImpVP      ;  --%
      mkImp : V  -> Imp                -- come
      = \v -> ImpVP (UseV v)  ;   --%
      mkImp : V2 -> NP -> Imp          -- buy it
      = \v,np -> ImpVP (ComplV2 v np) ; --%
      } ;  --%


--2 Noun phrases and determiners 

--3 NP, noun phrases 

-- A noun phrases can be built from a determiner and a common noun ($CN$) .
-- For determiners, the special cases of quantifiers, numerals, integers, 
-- and possessive pronouns are provided. For common nouns, the 
-- special case of a simple common noun ($N$) is always provided.

    mkNP = overload { 
      mkNP : Quant -> N  -> NP          -- this man
          = \q,n -> DetCN (DetQuant q NumSg) (UseN n) ; --%   
      mkNP : Quant -> CN -> NP          -- this old man
          = \q,n -> DetCN (DetQuant q NumSg) n ; --%   
      mkNP : Quant -> Num -> CN -> NP   -- these five old men
          = \q,nu,n -> DetCN (DetQuant q nu) n ; --%  
      mkNP : Quant -> Num -> Ord -> CN -> NP   -- these five best old men --%
          = \q,nu,or,n -> DetCN (DetQuantOrd q nu or) n ; --%  
      mkNP : Quant -> Num -> N  -> NP   -- these five men
          = \q,nu,n -> DetCN (DetQuant q nu) (UseN n) ; --%  
      mkNP : Det -> CN -> NP      -- the first old man   --:
          =  DetCN    ; --%   
      mkNP : Det -> N -> NP       -- the first man   
          =  \d,n -> DetCN d (UseN n)   ; --%   
      mkNP : Numeral -> CN -> NP      -- fifty old men   
	  = \d,n -> DetCN (DetArtCard IndefArt (NumNumeral d)) n ; --%  
      mkNP : Numeral -> N -> NP       -- fifty men  
	  = \d,n -> DetCN (DetArtCard IndefArt (NumNumeral d)) (UseN n) ; --%  
      mkNP : Digits -> CN -> NP      -- 51 old men 
	  = \d,n -> DetCN (DetArtCard IndefArt (NumDigits d)) n ; --% 
      mkNP : Digits -> N -> NP       -- 51 men 
	  = \d,n -> DetCN (DetArtCard IndefArt (NumDigits d)) (UseN n) ; --% 
      mkNP : Digit -> CN -> NP    ---- obsol --% 
	  = \d,n -> DetCN (DetArtCard IndefArt (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d))))))) n ; --% 
      mkNP : Digit -> N -> NP     ---- obsol --% 
	  = \d,n -> DetCN (DetArtCard IndefArt (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d))))))) (UseN n) ; --% 
      mkNP : Card -> CN -> NP     -- forty-five old men   
	  =  \d,n -> DetCN (DetArtCard IndefArt d) n ; --%   
      mkNP : Card -> N -> NP       -- forty-five men   
	  =  \d,n -> DetCN (DetArtCard IndefArt d) (UseN n) ; --%   
      mkNP : Pron -> CN -> NP   -- my old man
          = \p,n -> DetCN (DetQuant (PossPron p) NumSg) n ; --% 
      mkNP : Pron -> N  -> NP   -- my man
          = \p,n -> DetCN (DetQuant (PossPron p) NumSg) (UseN n) ; --% 

-- Proper names and pronouns can be used as noun phrases.

      mkNP : PN -> NP             -- she  --:
      = UsePN    ; --%  
      mkNP : Pron -> NP           -- he  --:
      = UsePron  ; --%  

-- Determiners alone can form noun phrases.

      mkNP : Quant -> NP           -- this  
          =  \q -> DetNP (DetQuant q sgNum) ; --%  
      mkNP : Quant -> Num -> NP    -- these five  
          =  \q,n -> DetNP (DetQuant q n) ; --%  
      mkNP : Det -> NP             -- these five best  --:
          =  DetNP ; --% 

-- Determinesless mass noun phrases.

      mkNP : CN -> NP  -- old beer   --:
          = MassNP ; --%   
      mkNP : N -> NP  -- beer   
          = \n -> MassNP (UseN n) ; --%   

-- A noun phrase once formed can be prefixed by a predeterminer and
-- suffixed by a past participle or an adverb.

      mkNP : Predet -> NP -> NP  -- only the man --:  
      = PredetNP  ; --%  
      mkNP : NP -> V2  -> NP     -- the man seen --:
      = PPartNP  ; --% 
      mkNP : NP -> Adv -> NP     -- Paris today --:
      = AdvNP ; --% 
      mkNP : NP -> RS -> NP      -- John, who walks --:
      = RelNP ; --% 

-- A conjunction can be formed both from two noun phrases and a longer
-- list of them.

      mkNP : Conj -> NP -> NP -> NP 
      = \c,x,y -> ConjNP c (BaseNP x y) ; --% 
      mkNP : Conj -> ListNP -> NP --: 
      = \c,xy -> ConjNP c xy ; --% 

-- backward compat --%
      mkNP : QuantSg -> CN -> NP --%  
          = \q,n -> DetCN (DetQuant q NumSg) n ; --% 
      mkNP : QuantPl -> CN -> NP  --%
          = \q,n -> DetCN (DetQuant q NumPl) n ; --% 

      } ; --% 

-- Pronouns can be used as noun phrases.

      i_NP : NP          -- I
      = mkNP i_Pron ;
      you_NP : NP        -- you (singular)
      = mkNP youSg_Pron ;
      youPol_NP : NP     -- you (polite singular)
      = mkNP youPol_Pron ;
      he_NP : NP         -- he
      = mkNP he_Pron ;
      she_NP : NP        -- she
      = mkNP she_Pron ;
      it_NP : NP         -- it
      = mkNP it_Pron ;
      we_NP : NP         -- we
      = mkNP we_Pron ;
      youPl_NP : NP      -- you (plural)
      = mkNP youPl_Pron ;
      they_NP : NP       -- they
      = mkNP they_Pron ;

    this_NP : NP -- this
    = DetNP (DetQuant this_Quant sgNum) ;  --% 
    that_NP : NP -- that 
    = DetNP (DetQuant that_Quant sgNum) ;  --% 
    these_NP : NP 
    = DetNP (DetQuant this_Quant plNum) ;  --% 
    those_NP : NP 
    = DetNP (DetQuant that_Quant plNum) ;  --% 


--3 Det, determiners 

-- A determiner is either a singular or a plural one.
-- Quantifiers that have both singular and plural forms are by default used as
-- singular determiners. If a numeral is added, the plural form is chosen.
-- A determiner also has an optional ordinal.

    mkDet = overload { --%

      mkDet : Quant ->  Det       -- this  
        = \q -> DetQuant q NumSg  ; --%  
      mkDet : Quant -> Card -> Det   -- these five
        = \d,nu -> (DetQuant d (NumCard nu)) ; --% 
      mkDet : Quant ->  Ord -> Det     -- the best
        = \q,o -> DetQuantOrd q NumSg o  ; --% 
      mkDet : Quant -> Num -> Ord -> Det  -- these five best --: 
        = DetQuantOrd  ; --% 
      mkDet : Quant -> Num -> Det -- these five  --:
        = DetQuant ; --%  

-- Numerals, their special cases integers and digits, and possessive pronouns can be
-- used as determiners.

      mkDet : Card ->  Det     -- forty  
	= DetArtCard IndefArt ; --%  
      mkDet : Digits -> Det    -- 51
	= \d -> DetArtCard IndefArt (NumDigits d) ; --% 
      mkDet : Numeral -> Det  -- five 
	= \d -> DetArtCard IndefArt (NumNumeral d) ; --%  
      mkDet : Pron -> Det     -- my
        = \p -> DetQuant (PossPron p) NumSg ; --% 
      mkDet : Pron -> Num -> Det -- my five
        = \p -> DetQuant (PossPron p) ; --% 

      } ; --% 


      the_Det   : Det -- the (house)
        = theSg_Det ; --% 
      a_Det     : Det -- a (house)
        = aSg_Det ; --% 
      theSg_Det : Det -- the (houses)
        = DetQuant DefArt NumSg ; --% 
      thePl_Det : Det -- the (houses)
        = DetQuant DefArt NumPl ; --% 
      aSg_Det   : Det -- a (house)
        = DetQuant IndefArt NumSg ; --% 
      aPl_Det   : Det -- (houses)
        = DetQuant IndefArt NumPl ; --% 
      this_Det : Det 
      = (DetQuant this_Quant sgNum) ; --% 
      that_Det : Det 
      = (DetQuant that_Quant sgNum) ; --% 
      these_Det : Det 
      = (DetQuant this_Quant plNum) ; --% 
      those_Det : Det 
      = (DetQuant that_Quant plNum) ; --% 



--3 Quant, quantifiers 

-- There are definite and indefinite articles.

    mkQuant = overload { --%
      mkQuant : Pron -> Quant   -- my  --:
      = PossPron ; --% 
      } ; --% 

    the_Quant : Quant    -- the --:
      = DefArt ; --% 
    a_Quant   : Quant    -- a  --:
      = IndefArt ; --%

--3 Num, cardinal numerals  

-- Numerals can be formed from number words ($Numeral$), their special case digits,
-- and from symbolic integers.

    mkNum = overload { --%  
      mkNum : Str -> Num   -- thirty-five (given by "35"; range 1-999) 
        = \s -> NumCard (str2card s) ; --%
      mkNum : Numeral -> Num  -- twenty  
        = \d -> NumCard (NumNumeral d) ; --%  
      mkNum : Digits -> Num   -- 21 
        = \d -> NumCard (NumDigits d)      ; --% 
      mkNum : Digit -> Num -- five
        = \d -> NumCard (NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d)))))) ; --% 
      mkNum : Card -> Num  -- almost ten --:
        = NumCard ; --%  

-- A numeral can be modified by an adnumeral.

      mkNum : AdN -> Card -> Num  -- almost ten
        = \a,c -> NumCard (AdNum a c) 
      } ; --%  

-- Dummy numbers are sometimes to select the grammatical number of a determiner.

      singularNum : Num              -- singular --:
      = NumSg       ; --% 
      pluralNum : Num                -- plural --:
      = NumPl       ; --% 


-- Cardinals are the non-dummy numerals.

    mkCard = overload {  --%
      mkCard : Str -> Card   -- thirty-five (given as "35"; range 1-999) 
        = str2card ; --%
      mkCard : Numeral -> Card   -- twenty  --:
        = NumNumeral ; --%  
      mkCard : Digits -> Card      -- 51  --:
        = NumDigits ; --%  
      mkCard : AdN -> Card -> Card  -- almost fifty
        = AdNum ; --%
      } ; --%

--3 Ord, ordinal numerals 

-- Just like cardinals, ordinals can be formed from number words ($Numeral$)
-- and from symbolic integers.

    mkOrd = overload { --% 
      mkOrd : Numeral -> Ord   -- twentieth  --:
      = OrdNumeral ; --% 
      mkOrd : Digits -> Ord         -- 51st --:
      = OrdDigits      ; --% 
      mkOrd : Digit -> Ord       -- fifth 
      = \d -> OrdNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 d))))) ; --% 

-- Also adjectives in the superlative form can appear on ordinal positions.

      mkOrd : A -> Ord           -- largest  --:
      = OrdSuperl ; --% 
      } ; --% 


--3 AdN, adnumerals 

-- Comparison adverbs can be used as adnumerals.

      mkAdN : CAdv -> AdN  -- more than --: 
      = AdnCAdv ; --%

--3 Numeral, number words 

-- Numerals are divided to classes Sub1000000 (= Numeral), Sub1000, Sub100, Sub10.

    mkNumeral = overload {  --%       

-- Number words up to 999,999 can be built as follows.

      mkNumeral : Unit -> Numeral -- eight (coerce 1..9) --: 
      = \n -> num (pot2as3 (pot1as2 (pot0as1 n.n))) ; --%
      mkNumeral : Sub100 -> Numeral -- twenty-five (coerce 1..99) --: 
      = \n -> num (pot2as3 (pot1as2 n)) ; --%
      mkNumeral : Sub1000 -> Numeral -- six hundred (coerce 1..999) --: 
      = \n -> num (pot2as3 n) ; --%
      mkNumeral : Sub1000 -> Sub1000 -> Numeral -- 1000m + n --: 
      = \m,n -> num (pot3plus m n) ; --%

-- Some numerals can also be extracted from strings at compile time.

      mkNumeral : Str -> Numeral   -- thirty-five (given by "35"; range 1-999)  
      = str2numeral ; --% 
      } ; --%      

    thousandfoldNumeral : Sub1000 -> Numeral -- 1000n  --:
      = \n -> num (pot3 n) ;  --%

    mkSub1000 = overload {  --% 
      mkSub1000 : Sub100 -> Sub1000 -- coerce 1..99  --:
      = pot1as2 ; --% 
      mkSub1000 : Unit -> Sub1000 -- 100n  --:
      = \n -> pot2 n.n ; --% 
      mkSub1000 : Unit -> Sub100 -> Sub1000 -- 100m + n  --:
      = \m,n -> pot2plus m.n n ; --% 
      } ; --%

    mkSub100 = overload {  --% 
      mkSub100 : Unit -> Sub100            -- coerce 1..9  --:
      = \n -> pot0as1 n.n ; --% 
      mkSub100 : Unit -> Unit -> Sub100    -- 10m + n  --:
      = \m,n -> case m.isOne of {
         Predef.PFalse => pot1plus m.d n.n ; --%
         _ => case n.isOne of { 
            Predef.PFalse => pot1to19 n.d ; --%
            _ => pot111
            }
         }
      } ; --%

    tenfoldSub100 : Unit -> Sub100 -- 10n  --:
      = \n -> case n.isOne of {  --%
        Predef.PTrue => pot110 ; --%
        _ => pot1 n.d  --%
        } ; --%

-- We introduce the internal type $Unit$ for 1..9

    Unit : Type --%
      = {n : Sub10 ; d : Digit ; isOne : Predef.PBool} ; --%

    n1_Unit : Unit -- one --:
      = {n = pot01 ; d = n2 ; isOne = Predef.PTrue} ; --%
    n2_Unit : Unit -- two --: 
      = {n = pot0 n2 ; d = n2 ; isOne = Predef.PFalse} ; --%
    n3_Unit : Unit -- three --: 
      = {n = pot0 n3 ; d = n3 ; isOne = Predef.PFalse} ; --%
    n4_Unit : Unit -- four --: 
      = {n = pot0 n4 ; d = n4 ; isOne = Predef.PFalse} ; --%
    n5_Unit : Unit -- five --: 
      = {n = pot0 n5 ; d = n5 ; isOne = Predef.PFalse} ; --%
    n6_Unit : Unit -- six --: 
      = {n = pot0 n6 ; d = n6 ; isOne = Predef.PFalse} ; --%
    n7_Unit : Unit -- seven --: 
      = {n = pot0 n7 ; d = n7 ; isOne = Predef.PFalse} ; --%
    n8_Unit : Unit -- eight --: 
      = {n = pot0 n8 ; d = n8 ; isOne = Predef.PFalse} ; --%
    n9_Unit : Unit -- nine --: 
      = {n = pot0 n9 ; d = n9 ; isOne = Predef.PFalse} ; --%

-- Use the category $Digits$ for numbers above one million.


--3 Digits, numerals as sequences of digits

   mkDigits = overload { --%
      mkDigits : Str -> Digits -- 35 (from string "35"; ; range 1-9999999)
      = str2digits ; --% 
      mkDigits : Dig -> Digits -- 4  --:
      = IDig ; --%  
      mkDigits : Dig -> Digits -> Digits -- 1,233,432  --:
      = IIDig ; --%  
      } ; --% 

--3 Dig, single digits 

      n0_Dig : Dig   -- 0 --: 
      = D_0 ; --% 
      n1_Dig : Dig   -- 1 --: 
      = D_1 ; --% 
      n2_Dig : Dig   -- 2 --:  
      = D_2 ; --% 
      n3_Dig : Dig   -- 3 --:     
      = D_3 ; --% 
      n4_Dig : Dig   -- 4 --: 
      = D_4 ; --% 
      n5_Dig : Dig   -- 5 --:     
      = D_5 ; --% 
      n6_Dig : Dig   -- 6 --:     
      = D_6 ; --% 
      n7_Dig : Dig   -- 7 --:          
      = D_7 ; --% 
      n8_Dig : Dig   -- 8 --:     
      = D_8 ; --% 
      n9_Dig : Dig   -- 9 --: 
      = D_9 ; --% 
      
--2 Nouns 

--3 CN, common noun phrases 

    mkCN = overload { --%

-- The simplest way of forming common noun phrases is from atomic nouns $N$.

      mkCN : N  -> CN            -- house  --:
      = UseN     ; --%  

-- Common noun phrases can be formed from relational nouns by providing arguments.

      mkCN : N2 -> NP -> CN      -- mother of John  --: 
      = ComplN2  ; --% 
      mkCN : N3 -> NP -> NP -> CN      -- distance from this city to Paris --:
      = \f,x -> ComplN2 (ComplN3 f x)  ; --% 

-- Relational nouns can also be used without their arguments.

      mkCN : N2 -> CN            -- mother 
      = UseN2    ; --% 
      mkCN : N3 -> CN            -- distance 
      = \n -> UseN2 (Use2N3 n)    ; --% 

-- A common noun phrase can be modified by an adjectival phrase. We give special 
-- cases of this, where one or both of the arguments are atomic.


      mkCN :  A ->  N  -> CN     -- big house  
      = \x,y -> AdjCN (PositA x) (UseN y); --%  
      mkCN :  A -> CN  -> CN     -- big blue house  
      = \x,y -> AdjCN (PositA x) y; --%  
      mkCN : AP ->  N  -> CN     -- very big house  
      = \x,y -> AdjCN x (UseN y) ; --%  
      mkCN : AP -> CN  -> CN     -- very big blue house  
      = AdjCN    ; --%  
      mkCN : CN -> AP  -> CN     -- very big blue house --: --%
      = \x,y -> AdjCN y x    ; --% 
      mkCN :  N -> AP  -> CN     -- very big house --%
      = \x,y -> AdjCN y (UseN x)    ; --% 

-- A common noun phrase can be modified by a relative clause or an adverb.

      mkCN :  N -> RS  -> CN     -- house that she owns 
      = \x,y -> RelCN (UseN x) y   ; --% 
      mkCN : CN -> RS  -> CN     -- big house that she loves --:
      = RelCN    ; --% 
      mkCN :  N -> Adv -> CN     -- house on the hill 
      = \x,y -> AdvCN (UseN x) y  ; --% 
      mkCN : CN -> Adv -> CN     -- big house on the hill 
      = AdvCN    ; --% 

-- For some nouns it makes sense to modify them by sentences, 
-- questions, or infinitives. But syntactically this is possible for
-- all nouns.

      mkCN : CN -> S   -> CN     -- rule that she sleeps 
      = \cn,s -> SentCN cn (EmbedS s) ; --% 
      mkCN : CN -> QS  -> CN     -- question if she sleeps 
      = \cn,s -> SentCN cn (EmbedQS s) ; --% 
      mkCN : CN -> VP  -> CN     -- reason to sleep 
      = \cn,s -> SentCN cn (EmbedVP s) ; --% 
      mkCN : CN -> SC  -> CN     -- reason to sleep --: 
      = \cn,s -> SentCN cn s ; --% 

-- A noun can be used in apposition to a noun phrase, especially a proper name.

      mkCN :  N -> NP  -> CN     -- king John 
      = \x,y -> ApposCN (UseN x) y ; --% 
      mkCN : CN -> NP  -> CN     -- old king John
      = ApposCN ; --% 
      } ; --%  


--2 Adjectives and adverbs 

--3 AP, adjectival phrases 

    mkAP = overload { --%

-- Adjectival phrases can be formed from atomic adjectives by using the positive form or
-- the comparative with a complement

      mkAP : A -> AP           -- warm   --:
      = PositA   ; --%   
      mkAP : A -> NP -> AP     -- warmer than Paris --:   
      = ComparA  ; --%   

-- Relational adjectives can be used with a complement or a reflexive

      mkAP : A2 -> NP -> AP    -- married to her --:
      = ComplA2  ; --% 
      mkAP : A2 -> AP          -- married --:
      = UseA2   ; --% 

-- Some adjectival phrases can take as complements sentences, 
-- questions, or infinitives. Syntactically this is possible for
-- all adjectives.

      mkAP : AP -> S -> AP    -- probable that she sleeps  
      =  \ap,s -> SentAP ap (EmbedS s) ; --% 
      mkAP : AP -> QS -> AP    -- uncertain if she sleeps  
      =  \ap,s -> SentAP ap (EmbedQS s) ; --% 
      mkAP : AP -> VP -> AP    -- ready to go 
      =  \ap,s -> SentAP ap (EmbedVP s) ; --% 
      mkAP : AP -> SC -> AP    -- ready to go --: 
      =  \ap,s -> SentAP ap s ; --% 

-- An adjectival phrase can be modified by an adadjective.

      mkAP : AdA -> A -> AP   -- very old
      =\x,y -> AdAP x (PositA y) ; --%
      mkAP : AdA -> AP -> AP   -- very very old  --:
      = AdAP ; --%

-- Conjunction can be formed from two or more adjectival phrases.

      mkAP : Conj -> AP -> AP -> AP -- old and big 
      = \c,x,y -> ConjAP c (BaseAP x y) ; --% 
      mkAP : Conj -> ListAP -> AP   -- old, big and warm --:
      = \c,xy -> ConjAP c xy ; --% 

-- Two more constructions.

      mkAP : Ord   -> AP              -- oldest 
      = AdjOrd ; --%
      mkAP : CAdv -> AP -> NP -> AP   -- as old as she
      = CAdvAP ; --%
      } ; --% 

      reflAP   : A2 -> AP             -- married to himself --:
      = ReflA2 ; --% 
      comparAP : A -> AP              -- warmer 
      = UseComparA ; --%

--3 Adv, adverbial phrases 

    mkAdv = overload { --%

-- Adverbs can be formed from adjectives.

      mkAdv : A -> Adv            -- warmly   --:
      = PositAdvAdj  ; --%   

-- Prepositional phrases are treated as adverbs.

      mkAdv : Prep -> NP -> Adv          -- in the house --:   
      = PrepNP       ; --%   

-- Subordinate sentences are treated as adverbs.

      mkAdv : Subj -> S -> Adv   -- when she sleeps  --:
      = SubjS ; --% 

-- An adjectival adverb can be compared to a noun phrase or a sentence.

      mkAdv : CAdv -> A -> NP -> Adv   -- more warmly than she --: 
      = ComparAdvAdj   ; --% 
      mkAdv : CAdv -> A -> S -> Adv    -- more warmly than he runs --:
      = ComparAdvAdjS  ; --% 

-- Adverbs can be modified by adadjectives.

      mkAdv : AdA -> Adv -> Adv        -- very warmly --:
      = AdAdv   ; --% 

-- Conjunction can be formed from two or more adverbial phrases.

      mkAdv : Conj -> Adv -> Adv -> Adv  -- here and now
      = \c,x,y -> ConjAdv c (BaseAdv x y) ; --% 
      mkAdv : Conj -> ListAdv -> Adv   -- with John, here and now --: 
      = \c,xy -> ConjAdv c xy ; --% 
      } ; --% 


--2 Questions and relatives 

--3 QS, question sentences 

    mkQS = overload { --%

-- Just like a sentence $S$ is built from a clause $Cl$, 
-- a question sentence $QS$ is built from
-- a question clause $QCl$ by fixing tense, anteriority and polarity. 
-- Any of these arguments can be omitted, which results in the 
-- default (present, simultaneous, and positive, respectively).

      mkQS : QCl  -> QS  --%
      = TUseQCl TPres ASimul PPos ; --%  
      mkQS : Tense -> QCl -> QS  --%  
      =  \t -> TUseQCl t ASimul PPos ; --% 
      mkQS : Ant -> QCl -> QS  --%
      = \a -> TUseQCl TPres a PPos ; --% 
      mkQS : Pol -> QCl -> QS  --%
      = \p -> TUseQCl TPres ASimul p ; --%  
      mkQS : Tense -> Ant -> QCl -> QS --%
      = \t,a -> TUseQCl t a PPos ; --% 
      mkQS : Tense -> Pol -> QCl -> QS --%
      = \t,p -> TUseQCl t ASimul p ; --% 
      mkQS : Ant -> Pol -> QCl -> QS --%
      = \a,p -> TUseQCl TPres a p ; --% 
      mkQS : (Tense) -> (Ant) -> (Pol) -> QCl -> QS -- who wouldn't have slept 
      = TUseQCl ; --%

-- Since 'yes-no' question clauses can be built from clauses (see below), 
-- we give a shortcut
-- for building a question sentence directly from a clause, using the defaults
-- present, simultaneous, and positive.

      mkQS : Cl -> QS                    
      = \x -> TUseQCl TPres ASimul PPos (QuestCl x) ; --%  
      } ; --% 


--3 QCl, question clauses 

    mkQCl = overload { --%

-- 'Yes-no' question clauses are built from 'declarative' clauses.

      mkQCl : Cl -> QCl -- does she sleep  --:  
      = QuestCl ; --%  
 
-- 'Wh' questions are built from interrogative pronouns in subject 
-- or object position. The former uses a verb phrase; we don't give
-- shortcuts for verb-argument sequences as we do for clauses.
-- The latter uses the 'slash' category of objectless clauses 
-- (see below); we give the common special case with a two-place verb.

      mkQCl : IP -> VP -> QCl               -- who sleeps  --:    
      = QuestVP ; --%  
      mkQCl : IP -> V -> QCl                -- who sleeps   
      = \s,v -> QuestVP s (UseV v); --%   
      mkQCl : IP -> V2 -> NP -> QCl         -- who loves her
      = \s,v,o -> QuestVP s (ComplV2 v o); --%   
      mkQCl : IP -> V3 -> NP -> NP -> QCl   -- who sends it to her
      = \s,v,o,i -> QuestVP s (ComplV3 v o i); --%   
      mkQCl : IP  -> VV -> VP -> QCl        -- who wants to sleep
        = \s,v,vp -> QuestVP s (ComplVV v vp) ; --% 
      mkQCl : IP  -> VS -> S  -> QCl        -- who says that she sleeps
        = \s,v,p -> QuestVP s (ComplVS v p) ; --% 
      mkQCl : IP  -> VQ -> QS -> QCl        -- who wonders who sleeps
        = \s,v,q -> QuestVP s (ComplVQ v q) ; --% 
      mkQCl : IP  -> VA -> A -> QCl        -- who becomes old
        = \s,v,q -> QuestVP s (ComplVA v (PositA q)) ; --% 
      mkQCl : IP  -> VA -> AP -> QCl        -- who becomes old
        = \s,v,q -> QuestVP s (ComplVA v q) ; --% 
      mkQCl : IP  -> V2A -> NP -> A -> QCl -- who paints it red
        = \s,v,n,q -> QuestVP s (ComplV2A v n (PositA q)) ; --% 
      mkQCl : IP  -> V2A -> NP -> AP -> QCl -- who paints it red
        = \s,v,n,q -> QuestVP s (ComplV2A v n q) ; --% 
      mkQCl : IP  -> V2S -> NP -> S -> QCl          -- who tells her that we sleep
        = \s,v,n,q -> QuestVP s (ComplSlash (SlashV2S v q) n) ; --% 
      mkQCl : IP  -> V2Q -> NP -> QS -> QCl         -- who asks her who sleeps 
        = \s,v,n,q -> QuestVP s (ComplSlash (SlashV2Q v q) n) ; --% 
      mkQCl : IP  -> V2V -> NP -> VP -> QCl         -- who forces her to sleep
        = \s,v,n,q -> QuestVP s (ComplSlash (SlashV2V v q) n) ; --% 
      mkQCl : IP -> A  -> QCl    -- who is old
        = \x,y -> QuestVP x (UseComp (CompAP (PositA y))) ; --%   
      mkQCl : IP -> A -> NP -> QCl -- who is older than her   
        = \x,y,z -> QuestVP x (UseComp (CompAP (ComparA y z))) ; --% 
      mkQCl : IP -> A2 -> NP -> QCl -- who is married to her 
	= \x,y,z -> QuestVP x (UseComp (CompAP (ComplA2 y z))) ; --% 
      mkQCl : IP -> AP -> QCl    -- who is very old 
	= \x,y -> QuestVP x (UseComp (CompAP y)) ; --% 
      mkQCl : IP -> NP -> QCl    -- who is the man   
        = \x,y -> QuestVP x (UseComp (CompNP y)) ; --%   
      mkQCl : IP -> N -> QCl    -- who is a man   
        = \x,y -> QuestVP x (UseComp (CompCN (UseN y))) ; --%   
      mkQCl : IP -> CN -> QCl    -- who is an old man   
	= \x,y -> QuestVP x (UseComp (CompCN y)) ; --%   
      mkQCl : IP -> Adv -> QCl   -- who is here   
	= \x,y -> QuestVP x (UseComp (CompAdv y)) ; --%   
      mkQCl : IP -> NP -> V2 -> QCl        -- who does she love 
      = \ip,np,v -> QuestSlash ip (SlashVP np (SlashV2a v)) ; --%
      mkQCl : IP -> ClSlash -> QCl         -- who does she love today   --:   
      = QuestSlash   ; --% 

-- Adverbial 'wh' questions are built with interrogative adverbials, with the
-- special case of prepositional phrases with interrogative pronouns.

      mkQCl : IAdv -> Cl -> QCl            -- why does she sleep   --:  
      = QuestIAdv    ; --%  
      mkQCl : Prep -> IP -> Cl -> QCl      -- with whom does she sleep 
      = \p,ip -> QuestIAdv (PrepIP p ip)  ; --% 

-- An interrogative adverbial can serve as the complement of a copula.

      mkQCl : IAdv -> NP -> QCl   -- where is she 
      = \a -> QuestIComp (CompIAdv a)   ; --% 

-- Asking about a known subject.

      mkQCl : IComp -> NP -> QCl   -- who is this man  --:  
      = \a -> QuestIComp a   ; --% 

-- Existentials are a special construction.

      mkQCl : IP -> QCl         -- which cities are there  --:  
      = ExistIP ; --% 
      } ; --% 


--3 IComp, interrogative complements

    mkIComp = overload { --%
      mkIComp : IAdv -> IComp  -- where (is it) --:
      = CompIAdv ; --%
      mkIComp : IP -> IComp    -- who (is it) --:
      = CompIP ; --%
      } ; --% 

--3 IP, interrogative pronouns 

    mkIP = overload { --%

-- Interrogative pronouns 
-- can be formed much like noun phrases, by using interrogative quantifiers.

      mkIP : IDet -> CN -> IP          -- which five big cities  --:  
      = IdetCN ; --% 
      mkIP : IDet -> N -> IP      -- which five cities
      = \i,n -> IdetCN i (UseN n)  ; --% 
      mkIP : IDet -> IP      -- which five --:
      = IdetIP  ; --% 
      mkIP : IQuant -> CN -> IP    -- which big city
                     =  \i,n -> IdetCN (IdetQuant i NumSg) n ; --%  
      mkIP : IQuant -> Num -> CN -> IP          -- which five big cities 
                     =  \i,nu,n -> IdetCN (IdetQuant i nu) n ; --% 
      mkIP : IQuant -> N -> IP      -- which city
                     =  \i,n -> IdetCN (IdetQuant i NumSg) (UseN n) ; --%  


-- An interrogative pronoun can be modified by an adverb.

      mkIP : IP -> Adv -> IP        -- who in Paris --:
      = AdvIP ; --%
      } ; --% 

    what_IP : IP  -- what (singular)
    = whatSg_IP ; --%  
    who_IP : IP   -- who (singular)
    = whoSg_IP ; --%  

-- More interrogative pronouns and determiners can be found in $Structural$.



--3 IAdv, interrogative adverbs. 

-- In addition to the interrogative adverbs defined in the $Structural$ lexicon, they
-- can be formed as prepositional phrases from interrogative pronouns.

    mkIAdv = overload {  --%
      mkIAdv : Prep -> IP -> IAdv --  in which city 
      = PrepIP ; --%    
      mkIAdv : IAdv -> Adv -> IAdv --  where in Paris  
      = AdvIAdv ; --%  
      } ; --%  

-- More interrogative adverbs are given in $Structural$.

--3 IDet, interrogative determiners
    mkIDet = overload { --%
      mkIDet : IQuant -> Num -> IDet          -- which (songs) 
      =  \i,nu -> IdetQuant i nu ; --% 
      mkIDet : IQuant -> IDet      
      =  \i -> IdetQuant i NumSg ; --% 
      } ; --% 

    which_IDet : IDet 
    = whichSg_IDet ; --% 
    whichSg_IDet : IDet  --%
    = IdetQuant which_IQuant NumSg ; --% 
    whichPl_IDet : IDet 
    = IdetQuant which_IQuant NumPl ; --% 




--3 RS, relative sentences 

-- Just like a sentence $S$ is built from a clause $Cl$, 
-- a relative sentence $RS$ is built from
-- a relative clause $RCl$ by fixing the tense, anteriority and polarity. 
-- Any of these arguments
-- can be omitted, which results in the default (present, simultaneous,
-- and positive, respectively).

    mkRS = overload { --%

      mkRS : RCl  -> RS --%
      = TUseRCl TPres ASimul PPos ; --% 
      mkRS : Tense -> RCl -> RS --%  
      = \t -> TUseRCl t ASimul PPos ; --% 
      mkRS : Ant -> RCl -> RS --%
      = \a -> TUseRCl TPres a PPos ; --% 
      mkRS : Pol -> RCl -> RS --%
      = \p -> TUseRCl TPres ASimul p ; --% 
      mkRS : Tense -> Ant -> RCl -> RS --% 
      = \t,a -> TUseRCl t a PPos ; --% 
      mkRS : Tense -> Pol -> RCl -> RS --%
      = \t,p -> TUseRCl t ASimul p ; --% 
      mkRS : Ant -> Pol -> RCl -> RS --%
      = \a,p -> TUseRCl TPres a p ; --% 
      mkRS : (Tense) -> (Ant) -> (Pol) -> RCl -> RS -- that wouldn't have slept 
      = TUseRCl ; --% 
      mkRS : Temp -> (Pol) -> RCl -> RS -- that wouldn't have slept 
      = UseRCl ; --% 
      mkRS : Conj -> RS -> RS -> RS -- who sleeps and whose mother runsx
      = \c,x,y -> ConjRS c (BaseRS x y) ; --% 
      mkRS : Conj -> ListRS -> RS -- who sleeps, whom I see and who sleeps --:
      = \c,xy -> ConjRS c xy ; --% 
      } ; --% 

--3 RCl, relative clauses 

    mkRCl = overload { --%

-- Relative clauses are built from relative pronouns in subject or object position.
-- The former uses a verb phrase; we don't give
-- shortcuts for verb-argument sequences as we do for clauses.
-- The latter uses the 'slash' category of objectless clauses (see below); 
-- we give the common special case with a two-place verb.

      mkRCl : RP -> VP -> RCl        -- that loves she   --:   
      = RelVP     ; --% 

      mkRCl : RP -> V -> RCl                -- who sleeps   
      = \s,v -> RelVP s (UseV v); --%   
      mkRCl : RP -> V2 -> NP -> RCl         -- who loves her
      = \s,v,o -> RelVP s (ComplV2 v o); --%   
      mkRCl : RP -> V3 -> NP -> NP -> RCl   -- who sends it to her
      = \s,v,o,i -> RelVP s (ComplV3 v o i); --%   
      mkRCl : RP  -> VV -> VP -> RCl        -- who wants to sleep
        = \s,v,vp -> RelVP s (ComplVV v vp) ; --% 
      mkRCl : RP  -> VS -> S  -> RCl        -- who says that she sleeps
        = \s,v,p -> RelVP s (ComplVS v p) ; --% 
      mkRCl : RP  -> VQ -> QS -> RCl        -- who wonders who sleeps
        = \s,v,q -> RelVP s (ComplVQ v q) ; --% 
      mkRCl : RP  -> VA -> A -> RCl        -- who becomes old
        = \s,v,q -> RelVP s (ComplVA v (PositA q)) ; --% 
      mkRCl : RP  -> VA -> AP -> RCl        -- who becomes old
        = \s,v,q -> RelVP s (ComplVA v q) ; --% 
      mkRCl : RP  -> V2A -> NP -> A -> RCl -- who paints it red
        = \s,v,n,q -> RelVP s (ComplV2A v n (PositA q)) ; --% 
      mkRCl : RP  -> V2A -> NP -> AP -> RCl -- who paints it red
        = \s,v,n,q -> RelVP s (ComplV2A v n q) ; --% 
      mkRCl : RP  -> V2S -> NP -> S -> RCl          -- who tells her that we sleep
        = \s,v,n,q -> RelVP s (ComplSlash (SlashV2S v q) n) ; --% 
      mkRCl : RP  -> V2Q -> NP -> QS -> RCl         -- who asks her who sleeps 
        = \s,v,n,q -> RelVP s (ComplSlash (SlashV2Q v q) n) ; --% 
      mkRCl : RP  -> V2V -> NP -> VP -> RCl         -- who forces her to sleep
        = \s,v,n,q -> RelVP s (ComplSlash (SlashV2V v q) n) ; --% 
      mkRCl : RP -> A  -> RCl    -- who is old
        = \x,y -> RelVP x (UseComp (CompAP (PositA y))) ; --%   
      mkRCl : RP -> A -> NP -> RCl -- who is older than her   
        = \x,y,z -> RelVP x (UseComp (CompAP (ComparA y z))) ; --% 
      mkRCl : RP -> A2 -> NP -> RCl -- who is married to her 
	= \x,y,z -> RelVP x (UseComp (CompAP (ComplA2 y z))) ; --% 
      mkRCl : RP -> AP -> RCl    -- who is very old 
	= \x,y -> RelVP x (UseComp (CompAP y)) ; --% 
      mkRCl : RP -> NP -> RCl    -- who is the man   
        = \x,y -> RelVP x (UseComp (CompNP y)) ; --%   
      mkRCl : RP -> N -> RCl    -- who is a man   
        = \x,y -> RelVP x (UseComp (CompCN (UseN y))) ; --%   
      mkRCl : RP -> CN -> RCl    -- who is an old man   
	= \x,y -> RelVP x (UseComp (CompCN y)) ; --%   
      mkRCl : RP -> Adv -> RCl   -- who is here   
	= \x,y -> RelVP x (UseComp (CompAdv y)) ; --%   
      mkRCl : RP -> NP -> V2 -> RCl        -- who does she love 
      = \ip,np,v -> RelSlash ip (SlashVP np (SlashV2a v)) ; --%
      mkRCl : RP -> ClSlash -> RCl         -- who does she love today   --:   
      = RelSlash   ; --% 

-- There is a simple 'such that' construction for forming relative 
-- clauses from clauses.

      mkRCl : Cl -> RCl              -- such that she loves him 
      = RelCl ; --% 
      } ; --% 

--3 RP, relative pronouns 

-- There is an atomic relative pronoun

    which_RP : RP                        -- which/who  --:
      = IdRP ; --% 

-- A relative pronoun can be made into a kind of a prepositional phrase.

    mkRP : Prep -> NP -> RP -> RP    -- all the houses in which --: 
      = FunRP ; --% 


--3 SSlash, objectless sentences 

    mkSSlash = overload { --%
      mkSSlash : Temp -> Pol -> ClSlash -> SSlash  --:
      = UseSlash --%
      } ; --%

--3 ClSlash, objectless clauses

    mkClSlash = overload { --%

-- Objectless sentences are used in questions and relative clauses.
-- The most common way of constructing them is by using a two-place verb
-- with a subject but without an object.

      mkClSlash : NP -> VPSlash -> ClSlash        -- (whom) he sees here --: 
      = \np,vps -> SlashVP np vps ; --% 
      mkClSlash : NP -> V2 -> ClSlash        -- (whom) he sees 
      = \np,v2 -> SlashVP np (SlashV2a v2) ; --% 

-- The two-place verb can be separated from the subject by a verb-complement verb.

      mkClSlash : NP -> VV -> V2 -> ClSlash  -- (whom) he wants to see 
               = \np,vv,v2 -> SlashVP np (SlashVV vv (SlashV2a v2))  ; --% 

-- The missing object can also be the noun phrase in a prepositional phrase.

      mkClSlash : Cl -> Prep -> ClSlash      -- (with whom) he sleeps --:
      = SlashPrep ; --% 

-- An objectless sentence can be modified by an adverb.

      mkClSlash : ClSlash -> Adv -> ClSlash    -- (whom) he sees tomorrow  --: 
      = AdvSlash ; --% 

-- Slash can be transferred to an embedded sentence.

      mkClSlash : NP -> VS -> SSlash -> ClSlash -- (whom) she says that he loves --:
      = SlashVS --%

      } ; --% 


--3 VPSlash, verb phrases missing an object 

    mkVPSlash = overload { --%

-- This is the deep level of many-argument predication, permitting extraction.

      mkVPSlash : V2  -> VPSlash         -- (whom) (she) loves --:
        = SlashV2a ; --% 
      mkVPSlash : V3  -> NP -> VPSlash   -- (whom) (she) gives an apple  --: 
        = Slash2V3 ; --% 
      mkVPSlash : V2A -> AP -> VPSlash   -- (whom) (she) paints red  --:
        = SlashV2A ; --% 
      mkVPSlash : V2Q -> QS -> VPSlash   -- (whom) (she) asks who sleeps  --: 
        = SlashV2Q ; --% 
      mkVPSlash : V2S -> S  -> VPSlash   -- (whom) (she) tells that we sleep  --:
        = SlashV2S ; --% 
      mkVPSlash : V2V -> VP -> VPSlash   -- (whom) (she) forces to sleep  --:
        = SlashV2V ; --% 
      mkVPSlash : VV  -> VPSlash -> VPSlash  -- want always to buy --:
        = SlashVV ; --%
      mkVPSlash : V2V -> NP -> VPSlash -> VPSlash -- beg me always to buy --:
        = SlashV2VNP ; --%
      } ; --% 


--2 Lists for coordination 

-- The rules in this section are very uniform: a list can be built from two or more
-- expressions of the same category.

--3 ListS, sentence lists 

  mkListS = overload { --%
   mkListS : S -> S -> ListS  -- list of two --:
   = BaseS ; --% 
   mkListS : S -> ListS -> ListS  -- list of more --:
   = ConsS  ; --% 
   } ; --% 

--3 ListAdv, adverb lists 

  mkListAdv = overload {  --%
   mkListAdv : Adv -> Adv -> ListAdv  -- list of two --:
   = BaseAdv ; --% 
   mkListAdv : Adv -> ListAdv -> ListAdv  -- list of more --:
   = ConsAdv  ; --% 
   } ; --% 



--3 ListAP, adjectival phrase lists 

  mkListAP = overload {  --%
   mkListAP : AP -> AP -> ListAP  -- list of two --:
   = BaseAP ; --% 
   mkListAP : AP -> ListAP -> ListAP  -- list of more --:
   = ConsAP  ; --% 
   } ; --% 



--3 ListNP, noun phrase lists 

  mkListNP = overload {  --%
   mkListNP : NP -> NP -> ListNP  -- list of two --:
   = BaseNP ; --% 
   mkListNP : NP -> ListNP -> ListNP  -- list of more --:
   = ConsNP  ; --% 
   } ; --% 

--3 ListRS, relative clause lists 

  mkListRS = overload {  --%
   mkListRS : RS -> RS -> ListRS  -- list of two --:
   = BaseRS ; --% 
   mkListRS : RS -> ListRS -> ListRS  -- list of more --:
   = ConsRS  ; --% 
   } ; --% 


--.  


      the_Art : Art = DefArt ;     -- the  
      a_Art   : Art = IndefArt ;   -- a  

    ---- obsol 

    mkQuantSg : Quant -> QuantSg = SgQuant ; 
    mkQuantPl : Quant -> QuantPl = PlQuant ; 

      this_QuantSg : QuantSg = mkQuantSg this_Quant ; 
      that_QuantSg : QuantSg = mkQuantSg that_Quant ;  

      these_QuantPl : QuantPl = mkQuantPl this_Quant ;  
      those_QuantPl : QuantPl = mkQuantPl that_Quant ;  

    sgNum : Num = NumSg ;  
    plNum : Num = NumPl ;  





------------ for backward compatibility 

    QuantSg : Type = Quant ** {isSg : {}} ; 
    QuantPl : Type = Quant ** {isPl : {}} ; 
    SgQuant : Quant -> QuantSg = \q -> q ** {isSg = <>} ; 
    PlQuant : Quant -> QuantPl = \q -> q ** {isPl = <>} ; 

-- Pre-4 constants defined

  DetSg : Quant -> Ord -> Det = \q -> DetQuantOrd q NumSg ; 
  DetPl : Quant -> Num -> Ord -> Det = DetQuantOrd ; 

  ComplV2 : V2 -> NP -> VP = \v,np -> ComplSlash (SlashV2a v) np ;
  ComplV2A : V2A -> NP -> AP -> VP = \v,np,ap -> ComplSlash (SlashV2A v ap) np ; 
  ComplV3 : V3 -> NP -> NP -> VP = \v,o,d -> ComplSlash (Slash3V3 v d) o ; 



-- new things



-- export needed, since not in Cat

  ListAdv : Type = Grammar.ListAdv ; 
  ListAP : Type = Grammar.ListAP ; 
  ListNP : Type = Grammar.ListNP ; 
  ListS : Type = Grammar.ListS ; 

-- bw to 4

    Art : Type = Quant ; 
      the_Art : Art = DefArt ;   -- the 
      a_Art : Art  = IndefArt ;   -- a 


    DetArtSg : Art -> CN -> NP = \a -> DetCN (DetQuant a sgNum) ; 
    DetArtPl : Art -> CN -> NP = \a -> DetCN (DetQuant a plNum) ; 

    DetArtOrd : Quant -> Num -> Ord -> Det = DetQuantOrd ; 
    DetArtCard : Art -> Card -> Det = \a,c -> DetQuant a (NumCard c) ; 

    TUseCl  : Tense -> Ant -> Pol ->  Cl ->  S = \t,a -> UseCl  (TTAnt t a) ; 
    TUseQCl : Tense -> Ant -> Pol -> QCl -> QS = \t,a -> UseQCl (TTAnt t a) ; 
    TUseRCl : Tense -> Ant -> Pol -> RCl -> RS = \t,a -> UseRCl (TTAnt t a) ; 

-- numerals from strings

oper 
  str2ord : Str -> Ord = \s -> case Predef.lessInt (Predef.length s) 7 of {
    Predef.PTrue  => OrdNumeral (str2numeral s) ;
    Predef.PFalse => OrdDigits (str2digits s)
    } ;

  str2card : Str -> Card = \s -> case Predef.lessInt (Predef.length s) 7 of {
    Predef.PTrue  => NumNumeral (str2numeral s) ;
    Predef.PFalse => NumDigits (str2digits s)
    } ;

  str2numeral : Str -> Numeral = 
(\s -> case s of {
    ? => num (pot2as3 (pot1as2 (pot0as1 (s2s10 s)))) ;
    ? + ? => num (pot2as3 (pot1as2 (s2s100 s))) ;
    ? + ? + ? => num (pot2as3 (s2s1000 s)) ;

--    m@(? + _) + "000"            => num (pot3 (s2s1000 m)) ;
--    m@(? + _) + "00" + n@?       => num (pot3plus (s2s1000 m) (s2s1000 n)) ; 
--    m@(? + _) + "0"  + n@(? + ?) => num (pot3plus (s2s1000 m) (s2s1000 n)) ; 
--    m@(? + _) + n@(? + ? + ?)    => num (pot3plus (s2s1000 m) (s2s1000 n)) ; 
--    _ => num (pot2as3 (s2s1000 s))
    _ => Predef.error ("no numeral for string" ++ s)
    })
  where {

  s2d : Str -> Digit = \s -> case s of {
    "2" => n2 ;
    "3" => n3 ;
    "4" => n4 ;
    "5" => n5 ;
    "6" => n6 ;
    "7" => n7 ;
    "8" => n8 ;
    "9" => n9 ;
    _   => Predef.error ("str2numeral: not a valid Digit" ++ s)
    } ;

  s2s10 : Str -> Sub10 = \s -> case s of {
    "1" => pot01 ;
    #idigit => pot0 (s2d s) ;
    _   => Predef.error ("str2numeral: not a valid Sub10" ++ s)
    } ;

  s2s100 : Str -> Sub100 = \s -> case s of {
    "10"       => pot110 ;
    "11"       => pot111 ;
    "1" + d@#digit  => pot1to19 (s2d d) ;
    d@#idigit + "0" => pot1 (s2d d) ;
    d@#idigit + n@? => pot1plus (s2d d) (s2s10 n) ;
    _               => pot0as1 (s2s10 s)
    } ;

  s2s1000 : Str -> Sub1000 = \s -> case s of {
    d@? + "00"      => pot2 (s2s10 d) ;
    d@? + "0" + n@? => pot2plus (s2s10 d) (s2s100 n) ;
    d@? + n@(? + ?) => pot2plus (s2s10 d) (s2s100 n) ;
    _ => pot1as2 (s2s100 s)
    } ;

  } ;
  idigit : pattern Str = #("1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9") ;
  digit : pattern Str = #("0" | #idigit) ;

  --- it would be nice to have foldr on strings...
  str2digits : Str -> Digits = (\s -> case s of {
    d0@? => IDig (s2d d0) ;
    d1@? + d0@? => IIDig (s2d d1) (IDig (s2d d0)) ;
    d2@? + d1@? + d0@? => IIDig (s2d d2) (IIDig (s2d d1) (IDig (s2d d0))) ;
    d3@? + d2@? + d1@? + d0@? => 
      IIDig (s2d d3) (IIDig (s2d d2) (IIDig (s2d d1) (IDig (s2d d0)))) ;
    d4@? + d3@? + d2@? + d1@? + d0@? => 
      IIDig (s2d d4) (IIDig (s2d d3) (IIDig (s2d d2) (IIDig (s2d d1) (IDig (s2d d0))))) ;
    d5@? + d4@? + d3@? + d2@? + d1@? + d0@? => 
      IIDig (s2d d5) (IIDig (s2d d4) (IIDig (s2d d3) (IIDig (s2d d2) 
        (IIDig (s2d d1) (IDig (s2d d0)))))) ;
    d6@? + d5@? + d4@? + d3@? + d2@? + d1@? + d0@? => 
      IIDig (s2d d6) (IIDig (s2d d5) (IIDig (s2d d4) (IIDig (s2d d3) 
        (IIDig (s2d d2) (IIDig (s2d d1) (IDig (s2d d0))))))) ;
    d7@? + d6@? + d5@? + d4@? + d3@? + d2@? + d1@? + d0@? => 
      IIDig (s2d d7) (IIDig (s2d d6) (IIDig (s2d d5) (IIDig (s2d d4) (IIDig (s2d d3) 
        (IIDig (s2d d2) (IIDig (s2d d1) (IDig (s2d d0)))))))) ;
    _ => Predef.error ("cannot deal with so many digits:" ++ s)
    }) where {
  s2d : Str -> Dig = \s -> case s of {
    "0" => D_0 ;
    "1" => D_1 ;
    "2" => D_2 ;
    "3" => D_3 ;
    "4" => D_4 ;
    "5" => D_5 ;
    "6" => D_6 ;
    "7" => D_7 ;
    "8" => D_8 ;
    "9" => D_9 ;
    _   => Predef.error ("s2d: not a valid digit" ++ s)
    } ;
  } ;

    n1_Digits : Digits -- 1 
    = IDig D_1 ; --% 
    n2_Digits : Digits -- 2 
    = IDig D_2 ; --% 
    n3_Digits : Digits -- 3
    = IDig D_3 ; --% 
    n4_Digits : Digits -- 4
    = IDig D_4 ; --% 
    n5_Digits : Digits -- 5
    = IDig D_5 ; --% 
    n6_Digits : Digits -- 6
    = IDig D_6 ; --% 
    n7_Digits : Digits -- 7
    = IDig D_7 ; --% 
    n8_Digits : Digits -- 8
    = IDig D_8 ; --% 
    n9_Digits : Digits -- 9
    = IDig D_9 ; --% 
    n10_Digits : Digits -- 10
    = IIDig D_1 (IDig D_0) ; --% 
    n20_Digits : Digits   -- 20
    = IIDig D_2 (IDig D_0) ; --% 
    n100_Digits : Digits -- 100
    = IIDig D_1 (IIDig D_0 (IDig D_0)) ; --% 
    n1000_Digits : Digits -- 1000
    = IIDig D_1 (IIDig D_0 (IIDig D_0 (IDig D_0))) ; --% 

-- Some "round" numbers are here given as shorthands.

    n1_Numeral : Numeral 
    = num (pot2as3 (pot1as2 (pot0as1 pot01))) ; --%  
    n2_Numeral : Numeral 
    = num (pot2as3 (pot1as2 (pot0as1 (pot0 n2)))) ; --%  
    n3_Numeral : Numeral 
    = num (pot2as3 (pot1as2 (pot0as1 (pot0 n3)))) ; --%  
    n4_Numeral : Numeral 
    = num (pot2as3 (pot1as2 (pot0as1 (pot0 n4)))) ; --%  
    n5_Numeral : Numeral 
    = num (pot2as3 (pot1as2 (pot0as1 (pot0 n5)))) ; --%  
    n6_Numeral : Numeral 
    = num (pot2as3 (pot1as2 (pot0as1 (pot0 n6)))) ; --%  
    n7_Numeral : Numeral 
    = num (pot2as3 (pot1as2 (pot0as1 (pot0 n7)))) ; --%  
    n8_Numeral : Numeral 
    = num (pot2as3 (pot1as2 (pot0as1 (pot0 n8)))) ; --%  
    n9_Numeral : Numeral 
    = num (pot2as3 (pot1as2 (pot0as1 (pot0 n9)))) ; --%  
    n10_Numeral : Numeral 
    = num (pot2as3 (pot1as2 pot110)) ; --%  
    n20_Numeral : Numeral 
    = num (pot2as3 (pot1as2 (pot1 n2))) ; --%  
    n100_Numeral : Numeral 
    = num (pot2as3 (pot2 pot01)) ; --%  
    n1000_Numeral : Numeral 
    = num (pot3 (pot1as2 (pot0as1 pot01))) ; --%  


}  
