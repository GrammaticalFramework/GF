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
    cnGen cn Hum ;
  cnNoHum : CommonNoun -> CommNoun = \cn ->
    cnGen cn NoHum ;

--2 Noun phrases
--
-- The worst case is pronouns, which have inflection in the possessive forms. 
-- Proper names are a special case.

  NounPhrase : Type = Pronoun ;

  nameNounPhrase : ProperName -> NounPhrase = \john -> 
    {s = \\c => john.s ! toCase c ; n = Sg ; p = P3} ;

  nameNounPhrasePl : ProperName -> NounPhrase = \john -> 
    {s = \\c => john.s ! toCase c ; n = Pl ; p = P3} ;

-- The following construction has to be refined for genitive forms:
-- "we two", "us two" are OK, but "our two" is not.

  Numeral : Type = {s : Case => Str} ;

  pronWithNum : Pronoun -> Numeral -> Pronoun = \we,two ->
    {s = \\c => we.s ! c ++ two.s ! toCase c ; n = we.n ; p = we.p} ;

  noNum : Numeral = {s = \\_ => []} ;

--2 Determiners
--
-- Determiners are inflected according to the nouns they determine.
-- The determiner is not inflected.

  Determiner : Type = {s : Str ; n : Number} ;

  detNounPhrase : Determiner -> CommNounPhrase -> NounPhrase = \every, man -> 
    {s = \\c => every.s ++ man.s ! every.n ! toCase c ; 
     n = every.n ; 
     p = P3
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
     n = n ; p = P3
    } ;

  defNounPhrase : Number -> CommNounPhrase -> NounPhrase = \n ->
    defNounPhraseNum n noNum ;
  defNounPhraseNum : Number -> Numeral -> CommNounPhrase -> NounPhrase = 
    \n,two,car -> 
    {s = \\c => artDef ++ two.s ! Nom ++ car.s ! n ! toCase c ; 
     n = n ; 
     p = P3
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
       n = n ; 
       p = P3
      } ;

-- *Bare plural noun phrases* like "men", "good cars", are built without a 
-- determiner word.

  plurDet : CommNounPhrase -> NounPhrase = \cn -> 
    {s = \\c => cn.s ! plural ! toCase c ; 
     p = P3 ; 
     n = Pl
    } ;

-- Constructions like "the idea that two is even" are formed at the
-- first place as common nouns, so that one can also have "a suggestion that...".

  nounThatSentence : CommNounPhrase -> Sentence -> CommNounPhrase = \idea,x -> 
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
     n = Sg ; 
     p = P3
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
    let {n = john.n ; nf = if_then_else Number coll Sg n} in 
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

  Anteriority = Simul | Anter ;

  Tense = Pres | Pas | Fut ;

  VerbForm = 
     VInd  Tense Anteriority Number Person
   | VCond Anteriority
   | VInf  Anteriority
   | VImp ;

-- This is how the syntactic verb phrase forms are realized as
-- inflectional forms of verbs.

  oper

{-
  VGrp : Type = {s,s2 : Str ; isAux : Bool}

  inflVerb : 
      VerbP3 -> Bool -> VerbForm -> VGrp =
        \verb,b,v -> let
           simple : Bool -> Str -> VGrp = \s -> {s = s ; s2 = [] ; isAux = False} ;
             s = if_then_Str b
              (walk.s ! v ++ walk.s1)
              (contractNot (verbP3Do.s ! v)) ;

s ; s2 = [] ; isAux = False} ;

         in case v of {
           VInd Pres Simul n p => simple b (indicVerb verb p n) ;
           VInd Pas  Simul n p => simple b (verb.s ! Past n) ;
           VInd Fut  Simul n p => compos (will b) infin ;
           VInd t    Anter n p => compos (have b t) pastp ;
           VCond a             => compos (would b)  infin ;



  indicVerb : VerbP3 -> Person -> Number -> Str = \v,p,n -> case n of {
    Sg => v.s ! Indic p ;
    Pl => v.s ! Indic P2
    } ;
     predVerb : Verb -> VerbGroup = \walk ->
      {s = \\b,v => if_then_Str b
              (walk.s ! v ++ walk.s1)
              (contractNot (verbP3Do.s ! v)) ;
       s2 = \\b,_ => if_then_Str b
              []
              (walk.s ! InfImp ++ walk.s1) ;
       isAuxT = False ;
       isAuxF = True
      } ;
  VerbGrp = {
    s  : Bool => VerbForm => Str ;
    s2 : Bool => Number => Str ; 
    isAuxT : Bool ;
    isAuxF : Bool
    } ;
-}

-- Verb phrases are discontinuous: the two parts of a verb phrase are
-- (s) an inflected verb, (s2) infinitive and complement.
-- For instance: "doesn't" - "walk" ; "isn't" - "old" ; "is" - "a man"
-- There's also a parameter telling if the verb is an auxiliary:
-- this is needed in question.

  VerbGroup = {
    s  : Bool => VForm => Str ;
    s2 : Bool => Number => Str ; 
    isAuxT : Bool ;
    isAuxF : Bool
    } ;

  VerbPhrase = VerbP3 ** {s2 : Number => Str ; isAux : Bool} ;

  predVerbGroup : Bool -> VerbGroup -> VerbPhrase = \b,vg -> {
    s  = vg.s ! b ;
    s2 = vg.s2 ! b ;
    isAux = if_then_else Bool b vg.isAuxT vg.isAuxF
    } ;

-- From the inflection table, we selecting the finite form as function 
-- of person and number:

  indicVerb : VerbP3 -> Person -> Number -> Str = \v,p,n -> case n of {
    Sg => v.s ! Indic p ;
    Pl => v.s ! Indic P2
    } ;

-- A simple verb can be made into a verb phrase with an empty complement.
-- There are two versions, depending on if we want to negate the verb.
-- N.B. negation is *not* a function applicable to a verb phrase, since
-- double negations with "don't" are not grammatical.

  predVerb : Verb -> VerbGroup = \walk ->
      {s = \\b,v => if_then_Str b
              (walk.s ! v ++ walk.s1)
              (contractNot (verbP3Do.s ! v)) ;
       s2 = \\b,_ => if_then_Str b
              []
              (walk.s ! InfImp ++ walk.s1) ;
       isAuxT = False ;
       isAuxF = True
      } ;

-- Sometimes we want to extract the verb part of a verb phrase.

  verbOfPhrase : VerbPhrase -> VerbP3 = \v -> {s = v.s} ;

-- Verb phrases can also be formed from adjectives ("is old"),
-- common nouns ("is a man"), and noun phrases ("ist John").
-- The third rule is overgenerating: "is every man" has to be ruled out
-- on semantic grounds.

  predAdjective : Adjective -> VerbGroup = \old ->
    {s = beOrNotBe ;
     s2 = \\_,_ => old.s ! AAdj ;
     isAuxT, isAuxF = True
    } ;

  predCommNoun : CommNoun -> VerbGroup = \man ->
    {s = beOrNotBe ;
     s2 = \\_,n => indefNoun n man ;
     isAuxT, isAuxF = True
    } ;

  predNounPhrase : NounPhrase -> VerbGroup = \john ->
    {s = beOrNotBe ;
     s2 = \\_,_ => john.s ! NomP ;
     isAuxT, isAuxF = True
    } ;

  predAdverb : Adverb -> VerbGroup = \elsewhere ->
    {s = beOrNotBe ;
     s2 = \\_,_ => elsewhere.s ;
     isAuxT, isAuxF = True
    } ;

-- We use an auxiliary giving all forms of "be".

  beOrNotBe : Bool => VForm => Str = \\b => 
    if_then_else (VForm => Str) b 
      verbBe.s
      (table {
        InfImp   => contractNot "do" ++ "be" ;
        Indic P1 => "am" ++ "not" ;
        v        => contractNot (verbBe.s ! v)
        }) ;

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
-- ("I switch on the TV" / "I switch the TV on").

  complTransVerb : TransVerb -> NounPhrase -> VerbGroup = \lookat,john ->
    let lookatjohn = bothWays lookat.s1 (lookat.s3 ++ john.s ! AccP)
    in {s  = \\b,v => if_then_Str b (lookat.s ! v) (contractNot (verbP3Do.s ! v)) ; 
        s2 = \\b,_ => if_then_Str b lookatjohn (lookat.s ! InfImp ++ lookatjohn) ; 
        isAuxT = False ;
        isAuxF = True
       } ;


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

--- reflTransVerb : TransVerb -> VerbGroup = \love -> 


-- Transitive verbs can be used elliptically as verbs. The semantics
-- is left to applications. The definition is trivial, due to record
-- subtyping.

  transAsVerb : TransVerb -> Verb = \love -> 
    love ;

-- *Ditransitive verbs* are verbs with three argument places.
-- We treat so far only the rule in which the ditransitive
-- verb takes both complements to form a verb phrase.

  DitransVerb = TransVerb ** {s4 : Preposition} ; 

  mkDitransVerb : Verb -> Preposition -> Preposition -> DitransVerb = \v,p1,p2 -> 
    v ** {s3 = p1 ; s4 = p2} ;

  complDitransVerb : DitransVerb -> NounPhrase -> NounPhrase -> VerbGroup = 
    \give,you,beer ->
      let
        youbeer = give.s1 ++ give.s3 ++ you.s ! AccP ++ give.s4 ++ beer.s ! AccP
      in
      {s  = \\b,v => if_then_Str b (give.s ! v) (contractNot (verbP3Do.s ! v)) ; 
       s2 = \\b,_ => if_then_Str b  youbeer     (give.s ! InfImp ++ youbeer) ;
       isAuxT = False ;
       isAuxF = True
      } ;


--2 Adverbials
--
-- Adverbials are not inflected (we ignore comparison, and treat
-- compared adverbials as separate expressions; this could be done another way).
-- We distinguish between post- and pre-verbal adverbs.

  Adverb : Type = SS ** {p : Bool} ;

  advPre  : Str -> Adverb = \seldom -> ss seldom ** {p = False} ;
  advPost : Str -> Adverb = \well   -> ss well   ** {p = True} ;

-- N.B. this rule generates the cyclic parsing rule $VP#2 ::= VP#2$
-- and cannot thus be parsed.

  adVerbPhrase : VerbPhrase -> Adverb -> VerbPhrase = \sings, well ->
    let {postp = orB well.p sings.isAux} in
    {
     s = \\v => (if_then_else Str postp [] well.s) ++ sings.s ! v ;
     s2 = \\n => sings.s2 ! n ++ (if_then_else Str postp well.s []) ;
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

-- This is a source of the "mann with a telescope" ambiguity, and may produce
-- strange things, like "cars always" (while "cars today" is OK).
-- Semantics will have to make finer distinctions among adverbials.
--
-- N.B. the genitive case created in this way would not make sense.

  advCommNounPhrase : CommNounPhrase -> Adverb -> CommNounPhrase = \car,today ->
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

-- This is the traditional $S -> NP VP$ rule. It takes care of
-- agreement between subject and verb. Recall that the VP may already
-- contain negation. 

  predVerbPhrase : NounPhrase -> VerbPhrase -> Sentence = \john,walks ->
    ss (john.s ! NomP ++ indicVerb (verbOfPhrase walks) john.p john.n ++ 
        walks.s2 ! john.n) ;



--3 Sentence-complement verbs
--
-- Sentence-complement verbs take sentences as complements.

  SentenceVerb : Type = Verb ;

-- To generate "says that John walks" / "doesn't say that John walks":

  complSentVerb : SentenceVerb -> Sentence -> VerbGroup = \say,johnruns ->
    let {thatjohnruns = optStr "that" ++ johnruns.s} in 
      {s  = \\b,v => if_then_Str b (say.s ! v)  (contractNot (verbP3Do.s ! v)) ;  
       s2 = \\b,_ => if_then_Str b thatjohnruns (say.s ! InfImp ++ thatjohnruns) ; 
       isAuxT = False ;
       isAuxF = True
      } ;

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

  complVerbVerb : VerbVerb -> VerbGroup -> VerbGroup = \try,run ->
    let
       taux  = try.isAux ;
       to    = if_then_Str taux [] "to" ;
       dont  = table VForm {v => if_then_Str taux 
                 (try.s ! v ++ "not")                -- can not
                 (contractNot (verbP3Do.s ! v))      -- doesn't ...
                 } ;
       trnot = if_then_Str taux 
                  []                                  --
                  (try.s ! InfImp ++ try.s1) ;        -- ... try
    in
      {s =  \\b,v => if_then_Str b 
                        (try.s ! v ++ try.s1 ++ to ++ run.s ! True ! InfImp)
                        (dont ! v) ;
       s2 = \\b,v => if_then_Str b
                        (run.s2 ! True ! v) 
                        (trnot ++ run.s ! True ! InfImp ++ run.s2 ! True ! v) ; 
       isAuxT = taux ;
       isAuxF = True
      } ;

-- The three most important example auxiliaries.

  mkVerbAux : (_,_,_,_: Str) -> VerbVerb = \beable, can, could, beenable -> 
    {s = table {
       InfImp => beable ; 
       Indic _ => can ; 
       Past _ => could ;
       PPart => beenable
       } ;
     s1 = [] ;
     isAux = True
    } ;

  vvCan  : VerbVerb = mkVerbAux ["be able to"] "can" "could" ["been able to"] ;
  vvMust : VerbVerb = mkVerbAux ["have to"] "must" ["had to"] ["had to"] ;

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

  SentenceSlashNounPhrase = {s : Bool => Str ; s2 : Preposition} ;

  slashTransVerb : Bool -> NounPhrase -> TransVerb -> SentenceSlashNounPhrase = 
    \b,You,lookat ->
    let {you   = You.s ! NomP ;
         looks = indicVerb {s = lookat.s} You.p You.n ;
         look  = lookat.s ! InfImp ;
         do    = indicVerb verbP3Do You.p You.n ;
         dont  = contractNot do ;
         up    = lookat.s1
        } in
    {s  = table {
            True  => if_then_else Str b do dont ++ you ++ look ++ up ; 
            False => you ++ if_then_else Str b looks (dont ++ look) ++ up
            } ;
     s2 = lookat.s3   
    } ;


  thereIs : NounPhrase -> Sentence = \abar ->
    predVerbPhrase 
      (case abar.n of {
         Sg => nameNounPhrase (nameReg "there") ;
         Pl => {s = \\_ => "there" ; n = Pl ; p = P3}
         })
      (predVerbGroup True (predNounPhrase abar)) ;


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

-- Relative clauses can be formed from both verb phrases ("who walks") and
-- slash expressions ("whom you see", "on which you sit" / "that you sit on"). 

  RelClause : Type = {s : Gender => Number => Str} ;

  relVerbPhrase : RelPron -> VerbPhrase -> RelClause = \who,walks ->
    {s = \\g, n => who.s ! g ! n ! NomP ++ 
                   indicVerb (verbOfPhrase walks) P3 n ++ walks.s2 ! n
    } ;

  relSlash : RelPron -> SentenceSlashNounPhrase -> RelClause = \who,yousee ->
    {s = \\g,n => 
           let {youSee = yousee.s ! False} in
           variants {
             who.s ! g ! n ! AccP ++ youSee ++ yousee.s2 ;
             yousee.s2 ++ who.s ! g ! n ! GenSP ++ youSee
             }
    } ;

-- A 'degenerate' relative clause is the one often used in mathematics, e.g.
-- "number x such that x is even".

  relSuch : Sentence -> RelClause = \A ->
    {s = \\_,_ => "such" ++ "that" ++ A.s} ;

-- The main use of relative clauses is to modify common nouns.
-- The result is a common noun, out of which noun phrases can be formed
-- by determiners. No comma is used before these relative clause.

  modRelClause : CommNounPhrase -> RelClause -> CommNounPhrase = \man,whoruns ->
    {s = \\n,c => man.s ! n ! c ++ whoruns.s ! man.g ! n ;
     g = man.g
    } ;


--2 Interrogative pronouns
--
-- If relative pronouns are adjective-like, interrogative pronouns are
-- noun-phrase-like. 

  IntPron : Type = {s : NPForm => Str ; n : Number} ; 

-- In analogy with relative pronouns, we have a rule for applying a function
-- to a relative pronoun to create a new one. 

  funIntPron : Function -> IntPron -> IntPron = \mother,which -> 
    {s = \\c => "the" ++ mother.s ! which.n ! Nom ++ mother.s2 ++ which.s ! GenSP ;
     n = which.n
    } ;

-- There is a variety of simple interrogative pronouns:
-- "which house", "who", "what".

  nounIntPron : Number -> CommNounPhrase -> IntPron = \n, car ->
    {s = \\c => "which" ++ car.s ! n ! toCase c ; 
     n = n
    } ; 

  intPronWho : Number -> IntPron = \num -> {
    s = table {
      NomP  => "who" ;
      AccP  => variants {"who" ; "whom"} ;
      GenP  => "whose" ;
      GenSP => "whom"
      } ;
    n = num
  } ;

  intPronWhat : Number -> IntPron = \num -> {
    s = table {
      GenP  => "what's" ;
      _ => "what"
      } ;
    n = num
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
  interrogUtt : Question -> Utterance = \x -> ss (x.s ! DirQ ++ "?") ;


--2 Questions
--
-- Questions are either direct ("are you happy") or indirect 
-- ("if/whether you are happy").

param 
  QuestForm = DirQ | IndirQ ;

oper
  Question = SS1 QuestForm ;

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

  questVerbPhrase : NounPhrase -> VerbPhrase -> Question = 
    questVerbPhrase' False ;

  questVerbPhrase' : Bool -> NounPhrase -> VerbPhrase -> Question = 
    \adv,john,walk ->
    {s = table {
      DirQ   => if_then_else Str walk.isAux 
                  (indicVerb (verbOfPhrase walk) john.p john.n ++
                   john.s ! NomP ++ walk.s2 ! john.n) 
                  (indicVerb verbP3Do john.p john.n ++ 
                   john.s ! NomP ++ walk.s ! InfImp ++ walk.s2 ! john.n) ;
      IndirQ => if_then_else Str adv [] (variants {"if" ; "whether"}) ++ 
                (predVerbPhrase john walk).s
      }
    } ;

  isThere : NounPhrase -> Question = \abar ->
    questVerbPhrase 
      (case abar.n of {
         Sg => nameNounPhrase (nameReg "there") ;
         Pl => {s = \\_ => "there" ; n = Pl ; p = P3}
         })
      (predVerbGroup True (predNounPhrase abar)) ;


--3 Wh-questions
--
-- Wh-questions are of two kinds: ones that are like $NP - VP$ sentences,
-- others that are line $S/NP - NP$ sentences.

  intVerbPhrase : IntPron -> VerbPhrase -> Question = \who,walk ->
    {s = \\_ => who.s ! NomP ++ indicVerb (verbOfPhrase walk) P3 who.n ++ 
                walk.s2 ! who.n 
    } ;

  intSlash : IntPron -> SentenceSlashNounPhrase -> Question = \who,yousee ->
    {s = \\q =>
           let {youSee = case q of {
                  DirQ   => yousee.s ! True ; 
                  IndirQ => yousee.s ! False
                  }
           } in
           variants {
             who.s ! AccP ++ youSee ++ yousee.s2 ;
             yousee.s2 ++ who.s ! GenSP ++ youSee
             } 
    } ;

--3 Interrogative adverbials
--
-- These adverbials will be defined in the lexicon: they include
-- "when", "where", "how", "why", etc, which are all invariant one-word
-- expressions. In addition, they can be formed by adding prepositions
-- to interrogative pronouns, in the same way as adverbials are formed
-- from noun phrases. 

  IntAdverb = SS ;

  prepIntAdverb : Preposition -> IntPron -> IntAdverb = \at, whom ->
    ss (at ++ whom.s ! AccP) ;

-- A question adverbial can be applied to anything, and whether this makes
-- sense is a semantic question.

  questAdverbial : IntAdverb -> NounPhrase -> VerbPhrase -> Question = 
    \why, you, walk ->
    {s = \\q => why.s ++ (questVerbPhrase' True you walk).s ! q} ;


--2 Imperatives
--
-- We only consider second-person imperatives. 

  Imperative = SS1 Number ;

  imperVerbPhrase : VerbPhrase -> Imperative = \walk -> 
    {s = \\n => walk.s ! InfImp ++ walk.s2 ! n} ;

  imperUtterance : Number -> Imperative -> Utterance = \n,I ->
    ss (I.s ! n ++ "!") ;

--2 Sentence adverbials
--
-- This class covers adverbials such as "otherwise", "therefore", which are prefixed
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

  ListNounPhrase : Type = {s1,s2 : NPForm => Str ; n : Number ; p : Person} ;

  twoNounPhrase : (_,_ : NounPhrase) -> ListNounPhrase = \x,y ->
    CO.twoTable NPForm x y ** {n = conjNumber x.n y.n ; p = conjPerson x.p y.p} ;

  consNounPhrase : ListNounPhrase -> NounPhrase -> ListNounPhrase =  \xs,x ->
    CO.consTable NPForm CO.comma xs x ** 
       {n = conjNumber xs.n x.n ; p = conjPerson xs.p x.p} ;

  conjunctNounPhrase : Conjunction -> ListNounPhrase -> NounPhrase = \c,xs ->
    CO.conjunctTable NPForm c xs ** {n = conjNumber c.n xs.n ; p = xs.p} ;

  conjunctDistrNounPhrase : ConjunctionDistr -> ListNounPhrase -> NounPhrase = 
    \c,xs ->
    CO.conjunctDistrTable NPForm c xs ** {n = conjNumber c.n xs.n ; p = xs.p} ;

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

  subjunctQuestion : Subjunction -> Sentence -> Question -> Question = 
    \if, A, B ->
    {s = \\q => subjunctVariants if A.s (B.s ! q)} ;

  subjunctVariants : Subjunction -> Str -> Str -> Str = \if,A,B ->
    variants {if.s ++ A ++ "," ++ B ; B ++ "," ++ if.s ++ A} ;

  subjunctVerbPhrase : VerbPhrase -> Subjunction -> Sentence -> VerbPhrase =
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

  useRegularName : SS -> NounPhrase = \john -> 
    nameNounPhrase (nameReg john.s) ;

-- Here are some default forms.

  defaultNounPhrase : NounPhrase -> SS = \john -> 
    ss (john.s ! NomP) ;

  defaultQuestion : Question -> SS = \whoareyou ->
    ss (whoareyou.s ! DirQ) ;

  defaultSentence : Sentence -> Utterance = \x -> 
    x ;

} ;
