--# -path=.:../abstract:../../prelude:../common

--1 Swahili Lexical Paradigms


resource ParadigmsSwa = open(Predef=Predef), Prelude, MorphoSwa,ResSwa,CatSwa in {

flags optimize=all ;

--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  Animacy : Type ; 

  animate   : Animacy ;
  inanimate : Animacy ;

-- To abstract over number names, we define the following.

  Number : Type ; 

  singular : Number ;
  plural   : Number ;

-- To abstract over case names, we define the following.

  Case : Type ;

  nominative : Case ;
  locative   : Case ;

-- To abstract over nounclass names, we define the following.
  
  Gender : Type ;

   m_wa :Gender ;
   m_mi : Gender ;
   ji_ma : Gender ;
   e_ma : Gender ;
   ma_ma : Gender ;
   ki_vi : Gender ;
   e_e : Gender ;
   u_u : Gender ;
   u_ma : Gender ;
   u_e : Gender ;

 

--2 Nouns

-- Worst case: give all four forms and the semantic gender.

  mkN  : (mtu,watu : Str) -> Gender -> Animacy -> N ;

-- The regular function captures the variants for nouns depending on Gender and Number

  regN : Str -> Gender -> Animacy -> N ;

-- In practice the worst case is just: give singular and plural nominative.


  mk2N : (mtu , watu : Str) -> Gender -> Animacy -> N ;
  mk2N x y g anim = mkNounIrreg x y g anim ** {lock_N = <>};

  mkN2 : N -> Prep -> N2 ;
  mkN2  : N -> Prep -> N2 = \n,p -> n ** {c2 = p.s ; lock_N2 = <>} ;

  mkPrep : Str -> Prep ;
--  mkPrep p = {s = p ; c = CPrep PNul ; isDir = False ; lock_Prep = <>} ;
  mkPrep p = {s = p ; lock_Prep = <>} ;


--3 Relational nouns 
-- 
-- Relational nouns ("fille de x") need a case and a preposition. 

-- All nouns created by the previous functions are marked as
-- $nonhuman$. If you want a $human$ noun, wrap it with the following
-- function:

--  genderN : Gender -> N -> N ; 

-- For regular adjectives, the adverbial form is derived. This holds
-- even for cases with the variation "happy - happily".

   regA : Str -> A ;

-- If comparison is formed by "kuliko", as usual in Swahili,
-- the following pattern is used:

 compADeg : A -> A ;

--2 Definitions of paradigms
--
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.
--.

  Animacy = ResSwa.Animacy ; 
  Number = ResSwa.Number ;
  Case = ResSwa.Case ;
  Gender = ResSwa.Gender ;
  animate = AN ; 
  inanimate = IN ;
  singular = Sg ;
  plural = Pl ;
  nominative = Nom ;
  locative = Loc ;
  m_wa = g1_2 ;
  m_mi = g3_4 ;
  ji_ma = g5_6 ;
  e_ma = g5a_6 ;
  ma_ma = g6 ; 
  ki_vi = g7_8 ;
  e_e = g9_10 ; 
  u_u = g11 ; 
  u_ma = g11_6 ; 
  u_e = g11_10 ;
  VForm = ResSwa.VForm ;

--  regN x g anim = mkNomReg x g anim ** {lock_N = <>} ;

    regN = \x,g,anim ->
      mkNomReg x g anim ** {lock_N = <>} ;

--  mkN x y g anim = mkNounIrreg x y g anim ** {lock_N = <>} ;
  mkN = \x,y,g,anim -> 
    mkNounIrreg x y g anim ** {lock_N = <>} ;
 
-- Adjectives

   regA a = compADeg { 
         s = \\_ => (mkAdjective a).s ;
         lock_A = <>} ;

  compADeg a = 
    {
       s = table {
          Posit => a.s ! Posit ;
           _ => \\f => a.s ! Posit ! f ++ "kuliko" 
       } ; 
     lock_A = <>} ;
 
-- Verbs
    regV : Str -> V ;
    regV = \enda -> mkV enda ** {s1 = [] ; lock_V = <>} ;

{--
	mkV2 = overload {
	    mkV2 : Str -> V2 = \s -> dirV2 (regV s) ;
	    mkV2 : V -> V2 = dirV2 ;  
	    mkV2 : V -> Prep -> V2 = mmkV2
	  } ;

   mmkV2 : V -> Prep -> V2 ;
   mmkV2 v p = v ** {c2 = p ; lock_V2 = <>} ;
   dirV2 : V -> V2 = \v -> mmkV2 v "na" ;
--}

--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. 

  mkAdv : Str -> Adv ;
  mkAdv x = ss x ** {lock_Adv = <>} ;


} ;
