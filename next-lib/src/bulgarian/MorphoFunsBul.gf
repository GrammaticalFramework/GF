--# -path=.:../abstract:../../prelude:../common

resource MorphoFunsBul = open
  Prelude, 
  CatBul,
  MorphoBul
  in {
  flags coding=cp1251 ;


oper
--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. Some can be preverbal (e.g. "always").

  mkAdv : Str -> Adv = \x -> ss x ** {lock_Adv = <>} ;
  mkAdV : Str -> AdV = \x -> ss x ** {lock_AdV = <>} ;

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA = \x -> ss x ** {lock_AdA = <>} ;


--2 Adjectives
--

  AS, A2S, AV : Type = A ;
  A2V : Type = A2 ;

  mkA2 : A -> Prep -> A2 ;
  mkA2 a p = a ** {c2 = p.s ; lock_A2 = <>} ;
  
  mkAS  : A -> AS ;
  mkAS  v = v ** {lock_A = <>} ;
  
  mkA2S : A -> Prep -> A2S ;
  mkA2S v p = mkA2 v p ** {lock_A = <>} ;
  
  mkAV  : A -> AV ;
  mkAV  v = v ** {lock_A = <>} ;
  
  mkA2V : A -> Prep -> A2V ;
  mkA2V v p = mkA2 v p ** {lock_A2 = <>} ;


--2 Verbs
--

  medialV : V -> Case -> V ;
  medialV v c = {s = v.s; vtype = VMedial  c; lock_V=<>} ;

  phrasalV : V -> Case -> V ;
  phrasalV v c = {s = v.s; vtype = VPhrasal c; lock_V=<>} ;
  
  actionV : VTable -> VTable -> V ;
  actionV imperf perf = { 
    s = table {Imperf=>imperf; Perf=>perf};
    vtype = VNormal;
    lock_V=<>
    } ;

  stateV : VTable -> V ;
  stateV vtable = { 
    s = \\_=>vtable;
    vtype = VNormal;
    lock_V=<>
    } ;

--3 Zero-place verbs
--

  V0 : Type = V ;
  mkV0  : V -> V0 ;
  mkV0  v = v ** {lock_V = <>} ;


--3 Two-place verbs
--

  prepV2 : V -> Prep -> V2 ;
  prepV2 v p = {s = v.s; c2 = p; vtype = v.vtype; lock_V2 = <>} ;
  
  dirV2 : V -> V2 ;
  dirV2 v = prepV2 v noPrep ;


--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3     : V -> Prep -> Prep -> V3 ;   -- speak, with, about
  mkV3 v p q = {s = v.s; s1 = v.s1; c2 = p; c3 = q; vtype = v.vtype; lock_V3 = <>} ;
  
  dirV3    : V -> Prep -> V3 ;           -- give,_,to
  dirV3 v p = mkV3 v noPrep p ;
  
  dirdirV3 : V -> V3 ;                   -- give,_,_
  dirdirV3 v = dirV3 v noPrep ;


--3 Other verbs
--

--  V2S, V2V, V2Q : Type = V2 ;

  mkV2S : V -> Prep -> V2S ;
  mkV2S v p = prepV2 v p ** {lock_V2S = <>} ;
  
  mkV2V : V -> Prep -> Prep -> V2V ;
  mkV2V v p t = prepV2 v p ** {s4 = t ; lock_V2V = <>} ;
  
  mkV2A : V -> Prep -> V2A ;
  mkV2A v p = prepV2 v p ** {lock_V2A = <>} ;
  
  mkV2Q : V -> Prep -> V2Q ;
  mkV2Q v p = prepV2 v p ** {lock_V2Q = <>} ;
  
  mkVS  : V -> VS ;
  mkVS  v = v ** {lock_VS = <>} ;
  
  mkVV : V -> VV ;
  mkVV  v = v ** {lock_VV = <>} ;
  
  mkVA : V -> VA ;
  mkVA  v = v ** {lock_VA = <>} ;

  mkV2A : V -> Prep -> V2A ;
  mkV2A v p = prepV2 v p ** {lock_V2A = <>} ;
  
  mkVQ  : V -> VQ ;
  mkVQ  v = v ** {lock_VQ = <>} ;
  
  mkV2Q : V -> Prep -> V2Q ;  
  mkV2Q v p = prepV2 v p ** {lock_V2Q = <>} ;


--2 Nouns

--3 Two-place Nouns
--

  prepN2 : N -> Prep -> N2 ;
  prepN2 n p = {s = n.s; g = n.g; c2 = p; lock_N2 = <>} ;
  
  dirN2 : N -> N2 ;
  dirN2 n = prepN2 n noPrep ;


--3 Three-place Nouns
--

  prepN3 : N -> Prep -> Prep -> N3 ;
  prepN3 n p q = {s = n.s; g = n.g; c2 = p; c3 = q; lock_N3 = <>} ;
  
  dirN3 : N -> Prep -> N3 ;
  dirN3 n p = prepN3 n noPrep p ;
  
  dirdirN3 : N -> N3 ;
  dirdirN3 n = dirN3 n noPrep ;

  compoundN = overload {
    compoundN : Str -> N -> N 
      = \s,n -> {s = \\nform => s ++ n.s ! nform ; g=n.g ; anim=n.anim ; lock_N = <>} ;
    compoundN : N -> Str -> N 
      = \n,s -> {s = \\nform => s ++ n.s ! nform ; g=n.g ; anim=n.anim ; lock_N = <>} ;
  } ;
  

--2 Prepositions
--
-- A preposition as used for rection in the lexicon, as well as to
-- build $PP$s in the resource API, just requires a string.

  mkPrep : Str -> Case -> Prep = \p,c -> {s = p; c = c; lock_Prep = <>} ;
  noPrep : Prep = mkPrep [] Acc ;
  

--2 Proper Names
--
  mkPN : Str -> Gender -> PN ;
  mkPN s g = {s = s; g = g ; lock_PN = <>} ;


--2 IAdv
--

  mkIAdv : Str -> IAdv ;
  mkIAdv s = {s = table {QDir=>s;QIndir=>s+"то"}; lock_IAdv = <>} ;
}
