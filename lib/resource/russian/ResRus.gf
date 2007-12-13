--# -path=.:../abstract:../common:../../prelude

--1 Russian auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.

resource ResRus = ParamX ** open Prelude in {

flags  coding=utf8 ; optimize=all ;

--2 Enumerated parameter types 
--
-- These types are the ones found in school grammars.
-- Their parameter values are atomic.

-- Some parameters, such as $Number$, are inherited from $ParamX$.
param
  Gender     = Masc | Fem | Neut ;
  Case       = Nom | Gen | Dat | Acc | Inst | Prepos | Prepos2 ; -- +++ MG_UR: new case Prepos2 introduced! +++
  Animacy    = Animate | Inanimate ;
  Voice        = Act | Pass ;
  Aspect     = Imperfective | Perfective ;
  RusTense      = Present | PastRus | Future ;
--  Degree     = Pos | Comp | Super ;
  AfterPrep  = Yes | No ; 
  Possessive = NonPoss | Poss GenNum ;
--  Anteriority = Simul | Anter ; 
  ClForm =  ClIndic RusTense Anteriority | ClCondit  | ClInfinit | ClImper;      
  -- "naked infinitive" clauses

-- A number of Russian nouns have common gender. They can
-- denote both males and females: "умница" (a clever person), "инженер" (an engineer).
-- We overlook this phenomenon for now.

-- The AfterPrep parameter is introduced in order to describe
-- the variations of the third person personal pronoun forms
-- depending on whether they come after a preposition or not. 

-- Declination forms depend on Case, Animacy , Gender: 
-- "большие дома" - "больших домов" (big houses - big houses'), 
-- Animacy plays role only in the Accusative case (Masc Sg and Plural forms):
-- Accusative Animate = Genetive, Accusaive Inanimate = Nominative
-- "я люблю большие дома-"я люблю больших мужчин"
-- (I love big houses - I love big men);
-- and on Number: "большой дом - "большие дома"
-- (a big house - big houses).
-- The plural never makes a gender distinction.

  GenNum = ASg Gender | APl ;

  -- Coercions between the compound gen-num type and gender and number:
oper
  gNum : Gender -> Number -> GenNum = \g,n -> 
    case n of 
   {   Sg => case g of 
                 { Fem => ASg Fem ;
                   Masc => ASg Masc ;
                   Neut => ASg Neut  } ;
       Pl => APl
   } ;


-- The Possessive parameter is introduced in order to describe
-- the possessives of personal pronouns, which are used in the 
-- Genetive constructions like "моя мама" (my mother) instead of 
-- "мама моя" (the mother of mine). 

--2 For $Noun$
-- Nouns decline according to number and case.
-- For the sake of shorter description these parameters are 
-- combined in the type SubstForm.
param
  SubstForm = SF Number Case ;


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

param  PronForm = PF Case AfterPrep Possessive;

oper Pronoun = { s : PronForm => Str ; n : Number ; p : Person ;
           g: PronGen ;  pron: Bool} ;     

-- Gender is not morphologically determined for first
--  and second person pronouns.

param  PronGen = PGen Gender | PNoGen ;

-- The following coercion is useful:

oper
  pgen2gen : PronGen -> Gender = \p -> case p of {
    PGen g => g ;
    PNoGen => Masc ---- variants {Masc ; Fem} --- the best we can do for ya, tu
    } ;


oper
  extCase: PronForm -> Case = \pf -> case pf of 
   { PF Nom _ _ => Nom ;
     PF Gen _ _ => Gen ;
     PF Dat _ _ => Dat ;
     PF Inst _ _ => Inst ;
     PF Acc _ _ => Acc ;
     PF Prepos _ _ => Prepos ; 
     PF Prepos2 _ _ => Prepos2 -- +++ MG_UR: added +++
    } ;

  mkPronForm: Case -> AfterPrep -> Possessive -> PronForm = 
    \c,n,p -> PF c n p ;

  CommNounPhrase: Type = {s : Number => Case => Str; g : Gender; anim : Animacy} ;  
  
  NounPhrase : Type = { s : PronForm => Str ; n : Number ; 
   p : Person ; g: PronGen ; anim : Animacy ;  pron: Bool} ;

  mkNP : Number -> CommNounPhrase -> NounPhrase = \n,chelovek -> 
    {s = \\cas => chelovek.s ! n ! (extCase cas) ;
     n = n ; g = PGen chelovek.g ; p = P3 ; pron =False ;
     anim = chelovek.anim 
    } ;

  det2NounPhrase : Adjective -> NounPhrase = \eto -> 
    {s = \\pf => eto.s ! (AF (extCase pf) Inanimate (ASg Neut)); n = Sg ; g = PGen Neut ; pron = False ; p = P3 ; anim = Inanimate } ;


 
 pron2NounPhraseNum : Pronoun -> Animacy -> Number -> NounPhrase = \ona, anim, num -> 
    {s = ona.s ; n = num ; g =  ona.g ; 
     pron = ona.pron; p = ona.p ; anim = anim } ;


-- Agreement of $NP$ is a record. We'll add $Gender$ later.
--  oper  Agr = {n : Number ; p : Person} ;


----2 For $Verb$

-- Mood is the main verb classification parameter.
-- The verb mood can be infinitive, subjunctive, imperative, and indicative.

-- Note: subjunctive mood is analytical, i.e. formed from the past form of the
-- indicative mood plus the particle "ли". That is why they have the same GenNum 
-- parameter. We choose to keep the "redundant" form in order to indicate 
-- the presence of the subjunctive mood in Russian verbs. 

-- Aspect and Voice parameters are present in every mood, so Voice is put
-- before the mood parameter in verb form description the hierachy.
-- Moreover Aspect is regarded as an inherent parameter of a verb entry.
-- The primary reason for that is that one imperfective form can have several
-- perfective forms: "ломать" - "сломать" - "поломать" (to break).
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
-- "любить" (to love), but exists for the verb "ломаться" (to break).
-- In present tense verbs do not conjugate according to Genus,
-- so parameter GenNum instead Number is used for the sake of 
-- using for example as adjective in predication.

-- Depending on the tense verbs conjugate according to combinations
-- of gender, person and number of the verb objects. 
-- Participles (Present and PastRus) and Gerund forms are not included in the
-- current description. This is the verb type used in the lexicon:

oper Verbum : Type = { s: VerbForm => Str ; asp : Aspect };

param

  VerbForm = VFORM Voice VerbConj ;
  VerbConj =  VIND GenNum VTense | VIMP Number Person | VINF | VSUB GenNum ;
  VTense   = VPresent Person | VPast | VFuture Person ;

oper 
   getVTense : RusTense -> Person -> VTense= \t,p ->
   case t of { Present => VPresent p ; PastRus => VPast; Future => VFuture p } ;

   getTense : Tense -> RusTense= \t ->
   case t of { Pres => Present  
    ; Fut => Future   --# notpresent
    ; _ => PastRus    --# notpresent
    } ;

  
   getVoice: VerbForm -> Voice = \vf ->
   case vf of {
    VFORM Act _ => Act;
    VFORM Pass _ => Pass
  };
oper sebya : Case => Str =table {
Nom => "";
Gen => "себя";
Dat=> "себе";
Acc => "себя";
Inst => "собой";
Prep =>"себе"};

  Verb : Type = {s : ClForm => GenNum => Person => Str ; asp : Aspect ; w: Voice} ;
-- Verb phrases are discontinuous: the parts of a verb phrase are
-- (s) an inflected verb, (s2) verb adverbials (not negation though), and
-- (s3) complement. This discontinuity is needed in sentence formation
-- to account for word order variations.
 
  VerbPhrase : Type = Verb ** {s2: Str; s3 : Gender => Number => Str ;
    negBefore: Bool} ;


-- This is one instance of Gazdar's *slash categories*, corresponding to his
-- $S/NP$.
-- We cannot have - nor would we want to have - a productive slash-category former.
-- Perhaps a handful more will be needed.
--
-- Notice that the slash category has the same relation to sentences as
-- transitive verbs have to verbs: it's like a *sentence taking a complement*.

  SlashNounPhrase = Clause ** Complement ;
  Clause = {s : Polarity => ClForm => Str} ;

-- This is the traditional $S -> NP VP$ rule. 

    predVerbPhrase : NounPhrase -> VerbPhrase -> SlashNounPhrase = 
    \Ya, tebyaNeVizhu -> { s = \\b,clf =>
       let 
       { ya = Ya.s ! (mkPronForm Nom No NonPoss);
         khorosho = tebyaNeVizhu.s2;
         vizhu = tebyaNeVizhu.s ! clf !(gNum (pgen2gen Ya.g) Ya.n)! Ya.p;
         tebya = tebyaNeVizhu.s3 ! (pgen2gen Ya.g) ! Ya.n 
       }
       in
        ya ++  khorosho ++ vizhu ++ tebya;
        s2= "";
       c = Nom
} ;

-- Questions are either direct ("Ты счастлив?") 
-- or indirect ("Потом он спросил счастлив ли ты").

param 
  QuestForm = DirQ | IndirQ ;

---- The order of sentence is needed already in $VP$.
--
--    Order = ODir | OQuest ;

oper
   getActVerbForm : ClForm -> Gender -> Number -> Person -> VerbForm = \clf,g,n, p -> case clf of
   { ClIndic Future _ => VFORM Act (VIND (gNum g n) (VFuture p));
     ClIndic PastRus _ => VFORM Act (VIND (gNum g n) VPast);
      ClIndic Present _ => VFORM Act (VIND (gNum g n) (VPresent p));
      ClCondit => VFORM Act (VSUB (gNum g n));
      ClInfinit => VFORM Act VINF ;
      ClImper => VFORM Act (VIMP n p) 
   };

   getPassVerbForm : ClForm -> Gender -> Number -> Person -> VerbForm = \clf,g,n, p -> case clf of
   { ClIndic Future _ => VFORM Pass (VIND (gNum g n) (VFuture p));
     ClIndic PastRus _ => VFORM Pass (VIND (gNum g n) VPast);
      ClIndic Present _ => VFORM Pass (VIND (gNum g n) (VPresent p));
      ClCondit => VFORM Pass (VSUB (gNum g n));
      ClInfinit => VFORM Pass VINF ;
      ClImper => VFORM Pass (VIMP n p) 
   };


--2 For $Adjective$
param
  AdjForm = AF Case Animacy GenNum | AdvF;

oper
  Complement =  {s2 : Str ; c : Case} ;

oper Refl ={s: Case => Str};
oper sam: Refl=
{s = table{
     Nom => "сам";
     Gen => "себя";
     Dat => "себе";
     Acc => "себя";
     Inst => "собой";
     Prepos => "себе";
     Prepos2 => "себе" -- +++ MG_UR: added +++
     }
};

  pgNum : PronGen -> Number -> GenNum = \g,n -> 
    case n of 
   {   Sg => case g of 
                 { PGen Fem => ASg Fem ;
                   PGen Masc => ASg Masc ;
                   PGen Neut => ASg Neut ;
                   _ => ASg Masc } ; -- assuming pronoun "I" is a male
        Pl => APl
   } ;
              --    _  => variants {ASg Masc ; ASg Fem}  } ; 
              --  "variants" version cause "no term variants" error during linearization



oper numGNum : GenNum -> Number = \gn ->
   case gn of { APl => Pl ; _ => Sg } ;

oper genGNum : GenNum -> Gender = \gn ->
   case gn of { ASg Fem => Fem; ASg Masc => Masc; _ => Neut } ;

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
-- "высочайший" (the highest). 

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

--3 Adjective phrases
-- 
-- An adjective phrase may contain a complement, e.g. "моложе Риты".
-- Then it is used as postfix in modification, e.g. "человек, моложе Риты".

  IsPostfixAdj = Bool ;


-- Simple adjectives are not postfix:

-- Adjective type includes both non-degree adjective classes:
-- possesive ("мамин"[mother's], "лисий" [fox'es]) 
-- and relative ("русский" [Russian]) adjectives.

  Adjective : Type = {s : AdjForm => Str} ;

-- A special type of adjectives just having positive forms 
-- (for semantic reasons)  is useful, e.g. "финский".

  AdjPhrase = Adjective ** {p : IsPostfixAdj} ; 


 mkAdjPhrase : Adjective -> IsPostfixAdj  -> AdjPhrase = \novuj ,p -> novuj ** {p = p} ;

----2 For $Relative$
-- 
--    RAgr = RNoAg | RAg {n : Number ; p : Person} ;
--    RCase = RPrep | RC Case ;
--
--2 For $Numeral$

param DForm = unit  | teen  | ten | hund ;
param Place = attr  | indep  ;
param Size  = nom | sgg | plg ;
--param Gend = masc | fem | neut ;
oper mille : Size => Str = table {
  {nom} => "тысяча" ;
  {sgg} => "тысячи" ;
  _     => "тысяч"} ;

oper gg : Str -> Gender => Str = \s -> table {_ => s} ;

--    CardOrd = NCard | NOrd ;

----2 Transformations between parameter types
--

oper 

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
      SF _ Prepos => Prepos ; 
      SF _ Prepos2 => Prepos2 -- +++ MG_UR: added +++
    } ;

}
