--1 Russian Word Classes and Morphological Parameters
--
--  Aarne Ranta, Janna Khegai 2003
--
-- This is a resource module for Russian morphology, defining the
-- morphological parameters and word classes of Russian. It is aimed
-- to be complete w.r.t. the description of word forms.
-- However, it does not include those parameters that are not needed for
-- analysing individual words: such parameters are defined in syntax modules.
--

resource TypesRus = open Prelude in {

flags  coding=utf8 ;

--2 Enumerated parameter types 
--
-- These types are the ones found in school grammars.
-- Their parameter values are atomic.

param
  Gender     = Masc | Fem | Neut ;
  Number     = Sg | Pl ;
  Case       = Nom | Gen | Dat | Acc | Inst | Prepos ;
  Voice        = Act | Pass ;
  Aspect     = Imperfective | Perfective ;
  Tense      = Present | Past | Future ;
  Degree     = Pos | Comp | Super ;
  Person     = P1 | P2 | P3 ;
  AfterPrep  = Yes | No ; 
  Possessive = NonPoss | Poss GenNum ;
  Animacy    = Animate | Inanimate ;

-- A number of Russian nouns have common gender. They can
-- denote both males and females: "умница" (a clever person), "инженер" (an engineer).
-- We overlook this phenomenon for now.

-- The AfterPrep parameter is introduced in order to describe
-- the variations of the third person personal pronoun forms
-- depending on whether they come after a preposition or not. 

-- The Possessive parameter is introduced in order to describe
-- the possessives of personal pronouns, which are used in the 
-- Genetive constructions like "мама моя" (my mother) instead of 
-- "мама меня" (the mother of mine). 

--2 Word classes and hierarchical parameter types
--
-- Real parameter types (i.e. ones on which words and phrases depend) 
-- are mostly hierarchical. The alternative would be cross-products of
-- simple parameters, but this would usually overgenerate.

-- However, we use the cross-products in complex cases 
-- (for example, aspect and tense parameter in the verb description)
-- where the relationship between the parameters are non-trivial
-- even though we aware that some combinations do not exist
-- (for example, present perfective does not exist, but removing 
-- this combination would lead to having different descriptions 
-- for perfective and imperfective verbs, which we do not want for the 
-- sake of uniformity).

--3 Nouns
--
-- Common nouns decline according to number and case.
-- For the sake of shorter description these parameters are 
-- combined in the type SubstForm.


param SubstForm = SF Number Case ;

-- Substantives moreover have an inherent gender. 

oper 
   CommNoun : Type = {s : SubstForm => Str ; g : Gender ; anim : Animacy } ;
   numSF: SubstForm -> Number = \sf -> case sf of 
    {
      SF Sg _ => Sg ;
      _       => Pl
    } ;
   
   caseSF: SubstForm -> Case = \sf -> case sf of 
    {
      SF _ Nom => Nom ;
      SF _ Gen => Gen ;
      SF _ Dat => Dat ;
      SF _ Inst => Inst ;
      SF _ Acc => Acc ;
      SF _ Prepos => Prepos 
    } ;

--
--3 Pronouns
--

oper
  Pronoun  : Type = { s : PronForm => Str ; n : Number ; 
   p : Person ; g: PronGen ; pron: Bool} ;

param  PronForm = PF Case AfterPrep Possessive;

-- Gender is not morphologically determined for first
--  and second person pronouns.

  PronGen = PGen Gender | PNoGen ;

-- The following coercion is useful:

oper
  pgen2gen : PronGen -> Gender = \p -> case p of {
    PGen g => g ;
    PNoGen => variants {Masc ; Fem} --- the best we can do for ya, tu
    } ;

oper
  extCase: PronForm -> Case = \pf -> case pf of 
   { PF Nom _ _ => Nom ;
     PF Gen _ _ => Gen ;
     PF Dat _ _ => Dat ;
     PF Inst _ _ => Inst ;
     PF Acc _ _ => Acc ;
     PF Prepos _ _ => Prepos 
    } ;

  mkPronForm: Case -> AfterPrep -> Possessive -> PronForm = 
    \c,n,p -> PF c n p ;

--3 Adjectives
--
-- Adjectives is a very complex class. 
-- The major division is between the comparison degrees.

param
  AdjForm = AF Case Animacy GenNum | AdvF;

-- Declination forms depend on Case, Animacy , Gender: 
-- "большие дома" - "больших домов" (big houses - big houses'), 
-- Animacy plays role only in the Accusative case (Masc Sg and Plural forms):
-- Accusative Animate = Genetive, Accusaive Inanimate = Nominative
-- "я люблю большие дома"-"я люблю больших мужчин"
-- (I love big houses - I love big men);
-- and on Number: "большой дом" - "большие дома"
-- (a big house - big houses).
-- The plural never makes a gender distinction.

  GenNum = ASg Gender | APl ;

oper numGNum : GenNum -> Number = \gn ->
   case gn of { APl => Pl ; _ => Sg } ;

oper genGNum : GenNum -> Gender = \gn ->
   case gn of { ASg Fem => Fem; _ => Masc } ;

oper numAF: AdjForm -> Number = \af ->
   case af of { AdvF => Sg; AF _ _  gn => (numGNum gn) } ;

oper genAF: AdjForm -> Gender = \af ->
   case af of { AdvF => Neut; AF _ _  gn => (genGNum gn) } ;

oper caseAF: AdjForm -> Case = \af ->
   case af of { AdvF => Nom; AF c _ _ => c } ;

-- The Degree parameter should also be more complex, since most Russian
-- adjectives have two comparative forms: 
-- attributive (syntactic (compound), declinable) - 
-- "более высокий" (corresponds to "more high")
-- and predicative (indeclinable)- "выше" (higher) and more than one 
-- superlative forms: "самый высокий" (corresponds to "the most high") - 
-- "наивысший" (the highest). 

-- Even one more parameter independent of the degree can be added,
-- since Russian adjectives in the positive degree also have two forms: 
-- long  (attributive and predicative) - "высокий" (high) and short (predicative) - "высок" 
-- although this parameter will not be exactly orthogonal to the 
-- degree parameter. 
-- Short form has no case declension, so in principle
-- it can be considered as an additional case.

-- Note: although the predicative usage of the long 
-- form is perfectly grammatical, it can have a slightly different meaning
-- compared to the short form. 
-- For example: "он - больной"  (long, predicative) vs. 
-- "он - болен" (short, predicative). 

oper 
  AdjDegr : Type = {s : Degree => AdjForm => Str} ;

-- Adjective type includes both non-degree adjective classes:
-- possesive ("мамин"[mother's], "лисий" [fox'es]) 
-- and relative ("русский" [Russian]) adjectives.

  Adjective : Type = {s : AdjForm => Str} ;


--3 Verbs

-- Mood is the main verb classification parameter.
-- The verb mood can be infinitive, subjunctive, imperative, and indicative.

-- Note: subjunctive mood is analytical, i.e. formed from the past form of the
-- indicative mood plus the particle "бы". That is why they have the same GenNum 
-- parameter. We choose to keep the "redundant" form in order to indicate 
-- the presence of the subjunctive mood in Russian verbs. 

-- Aspect and Voice parameters are present in every mood, so Voice is put
-- before the mood parameter in verb form description the hierachy.
-- Moreover Aspect is regarded as an inherent parameter of a verb entry.
-- The primary reason for that is that one imperfective form can have several
-- perfective forms: "ломать" - "с-ломать" - "по-ломать" (to break).
-- Besides, the perfective form could be formed from imperfective 
-- by prefixation, but also by taking a completely different stem:
-- "говорить"-"сказать" (to say). In the later case it is even natural to 
-- regard them as different verb entries.
-- Another reason is that looking at the Aspect as an inherent verb parameter
-- seem to be customary in other similar projects:
-- http://starling.rinet.ru/morph.htm

-- Note: Of course, the whole inflection table has many redundancies
-- in a sense that many verbs do not have all grammatically possible
-- forms. For example, passive does not exist for the verb 
-- "любить" (to love), but exists for the verb "ломать" (to break).
-- In present tense verbs do not conjugate according to Genus,
-- so parameter GenNum instead Number is used for the sake of 
-- using for example as adjective in predication.

-- Depending on the tense verbs conjugate according to combinations
-- of gender, person and number of the verb objects. 
-- Participles (Present and Past) and Gerund forms are not included in the
-- current description. This is the verb type used in the lexicon:

oper Verbum : Type = { s: VerbForm => Str ; asp : Aspect };

param

  VerbForm = VFORM Voice VerbConj ;
  VerbConj =  VIND GenNum VTense | VIMP Number Person | VINF | VSUB GenNum ;
  VTense   = VPresent Person | VPast | VFuture Person ;

oper 
   getVTense : Tense -> Person -> VTense= \t,p ->
   case t of { Present => VPresent p ; Past => VPast; Future => VFuture p } ;
  
   getVoice: VerbForm -> Voice = \vf ->
   case vf of {
    VFORM Act _ => Act;
    VFORM Pass _ => Pass
  };

-- For writing an application grammar one usually doesn't need
-- the whole inflection table, since each verb is used in 
-- a particular context that determines some of the parameters
-- (Tense and Voice while Aspect is fixed from the beginning) for certain usage. 
-- So we define the "Verb" type, that have these parameters fixed. 
-- The conjugation parameters left (Gender, Number, Person)
-- are combined in the "VF" type:


param VF =
   VFin  GenNum Person | VImper Number Person | VInf | VSubj GenNum;

oper 
  Verb : Type = {s : VF => Str ; t: Tense ; a : Aspect ; w: Voice} ;

  extVerb : Verbum -> Voice -> Tense -> Verb = \aller, vox, t -> 
    { s = table { 
       VFin gn p => case t of { 
           Present => aller.s ! VFORM vox (VIND gn (VPresent p)) ;
           Past =>   aller.s ! VFORM vox (VIND gn VPast ) ;
           Future =>   aller.s ! VFORM vox (VIND gn (VFuture p)) 
           } ; 
       VImper n p => aller.s ! VFORM vox (VIMP n p) ;
       VInf => aller.s ! VFORM vox VINF ;
       VSubj gn => aller.s ! VFORM vox (VSUB gn)
       }; t = t ; a = aller.asp ; w = vox } ;


--3 Other open classes
--
-- Proper names and adverbs are the remaining open classes.

oper 
  PNm    : Type = {s : Case => Str ; g : Gender} ;

-- Adverbials are not inflected (we ignore comparison, and treat
-- compared adverbials as separate expressions; this could be done another way).

  Adverb : Type = SS ;


--3 Closed classes
--
-- The rest of the Russian word classes are closed, i.e. not extensible by new
-- lexical entries. Thus we don't have to know how to build them, but only
-- how to use them, i.e. which parameters they have.
--

--3 Relative pronouns
--
-- Relative pronouns are inflected in
-- gender, number, and case just like adjectives.

  RelPron : Type = {s : GenNum => Case => Animacy => Str} ;

 
--3 Prepositions
-- the same as "Complement" category. Renaming the field "s2" into "s" has lead to 
-- the internal Haskell error during grammar compilation (heap size exausted)!  
  Preposition = { s2: Str; c: Case };
};
