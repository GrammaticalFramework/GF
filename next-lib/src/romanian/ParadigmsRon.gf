--# -path=.:../romance:../common:../abstract:../../prelude

--1 Romanian Lexical Paradigms
--
--  Ramona Enache 2008 - 2009
--


resource ParadigmsRon = 
  open 
    (Predef=Predef), 
    Prelude, 
    MorphoRon, 
    CatRon,
    BeschRon in {

  flags optimize=all ;

--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  NGender : Type ; 

  masculine : NGender ;
  feminine  : NGender ;
  neuter    : NGender ;
  
  Gender : Type ;
  
  Masculine : Gender ;
  Feminine  : Gender ;
  
--To abstract over animacy, we define the following :  

  Anim : Type ;
  
  animate   : Anim ;
  inanimate : Anim;
  
-- To abstract over number names, we define the following.

  Number : Type ; 

  singular : Number ;
  plural   : Number ;

-- prepositions which require cases :
   
   Preposition : Type ;
 
 NCase : Type ;
  Acc : NCase ;
  Dat : NCase ;
  Gen : NCase ;
    
  mkPrep : Str -> NCase -> Prep ;
  noPrep : NCase -> Prep ;

--2 Nouns



--3 Relational nouns 
-- 
-- Relational nouns need a noun and a preposition. 

 mkN2 : N -> Prep -> N2 ;
 mkN2 n p = n ** {lock_N2 = <> ; c2 = p};

-- Three-place relational nouns need two prepositions.

mkN3 : N -> Prep -> Prep -> N3 ;
mkN3 n p q = n ** {lock_N3 = <> ; c2 = p ; c3 = q };



--3 Proper names and noun phrases
--
-- Proper names need a string and a gender. If no gender is given, the
-- feminine is used for strings ending with "e", the masculine for other strings.

  mkPN  = overload {
    mkPN : Str -> PN = mkPropN ;
    mkPN : Str -> Gender -> PN = mkPropNoun ;
    mkPN : Str -> Gender -> Number -> PN = mkProperNoun; 
    } ;


mkPropN : Str -> PN = \Ion ->
case last Ion of
{ "a" => mkPropNoun Ion Feminine ;
   _  => mkPropNoun Ion Masculine
};

mkPropNoun : Str -> Gender -> PN = \Ion, gen ->
 mkProperNoun Ion gen singular ;

mkProperNoun : Str -> Gender -> Number -> PN = \Ion, gen, num ->
{s = table {ANomAcc => Ion;
            AGenDat => case <last Ion,gen> of
                      { <"a",Fem> => init Ion + "ei" ;
                        _         => "lui" ++ Ion
                      };
            AVoc => Ion            
            };
g = gen ;
n = num ;
lock_PN = <>
};




--3 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

 mkA2 : A -> Prep -> A2 ;
 mkA2 a p = a ** {c2 = p ; lock_A2 = <>} ;

--.
--2 Definitions of the paradigms
--
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.


  NGender = MorphoRon.NGender ; 
  Number = MorphoRon.Number ;
  Anim   = MorphoRon.Animacy ;
  Gender = MorphoRon.Gender ;
  NCase   = MorphoRon.NCase ;
  
  masculine = NMasc ;
  feminine  = NFem ;
  neuter    = NNeut ;
  
  singular = Sg ;
  plural   = Pl ;
 
  animate   = Animate ;
  inanimate = Inanimate ;

  Masculine = Masc ;
  Feminine = Fem ;
  
  Acc = Ac ;
  Dat = Da ;
  Gen = Ge ;
  
  
  Preposition = Compl ;
  mkPrep ss cc = {s = ss ; c = cc; isDir = True; lock_Prep = <>} ;
  noPrep cc = mkPrep [] cc  ;

  
compN : N -> Str -> N ;
compN x y = composeN x y ** {lock_N = <>} ;

ccompN : N -> Str -> N ;
ccompN x y = ccompose x y ** {lock_N = <>} ;

mkNI : Str -> Str -> NGender -> N;
mkNI s ss g = mkIn (mkNomIrreg s ss g) ** {lock_N = <>} ; 
             
regN : Str -> NGender -> N ;
regN s g = mkIn (mkNomReg s g) ** {lock_N = <>};
             

mkVI : Str -> Str -> Str -> N;
mkVI s ss sss = mkIn (mkNomVIrreg s ss sss) ** {lock_N = <>} ;

mkIn : N -> N ;
mkIn n = mkInanimate n ** {lock_N = <> };

mkAnim : N -> N ;
mkAnim n = mkAnimate n ** {lock_N = <> }; 

chV : Str -> N -> N ;
chV s n = mkVocc n s ** {lock_N = <> } ;


--smart paradigm for inferring the gender of the nouns
--partly based on the paper 
--"COVERT SEMANTIC AND MORPHOPHONEMIC CATEGORIES IN THE ROMANIAN GENDER SYSTEM"
-- by Jan Louis Perkowski, Emil Vrabie

mkSPN : Str -> N ;
mkSPN s = case s of 
   { x + ("ã"|"e"|"a") => regN s feminine ;
     x + ("el"|"mp"|"mb"|"en"|"id"|"at"|"ete"|"ol"|"et"|"or") => regN s masculine ;
     _  => regN s neuter  
    };

mkNN : Str -> Str -> N ;
mkNN s ss = case s of 
     { x + ("ã"|"e"|"a") => mkNI s ss feminine ;
       _                 => case ss of 
                          {x + "uri" => mkNI s ss neuter ;
                           x + "e"   => mkNI s ss neuter ;
                           _         => mkNI s ss masculine
                          
                          }
     };

 mkN = overload {
    mkN : Str -> Str -> NGender -> N = mkNI; -- worst case - we need Singular + Plural form + gender
    mkN : Str -> Str -> Str -> N = mkVI; -- very irregular nouns - feminine
    mkN : Str -> Str -> N = mkNN; -- needed Singular + Plural form, infers gender
    mkN : Str -> NGender -> N = regN;  -- needed Singular +  gender, infers Plural form
    mkN : Str -> N = mkSPN; -- needed Singular form, infers gender and Plural form
 } ; 

--because the plurals ending in "uri" are becoming less and less frequent for neuter nouns,
--and because there is no way of infering the plural form by looking at the structure of the word
--we treat this case separately :
   
mkNR : Str -> N;
mkNR s = mkIn (mkNomNeut s) ** {lock_N = <>} ;

--------------------------------------------------------------------

mkA = overload {
   mkA : Str -> Str -> Str -> Str -> Str -> A = mk5A ;--worst case -- all 4 forms are needed + form for adverb
   mkA : Str -> Str -> Str -> Str -> A = mk4A; -- 4 forms are needed
   mkA : Str -> A = regA; -- regular adjectives
};

mk4A : Str -> Str -> Str -> Str -> A;
mk4A a b c d =  
let adj = mkAdjSpec a b c d in
{s = table { Posit  => adj.s ;
             Compar => \\f => "mai" ++ (adj.s ! f) ++ "decât";
             Superl => table {AF g n a c => artDem g n c ++ "mai" ++ adj.s ! (AF g n Indef c) ;
                              AA         => artDem Masc Sg ANomAcc ++ "mai" ++ adj.s ! AA 
                                                          
                              }
            }; isPre = False ; lock_A = <>} ;

mk5A : Str -> Str -> Str -> Str -> Str -> A ;
mk5A a b c d e = 
let adj = mkAdjSSpec a b c d e in
{s = table { Posit  => adj.s ;
             Compar => \\f => "mai" ++ (adj.s ! f) ++ "decât";
             Superl => table {AF g n a c => artDem g n c ++ "mai" ++ adj.s ! (AF g n Indef c);
                              AA         => artDem Masc Sg ANomAcc ++ "mai" ++ adj.s ! AA 
                                                          
                              }
            }; isPre = False ; lock_A = <>} ;

regA : Str -> A = \auriu ->  let adj = mkAdjReg auriu in
                             {s = table {Posit  => adj.s ;
                                         Compar => \\f => "mai" ++  (adj.s ! f) ++ "decât";
                                         Superl => table {AF g n a c => artDem g n c ++ "mai" ++ adj.s ! (AF g n Indef c);
                                                          AA         => artDem Masc Sg ANomAcc ++ "mai" ++ adj.s ! AA 
                                                          } 
                             }; isPre = False ; lock_A = <> } ;
                             
invarA : Str -> A = \auriu -> 
let adj =mkAdjInvar auriu in
{s = table { Posit  => adj.s ;
             Compar => \\f => "mai" ++ (adj.s ! f) ++ "decât";
             Superl => table {AF g n a c => artDem g n c ++ "mai" ++ adj.s ! (AF g n Indef c);
                              AA         => artDem Masc Sg ANomAcc ++ "mai" ++ adj.s ! AA 
                                                          
                              }
            }; isPre = False ; lock_A = <>} ;

mkRMut : Str -> A = \auriu ->
let adj = mkRegMut auriu in
{s = table { Posit  => adj.s ;
             Compar => \\f => "mai" ++ (adj.s ! f) ++ "decât";
             Superl => table {AF g n a c => artDem g n c ++ "mai" ++ adj.s ! (AF g n Indef c);
                              AA         => artDem Masc Sg ANomAcc ++ "mai" ++ adj.s ! AA 
                                                          
                              }
            }; isPre = False ; lock_A = <>} ;
       
mkSMut : Str -> A = \auriu ->
let adj = mkSpecMut auriu in
{s = table { Posit  => adj.s ;
             Compar => \\f => "mai" ++ (adj.s ! f) ++ "decât";
             Superl => table {AF g n a c => artDem g n c ++ "mai" ++ adj.s ! (AF g n Indef c);
                              AA         => artDem Masc Sg ANomAcc ++ "mai" ++ adj.s ! AA 
                                                          
                              }
            }; isPre = False ; lock_A = <>} ;    
            
 mkADeg : A -> A -> A ;
 noComp : A -> A ;


  prefA : A -> A ;

mkADeg a b = 
    {s = table {Posit => a.s ! Posit ; _ => b.s ! Posit} ; isPre = a.isPre ; lock_A = <>} ;

noComp a = 
    {s = \\_ => a.s ! Posit ;
     isPre = a.isPre ;
     lock_A = <>} ;
  
prefA a = {s = a.s ; isPre = True ; lock_A = <>} ;

--Adverbs :
         
    mkAdv : Str -> Adv ;
    mkAdV : Str -> AdV ;
    mkAdA : Str -> AdA ;      

  mkAdv x = ss x ** {lock_Adv = <>} ;
  mkAdV x = ss x ** {lock_AdV = <>} ;
  mkAdA x = ss x ** {lock_AdA = <>} ;


--Verbs :

oper regV : Str -> Verbe = \s ->
case s of 
{ x + ("chea"|"ghea") => mkV61 s ;
  x + "ea" => mkV69 s ;
  x + "ca" => mkV8 s ;
  x + "ga" => mkV9 s ;
  x + "eia" => mkV11 s;
  x + "ia"  => mkV10 s;
  x + "a"   => mkV6 s ;
  x + "e"   => mkV79 s ;
  x + "ui"  => mkV121 s ;
  x + "ii"  => mkV120 s ;
  x + "i"   => mkV119 s ;
  x + "î"   => mkV141 s
};

oper mkV : Str -> V = \s -> mkNV (regV s) ; 



  mkV2S : V -> Prep -> V2S ;
--  mkVV  : V -> VV ;  
  mkV2V : V -> Prep -> Prep -> V2V ;
  mkVA  : V -> VA ;
  mkV2A : V -> Prep -> Prep -> V2A ;
  mkVQ  : V -> VQ ;
  mkV2Q : V -> Prep -> V2Q ;

  mkAS  : A -> AS ;
  mkA2S : A -> Prep -> A2S ;
  mkAV  : A -> Prep -> AV ;
  mkA2V : A -> Prep -> Prep -> A2V ;


  mmkV3 : V -> Prep -> Prep -> V3;
  mmkV3 v p q = v ** {c2 = p ; c3 = q ; lock_V3 = <>} ;
  
  dirV3 : V -> V3 ;
  dirV3 v = mmkV3 v (noPrep Ac) (noPrep Da) ;

  mkV3 = overload {
    mkV3 : V -> V3 = dirV3 ;          
    mkV3 : V -> Prep -> Prep -> V3 = mmkV3    
    } ;

  V0 : Type = V ;
  AS, AV : Type = A ;
  A2S, A2V : Type = A2 ;
  mkV0 : V -> V0 ;
  mkV0  v = v ** {lock_V0 = <>} ;

  mmkV2 : V -> Prep -> V2 ;
  mmkV2 v p = v ** {c2 = p ; lock_V2 = <>} ;

  dirV2 : V -> V2 ;
  dirV2 v = mmkV2 v (noPrep Ac) ;
   
  mmkV3 : V -> Prep -> Prep -> V3 ;
  mmkV3 v p q = v ** {c2 = p ; c3 = q ; lock_V3 = <>} ;
  
  mkVS : V -> VS ;
  mkVS  v = v ** {m = \\_ => Indic ; lock_VS = <>} ;  
  mkV2S v p = mmkV2 v p ** {mn,mp = Indic ; lock_V2S = <>} ;
--  mkVV  v = v ** {c2 = complAcc ; lock_VV = <>} ;
--  deVV  v = v ** {c2 = complGen ; lock_VV = <>} ;
--aVV  v = v ** {c2 = complDat ; lock_VV = <>} ;
  mkV2V v p q = mmkV3 v p q ** {lock_V2V = <>} ;
  mkVA  v = v ** {lock_VA = <>} ;
  mkV2A v p q = mmkV3 v p q ** {lock_V2A = <>} ;
   mkVQ : V -> VQ ;
   mkVQ  v = v ** {lock_VQ = <>} ;
   mkV2Q : V -> Prep -> V2Q ;
   mkV2Q v p = mmkV2 v p ** {lock_V2Q = <>} ;

  mkAS  v = v ** {lock_AS = <>} ; ---- more moods
  mkA2S v p = mkA2 v p ** {lock_A2S = <>} ;
  mkAV  v p = v ** {c = p.p1 ; s2 = p.p2 ; lock_AV = <>} ;
  mkA2V v p q = mkA2 v p ** {s3 = q.p2 ; c3 = q.p1 ; lock_A2V = <>} ;



 
mkOrd : A -> Ord ;
mkOrd a = {s = a.s ! Posit ; isPre = a.isPre ; lock_Ord = <>} ;



--mkComp a = 
--let adj = a.s ! Posit in
--{ s = table {Posit  => adj ;
--             Compar => \\f => "mai" ++ adj ! f ++ "decât";
--             Superl => table {AF g n a c => (artDem g n c) ++ "mai" ++ adj ! (AF g n a c);
--                              AA         => "cel"++"mai" ++ adj ! AA
--                              }  
--            };
--              isPre = a.isPre ;
--              lock_A = <>
-- };          
 
     
  



} ;
