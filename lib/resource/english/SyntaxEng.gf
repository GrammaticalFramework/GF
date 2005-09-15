--# -path=.:../../prelude

--1 A Small English Resource Syntax
--
-- Aarne Ranta 2002 - 2005
--
-- This resource grammar contains definitions needed to construct 
-- indicative, interrogative, and imperative sentences in English.
--
-- The following files are presupposed:

resource SyntaxEng = MorphoEng ** open Prelude, (CO = Coordination) in {

flags optimize=parametrize ;

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

  caseSymb : Case -> Str -> Str = \c,i -> case c of {
    Nom => i ; 
    Gen => glue i "'s"
    } ;

  nameNounPhrase : ProperName -> NounPhrase = 
    nameNounPhraseN Sg ;
  nameNounPhrasePl : ProperName -> NounPhrase = 
    nameNounPhraseN Pl ;
  nameNounPhraseN : Number -> ProperName -> NounPhrase = \n,john -> 
    {s = \\c => john.s ! toCase c ; a = toAgr n P3 john.g} ;

-- The following construction has to be refined for genitive forms:
-- "we two", "us two" are OK, but "our two" is not.

  Numeral : Type = {s : Case => Str ; n : Number} ;

  pronWithNum : Pronoun -> Numeral -> Pronoun = \we,two ->
    {s = \\c => we.s ! c ++ two.s ! toCase c ; n = we.n ; p = we.p ; g
    = human} ;

  noNum : Numeral = {s = \\_ => [] ; n = Pl} ;

  pronNounPhrase : Pronoun -> NounPhrase = \pro -> 
    {s = pro.s ; a = toAgr pro.n pro.p pro.g} ;

-- To add a symbol, such as a variable or variable list, to the end of
-- an NP.

  addSymbNounPhrase : NounPhrase -> Str -> NounPhrase = \np,x ->
    {s = \\c => np.s ! c ++ x ;
     a = np.a
    } ;

--2 Determiners
--
-- Determiners are inflected according to the nouns they determine.
-- The determiner is not inflected.

  Determiner    : Type = {s : Str ; n : Number} ;
  DeterminerNum : Type = {s : Str} ;

  detNounPhrase : Determiner -> CommNounPhrase -> NounPhrase = \every, man -> 
    {s = \\c => every.s ++ man.s ! every.n ! toCase c ; 
     a = toAgr every.n P3 man.g 
    } ;

  numDetNounPhrase : DeterminerNum -> Numeral -> CommNounPhrase -> NounPhrase = 
    \all, six, men -> 
    {s = \\c => all.s ++ six.s ! Nom ++ men.s ! six.n ! toCase c ; 
     a = toAgr six.n P3 men.g 
    } ;
  justNumDetNounPhrase : DeterminerNum -> Numeral -> NounPhrase = 
    \all, six -> 
    {s = \\c => all.s ++ six.s ! toCase c ; 
     a = toAgr six.n P3 Neutr --- gender does not matter
    } ;

  mkDeterminer : Number -> Str -> Determiner = \n,the -> 
    {s = the ;
     n = n
    } ;

  mkDeterminerNum : Str -> DeterminerNum = mkDeterminer Pl ;

  everyDet = mkDeterminer Sg "every" ;
  allDet   = mkDeterminerNum "all" ;
  mostDet  = mkDeterminer Pl "most" ;
  aDet     = mkDeterminer Sg artIndef ;
  plDet    = mkDeterminerNum [] ;
  theSgDet = mkDeterminer Sg "the" ;
  thePlDet = mkDeterminerNum "the" ;
  anySgDet = mkDeterminer Sg "any" ;
  anyPlDet = mkDeterminerNum "any" ;

  whichSgDet = mkDeterminer Sg "which" ;
  whichPlDet = mkDeterminerNum "which" ;

  whichDet = whichSgDet ; --- API

  indefNoun : Number -> CommNoun -> Str = \n,man -> 
    (indefNounPhrase n man).s ! NomP ;

  indefNounPhrase : Number -> CommNounPhrase -> NounPhrase = \n ->
    indefNounPhraseNum n noNum ; 

  indefNounPhraseNum : Number -> Numeral ->CommNounPhrase -> NounPhrase = 
    \n,two,man -> 
    {s = \\c => case n of {
                       Sg => artIndef ++ two.s ! Nom ++ man.s ! n ! toCase c ; 
                       Pl => two.s ! Nom ++ man.s ! two.n ! toCase c
                       } ;
     a = toAgr nb P3 man.g where {
       nb = case <n,two.n> of {
         <Pl,Pl> => Pl ;
         _ => Sg
         }
       }
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

  AdjPhrase : Type = {s : Agr => Str ; p : Bool} ;

  noAPAgr : Agr = ASgP2 ;

  adj2adjPhrase : Adjective -> AdjPhrase = \new -> 
    {s = \\_ => new.s ! AAdj ;
     p = True
    } ;

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
    {s = \\_ => big.s ! Comp ! AAdj ++ "than" ++ you.s ! NomP ; 
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
    {s = \\_ => "the" ++ big.s ! Sup ! AAdj ; 
     p = True
    } ;

--3 Two-place adjectives
--
-- A two-place adjective is an adjective with a preposition used before
-- the complement.

  Preposition = Str ;

  AdjCompl = Adjective ** {s2 : Preposition} ;

  complAdj : AdjCompl -> NounPhrase -> AdjPhrase = \related,john ->
    {s = \\a => related.s ! AAdj ++ related.s2 ++ john.s ! AccP ; 
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
           (\\c => big.s ! noAPAgr ++ car.s ! n ! c)
           (\\c => car.s ! n ! Nom ++ big.s ! noAPAgr ++ case c of {
              Nom => [] ;
              Gen => "'s" --- detached clitic
              }
           ) ;
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

{- --vg
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
--vg -}

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

-- The following is just an infinitival (or present participle) phrase.

param
  VIForm = VIInfinit | VIPresPart ;

oper
  VerbPhrase = {
    s  : VIForm => Agr => Str ;
    s1 : Str -- "not" or []
    } ;

  VerbClause = {
    s  : Bool => Anteriority => VIForm => Agr => Str ;
    s1 : Bool => Str -- "not" or []
    } ;

-- To form an infinitival group

{- ---- obsolete
  predVerbGroup : Bool -> {s : Str ; a : Anteriority} -> VerbGroup -> VerbPhrase =
    \b,ant,vg -> {
    s  = table {
           VIInfinit  => \\a => ant.s ++ vg.s2 ! b ! VInfinit ant.a ! a ;
           VIPresPart => \\a => ant.s ++ vg.s2 ! b ! VPresPart ! a
           } ;
    s1 = if_then_Str b [] "not"
    } ;
-}

  predVerbI : Verb -> Complement -> VerbClause = 
    \verb,comp -> 
    {s = \\p,a =>
         let
           inf = case a of {
             Simul => verb.s ! InfImp ;
             Anter => "have" ++ verb.s ! PPart 
             }
           in
           table {
             VIInfinit  => \\ag => inf ++ verb.s1 ++ comp ! ag ;
             VIPresPart => \\ag => verb.s ! PresPart ++ comp ! ag
           } ;
       s1 = \\b => if_then_Str b [] "not"
      } ;

-- A simple verb can be made into a verb phrase with an empty complement.
-- There are two versions, depending on if we want to negate the verb.
-- N.B. negation is *not* a function applicable to a verb phrase, since
-- double negations with "don't" are not grammatical.

  complVerb : Verb -> Complement = \walk ->
    \\_ => walk.s1 ;

  mkComp : Verb -> Complement -> Complement = \verb,comp ->
    \\a => verb.s1 ++ comp ! a ;

-- Verb phrases can also be formed from adjectives ("is old"),
-- common nouns ("is a man"), and noun phrases ("ist John").
-- The third rule is overgenerating: "is every man" has to be ruled out
-- on semantic grounds.

  complAdjective : Adjective -> Complement = \old ->
    (\\_ => old.s ! AAdj) ;

  complCommNoun : CommNoun -> Complement = \man ->
    (\\a => indefNoun (fromAgr a).n man) ;

  complNounPhrase : NounPhrase -> Complement = \john ->
    (\\_ => john.s ! NomP) ;

  complAdverb : PrepPhrase -> Complement = \elsewhere ->
    (\\_ => elsewhere.s) ;

  predAdjSent : Adjective -> Sentence -> Clause = \bra,hansover ->
    predBeGroup (pronNounPhrase pronIt) (\\n => bra.s ! AAdj ++ "that" ++ hansover.s) ;

  Complement = Agr => Str ;

  predBeGroupI : Complement -> VerbClause = 
    \vg ->
    {s = \\b,ant => table {
       VIInfinit => \\a => case ant of {
         Simul => "be" ++ vg ! a ;
         Anter => "have" ++ "been" ++ vg ! a
         } ;
       VIPresPart => \\a => "being" ++ vg ! a
       } ; 
    s1 = \\b => if_then_Str b [] "not" ;
    } ;



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

  complTransVerb : TransVerb -> NounPhrase -> Complement = \switch,radio ->
    mkComp switch (\\_ => switch.s3 ++ radio.s ! AccP) ;

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

  passVerb : Verb -> Complement = \love ->
    complAdjective (regAdjective (love.s ! PPart)) ;

-- Transitive verbs can also be used reflexively.
-- But to formalize this we must make verb phrases depend on a person parameter.

  reflTransVerb : TransVerb -> Complement = \love -> 
    mkComp love (\\a => love.s1 ++ love.s3 ++ reflPron a) ; ----

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
    DitransVerb -> NounPhrase -> NounPhrase -> Complement = \give,her,beer ->
      mkComp give 
        (\\_ => give.s3 ++ her.s ! AccP ++ give.s4 ++ beer.s ! AccP) ;

  complDitransAdjVerb : 
    TransVerb -> NounPhrase -> AdjPhrase -> Complement = \gor,dig,sur ->
      mkComp
        gor 
        (\\_ => gor.s1 ++ gor.s3 ++ dig.s ! AccP ++ sur.s ! noAPAgr) ;
    ---- should be agr a; make mkComp more general

  complAdjVerb : 
    Verb -> AdjPhrase -> Complement = \seut,sur ->
      mkComp 
        seut 
        (\\n => sur.s ! noAPAgr ++ seut.s1) ;


--2 Adverbs
--
-- Adverbs are not inflected (we ignore comparison, and treat
-- compared adverbials as separate expressions; this could be done another way).
-- We distinguish between different combinatory adverbs in the sybntax itself.

  Adverb : Type = SS ;

-- N.B. this rule generates the cyclic parsing rule $VP#2 ::= VP#2$
-- and cannot thus be parsed.

  adVerbPhrase : VerbGroup -> Adverb -> VerbGroup = \sings, often ->
    {
     s  = \\b,sf,a => sings.s ! b ! sf ! a ++ often.s ; ---- depends on sf and isAux 
     s2 = \\b,sf,a => sings.s2 ! b ! sf ! a ;
     isAux = sings.isAux
    } ;

  advVerbPhrase : VerbPhrase -> Adverb -> VerbPhrase = \sing, well ->
    {
     s  = \\b,a => sing.s ! b ! a ++ well.s ;
     s1 = sing.s1
    } ;

  advAdjPhrase : SS -> AdjPhrase -> AdjPhrase = \very, good ->
    {s = \\a => very.s ++ good.s ! a ;
     p = good.p
    } ;

-- Adverbials are typically generated by prefixing prepositions.
-- The rule for creating locative noun phrases by the preposition "in"
-- is a little shaky, since other prepositions may be preferred ("on", "at").

  prepPhrase : Preposition -> NounPhrase -> Adverb = \on, it ->
    ss (on ++ it.s ! AccP) ;

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

  progressiveClause : NounPhrase -> VerbPhrase -> Clause = \np,vp ->
    predBeGroup np (vp.s ! VIPresPart) ; 

  progressiveVerbPhrase : VerbPhrase -> VerbGroup = \vp ->
    predClauseBeGroup (vp.s ! VIPresPart) ; 

--- negation of prp ignored: "not" only for "be"

--3 Tensed clauses

-- We have direct (declarative) and inverted (interrogative) clauses.

  Clause = {s : Order => Bool => SForm => Str} ;

  param Order = Dir | Inv ;

  oper
  Verbal = VForm => Agr => Str ;

  -- This applies to non-auxiliaries.

  predVerbClause : NounPhrase -> Verb -> Complement -> Clause =  \np,verb,comp -> 
    let nv = predVerbClauseGen np verb comp in
    {s = table {
       Dir => \\b,sf => let nvg = nv ! b ! sf in nvg.p1 ++ nvg.p2 ++ nvg.p3 ;
       Inv => \\b,sf => let nvg = nv ! b ! sf in 
         case sf of {
           VFinite t Simul => case b of {
             True => auxTense b t np.a ++ nvg.p1 ++ (nv ! False ! sf).p3 ;
             _    => nvg.p2            ++ nvg.p1 ++ nvg.p3 
            } ;
           _ => nvg.p2 ++ nvg.p1 ++ nvg.p3
           }
       }
    } ;

-- These three function are just to restore the $VerbGroup$ ($VP$) based structure.

  predVerbGroupClause : NounPhrase -> VerbGroup -> Clause = \np,vp ->
    let
      ag = np.a ;
      it = np.s ! NomP
    in
    {s = table {
       Dir => \\b,sf => it ++ vp.s  ! b ! sf ! ag  ++ vp.s2  ! b ! sf ! ag ;
       Inv => \\b,sf =>  
         let
           does = vp.s  ! b ! sf ! ag ;
           walk = vp.s2 ! False ! sf ! ag
         in
         case sf of {
           VFinite t Simul => case b of {
             True => if_then_Str vp.isAux does (auxTense b t ag)++ it ++ walk ;
             _    => does ++ it ++ walk
            } ;
           _ => does ++ it ++ walk
           }
       }
    } ; 

  predClauseGroup : Verb -> Complement -> VerbGroup =  \verb,comp -> 
    let
      nvg : Agr -> (Bool => SForm => (Str * Str * Str)) = 
        \ag -> predVerbClauseGen {s = \\_ => [] ; a = ag} verb comp 
    in
    {s  = \\b,f,a => (nvg a ! b ! f).p2 ;
     s2 = \\b,f,a => (nvg a ! b ! f).p3 ;
     isAux = False
    } ;

  predClauseBeGroup : Complement -> VerbGroup = \comp ->
    let
      nvg : Agr -> (Bool => SForm => (Str * Str * Str)) = 
        \ag -> predAuxClauseGen {s = \\_ => [] ; a = ag} auxVerbBe comp 
    in
    {s  = \\b,f,a => (nvg a ! b ! f).p2 ;
     s2 = \\b,f,a => (nvg a ! b ! f).p3 ;
     isAux = True
    } ;

-- This is the general predication function for non-auxiliary verbs,
-- i.e. ones with "do" inversion and negation.

  predVerbClauseGen : NounPhrase -> Verb -> Complement -> (Bool =>
    SForm => (Str * Str * Str)) =  \np,verb,comp -> 
    let 
      it  = np.s ! NomP ;
      agr = np.a ; 
      goes : Tense -> Str = \t -> verb.s ! case t of {
         Present => case agr of {
                      ASgP3 _ => Indic Sg ;
                      _ => Indic Pl
                      } ;
         _       => Pastt --- Future doesn't matter
         } ;
      off   = comp ! agr ;
      go    = verb.s ! InfImp ++ off ;
      gone  = verb.s ! PPart ++ off ;
      going = verb.s ! PresPart ++ off ;
      have = "have" ;
      has  : Bool -> Tense -> Str = \b,t -> auxHave b t agr ;
      does : Bool -> Tense -> Str = \b,t -> auxTense b t agr
     in 
     \\b =>
      let neg = if_then_Str b [] "not" in
      table {
      VFinite Present Simul => case b of {
        True  => <it,goes Present,off> ;
                 ---- does b Present ++ it ++ go
        False => <it,does b Present, go>
        } ;
      VFinite Past Simul => case b of {
        True  => <it,goes Past,off> ;
                 ---- does b Present ++ it ++ go
        False => <it,does b Past, go>
        } ;
      VFinite t       Simul => <it,does b t,    go> ;
      VFinite Present Anter => <it,has b Present, gone> ;
      VFinite Past    Anter => <it,has b Past,    gone> ;
      VFinite t Anter       => <it,does b t,    have ++ gone>  ;
      VInfinit  Simul       => <it, neg,           go> ;
      VInfinit  Anter       => <it, neg,           have ++ gone> ;
      VPresPart             => <it, neg,           going>
     } ;

-- This is for auxiliaries.

  predBeGroup : NounPhrase -> Complement -> Clause = \np,comp ->
    let nv = predAuxClauseGen np auxVerbBe comp in
    {s = table {
       Dir => \\b,sf => let nvg = nv ! b ! sf in nvg.p1 ++ nvg.p2 ++ nvg.p3 ;
       Inv => \\b,sf => let nvg = nv ! b ! sf in nvg.p2 ++ nvg.p1 ++ nvg.p3
       }
    } ;

  predAuxClauseGen : NounPhrase -> AuxVerb -> Complement -> 
    (Bool => SForm => (Str * Str * Str)) = \np,verb,comp -> 
    let
      it = np.s ! NomP ;
      ita = np.a ;
      been = verb.s ! APPart ;
      good = comp ! ita ;
      begood : Tense -> Str = \t -> case t of {
        Present => good ;
        Past => good ;
        _ => verb.s ! AInfImp ++ good
        } ;
      beengood : Tense -> Str = \t -> case t of {
        Future      => "have" ++ been ++ good ;
        Conditional => "have" ++ been ++ good ;
        _ => been ++ good
        } ;
      has : Bool -> Tense -> Str = \b,t -> case t of {
        Future      => if_then_Str b "will" "won't" ;
        Conditional => negAux b "would" ;
        _ => auxHave b t ita
        } ;
      is  : Bool -> Tense -> Str = \b,t -> case t of {
        Future      => if_then_Str b "will" "won't" ;
        Conditional => negAux b "would" ;
        _ => auxVerbForm verb b t ita
        }
    in
    \\b => 
      table {
        VFinite t Simul => <it,     is b t, begood t> ;
        VFinite t Anter => <it,     has b t, beengood t> ;
        VInfinit Simul  => <it,     [], begood Future> ;
        VInfinit Anter  => <it,     [], beengood Future> ;
        VPresPart       => <it,     [], "being" ++ good>
      } ;

  auxVerbForm : AuxVerb -> Bool -> Tense -> Agr -> Str = \verb,b,t,a -> 
      case t of {
        Present => case a of {
          ASgP3 _ => verb.s ! AIndic P3 b ;
          ASgP1   => verb.s ! AIndic P1 b ;
          _       => verb.s ! AIndic P2 b
          } ;
        Past      => case a of {
          ASgP3 _ => verb.s ! APastt Sg b ;
          _       => verb.s ! APastt Pl b
          } ;
        _         => verb.s ! AInfImp --- never used
        } ;



--3 Sentence-complement verbs
--
-- Sentence-complement verbs take sentences as complements.

  SentenceVerb : Type = Verb ;

-- To generate "says that John walks" / "doesn't say that John walks":
---- TODO: the alternative without "that"

  complSentVerb : SentenceVerb -> Sentence -> Complement = \say,johnruns ->
    mkComp say (\\_ => "that" ++ johnruns.s) ;

  complQuestVerb : SentenceVerb -> QuestionSent -> Complement = \se,omduler ->
    mkComp se (\\_ => se.s1 ++ omduler.s ! IndirQ) ;

  complDitransSentVerb : TransVerb -> NounPhrase -> Sentence -> Complement = 
    \sa,honom,duler ->
      mkComp sa 
        (\\_ => sa.s1 ++ sa.s3 ++ honom.s ! AccP ++ "that" ++ duler.s) ;

  complDitransQuestVerb : TransVerb -> NounPhrase -> QuestionSent -> Complement = 
    \sa,honom,omduler ->
      mkComp sa 
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

  VerbVerb : Type = AuxVerb ** {isAux : Bool} ;

-- To generate "can walk"/"can't walk"; "tries to walk"/"does not try to walk":
-- The contraction of "not" is not provided, since it would require changing
-- the verb parameter type.

  complVerbVerb : VerbVerb -> VerbPhrase -> Complement = \try,run ->
    let
       taux  = try.isAux ;
       to    = if_then_Str taux [] "to" ;
       torun : Agr => Str = 
         \\a => run.s1 ++ to ++ run.s ! VIInfinit ! a  
    in
----      if_then_else VerbGroup taux 
----        (useVerbAux try torun)
        (mkComp    (aux2verb try) torun) ; ----

---- Problem: "to" in non-present tenses comes to wrong place.
--- The real problem is that these are *not* auxiliaries in all tenses.

  vvCan  : VerbVerb = mkVerbAux ["be able to"] "can" "could" ["been able to"] ** {isAux = True} ;
  vvMust : VerbVerb = mkVerbAux ["have to"] "must" ["had to"] ["had to"] ** {isAux = True} ;

-- Notice agreement to object vs. subject:

  DitransVerbVerb = TransVerb ** {s4 : Str} ;

  complDitransVerbVerb : 
    Bool -> DitransVerbVerb -> NounPhrase -> VerbPhrase -> Complement = 
     \obj,be,dig,simma ->
      mkComp be 
        (\\a => be.s1 ++ be.s3 ++ dig.s ! AccP ++ be.s3 ++ be.s4 ++
                simma.s1 ++ -- negation
              if_then_Str obj 
                 (simma.s ! VIInfinit ! dig.a)
                 (simma.s ! VIInfinit ! a)
        ) ;

  complVerbAdj : Adjective -> VerbPhrase -> AdjPhrase = \grei, simma ->
    {s = \\a => 
              grei.s ! AAdj ++ simma.s1 ++
              "to" ++
              simma.s ! VIInfinit ! a ;
     p = False 
    } ;

  complVerbAdj2 : 
    Bool -> AdjCompl -> NounPhrase -> VerbPhrase -> AdjPhrase = 
      \obj,grei,dig,simma ->
      {s = \\a =>
              grei.s ! AAdj ++ 
              grei.s2 ++ dig.s ! AccP ++
              simma.s1 ++ "to" ++
              if_then_Str obj 
                 (simma.s ! VIInfinit ! dig.a)
                 (simma.s ! VIInfinit ! a) ;
       p = False
      } ;


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
    let youlookat = (predVerbClause you lookat (complVerb lookat)).s in 
    {s = table {
       DirQ   => youlookat ! Inv ;
       IndirQ => youlookat ! Dir
       } ;
     s2 = lookat.s3
    } ;

--- this does not give negative or anterior forms

  slashVerbVerb : NounPhrase -> VerbVerb -> TransVerb -> ClauseSlashNounPhrase = 
    \you,want,lookat ->
    let
      tolook = predVerbI lookat (complVerb lookat) ; 
      youlookat = 
      (predVerbClause you (aux2verb want) 
        (complVerbVerb want 
           {s = tolook.s ! True ! Simul ; s1 = tolook.s1 ! True})).s
    in 
    {s = table {
       DirQ   => youlookat ! Inv ;
       IndirQ => youlookat ! Dir
       } ;
     s2 = lookat.s3
    } ;

  slashAdverb : Clause -> Preposition -> ClauseSlashNounPhrase = 
    \youwalk,by ->
    {s = table {
       DirQ   => youwalk.s ! Inv ;
       IndirQ => youwalk.s ! Dir
       } ;
     s2 = by
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

  RelClause   : Type = {s : (Bool * SForm * Agr) => Str} ;
  RelSentence : Type = {s :                 Agr  => Str} ;

  relVerbPhrase : RelPron -> VerbGroup -> RelClause = \who,walks ->
    {s = \\bsfa => 
      let wa = fromAgr (bsfa.p3) in
      (predVerbGroupClause (relNounPhrase who wa.g wa.n) walks).s ! 
         Dir ! bsfa.p1 ! bsfa.p2
    } ;

  relVerbClause : RelPron -> Verb -> Complement -> RelClause = \who,walk,here ->
    {s = \\bsfa => 
    let 
      wa = fromAgr bsfa.p3 ;
      who : NounPhrase = relNounPhrase who wa.g wa.n ;
      whowalks : Clause = predVerbClause who walk here
    in
    whowalks.s ! Dir ! bsfa.p1 ! bsfa.p2
    } ;

  predBeGroupR : RelPron -> Complement -> RelClause = \who,old ->
    {s = \\bsfa => 
      let 
        wa = fromAgr bsfa.p3 ;
        whoisold = predBeGroup (relNounPhrase who wa.g wa.n) old
      in
      whoisold.s ! Dir ! bsfa.p1 ! bsfa.p2
    } ;

  relSlash : RelPron -> ClauseSlashNounPhrase -> RelClause = \who,yousee ->
    {s = \\bsfa => 
           let
             a = fromAgr bsfa.p3 ;
             whom = who.s ! a.g ! a.n ; 
             youSee = yousee.s ! IndirQ ! bsfa.p1 ! bsfa.p2
           in
           variants {
             whom ! AccP ++ youSee ++ yousee.s2 ;
             yousee.s2 ++ whom ! GenSP ++ youSee
             }
    } ;

-- A 'degenerate' relative clause is the one often used in mathematics, e.g.
-- "number x such that x is even".

  relSuch : Clause -> RelClause = \A ->
    {s = \\bsfa => "such" ++ "that" ++ A.s ! Dir ! bsfa.p1 ! bsfa.p2} ;

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
      AccP  => variants {"whom" ; "who"} ;
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

  questClause : Clause -> Question = \cl -> 
    {s = \\b,c => table {
       DirQ   => cl.s ! Inv ! b ! c ;
       IndirQ => cl.s ! Dir ! b ! c
       }
    } ;
{- --vg
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
                (predVerbGroupClause John walk).s ! Dir ! b ! cl
      }
    } ;
  -- vg -}

--3 Wh-questions
--
-- Wh-questions are of two kinds: ones that are like $NP - VP$ sentences,
-- others that are line $S/NP - NP$ sentences.

  nounPhraseInt : NounPhrase -> IntPron = \who -> 
    {s = who.s} ** fromAgr who.a ;

  intNounPhrase : IntPron -> NounPhrase = \who -> 
    {s = who.s ; a = toAgr who.n P3 who.g} ;

  predBeGroupQ : IntPron -> Complement -> Question = \who,old ->
    let whoisold = predBeGroup (intNounPhrase who) old
    in
    {s = \\b,sf,_ => whoisold.s ! Dir ! b ! sf} ;

  intVerbPhrase : IntPron -> VerbGroup -> Question = \who,walk ->
    let 
      who : NounPhrase =  {s = who.s ; a = toAgr who.n P3 who.g} ;
      whowalks : Clause = predVerbGroupClause who walk
    in
    {s = \\b,sf,_ => whowalks.s ! Dir ! b ! sf} ;

  intVerbClause : IntPron -> Verb -> Complement -> Question = \who,walk,here ->
    let 
      who : NounPhrase =  {s = who.s ; a = toAgr who.n P3 who.g} ;
      whowalks : Clause = predVerbClause who walk here
    in
    {s = \\b,sf,_ => whowalks.s ! Dir ! b ! sf} ;

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

  questAdverbial : IntAdverb -> Clause -> Question = 
    \why, youwalk ->
    {s = \\b,cf,q => 
       why.s ++ (questClause youwalk).s ! b ! cf !  q} ;

--2 Imperatives
--
-- We only consider second-person imperatives. 

  Imperative = SS1 Number ;

  imperVerbPhrase : Bool -> VerbClause -> Imperative = \b,walk -> 
    {s = \\n => 
       let 
         a = toAgr n P2 human ;
         dont = if_then_Str b [] "don't" 
       in
       dont ++ walk.s ! b ! Simul ! VIInfinit ! a
    } ;

  imperUtterance : Number -> Imperative -> Utterance = \n,I ->
    ss (I.s ! n ++ "!") ;

-- --- Here the agreement feature should really be given in context: 
-- "What do you want to do? - Wash myself."

  verbUtterance : VerbPhrase -> Utterance = \vp ->
    ss (vp.s1 ++ vp.s ! VIInfinit ! ASgP1) ; 


--2 Sentence adverbs
--
-- Sentence adverbs is the largest class and open for
-- e.g. prepositional phrases.

  advClause : Clause -> Adverb -> Clause = \yousing,well ->
   {s = \\o,b,c => yousing.s ! o ! b ! c ++ well.s} ;

-- Conjunctive adverbs are such as "otherwise", "therefore", which are prefixed
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

  ListAdjPhrase : Type = {s1,s2 : Agr => Str ; p : Bool} ;

  twoAdjPhrase : (_,_ : AdjPhrase) -> ListAdjPhrase = \x,y ->
    CO.twoTable Agr x y ** {p = andB x.p y.p} ;

  consAdjPhrase : ListAdjPhrase -> AdjPhrase -> ListAdjPhrase =  \xs,x ->
    CO.consTable Agr CO.comma xs x ** {p = andB xs.p x.p} ;

  conjunctAdjPhrase : Conjunction -> ListAdjPhrase -> AdjPhrase = \c,xs ->
    CO.conjunctTable Agr c xs ** {p = xs.p} ;

  conjunctDistrAdjPhrase : ConjunctionDistr -> ListAdjPhrase -> AdjPhrase = 
    \c,xs ->
    CO.conjunctDistrTable Agr c xs ** {p = xs.p} ;


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
    adVerbPhrase V (ss (if.s ++ A.s)) ;

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
