--# -path=.:../abstract:../../prelude:../common
--
----1 Pnbu Lexical Paradigms

resource ParadigmsPes = open 
  Predef, 
  Prelude, 
  MorphoPes,
  CatPes
  in {
  
  flags optimize=all ;
   coding = utf8;

--2 Parameters 

oper
  animate : Animacy ;
  inanimate : Animacy ;
  singular : Number;
  plural : Number;
  
  singular = Sg ; plural = Pl;

  animate = Animate ; inanimate = Inanimate ; --i
  mkN01 : Str -> Animacy -> Noun ;
  mkN01 str ani = mkN str (str ++ "hA") ani;
  mkN02 : Str -> Animacy -> Noun ;
  mkN02 str ani = case (last str) of {
    "h" => mkN str ((init str) + "gAn") ani ;
    ("A"|"v") => mkN str (str + "yAn") ani ;
    _ => mkN str (str+"An") ani
  };
{-

--2 Nouns


  mkN2 : N -> Prep -> Str -> N2;
  mkN2 = \n,p,c -> n ** {lock_N2 = <> ; c2 = p.s ; c3 = c } ; 
  
  mkN3 : N -> Prep -> Str -> Str-> N3 ;
  mkN3 = \n,p,q,r -> n ** {lock_N3 = <> ; c2 = p.s ; c3 = q ; c4 = r} ;
-}  
-- Compound Nouns  

    mkCmpdNoun1 : Str -> N -> N
     = \s,noun -> {s =\\ez,n => s ++ noun.s ! ez ! n  ;  animacy = noun.animacy ; definitness = noun.definitness ; lock_N = <>};
     mkCmpdNoun2 : N -> Str -> N
     = \noun,s -> {s =\\ez,n =>  noun.s ! ez ! n  ++ s ; animacy = noun.animacy ; definitness =noun.definitness ; lock_N = <>};


-- Proper names     
   mkPN : Str -> Animacy -> PN =

     \str,ani -> {s = str ; animacy = ani ; lock_PN = <>} ;

 
-- Personal Pronouns     
  personalPN : Str -> Number -> PPerson -> Pron =
     \str,nn,p ->  {s = str ; a = AgPes nn p ; ps = str ; lock_Pron = <>};
{-
-- Demonstration Pronouns     
  demoPN : Str -> Str -> Str -> Quant =
    \s1,s2,s3 -> let n = makeDemonPronForm s1 s2 s3 in {s = n.s ; a = defaultAgr ; lock_Quant = <>};
-- Determiner
-}
  mkDet = overload {
  mkDet : Str -> Number -> Det =
    \s1,n -> makeDet s1 n False ** { lock_Det = <>};
  mkDet : Str -> Number -> Bool -> Det =
    \s1,n,b -> makeDet s1 n b ** { lock_Det = <>};
    };
 {-   
-- Intergative pronouns    
  mkIP : (x1,x2,x3,x4:Str) -> Number -> Gender -> IP =
   \s1,s2,s3,s4,n,g -> let p = mkIntPronForm s1 s2 s3 s4 in { s = p.s ; n = n ; g = g ;  lock_IP = <>}; 

-- AdN
  mkAdN : Str -> AdN = \s -> ss s ;
-}  
--2 Adjectives

  mkA = overload {
    mkA : Str-> A 
      = \str ->   mkAdj str str ** { lock_A = <>} ;
    mkA : Str-> Str -> A 
      = \str,adv ->   mkAdj str adv ** { lock_A = <>} ;  
	mkA : Str -> Str -> A2
	  = \a,c -> mkAdj a a  ** { c2 = c ; lock_A2 = <>} ;
    } ;

--2 Verbs
 mkV : Str -> Str -> V 
      = \s1, s2 -> mkVerb s1 s2 ** {lock_V = <>} ;
  -- mkVerb takes both the Infinitive and the present root(root2) and is applied for iregular verbs
  haveVerb : V = mkHave ; 
  mkV_1 : Str -> V 
      = \s -> mkVerb1 s ** {lock_V = <>} ;
      
  mkV_2 : Str -> V 
      = \s -> mkVerb2 s ** {lock_V = <>} ;
      
  mkV2 = overload {
--    mkV2 : Str -> V2 
--      = \s -> mkV s **  {c2 = {s = [] ; c = VTrans} ; lock_V2 = <>} ;
    mkV2 : V -> V2 
      = \v -> v ** {c2 = {s = [] ; ra = [] ; c = VTrans} ; lock_V2 = <>} ;
    mkV2 : V -> Str -> V2 
      = \v,ra -> v ** {c2 = {ra = ra ; s = [] ; c = VTrans} ; lock_V2 = <>} ;
    mkV2 : V -> Str -> Bool -> V2 
      = \v,p,b -> v ** {c2 = {ra = [] ; s = p ; c = VTrans} ; lock_V2 = <>} ;  
    } ;
  
  mkV3 : V -> Str -> Str -> V3;
    mkV3 v p q = v ** { c2 = p ; c3 = q ; lock_V3 = <>} ;
  mkV2V : V -> Str -> Str -> Bool -> V2V ;
    mkV2V v s1 s2 b = v ** {isAux = b ; c1 = s1 ; c2 = s2 ; lock_V2V = <>} ;
  
-- compund verbs
   compoundV = overload {
   compoundV : Str -> V -> V = \s,v -> {s = \\vf => s ++ v.s ! vf ; lock_V = <>} ;     
   compoundV : Str -> V2 -> V = \s,v -> {s = \\vf => s ++ v.s ! vf ; lock_V = <>} ;
   };
 

----2 Adverbs
  mkAdv : Str -> Adv = \str -> {s =  str ; lock_Adv = <>};

----2 Prepositions

  mkPrep : Str -> Prep ;
    mkPrep str = {s = str ; lock_Prep = <>};
{-    
--3 Determiners and quantifiers

--  mkQuant : overload {
--    mkQuant : Pron -> Quant ;
--    mkQuant : (no_sg, no_pl, none_sg, : Str) -> Quant ;
--  } ;
-}  
  mkQuant = overload {
--    mkQuant : Pron -> Quant = \p -> {s = \\_,_,c => p.s!c ;a = p.a ; lock_Quant = <>};
    mkQuant :  Str -> Str -> Quant = \sg,pl -> makeQuant sg pl;
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

--  mkV0  : V -> V0 ;
--  mkVS  : V -> VS ;
--  mkV2S : V -> Prep -> V2S ;
  mkVV  : V -> VV = \v ->  lin VV (v ** {isAux = False});
    

--  mkV2V : V -> Prep -> Prep -> V2V ;
--  mkVA  : V -> VA ;
--  mkV2A : V -> Prep -> V2A ;
--  mkVQ  : V -> VQ ;
--  mkV2Q : V -> Prep -> V2Q ;
--
--  mkAS  : A -> AS ;
--  mkA2S : A -> Prep -> A2S ;
--  mkAV  : A -> AV ;
--  mkA2V : A -> Prep -> A2V ;
--  mkA2V a p = a ** {c2 = p.s } ; 
--
---- Notice: Categories $V0, AS, A2S, AV, A2V$ are just $A$.
---- $V0$ is just $V$; the second argument is treated as adverb.
--
--  V0 : Type ;
--  AS, A2S, AV, A2V : Type ;
--
----.
----2 Definitions of paradigms
----
---- The definitions should not bother the user of the API. So they are
---- hidden from the document.
--
--  Gender = MorphoHin.Gender ; 
--  Number = MorphoHin.Number ;
--  Case = MorphoHin.Case ;
--  human = Masc ; 
--  nonhuman = Neutr ;
--  masculine = Masc ;
--  feminine = Fem ;
--  singular = Sg ;
--  plural = Pl ;
--  nominative = Nom ;
--  genitive = Gen ;
-}  
}
