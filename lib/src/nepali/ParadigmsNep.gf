--# -path=.:../abstract:../../prelude:../common
--
----1 Lexical Paradigms

resource ParadigmsNep = open 
  Predef, 
  Prelude, 
  MorphoNep,
  CatNep,
  ResNep
  in {

--2 Parameters 

oper
  masculine  : Gender ;
  feminine   : Gender ;
  singular   : Number ;
  plural     : Number ;
  human      : NType ;
  profession : NType ;
  living     : NType ;
  
  singular = Sg ; plural = Pl;

  masculine = Masc ; feminine = Fem ; 
  human = Living ; profession = Living ; living = Living ; 

--2 Nouns
  -- For regular nouns takes Masc as default gender
  regN = overload {
     -- If no parameter is passed noun will take 
     -- Animacy : Nonliving, Honor : 3rd person Low grade honorific
     regN  : Str -> N = \s -> mkNReg s NonLiving Pers3_L ** {lock_N= <>} ; 
     
     -- Animacy : Nonliving by default, Honor : explicitely given, 
     regN  : Str -> NPerson -> N = \s,h -> mkNReg s NonLiving h ** {lock_N= <>} ; 
     
     -- Animacy : explicitely given, Honor : 3rd person Low grade honorific by default
     regN  : Str -> NType -> N = \s,t -> mkNReg s t Pers3_L ** {lock_N= <>} ;
     
     -- Animacy, Honor both exlicutely given
     regN  : Str -> NType -> NPerson -> N = \s,t,h -> mkNReg s t h ** {lock_N= <>} ;
     
     } ;
     
  -- For femenine nouns
  mkNF = overload {
    mkNF : Str -> N = \s -> mkNFem s NonLiving Pers3_L ** {lock_N= <>} ;
    
    mkNF : Str -> NPerson -> N = \s,h -> mkNFem s NonLiving h ** {lock_N= <>} ;
    
    mkNF : Str -> NType -> N = \s,t -> mkNFem s t Pers3_L ** {lock_N= <>} ;
    
    mkNF : Str -> NType -> NPerson -> N = \s,t,h -> mkNFem s t h ** {lock_N= <>} ;
    } ;
  
  -- For uncountable nouns, could be both Masc or Fem Gender
  mkNUC = overload {
    mkNUC : Str -> N = 
      \s -> mkNUnc s Masc NonLiving Pers3_L ** {lock_N= <>} ; 
    
    mkNUC : Str -> Gender -> N = 
      \s,g -> mkNUnc s g NonLiving Pers3_L ** {lock_N= <>} ; 
    
    mkNUC : Str -> Gender -> NType -> N = 
      \s,g,t -> mkNUnc s g t Pers3_L ** {lock_N= <>} ; 
    
    mkNUC : Str -> Gender -> NType -> NPerson -> N = 
      \s,g,t,h -> mkNUnc s g t h ** {lock_N= <>} ; 
    } ;
  --mkNUC : Str -> NType -> Gender -> N = \s,t,g -> mkNUnc s g t ** {lock_N= <>} ; 

  {-
  mkN2 = overload {
    mkN2 : N -> Prep -> Str -> N2 =
        \n,p,c -> n ** {lock_N2 = <> ; c2 = p.s ; c3 = c.s } ; 
        
    mkN2 : N -> Prep -> Str -> NType -> N2 =
        \n,p,c,t -> n ** {lock_N2 = <> ; c2 = p.s ; c3 = c } ;         
        
    mkN2 : N -> Prep -> Str -> NType -> NPerson -> N2 =
        \n,p,c,t,h -> n ** {lock_N2 = <> ; c2 = p.s ; c3 = c} ; 
   } ;
   -}
   
  mkN2 : N -> Prep -> Str -> N2;
  mkN2 = \n,p,c -> n ** {lock_N2 = <> ; c2 = p.s ; c3 = c} ; 
  
  {-
  mkN3 = overload {
    mkN3 : N -> Prep -> Prep -> Str-> N3 =
        \n,p,q,r -> n ** {lock_N3 = <> ; c2 = p.s ; c3 = q.s ; c4 = r} ;
        
    mkN3 : N -> Prep -> Prep -> Str-> NType -> N3 =
        \n,p,q,r,t -> n ** {lock_N3 = <> ; c2 = p.s ; c3 = q.s ; c4 = r} ;
  } ;
  -}
  
  mkN3 : N -> Prep -> Prep -> Str-> N3 ;
  mkN3 = \n,p,q,r -> n ** {lock_N3 = <> ; c2 = p.s ; c3 = q.s ; c4 = r} ;
  
-- Compound Nouns  

  mkCmpdNoun : Str -> N -> N
     = \s,noun -> {s =\\n,c => s ++ noun.s ! n ! c ; g = noun.g ; t = noun.t ; h = noun.h ; lock_N = <>};
 

-- Proper names     
  mkPN = overload {
    mkPN : Str -> PN =
      \s -> let n = regN1 s Masc NonLiving Pers2_M in {s = n.s ! Sg ; g = n.g ; t = n.t ; h = n.h ; lock_PN = <>} ;
    
    mkPN : Str -> Gender -> NPerson -> PN =
      \s,g,h -> let n = regN1 s g NonLiving h in {s = n.s ! Sg ; g = n.g ; t = n.t ; h = n.h ; lock_PN = <>} ;
     
    mkPN : Str -> Gender -> NType -> NPerson -> PN =
      \s,g,t,h -> let n = regN1 s g t h in {s = n.s ! Sg ; g = n.g ; t = n.t ; h = n.h ; lock_PN = <>} ;
  } ;
  
     

-- Personal Pronouns     
  mkPron = overload {
    mkPron : Str -> Str -> Number -> Gender -> NPerson -> Pron = 
      \s,s1,nu,gn,pn -> let n = makePronReg s in {s = n.s ; ps = s1 ; a = toAgr nu pn gn ; lock_Pron = <> } ;
      
    mkPron : (x1,_,_,_,_,_,x7 : Str) -> Number -> Gender -> NPerson -> Pron =
      \x1,x2,x3,x4,x5,x6,x7,nu,gn,pn -> 
           let n = makePron x1 x2 x3 x4 x5 x6 in {s = n.s ; ps = x7 ; a = toAgr nu pn gn ; lock_Pron = <> } ;
  } ;
  
{-
-- Demonstration Pronouns     
  demoPN : Str -> Str -> Str -> Quant =
    \s1,s2,s3 -> let n = makeDemonPronForm s1 s2 s3 in {s = n.s ; a = defaultAgr ; lock_Quant = <>};
-}
--  Determiner    
   mkDet = overload {
     mkDet : (s1,s2:Str) -> Number -> Det =
       \s1,s2,nb -> let dt = makeDet s1 s1 s2 s2 nb in {s = dt.s ; n = nb ; lock_Det = <>} ;
     
     mkDet : (s1,s2,s3,s4:Str) -> Number -> Det =
       \s1,s2,s3,s4,nb -> let dt = makeDet s1 s2 s3 s4 nb in {s = dt.s ; n = nb ; lock_Det = <>} ;
     } ;

-- IDet     
   mkIDetn : (s1,s2:Str) -> Number -> IDet =
      \s1,s2,nb -> let dt = makeIDet s1 s2 in {s = dt.s ; n = nb ; lock_IDet = <>} ;
   
-- Intergative pronouns    
   mkIP : (x1,x2,x3,x4:Str) -> Number -> IP =
     \s1,s2,s3,s4,n -> let p = mkIntPronForm s1 s2 s3 s4 in { s = p.s ; n = n ; lock_IP = <>} ; 

  
--2 Adjectives

  mkA = overload {
    mkA : Str-> A 
      = \s -> mkAdjnp s ** {lock_A = <>} ;
	mkA : Str -> Str -> A2
	  = \a,c -> let n = mkAdjnp a in {s = n.s; c2 = c} ** {lock_A2 = <>} ;
    } ;

--2 Verbs

  mkV : Str -> V = 
    \s -> mkVerb s ** {lock_V = <>} ;

  mkV2 = overload {
    mkV2 : Str -> V2 
      = \s -> mkVerb s **  {c2 = {s = [] ; c = VTrans} ; lock_V2 = <>} ;
    mkV2 : V -> V2 
      = \v -> v ** {c2 = {s = [] ; c = VTrans} ; lock_V2 = <>} ;
    mkV2 : V -> Str -> V2 
      = \v, p -> v ** {c2 = {s = p ; c = VTrans} ; lock_V2 = <>} ;
    } ;
  
  mkV3 : V -> Str -> Str -> V3 ;
  mkV3 v p q = v ** { c2 = p ; c3 = q ; lock_V3 = <>} ;
  
  mkV2V : V -> Str -> Str -> Bool -> V2V ;
  mkV2V v s1 s2 b = v ** {isAux = b ; c1 = s1 ; c2 = s2 ; lock_V2V = <>} ;
  
-- compund verbs
  compoundV = overload {
    compoundV : Str -> V -> V = \s,v -> {s = \\vf => s ++ v.s ! vf ; lock_V = <>} ;
    compoundV : Str -> V2 -> V = \s,v -> {s = \\vf => s ++ v.s ! vf ; lock_V = <>} ;
    };
 

----2 Adverbs
  mkAdv : Str -> Adv ; -- e.g. today  
  mkAdv x = lin Adv (ss x) ;
  
  mkAdV : Str -> AdV ; -- e.g. always
  mkAdV x = lin AdV (ss x) ;
  
-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ; -- e.g. quite
  mkAdA x = lin AdA (ss x) ;

-- Adverbs modifying numerals

  mkAdN : Str -> AdN ; -- e.g. approximately
  mkAdN x = lin AdN (ss x) ;
  
--2 Prepositions
--
-- A preposition as used for rection in the lexicon, as well as to
-- build $PP$s in the resource API, just requires a string.
  mkPrep : Str -> Prep ;
  mkPrep p = lin Prep (ss p) ;
  
  noPrep : Prep ;
  noPrep = mkPrep [] ;

    
--3 Determiners and quantifiers
    
  mkQuant = overload  {
    --mkQuant : Pron -> Quant = \p -> {s = \\_,_,c => p.s!c ; lock_Quant = <>};    
    mkQuant : (s1,s2,s3,s4:Str) -> Quant = 
      \sm,sf,pm,pf -> {s = (makeQuant sm sf pm pf).s ; lock_Quant = <>};
    
    mkQuant : (s1,s2:Str) -> Quant = 
      \sg,pl -> {s = (makeQuant sg sg pl pl).s ; lock_Quant = <>} ;
    } ;


{- 
--2 Conjunctions
  mkConj : overload {
    mkConj : Str -> Conj ;                  -- and (plural agreement)
    mkConj : Str -> Number -> Conj ;        -- or (agrement number given as argument)
    mkConj : Str -> Str -> Conj ;           -- both ... and (plural)
    mkConj : Str -> Str -> Number -> Conj ; -- either ... or (agrement number given as argument)
  } ;
 mkConj = overload {
    mkConj : Str -> Conj = \y -> mk2Conj [] y plural ;
    mkConj : Str -> Number -> Conj = \y,n -> mk2Conj [] y n ;
    mkConj : Str -> Str -> Conj = \x,y -> mk2Conj x y plural ;
    mkConj : Str -> Str -> Number -> Conj = mk2Conj ;
  } ;

  mk2Conj : Str -> Str -> Number -> Conj = \x,y,n -> 
    lin Conj (sd2 x y ** {n = n}) ;  
-}
}
