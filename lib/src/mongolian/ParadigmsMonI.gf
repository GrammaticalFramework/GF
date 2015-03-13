--# -path=.:../abstract:../prelude:../common

--1 Mongolian Lexical Paradigms

-- This is an API for the user of the resource grammar for adding lexical
-- items. It gives functions for forming expressions of open categories:
-- nouns, adjectives, verbs.

-- Closed categories (determiners, pronouns, conjunctions) are accessed
-- through the resource syntax API, $Structural.gf$.

-- The main difference with $MorphoMon.gf$ is that the result types referred 
-- to are compiled resource grammar types, i.e. wrapped with $lin Cat$.

interface ParadigmsMonI = open Prelude, MorphoMon, CatMon in {

 flags  coding=utf8 ; optimize=all ; 

oper 
 regV : Str -> Verb ;
-- Auxiliary categories not in abstract/Cat.gf

-- Categories $V0, AS, A2S, AV, A2V$ are just $A$, $V0$ is just $V$; 
-- the second argument is treated as adverb.

 V0, AS, AV, A2S, A2V : Type ;

-- Parameters 

-- To abstract over case names, we define the following case names, following 
-- the case order standard for Mongolian textbooks. 

 RCase : Type ; 
 nominative    : RCase ;
 genitive      : RCase ;
 dative        : RCase ;
 accusative    : RCase ; 
 ablative      : RCase ;
 instrumental  : RCase ;
 comitative    : RCase ;
 directive     : RCase ;

-- To abstract over number names, we define the following.

 Number : Type ;
 singular : Number ;
 plural   : Number ;

-- Preposition

 mkPrep : RCase -> Str -> Prep ;
 noPrep : RCase -> Prep ;
 
-- Conjunctions

 mkConj : Str -> ConjType -> Conj ; 
                      
 mkSubj : Str -> Subj ;

-- Nouns

 mkN : overload { mkN : (nNomSg : Str) -> Noun ;
                  mkN : (nNomSg,nNomPl : Str) -> Noun } ;
-- Foreign nouns, which are inflected differently.

 mkLN : overload { mkLN : Str -> Noun ;
                   mkLN : (_,_ : Str) -> Noun } ; 
				  
-- Compound nouns constructed with an adjective; only the noun part is inflected.
  
 mk2N : (adj : Str) -> Noun -> Noun ;

 mkN2 : N -> N2 ;

 mkN3 : Noun -> Prep -> Prep -> N3 ;

-- Proper names and Noun Phrases.  

 mkPN : Str -> PN ;  
 mkNP : Str -> Def -> NP ;  

-- Adjectives

-- Mongolian adjectives have only a positive form.

 mkA : (positive : Str) -> A ;

-- Two-place adjectives need a case as an extra argument.

 mkA2 : A -> RCase -> A2 ;  

-- Adverbs

-- Adverbs are not inflected.

 mkAdv : Str -> Adv ;

-- Verbs

-- In our lexicon description there are so far 120 forms: 
-- 5 Voice * 4 Aspect * 6 indicative tensed Mood 

 Voice: Type; 
 active      : Voice ;
 causative   : Voice ;
 passive     : Voice ;
 communal    : Voice ;
 adversative : Voice ;

 Aspect: Type; 
 simple      : Aspect ;
 quick       : Aspect ;
 complete    : Aspect ;
 collective  : Aspect ;

 Imperative : Type ;
 intention  : Imperative ;
 decision   : Imperative ;
 command    : Imperative ;
 request    : Imperative ;
 demand     : Imperative ;
 admonition : Imperative ;
 appeal     : Imperative ;
 permission : Imperative ;
 hope       : Imperative ;
 blessing   : Imperative ;
 
 Subordination : Type ;
 conditional        : Subordination ;
 concessive         : Subordination ;
 immediatsucceeding : Subordination ;
 logicalsucceeding  : Subordination ;
 intending          : Subordination ;
 limiting           : Subordination ;
 progressive        : Subordination ;
 succeeding         : Subordination ;

 Bool: Type;
 true        : Bool;
 false       : Bool;

-- One-place verbs. 

 mkV : Str -> Verb ;

-- Two-place and three-place verbs:

 mkV2 : overload { mkV2 : Verb -> V2 ;
                   mkV2 : Verb -> Prep -> V2 } ;

 mkV3 : overload { mkV3 : Verb -> V3 ;
                   mkV3 : Verb -> Prep -> Prep -> V3 } ;

-- Determiners and quantifiers

 mkOrd : Str -> Ord ;

-- Other complement patterns

-- Verbs and adjectives can take complements such as sentences,
-- questions, verb phrases, and adjectives.

 mkVA : Verb -> VA ;
 mkV0 : Verb -> V0 ;
 mkVS : Verb -> VS ;
 mkVV : {s : VVVerbForm => Str} -> VV ;
 mkVQ : Verb -> VQ ;
 mkV2S : Verb -> Prep -> V2S ;
 mkV2V : Verb -> Prep -> V2V ;
 mkV2A : Verb -> Prep -> V2A ;
 mkV2Q : Verb -> Prep -> V2Q ;
 mkAS : Adjective -> AS ;
 mkA2S : Adjective -> Prep -> A2S ;
 mkAV : Adjective -> AV ;
 mkA2V : Adjective -> Prep -> A2V ;

-- Definitions of parameters and paradigms should not bother the user of the API.

-- We separate the definitions that should be compiled with optimize=all into 
-- ParadigmsMonO.gf, those which should be compiled with optimize=noexpand into
-- ParadigmsMon.gf. 

-- Implementation: Why is it much slower if the definitions that should be optimized
-- are contained here? 

} ;

