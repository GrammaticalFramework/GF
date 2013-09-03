--# -path=.:../abstract:../prelude:../common

--1 Latin Lexical Paradigms
--
-- Aarne Ranta 2008, Extended Herbert Lange 2013
--
-- This is an API for the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 

resource ParadigmsLat = open 
  (Predef=Predef), 
  Prelude, 
  ResLat,
  MorphoLat,
  CatLat
  in {

--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  masculine : Gender ;
  feminine  : Gender ;
  neuter    : Gender ;

  mkN = overload {
    mkN : (verbum : Str) -> N 
      = \n -> lin N ( noun n ) ;
    mkN : (verbum, verbi : Str) -> Gender -> N 
      = \x,y,z -> lin N ( noun_ngg x y z ) ;
  } ;
  
  mkA = overload {
    mkA : (verbum : Str) -> A 
      = \n -> lin A ( adj n ** {isPre = False } ) ;
    mkA : (verbum, verbi : Str) -> A 
      = \x,y -> lin A ( adj123 x y ** {isPre = False } ) ;
    mkA : (bonus,bona,bonum : N) -> A 
      = \x,y,z -> 
      let compsup = comp_super x ;
	  advs : Str * Str = 
	    case x.s!Sg!Nom of {
	      -- Bayer-Lindauer 50 4
	      idon + #vowel + "us" => < "magis" , "maxime" > ;
	      _ => < "" , "" >
	    };
      in
      lin A ( mkAdjective x y z < compsup.p1 , advs.p2 > < compsup.p2 , advs.p2> ** {isPre = False } ) ;
  } ;
  

  mkV = overload {
    mkV : (tacere : Str) -> V
      = \v -> lin V ( verb v ) ; 
    mkV : (iacere,iacio,ieci,iactus : Str) -> V
      = \v,x,y,z -> lin V ( verb_ippp v x y z ) ; 
    mkV : (iacere,iacio,ieci : Str) -> V
      = \v,x,y -> lin V ( verb_ippp v x y "######" ) ; 
  } ;

  V0 : Type = V ;
  mkV0 : V -> V0 = \v -> lin V0 v ; -- Same as in english, don't know if it's working

  mkV2 = overload {
    mkV2 : (amare : Str) -> V2
      = \v -> lin V2 ( verb v ** { c = lin Prep ( mkPrep "" Acc ) } ) ; 
    mkV2 : (facere : V) -> V2
      = \v -> lin V2 ( v ** { c = lin Prep ( mkPrep "" Acc ) } ) ; 
    mkV2 : V -> Prep -> V2
      = \v,p -> lin V2 ( v ** { c = p } ) ; 
    } ;

  masculine = Masc ;
  feminine = Fem ;
  neuter = Neutr ;

-- To be implemented, just place holders
  mkPN : N -> PN = \n -> lin PN n ;
  mkN2 : N -> Prep -> N2 = \n,p -> lin N2 ( n ** { c = p } );
  mkN3 : N -> Prep -> Prep -> N3 = \n,p1,p2 -> lin N3 ( n **{ c = p1 ; c2 = p2 } ) ;
  mkV2S : V -> Prep -> V2S = \v,p -> lin V2S ( v ** { c = p } ) ;
  mkV2Q : V -> Prep -> V2Q = \v,p -> lin V2Q ( v ** { c = p } ) ;
  mkV2V : V -> Str -> Bool -> V2V = \v,s,b -> lin V2V ( v ** { c2 = s ; isAux = b } ) ;
  mkVV : V -> Bool -> VV = \v,b -> lin VV ( v ** { isAux = b } ) ;
  mkVA : V -> VA = \v -> lin VA v ;
  mkV3 : V -> Prep -> Prep -> V3 = \v,p1,p2 -> lin V3 ( v ** { c2 = p1; c3 = p2 } ) ;
  mkVQ : V -> VQ = \v -> lin VQ v ;
  mkVS : V -> VS = \v -> lin VS v ;
  mkV2A : V -> Prep -> V2A = \v,p -> lin V2A (v ** { c = p } ) ;
  AS : Type = A ;
  mkAS : A -> AS = \a -> lin AS a ;
  mkA2 : A -> Prep -> A2 = \a,p -> lin A2 ( a ** { c = p } ) ;
  A2V : Type = A2 ;
  mkA2V : A -> Prep -> A2V = \a,p -> lin A2V ( lin A2 ( a ** { c = p } ) ) ;
  AV : Type = A ;
  mkAV : A -> AV = \a -> lin AV a ;
}
