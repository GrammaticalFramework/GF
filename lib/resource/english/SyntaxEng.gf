--# -path=.:../../prelude

--1 A Small English Resource Syntax
--
-- Aarne Ranta 2002
--
-- This resource grammar contains definitions needed to construct 
-- indicative, interrogative, and imperative sentences in English.
--
-- The following files are presupposed:

resource SyntaxEng = MorphoEng ** open Prelude, (CO = Coordination) in {

--2 Common Nouns
--
-- Simple common nouns are defined as the type $CommNoun$ in $morpho.Deu.gf$.

--3 Common noun phrases

-- To the common nouns of morphology,
-- we add natural gender (human/nonhuman) which is needed in syntactic
-- combinations (e.g. "man who runs" - "program which runs").

oper
  CommNoun = CommonNoun ** {g : Gender} ;

  CommNounPhrase = CommNoun ;

  noun2CommNounPhrase : CommNoun -> CommNounPhrase = \man ->
    man ;

  cnGen : CommonNoun -> Gender -> CommNoun = \cn,g ->
    cn ** {g = g} ;

  cnHum : CommonNoun -> CommNoun = \cn ->
    cnGen cn human ;
  cnNoHum : CommonNoun -> CommNoun = \cn ->
    cnGen cn Neutr ;

--2 Noun phrases
--
-- The worst case is pronouns, which have inflection in the possessive forms. 
-- Proper names are a special case.

  NounPhrase : Type = {s : NPForm => Str ; a : Agr} ;

-- The worst case for agreement features are reflexive pronouns (8 different).

  param Agr = ASgP1 | ASgP2 | ASgP3 Gender | APl Person ;

  oper
    toAgr : Number -> Person -> Gender -> Agr = \n,p,g -> 
      case <n,p> of {
        <Sg,P1> => ASgP1 ;
        <Sg,P2> => ASgP2 ;
        <Sg,P3> => ASgP3 g ;
        _       => APl p
        } ;
    fromAgr : Agr -> {n : Number ; p : Person ; g : Gender} = \a ->
      case a of {
        ASgP1   => {n = Sg ; p = P1 ; g = human} ;
        ASgP2   => {n = Sg ; p = P2 ; g = human} ;
        ASgP3 g => {n = Sg ; p = P1 ; g = g} ;
        APl   p => {n = Pl ; p = p ; g = human}
        } ;

  nameNounPhrase : ProperName -> NounPhrase = \john -> 
    {s = \\c => john.s ! toCase c ; a = toAgr Sg P3 john.g} ;

  nameNounPhrasePl : ProperName -> NounPhrase = \john -> 
    {s = \\c => john.s ! toCase c ; a = toAgr Pl P3 john.g} ;

-- The following construction has to be refined for genitive forms:
-- "we two", "us two" are OK, but "our two" is not.

  Numeral : Type = {s : Case => Str} ;

  pronWithNum : Pronoun -> Numeral -> Pronoun = \we,two ->
    {s = \\c => we.s ! c ++ two.s ! toCase c ; n = we.n ; p = we.p ; g
    = human} ;

  noNum : Numeral = {s = \\_ => []} ;

  pronNounPhrase : Pronoun -> NounPhrase = \pro -> 
    {s = pro.s ; a = toAgr pro.n pro.p pro.g} ;

--2 Determiners
--
-- Determiners are inflected according to the nouns they determine.
-- The determiner is not inflected.

  Determiner : Type = {s : Str ; n : Number} ;

  detNounPhrase : Determiner -> CommNounPhrase -> NounPhrase = \every, man -> 
    {s = \\c => every.s ++ man.s ! every.n ! toCase c ; 
     a = toAgr every.n P3 man.g 
    } ;

  mkDeterminer : Number -> Str -> Determiner = \n,the -> 
    mkDeterminerNum n the noNum ;

  mkDeterminerNum : Number -> Str -> Numeral -> Determiner = \n,det,two -> 
    {s = det ++ two.s ! Nom ; 
     n = n
    } ;

  everyDet = mkDeterminer Sg "every" ;
  allDet   = mkDeterminerNum Pl "all" ;
  mostDet  = mkDeterminer Pl "most" ;
  aDet     = mkDeterminer Sg artIndef ;
  plDet    = mkDeterminerNum Pl [] ;
  theSgDet = mkDeterminer Sg "the" ;
  thePlDet = mkDeterminerNum Pl "the" ;
  anySgDet = mkDeterminer Sg "any" ;
  anyPlDet = mkDeterminerNum Pl "any" ;

  whichSgDet = mkDeterminer Sg "which" ;
  whichPlDet = mkDeterminerNum Pl "which" ;

  whichDet = whichSgDet ; --- API

  indefNoun : Number -> CommNoun -> Str = \n,man -> 
    (indefNounPhrase n man).s ! NomP ;

  indefNounPhrase : Number -> CommNounPhrase -> NounPhrase = \n ->
    indefNounPhraseNum n noNum ; 

  indefNounPhraseNum : Number -> Numeral ->CommNounPhrase -> NounPhrase = 
    \n,two,man -> 
    {s = \\c => case n of {
                       Sg => artIndef ++ two.s ! Nom ++ man.s ! n ! toCase c ; 
                       Pl => two.s ! Nom ++ man.s ! n ! toCase c
                       } ;
     a = toAgr n P3 man.g
    } ;

  defNounPhrase : Number -> CommNounPhrase -> NounPhrase = \n ->
    defNounPhraseNum n noNum ;
  defNounPhraseNum : Number -> Numeral -> CommNounPhrase -> NounPhrase = 
    \n,two,car -> 
    {s = \\c => artDef ++ two.s ! Nom ++ car.s ! n ! toCase c ; 
     a = toAgr n P3 car.g
    } ;

-- Genitives of noun phrases can be used like determiners, to build noun phrases.
-- The number argument makes the difference between "my house" - "my houses".
--
-- We have the variation "the car of John / the car of John's / John's car"

  npGenDet : Number -> Numeral -> NounPhrase -> CommNounPhrase -> NounPhrase = 
    \n,two,john,car -> 
      {s = \\c => variants {
             artDef ++ two.s ! Nom ++ car.s ! n ! Nom ++ "of" ++ john.s ! GenSP ; 
             john.s ! GenP ++ two.s ! Nom ++ car.s ! n ! toCase c
             } ;
       a = toAgr n P3 car.g
      } ;

-- *Bare plural noun phrases* like "men", "good cars", are built without a 
-- determiner word.

  plurDet : CommNounPhrase -> NounPhrase = \cn -> 
    {s = \\c => cn.s ! plural ! toCase c ; 
     a = toAgr Pl P3 cn.g
    } ;

-- Constructions like "the idea that two is even" are formed at the
-- first place as common nouns, so that one can also have "a suggestion that...".

  nounThatSentence : CommNounPhrase -> SS -> CommNounPhrase = \idea,x -> 
    {s = \\n,c => idea.s ! n ! c ++ "that" ++ x.s ; 
     g = idea.g
    } ;


--2 Adjectives
--
-- Adjectival phrases have a parameter $p$ telling if they are prefixed ($True$) or 
-- postfixed (complex APs). 

  AdjPhrase : Type = Adjective ** {p : Bool} ;

  adj2adjPhrase : Adjective -> AdjPhrase = \new -> new ** {p = True} ;

  simpleAdjPhrase : Str -> AdjPhrase = \French ->
    adj2adjPhrase (regAdjective French) ;


--3 Comparison adjectives
--
-- Each of the comparison forms has a characteristic use:
--
-- Positive forms are used alone, as adjectival phrases ("big").

  positAdjPhrase : AdjDegr -> AdjPhrase = \big -> 
    adj2adjPhrase {s = big.s ! Pos} ;

-- Comparative forms are used with an object of comparison, as
-- adjectival phrases ("bigger then you").

  comparAdjPhrase : AdjDegr -> NounPhrase -> AdjPhrase = \big, you ->
    {s = \\a => big.s ! Comp ! a ++ "than" ++ you.s ! NomP ; 
     p = False
    } ;

-- Superlative forms are used with a modified noun, picking out the
-- maximal representative of a domain ("the biggest house").

  superlNounPhrase : AdjDegr -> CommNoun -> NounPhrase = \big, house ->
    {s = \\c => "the" ++ big.s ! Sup ! AAdj ++ house.s ! Sg ! toCase c ; 
     a = toAgr Sg P3 house.g
    } ;

-- Moreover, superlatives can be used alone as adjectival phrases
-- ("the youngest" - in free variation). 

  superlAdjPhrase : AdjDegr -> AdjPhrase = \big ->
    {s = \\a => "the" ++ big.s ! Sup ! a ; 
     p = True
    } ;

--3 Two-place adjectives
--
-- A two-place adjective is an adjective with a preposition used before
-- the complement.

  Preposition = Str ;

  AdjCompl = Adjective ** {s2 : Preposition} ;

  complAdj : AdjCompl -> NounPhrase -> AdjPhrase = \related,john ->
    {s = \\a => related.s ! a ++ related.s2 ++ john.s ! AccP ; 
     p = False
    } ;


--3 Modification of common nouns
--
-- The two main functions of adjective are in predication ("John is old")
-- and in modification ("an old man"). Predication will be defined
-- later, in the chapter on verbs.
--
-- Modification must pay attention to pre- and post-noun
-- adjectives: "big car"/"car bigger than X"

  modCommNounPhrase : AdjPhrase -> CommNounPhrase -> CommNounPhrase = \big, car -> 
    {s = \\n => if_then_else (Case => Str) big.p 
           (\\c => big.s ! AAdj ++ car.s ! n ! c)
           (table {Nom => car.s ! n ! Nom ++ big.s ! AAdj ; Gen => variants {}}) ;
     g = car.g
    } ;


--2 Function expressions

-- A function expression is a common noun together with the
-- preposition prefixed to its argument ("mother of x").
-- The type is analogous to two-place adjectives and transitive verbs.

  Function = CommNounPhrase ** {s2 : Preposition} ;

-- The application of a function gives, in the first place, a common noun:
-- "mother/mothers of John". From this, other rules of the resource grammar 
-- give noun phrases, such as "the mother of John", "the mothers of John",
-- "the mothers of John and Mary", and "the mother of John and Mary" (the
-- latter two corresponding to distributive and collective functions,
-- respectively). Semantics will eventually tell when each
-- of the readings is meaningful.

  appFunComm : Function -> NounPhrase -> CommNounPhrase = \mother,john -> 
    {s = \\n => table {
            Gen => nonExist ; --- ?
            _ => mother.s ! n ! Nom ++ mother.s2 ++ john.s ! GenSP 
            } ;
     g = mother.g
    } ;

-- It is possible to use a function word as a common noun; the semantics is
-- often existential or indexical.

  funAsCommNounPhrase : Function -> CommNounPhrase = 
    noun2CommNounPhrase ;

-- The following is an aggregate corresponding to the original function application
-- producing "John's mother" and "the mother of John". It does not appear in the
-- resource grammar API any longer.

  appFun : Bool -> Function -> NounPhrase -> NounPhrase = \coll, mother,john -> 
    let {n = (fromAgr john.a).n ; nf = if_then_else Number coll Sg n} in 
    variants {
      defNounPhrase nf (appFunComm mother john) ;
      npGenDet nf noNum john mother
      } ;

-- The commonest case is functions with the preposition  "of".

  funOf : CommNoun -> Function = \mother -> 
    mother ** {s2 = "of"} ;

  funOfReg : Str -> Gender -> Function = \mother,g -> 
    funOf (nounReg mother ** {g = g}) ;

-- Two-place functions add one argument place.

  Function2 = Function ** {s3 : Preposition} ;

-- There application starts by filling the first place.

  appFun2 : Function2 -> NounPhrase -> Function = \train, paris ->
    {s  = \\n,c => train.s ! n ! c ++ train.s2 ++ paris.s ! AccP ;
     g  = train.g ;
     s2 = train.s3
    } ;


--2 Verbs
--
--3 Verb phrases
--
-- The syntactic verb phrase form type, which includes compound tenses,
-- is defined as follows.

  param

  Tense = Present | Past | Future | Conditional ;
  Anteriority = Simul | Anter ;

  SForm = 
     VFinite  Tense Anteriority
   | VInfinit Anteriority
   | VPresPart
   ;

-- This is how the syntactic verb phrase forms are realized as
-- inflectional forms of verbs.

  oper

  verbSForm : Bool -> Verb -> Bool -> SForm -> Agr -> {fin,inf : Str} = 
    \isAux,verb,b,sf,agr ->
    let 
      parts : Str -> Str -> {fin,inf : Str} = \x,y -> 
        {fin = x ; inf = y} ;
      likes : Tense -> Str = \t -> verb.s ! case <t,agr> of {
         <Present,ASgP1>   => Indic P1 ;
         <Present,ASgP3 _> => Indic P3 ;
         <Present,_>       => Indic P2 ;
         <Past,ASgP1>   => Pastt Pl ;
         <Past,ASgP3 _> => Pastt Sg ;
         _       => Pastt Pl --- Future doesn't matter
         } ;
      like   = verb.s ! InfImp ;
      liked  = verb.s ! PPart ;
      liking = verb.s ! PresPart ;
      has  : Tense -> Str = \t -> auxHave b t agr ;
      have = "have" ;
      neg  = if_then_Str b [] "not" ;
      does : Tense -> Str = \t -> auxTense b t agr
    in
    case sf of {
      VFinite Present Simul => case b of {
        True  => parts (likes Present) [] ;
        False => case isAux of {
          True => parts (likes Present ++ "not") [] ;
          _ => parts (does  Present) like
          } 
        } ;
      VFinite Past Simul => case b of {
        True  => parts (likes Past) [] ;
        False => case isAux of {
          True => parts (likes Past ++ "not") [] ;
          _ => parts (does  Past) like
          }
        } ;
      VFinite t       Simul => parts (does t)      like ;
      VFinite Present Anter => parts (has Present) liked ;
      VFinite Past    Anter => parts (has Past)    liked ;
      VFinite t Anter       => parts (does t)      (have ++ liked) ;
      VInfinit  Simul => parts neg like ;
      VInfinit  Anter => parts neg (have ++ liked) ;
      VPresPart  => parts neg liking
      } ;
 
  auxHave : Bool -> Tense -> Agr -> Str = \b,t,a -> 
    let has = 
      case t of {
        Present => case a of {
          ASgP3 _ => "has" ; 
          _       => "have" 
          } ;
        Past      => "had" ;
        _         => "have" --- never used
        } 
    in negAux b has ;

  auxTense : Bool -> Tense -> Agr -> Str = \b,t,a -> 
      case t of {
         Present => negAux b (case a of {
           ASgP3 _  => "does" ;
           _   => "do" 
           }) ;
         Past      => negAux b "did" ;
         Future    => if_then_Str b "will" "won't" ;
         Conditional => negAux b "would"
         } ; 

  negAux : Bool -> Str -> Str = \b,is -> if_then_Str b is (is + "n't") ;

  useVerbGen : Bool -> Verb -> (Agr => Str) -> VerbGroup = \isAux,verb,arg -> 
    let 
      go = verbSForm isAux verb 
    in
    {s  = \\b,sf,ag => (go b sf ag).fin ;
     s2 = \\b,sf,ag => (go b sf ag).inf ++ arg ! ag ;
     isAux = isAux
    } ;

  useVerb    : Verb -> (Agr => Str) -> VerbGroup = useVerbGen False ;
  useVerbAux : Verb -> (Agr => Str) -> VerbGroup = useVerbGen True ;

  beGroup : (Agr => Str) -> VerbGroup = 
    useVerbAux (verbBe ** {s1 = []}) ; 

---- TODO: the contracted forms.

-- Verb phrases are discontinuous: the three parts of a verb phrase are
-- (s) an inflected verb, (s2) infinitive or participle, and (s3) complement.
-- For instance: "doesn't" - "walk" - ""; "hasn't" - "been" - "old".
-- There's also a parameter telling if the verb is an auxiliary:
-- this is needed in question.

  VerbGroup = {
    s  : Bool => SForm => Agr => Str ;
    s2 : Bool => SForm => Agr => Str ;
    isAux : Bool
    } ;

-- This is just an infinitival (or present participle) phrase

oper
  VerbPhrase = {
    s  : Agr => Str ;
    s1 : Str -- "not" or []
    } ;


-- All negative verb phrase behave as auxiliary ones in questions.

  predVerbGroup : Bool -> Anteriority -> VerbGroup -> VerbPhrase = \b,ant,vg -> {
    s  = \\a => vg.s2 ! b ! VInfinit ant ! a ; -- s1 is just neg for inf
    s1 = if_then_Str b [] "not"
    } ;

-- A simple verb can be made into a verb phrase with an empty complement.
-- There are two versions, depending on if we want to negate the verb.
-- N.B. negation is *not* a function applicable to a verb phrase, since
-- double negations with "don't" are not grammatical.

  predVerb : Verb -> VerbGroup = \walk ->
    useVerb walk (\\_ => []) ;

-- Verb phrases can also be formed from adjectives ("is old"),
-- common nouns ("is a man"), and noun phrases ("ist John").
-- The third rule is overgenerating: "is every man" has to be ruled out
-- on semantic grounds.

  predAdjective : Adjective -> VerbGroup = \old ->
    beGroup (\\_ => old.s ! AAdj) ;

  predCommNoun : CommNoun -> VerbGroup = \man ->
    beGroup (\\a => indefNoun (fromAgr a).n man) ;

  predNounPhrase : NounPhrase -> VerbGroup = \john ->
    beGroup (\\_ => john.s ! NomP) ;

  predAdverb : PrepPhrase -> VerbGroup = \elsewhere ->
    beGroup (\\_ => elsewhere.s) ;

  predAdjSent : Adjective -> Sentence -> Clause = \bra,hansover ->
    predVerbGroupClause
      (pronNounPhrase pronIt)
      (beGroup (
        \\n => bra.s ! AAdj ++ "that" ++ hansover.s)) ;

  predAdjSent2 : AdjCompl -> NounPhrase -> Adjective = \bra,han ->
   {s = \\af => bra.s ! af ++ bra.s2 ++ han.s ! AccP} ;


--3 Transitive verbs
--
-- Transitive verbs are verbs with a preposition for the complement,
-- in analogy with two-place adjectives and functions.
-- One might prefer to use the term "2-place verb", since
-- "transitive" traditionally means that the inherent preposition is empty.
-- Such a verb is one with a *direct object*.

  TransVerb : Type = Verb ** {s3 : Preposition} ;

-- The rule for using transitive verbs is the complementization rule.
-- Particles produce free variation: before or after the complement 
-- ("I switch on the radio" / "I switch the radio on").
---- TODO: do this again.

  complTransVerb : TransVerb -> NounPhrase -> VerbGroup = \switch,radio ->
    useVerb switch (\\_ => switch.s3 ++ radio.s ! AccP) ;

-- Verbs that take direct object and a  particle:

  mkTransVerbPart : VerbP3 -> Str -> TransVerb = \turn,off -> 
    {s = turn.s ; s1 = off ; s3 = []} ;

-- Verbs that take prepositional object, no particle:

  mkTransVerb : VerbP3 -> Str -> TransVerb = \wait,for -> 
    {s = wait.s ; s1 = [] ; s3 = for} ;

-- Verbs that take direct object, no particle:

  mkTransVerbDir : VerbP3 -> TransVerb = \love -> 
    mkTransVerbPart love [] ;

-- Transitive verbs with accusative objects can be used passively. 
-- The function does not check that the verb is transitive.
-- Therefore, the function can also be used for "he is swum", etc.
-- The syntax is the same as for adjectival predication.

  passVerb : Verb -> VerbGroup = \love ->
    predAdjective (adj2adjPhrase (regAdjective (love.s ! PPart))) ;

-- Transitive verbs can also be used reflexively.
-- But to formalize this we must make verb phrases depend on a person parameter.

  reflTransVerb : TransVerb -> VerbGroup = \love -> 
    useVerb love (\\a => love.s1 ++ love.s3 ++ reflPron a) ; ----

-- Transitive verbs can be used elliptically as verbs. The semantics
-- is left to applications. The definition is trivial, due to record
-- subtyping.

  transAsVerb : TransVerb -> Verb = \love -> 
    love ;

-- *Ditransitive verbs* are verbs with three argument places.
---- TODO: We treat so far only the rule in which the ditransitive
---- verb takes both complements to form a verb phrase.

  DitransVerb = TransVerb ** {s4 : Preposition} ; 

  mkDitransVerb : Verb -> Preposition -> Preposition -> DitransVerb = \v,p1,p2 -> 
    v ** {s3 = p1 ; s4 = p2} ;

  complDitransVerb : 
    DitransVerb -> NounPhrase -> TransVerb = \ge,dig ->
      {s  = ge.s ;
       s1 = ge.s1 ++ ge.s3 ++ dig.s ! AccP ;
       s3 = ge.s4
      } ;

  complDitransAdjVerb : 
    TransVerb -> NounPhrase -> AdjPhrase -> VerbGroup = \gor,dig,sur ->
      useVerb 
        gor 
        (\\_ => gor.s1 ++ gor.s3 ++ dig.s ! AccP ++ sur.s ! AAdj) ;

  complAdjVerb : 
    Verb -> AdjPhrase -> VerbGroup = \seut,sur ->
      useVerb 
        seut 
        (\\n => sur.s ! AAdj ++ seut.s1) ;


--2 Adverbs
--
-- Adverbs are not inflected (we ignore comparison, and treat
-- compared adverbials as separate expressions; this could be done another way).
-- We distinguish between post- and pre-verbal adverbs.

  Adverb : Type = SS ** {p : Bool} ;

  advPre  : Str -> Adverb = \seldom -> ss seldom ** {p = False} ;
  advPost : Str -> Adverb = \well   -> ss well   ** {p = True} ;

-- N.B. this rule generates the cyclic parsing rule $VP#2 ::= VP#2$
-- and cannot thus be parsed.

  adVerbPhrase : VerbGroup -> Adverb -> VerbGroup = \sings, well ->
    let {postp = orB well.p sings.isAux} in
    {
     s  = \\b,sf,a => (if_then_else Str postp [] well.s) ++ sings.s ! b ! sf ! a ;
     s2 = \\b,sf,a => sings.s2 ! b ! sf ! a ++ (if_then_else Str postp well.s []) ;
     isAux = sings.isAux
    } ;

  advAdjPhrase : SS -> AdjPhrase -> AdjPhrase = \very, good ->
    {s = \\a => very.s ++ good.s ! a ;
     p = good.p
    } ;

-- Adverbials are typically generated by prefixing prepositions.
-- The rule for creating locative noun phrases by the preposition "in"
-- is a little shaky, since other prepositions may be preferred ("on", "at").

  prepPhrase : Preposition -> NounPhrase -> Adverb = \on, it ->
    advPost (on ++ it.s ! AccP) ;

  locativeNounPhrase : NounPhrase -> Adverb = 
    prepPhrase "in" ;

  PrepPhrase = SS ;

-- This is a source of the "man with a telescope" ambiguity, and may produce
-- strange things, like "cars always" (while "cars today" is OK).
-- Semantics will have to make finer distinctions among adverbials.
--
-- N.B. the genitive case created in this way would not make sense.

  advCommNounPhrase : CommNounPhrase -> PrepPhrase -> CommNounPhrase = \car,today ->
   {s = \\n => table {
      Nom => car.s ! n ! Nom ++ today.s ; 
      Gen => nonExist
      } ;
    g = car.g
   } ;

--2 Sentences
--
-- Sentences are not inflected in this fragment of English without tense.

  Sentence : Type = SS ;

  adjPastPart : Verb -> Adjective = \verb -> {
    s = \\_ => verb.s ! PPart ++ verb.s1 ---- same Adv form
    } ;

  reflPron : Agr -> Str = \a -> case a of {
    ASgP1 => "myself" ;
    ASgP2 => "yourself" ;
    ASgP3 Masc  => "himself" ;
    ASgP3 Fem   => "herself" ;
    ASgP3 Neutr => "itself" ;
    APl P1 => "ourselves" ;
    APl P2 => "yourselves" ;
    APl P3 => "themselves"
    } ;

  progressiveVerbPhrase : VerbGroup -> VerbGroup = \vp ->
    beGroup (vp.s2 ! True ! VPresPart) ; 

--- negation of prp ignored: "not" only for "be"

--3 Tensed clauses

  Clause = {s : Bool => SForm => Str} ;

  ClForm = SForm ; ---- to be removed

  predVerbGroupClause : NounPhrase -> VerbGroup -> Clause = 
    \yo,sleep -> {
      s = \\b,c => 
        let
          a   = yo.a ; 
          you = yo.s ! NomP
        in  
          you ++ sleep.s ! b ! c ! a  ++  sleep.s2 ! b ! c ! a 
      } ;

--3 Sentence-complement verbs
--
-- Sentence-complement verbs take sentences as complements.

  SentenceVerb : Type = Verb ;

-- To generate "says that John walks" / "doesn't say that John walks":
---- TODO: the alternative without "that"

  complSentVerb : SentenceVerb -> Sentence -> VerbGroup = \say,johnruns ->
    useVerb say (\\_ => "that" ++ johnruns.s) ;

  complQuestVerb : SentenceVerb -> QuestionSent -> VerbGroup = \se,omduler ->
    useVerb se (\\_ => se.s1 ++ omduler.s ! IndirQ) ;

  complDitransSentVerb : TransVerb -> NounPhrase -> Sentence -> VerbGroup = 
    \sa,honom,duler ->
      useVerb sa 
        (\\_ => sa.s1 ++ sa.s3 ++ honom.s ! AccP ++ "that" ++ duler.s) ;

  complDitransQuestVerb : TransVerb -> NounPhrase -> QuestionSent -> VerbGroup = 
    \sa,honom,omduler ->
      useVerb sa 
        (\\_ => sa.s1 ++ sa.s3 ++ honom.s ! AccP ++ omduler.s ! IndirQ) ;


--3 Verb-complement verbs
--
-- Sentence-complement verbs take verb phrases as complements.
-- They can be auxiliaries ("can", "must") or ordinary verbs
-- ("try"); this distinction cannot be done in the multilingual
-- API and leads to some anomalies in English, such as the necessity
-- to create the infinitive form "to be able to" for "can" so that
-- the construction can be iterated, and the corresponding complication
-- in the parameter structure.

  VerbVerb : Type = Verb ** {isAux : Bool} ;

-- To generate "can walk"/"can't walk"; "tries to walk"/"does not try to walk":
-- The contraction of "not" is not provided, since it would require changing
-- the verb parameter type.

  complVerbVerb : VerbVerb -> VerbPhrase -> VerbGroup = \try,run ->
    let
       taux  = try.isAux ;
       to    = if_then_Str taux [] "to" ;
       torun : Agr => Str = 
         \\a => run.s1 ++ to ++ run.s ! a  
    in
      if_then_else VerbGroup taux 
        (useVerb    try torun)
        (useVerbAux try torun) ;

-- The three most important example auxiliaries.

  mkVerbAux : (_,_,_,_: Str) -> VerbVerb = \beable, can, could, beenable -> 
    {s = table {
       InfImp => beable ; 
       Indic _ => can ; 
       Pastt _ => could ;
       PPart => beenable ;
       PrepPart => nonExist ---- fix!
       } ;
     s1 = [] ;
     isAux = True
    } ;

---- Problem: "to" in non-present tenses comes to wrong place.

  vvCan  : VerbVerb = mkVerbAux ["be able to"] "can" "could" ["been able to"] ;
  vvMust : VerbVerb = mkVerbAux ["have to"] "must" ["had to"] ["had to"] ;

-- Notice agreement to object vs. subject:

  DitransVerbVerb = TransVerb ** {s4 : Str} ;

  complDitransVerbVerb : 
    Bool -> DitransVerbVerb -> NounPhrase -> VerbPhrase -> VerbGroup = 
     \obj,be,dig,simma ->
      useVerb be 
        (\\a => be.s1 ++ be.s3 ++ dig.s ! AccP ++ be.s3 ++ be.s4 ++
                simma.s1 ++ -- negation
              if_then_Str obj 
                 (simma.s ! dig.a)
                 (simma.s ! a)
        ) ;

  transVerbVerb : VerbVerb -> TransVerb -> TransVerb = \vilja,hitta ->
    {s  = vilja.s ;
     s1 = vilja.s1 ++ if_then_Str vilja.isAux [] "to" ++
          hitta.s ! InfImp ++ hitta.s1 ;
     s3 = hitta.s3
    } ;

  complVerbAdj : Adjective -> VerbPhrase -> VerbGroup = \grei, simma ->
    beGroup
      (\\a => 
              grei.s ! AAdj ++ simma.s1 ++
              "to" ++
              simma.s ! a) ;

  complVerbAdj2 : 
    Bool -> AdjCompl -> NounPhrase -> VerbPhrase -> VerbGroup = 
      \obj,grei,dig,simma ->
        beGroup
          (\\a =>
              grei.s ! AAdj ++ 
              grei.s2 ++ dig.s ! AccP ++
              simma.s1 ++ "to" ++
              if_then_Str obj 
                 (simma.s ! dig.a)
                 (simma.s ! a)
          ) ;


--2 Sentences missing noun phrases
--
-- This is one instance of Gazdar's *slash categories*, corresponding to his
-- $S/NP$.
-- We cannot have - nor would we want to have - a productive slash-category former.
-- Perhaps a handful more will be needed.
--
-- Notice that the slash category has a similar relation to sentences as
-- transitive verbs have to verbs: it's like a *sentence taking a complement*.
-- However, we need something more to distinguish its use in direct questions:
-- not just "you see" but ("whom") "do you see".
--
-- The particle always follows the verb, but the preposition can fly:
-- "whom you make it up with" / "with whom you make it up".
--- We reduce the current case to a more general one that has tense variation.

  ClauseSlashNounPhrase = {s : QuestForm => Bool => SForm => Str ; s2 : Preposition} ;

  slashTransVerbCl : NounPhrase -> TransVerb -> ClauseSlashNounPhrase = 
    \you,lookat ->
    {s = table {
       DirQ   => \\b,f => (questVerbPhrase     you (predVerb
    lookat)).s ! b ! f ! DirQ ;
       IndirQ => (predVerbGroupClause you (predVerb lookat)).s
       } ;
     s2 = lookat.s3
    } ;


--2 Relative pronouns and relative clauses
--
-- As described in $types.Eng.gf$, relative pronouns are inflected in 
-- gender (human/nonhuman), number, and case.
--
-- We get the simple relative pronoun ("who"/"which"/"whom"/"whose"/"that"/$""$)
-- from $morpho.Eng.gf$.

  identRelPron : RelPron = relPron ;

  funRelPron : Function -> RelPron -> RelPron = \mother,which -> 
    {s = \\g,n,c => "the" ++ mother.s ! n ! Nom ++ 
                    mother.s2 ++ which.s ! g ! n ! GenSP
    } ;

-- An auxiliary that allows the use of predication with relative pronouns.

  relNounPhrase : RelPron -> Gender -> Number -> NounPhrase = \who,g,n ->
    {s = who.s ! g ! n ; a = toAgr n P3 g} ;

-- Relative clauses can be formed from both verb phrases ("who walks") and
-- slash expressions ("whom you see", "on which you sit" / "that you sit on"). 

  RelClause   : Type = {s : Bool => SForm => Agr => Str} ;
  RelSentence : Type = {s :                  Agr => Str} ;

  relVerbPhrase : RelPron -> VerbGroup -> RelClause = \who,walks ->
    {s = \\b,sf,a => 
      let wa = fromAgr a in
      (predVerbGroupClause (relNounPhrase who wa.g wa.n) walks).s ! b ! sf
    } ;

--- TODO: full tense variation in relative clauses.

  relSlash : RelPron -> ClauseSlashNounPhrase -> RelClause = \who,yousee ->
    {s = \\b,sf,a => 
           let
             whom = who.s ! (fromAgr a).g ! (fromAgr a).n ; 
             youSee = yousee.s ! IndirQ ! b ! sf
           in
           variants {
             whom ! AccP ++ youSee ++ yousee.s2 ;
             yousee.s2 ++ whom ! GenSP ++ youSee
             }
    } ;

-- A 'degenerate' relative clause is the one often used in mathematics, e.g.
-- "number x such that x is even".

  relSuch : Clause -> RelClause = \A ->
    {s = \\b,sf,_ => "such" ++ "that" ++ A.s ! b ! sf} ;

-- The main use of relative clauses is to modify common nouns.
-- The result is a common noun, out of which noun phrases can be formed
-- by determiners. No comma is used before these relative clause.

  modRelClause : CommNounPhrase -> RelSentence -> CommNounPhrase = \man,whoruns ->
    {s = \\n,c => man.s ! n ! c ++ whoruns.s ! toAgr n P3 man.g ;
     g = man.g
    } ;

--2 Interrogative pronouns
--
-- If relative pronouns are adjective-like, interrogative pronouns are
-- noun-phrase-like. 

  IntPron : Type = {s : NPForm => Str ; n : Number ; g : Gender} ; 

-- In analogy with relative pronouns, we have a rule for applying a function
-- to a relative pronoun to create a new one. 

  funIntPron : Function -> IntPron -> IntPron = \mother,which -> 
    {s = \\c => "the" ++ mother.s ! which.n ! Nom ++ mother.s2 ++ which.s ! GenSP ;
     n = which.n ;
     g = mother.g
    } ;

-- There is a variety of simple interrogative pronouns:
-- "which house", "who", "what".

  nounIntPron : Number -> CommNounPhrase -> IntPron = \n, car ->
    {s = \\c => "which" ++ car.s ! n ! toCase c ; 
     n = n ;
     g = car.g
    } ; 

  intPronWho : Number -> IntPron = \num -> {
    s = table {
      NomP  => "who" ;
      AccP  => variants {"who" ; "whom"} ;
      GenP  => "whose" ;
      GenSP => "whom"
      } ;
    n = num ; g = human
  } ;

  intPronWhat : Number -> IntPron = \num -> {
    s = table {
      GenP  => "what's" ;
      _ => "what"
      } ;
    n = num ; g = Neutr
  } ;


--2 Utterances

-- By utterances we mean whole phrases, such as 
-- 'can be used as moves in a language game': indicatives, questions, imperative,
-- and one-word utterances. The rules are far from complete.
--
-- N.B. we have not included rules for texts, which we find we cannot say much
-- about on this level. In semantically rich GF grammars, texts, dialogues, etc, 
-- will of course play an important role as categories not reducible to utterances.
-- An example is proof texts, whose semantics show a dependence between premises
-- and conclusions. Another example is intersentential anaphora.

  Utterance = SS ;
  
  indicUtt : Sentence -> Utterance = \x -> ss (x.s ++ ".") ;
  interrogUtt : QuestionSent -> Utterance = \x -> ss (x.s ! DirQ ++ "?") ;


--2 Questions
--
-- Questions are either direct ("are you happy") or indirect 
-- ("if/whether you are happy").

param 
  QuestForm = DirQ | IndirQ ;

oper
  Question     = {s : Bool => SForm => QuestForm => Str} ;
  QuestionSent = {s :                  QuestForm => Str} ;

--- TODO: questions in all tenses.

--3 Yes-no questions 
--
-- Yes-no questions are used both independently 
-- ("does John walk" / "if John walks")
-- and after interrogative adverbials 
-- ("why does John walk" / "why John walks").
-- 
-- It is economical to handle with all these cases by the one
-- rule, $questVerbPhrase'$. The word ("ob" / "whether") never appears
-- if there is an adverbial.

  questVerbPhrase : NounPhrase -> VerbGroup -> Question = 
    questVerbPhrase' False ;

  questVerbPhrase' : Bool -> NounPhrase -> VerbGroup -> Question = 
    \adv,John,walk ->
    let 
      john = John.s ! NomP ;
      does : Bool -> Tense -> Str = \b,t -> auxTense b t John.a
    in
    {s = \\b,cl => table {
      DirQ  => case walk.isAux of {
        False => case cl of {
          VFinite t Simul => 
            does b t ++ john ++ walk.s2 ! False ! cl ! John.a ;
          _ => 
            walk.s  ! b ! cl ! John.a ++ john ++ walk.s2 ! b ! cl ! John.a
          } ;
        _ => walk.s  ! b ! cl ! John.a ++ john ++ walk.s2 ! b ! cl ! John.a
        } ;
      IndirQ => if_then_else Str adv [] (variants {"if" ; "whether"}) ++ 
                (predVerbGroupClause John walk).s ! b ! cl
      }
    } ;

--3 Wh-questions
--
-- Wh-questions are of two kinds: ones that are like $NP - VP$ sentences,
-- others that are line $S/NP - NP$ sentences.

  intVerbPhrase : IntPron -> VerbGroup -> Question = \who,walk ->
    let 
      who : NounPhrase = {s = who.s ; a = toAgr who.n P3 who.g} ;
      whowalks : Clause = predVerbGroupClause who walk
    in
    {s = \\b,sf,_ => whowalks.s ! b ! sf} ;

  intSlash : IntPron -> ClauseSlashNounPhrase -> Question = \who,yousee ->
    {s = \\b,cl,q =>
           let 
             youSee = yousee.s ! q ! b ! cl 
           in
           variants {
             who.s ! AccP ++ youSee ++ yousee.s2 ;
             yousee.s2 ++ who.s ! GenSP ++ youSee
             } 
    } ;

--3 Interrogative adverbs
--
-- These adverbs will be defined in the lexicon: they include
-- "when", "where", "how", "why", etc, which are all invariant one-word
-- expressions. In addition, they can be formed by adding prepositions
-- to interrogative pronouns, in the same way as adverbials are formed
-- from noun phrases. 

  IntAdverb = SS ;

  prepIntAdverb : Preposition -> IntPron -> IntAdverb = \at, whom ->
    ss (at ++ whom.s ! AccP) ;

-- A question adverbial can be applied to anything, and whether this makes
-- sense is a semantic question.

  questAdverbial : IntAdverb -> NounPhrase -> VerbGroup -> Question = 
    \why, you, walk ->
    {s = \\b,cf,q => 
       why.s ++ (questVerbPhrase' True you walk).s ! b ! cf !  q} ;

--2 Imperatives
--
-- We only consider second-person imperatives. 

  Imperative = SS1 Number ;

  imperVerbPhrase : Bool -> VerbGroup -> Imperative = \b,walk -> 
    {s = \\n => 
       let a = toAgr n P2 human in
       walk.s ! b ! VInfinit Simul ! a ++ walk.s2 ! b ! VInfinit Simul ! a
    } ;

  imperUtterance : Number -> Imperative -> Utterance = \n,I ->
    ss (I.s ! n ++ "!") ;

--2 Sentence adverbs
--
-- This class covers adverbs such as "otherwise", "therefore", which are prefixed
-- to a sentence to form a phrase.

  advSentence : SS -> Sentence -> Utterance = \hence,itiseven ->
    ss (hence.s ++ itiseven.s ++ ".") ;


--2 Coordination
--
-- Coordination is to some extent orthogonal to the rest of syntax, and
-- has been treated in a generic way in the module $CO$ in the file
-- $coordination.gf$. The overall structure is independent of category,
-- but there can be differences in parameter dependencies.
--
--3 Conjunctions
--
-- Coordinated phrases are built by using conjunctions, which are either
-- simple ("and", "or") or distributed ("both - and", "either - or").
--
-- The conjunction has an inherent number, which is used when conjoining
-- noun phrases: "John and Mary are..." vs. "John or Mary is..."; in the
-- case of "or", the result is however plural if any of the disjuncts is.

  Conjunction = CO.Conjunction ** {n : Number} ;
  ConjunctionDistr = CO.ConjunctionDistr ** {n : Number} ;

--3 Coordinating sentences
--
-- We need a category of lists of sentences. It is a discontinuous
-- category, the parts corresponding to 'init' and 'last' segments
-- (rather than 'head' and 'tail', because we have to keep track of the slot between
-- the last two elements of the list). A list has at least two elements.

  ListSentence : Type = SD2 ;

  twoSentence : (_,_ : Sentence) -> ListSentence = CO.twoSS ;

  consSentence : ListSentence -> Sentence -> ListSentence =
    CO.consSS CO.comma ;

-- To coordinate a list of sentences by a simple conjunction, we place
-- it between the last two elements; commas are put in the other slots,
-- e.g. "du rauchst, er trinkt und ich esse".

  conjunctSentence : Conjunction -> ListSentence -> Sentence = \c,xs ->
    ss (CO.conjunctX c xs) ;

-- To coordinate a list of sentences by a distributed conjunction, we place
-- the first part (e.g. "either") in front of the first element, the second
-- part ("or") between the last two elements, and commas in the other slots.
-- For sentences this is really not used.

  conjunctDistrSentence : ConjunctionDistr -> ListSentence -> Sentence = 
    \c,xs ->
    ss (CO.conjunctDistrX c xs) ;

--3 Coordinating adjective phrases
--
-- The structure is the same as for sentences. The result is a prefix adjective
-- if and only if all elements are prefix.

  ListAdjPhrase : Type = {s1,s2 : AForm => Str ; p : Bool} ;

  twoAdjPhrase : (_,_ : AdjPhrase) -> ListAdjPhrase = \x,y ->
    CO.twoTable AForm x y ** {p = andB x.p y.p} ;

  consAdjPhrase : ListAdjPhrase -> AdjPhrase -> ListAdjPhrase =  \xs,x ->
    CO.consTable AForm CO.comma xs x ** {p = andB xs.p x.p} ;

  conjunctAdjPhrase : Conjunction -> ListAdjPhrase -> AdjPhrase = \c,xs ->
    CO.conjunctTable AForm c xs ** {p = xs.p} ;

  conjunctDistrAdjPhrase : ConjunctionDistr -> ListAdjPhrase -> AdjPhrase = 
    \c,xs ->
    CO.conjunctDistrTable AForm c xs ** {p = xs.p} ;


--3 Coordinating noun phrases
--
-- The structure is the same as for sentences. The result is either always plural
-- or plural if any of the components is, depending on the conjunction.

  ListNounPhrase : Type = {s1,s2 : NPForm => Str ; a : Agr} ;

  twoNounPhrase : (_,_ : NounPhrase) -> ListNounPhrase = \x,y ->
    CO.twoTable NPForm x y ** {a = conjAgr x.a y.a} ;

  consNounPhrase : ListNounPhrase -> NounPhrase -> ListNounPhrase =  \xs,x ->
    CO.consTable NPForm CO.comma xs x ** {a = conjAgr xs.a x.a} ;

  conjunctNounPhrase : Conjunction -> ListNounPhrase -> NounPhrase = \c,xs ->
    let xa = fromAgr xs.a
    in
    CO.conjunctTable NPForm c xs ** 
      {a = toAgr (conjNumber c.n xa.n) xa.p xa.g} ;

  conjunctDistrNounPhrase : ConjunctionDistr -> ListNounPhrase -> NounPhrase = 
    \c,xs ->
    let xa = fromAgr xs.a
    in
    CO.conjunctDistrTable NPForm c xs ** 
      {a = toAgr (conjNumber c.n xa.n) xa.p xa.g} ;

-- We have to define a calculus of numbers of persons. For numbers,
-- it is like the conjunction with $Pl$ corresponding to $False$.

  conjNumber : Number -> Number -> Number = \m,n -> case <m,n> of {
    <Sg,Sg> => Sg ;
    _ => Pl 
    } ;

-- For persons, we let the latter argument win ("either you or I am absent"
-- but "either I or you are absent"). This is not quite clear.

  conjPerson : Person -> Person -> Person = \_,p -> 
    p ;

-- For gender, human (Masc) if any component is human.

  conjGender : Gender -> Gender -> Gender = \m,n -> case <m,n> of {
    <Neutr,Neutr> => Neutr ;
    _ => human
    } ;

-- Thus

  conjAgr : Agr -> Agr -> Agr = \x,y -> 
    let
      xa = fromAgr x ;
      ya = fromAgr y
    in
      toAgr (conjNumber xa.n ya.n) (conjPerson xa.p ya.p) (conjGender xa.g ya.g) ;
   

--2 Subjunction
--
-- Subjunctions ("when", "if", etc) 
-- are a different way to combine sentences than conjunctions.
-- The main clause can be a sentences, an imperatives, or a question,
-- but the subjoined clause must be a sentence.
--
-- There are uniformly two variant word orders, e.g. 
-- "if you smoke I get angry"
-- and "I get angry if you smoke".

  Subjunction = SS ;

  subjunctSentence : Subjunction -> Sentence -> Sentence -> Sentence = 
    \if, A, B -> 
    ss (subjunctVariants if A.s B.s) ;

  subjunctImperative : Subjunction -> Sentence -> Imperative -> Imperative = 
    \if, A, B -> 
    {s = \\n => subjunctVariants if A.s (B.s ! n)} ;

  subjunctQuestion : Subjunction -> Sentence -> QuestionSent -> QuestionSent = 
    \if, A, B ->
    {s = \\q => subjunctVariants if A.s (B.s ! q)} ;

  subjunctVariants : Subjunction -> Str -> Str -> Str = \if,A,B ->
    variants {if.s ++ A ++ "," ++ B ; B ++ "," ++ if.s ++ A} ;

  subjunctVerbPhrase : VerbGroup -> Subjunction -> Sentence -> VerbGroup =
    \V, if, A -> 
    adVerbPhrase V (advPost (if.s ++ A.s)) ;

--2 One-word utterances
-- 
-- An utterance can consist of one phrase of almost any category, 
-- the limiting case being one-word utterances. These
-- utterances are often (but not always) in what can be called the
-- default form of a category, e.g. the nominative.
-- This list is far from exhaustive.

  useNounPhrase : NounPhrase -> Utterance = \john ->
    postfixSS "." (defaultNounPhrase john) ;

  useCommonNounPhrase : Number -> CommNounPhrase -> Utterance = \n,car -> 
    useNounPhrase (indefNounPhrase n car) ;

-- Here are some default forms.

  defaultNounPhrase : NounPhrase -> SS = \john -> 
    ss (john.s ! NomP) ;

  defaultQuestion : QuestionSent -> SS = \whoareyou ->
    ss (whoareyou.s ! DirQ) ;

  defaultSentence : Sentence -> Utterance = \x -> 
    x ;

} ;
