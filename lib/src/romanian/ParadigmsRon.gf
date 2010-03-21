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

  flags optimize=all ; coding = utf8 ;

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
 mkPrep : overload {   
  mkPrep : Str -> NCase-> Bool -> Prep ;
  mkPrep : Str -> NCase -> Prep; 
 };
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
    mkPN : Str -> Str -> Gender -> Number -> PN = mkPropNI ;
    mkPN : Str -> Gender -> PN = mkPropNoun ;
    mkPN : Str -> Gender -> Number -> PN = mkProperNoun;  
   } ;

mkInAn : PN -> PN = \romania ->
   {s = table {No | Ac | Vo => romania.s ! No ;
               _ => case romania.g of
                       { Fem => romania.s ! Ge ;
                         Masc => romania.s ! No + "ului" }
              };
    g = romania.g; n = romania.n;
    a = Inanimate;
    lock_PN = <>
    };

mkPropNI : Str -> Str -> Gender -> Number -> PN =
\romania, romaniei,g,n ->
{s = table {Ge | Da => romaniei;
            _       => romania  };
g = g; n = n;
a = Inanimate;
lock_PN = <>
};
mkPropN : Str -> PN = \Ion ->
case last Ion of
{ "a" => mkPropNoun Ion Feminine ;
   _  => mkPropNoun Ion Masculine
};

mkPropNoun : Str -> Gender -> PN = \Ion, gen ->
 mkProperNoun Ion gen singular ;

mkProperNoun : Str -> Gender -> Number -> PN = \Ion, gen, num ->
{s = table {No => Ion;
            Ac => Ion;
            Ge => case <last Ion,gen> of
                      { <"a",Fem> => init Ion + "ei" ;
                        _         => "lui" ++ Ion
                      };
            Da => case <last Ion,gen> of
                      { <"a",Fem> => init Ion + "ei" ;
                        _         => "lui" ++ Ion
                      };
            Vo => Ion            
            };
g = gen ;
n = num ; a = Animate;
lock_PN = <>
};




--3 Two-place adjectives
--
-- Two-place adjectives need a preposition for their second argument.

 mkA2 : A -> Prep -> A2 ;
 mkA2 a p = a ** {c2 = p ; lock_A2 = <>} ;

--.
--2 Definitions of the paradigms



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

mkPrep = overload {
mkPrep : Str -> NCase-> Bool -> Prep = mkPreposition;
mkPrep : Str -> NCase -> Prep = mkPrepos; 
};
  mkPreposition : Str -> NCase-> Bool -> Prep ;
  mkPreposition ss cc b = {s = ss ; c = cc; isDir = NoDir; needIndef = b; prepDir = ""; lock_Prep = <>} ;
  
  mkPrepos : Str -> NCase -> Prep ;
  mkPrepos ss cc = mkPreposition ss cc False;

  noPrep cc = case cc of 
                      {Ac  => {s = []; c = Ac ; isDir = Dir PAcc; needIndef = True; prepDir = "pe"; lock_Prep = <>};
                       Da  => {s = []; c = Da ; isDir = Dir PDat; needIndef = False; prepDir = "" ; lock_Prep = <>};
                       _  => mkPreposition [] cc False 
                       } ;
  
compN : N -> Str -> N ;
compN x y = composeN x y ** {lock_N = <>} ;

ccompN : N -> Str -> N ;
ccompN x y = ccompose x y ** {lock_N = <>} ;

mkNI : Str -> Str -> NGender -> N;
mkNI s ss g = mkInanimate (mkNomIrreg s ss g) ** {lock_N = <>}; 
             
regN : Str -> NGender -> N ;
regN s g = mkInanimate (mkNomReg s g) ** {lock_N = <>};
             

mkVI : Str -> Str -> Str -> N;
mkVI s ss sss = mkInanimate (mkNomVIrreg s ss sss) ** {lock_N = <>};

mkIn : N -> N ;
mkIn n = mkInanimate n ** {lock_N = <>};

mkAnim : N -> N ;
mkAnim n = mkAnimate n ** {lock_N = <>}; 

chV : Str -> N -> N ;
chV s n = mkVocc n s ** {lock_N = <>};


--smart paradigm for inferring the gender of the nouns
--partly based on the paper 
--"COVERT SEMANTIC AND MORPHOPHONEMIC CATEGORIES IN THE ROMANIAN GENDER SYSTEM"
-- by Jan Louis Perkowski, Emil Vrabie

mkSPN : Str -> N ;
mkSPN s = case s of 
   { x + ("ă"|"e"|"a") => regN s feminine ;
     x + ("el"|"mp"|"mb"|"en"|"id"|"at"|"ete"|"ol"|"et"|"or") => regN s masculine ;
     _  => regN s neuter  
    };

mkNN : Str -> Str -> N ;
mkNN s ss = case s of 
     { x + ("ă"|"e"|"a") => mkNI s ss feminine ;
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
mkNR s = mkInanimate (mkNomNeut s) ** {lock_N = <>} ;

--------------------------------------------------------------------

mkA = overload {
   mkA : Str -> Str -> Str -> Str -> Str -> A = mk5A ;--worst case -- all 4 forms are needed + form for adverb
   mkA : Str -> Str -> Str -> Str -> A = mk4A; -- 4 forms are needed
   mkA : Str -> A = regA; -- regular adjectives
};

mk4A : Str -> Str -> Str -> Str -> A;
mk4A a b c d =  
let adj = mkAdjSpec a b c d in
{s =  adj.s ;
 isPre = False ; lock_A = <>} ;

mk5A : Str -> Str -> Str -> Str -> Str -> A ;
mk5A a b c d e = 
let adj = mkAdjSSpec a b c d e in
{s =  adj.s ;
 isPre = False ; lock_A = <>} ;

regA : Str -> A = \auriu ->  let adj = mkAdjReg auriu in
                             {s = adj.s ;
                              isPre = False ; lock_A = <> } ;
                             
invarA : Str -> A = \auriu -> 
let adj =mkAdjInvar auriu in
{s = adj.s ;
 isPre = False ; lock_A = <>} ;

mkRMut : Str -> A = \auriu ->
let adj = mkRegMut auriu in
{s = adj.s ;
 isPre = False ; lock_A = <>} ;
       
mkSMut : Str -> A = \auriu ->
let adj = mkSpecMut auriu in
{s = adj.s ;
 isPre = False ; lock_A = <>} ;    
            
 mkADeg : A -> A -> A ;
 noComp : A -> A ;


  prefA : A -> A ;

mkADeg a b = 
    {s = a.s ; isPre = a.isPre ; lock_A = <>} ;

noComp a = 
    {s =  a.s ;
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
    mkV3 : V -> Prep -> Prep ->  V3 = mmkV3    
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
  
  mkVS : V -> VS ;
  mkVS  v = v ** {m = \\_ => Indic ; lock_VS = <>} ;  
  mkV2S v p = v ** {c2 = p ; mn,mp = Indic ; lock_V2S = <>} ;
  mkVV : V -> VV ;
  mkVV  v = v ** {c2 = \\_ => "" ;  lock_VV = <>} ;
  mkV2V v p q = v ** {c2 = p; c3 = q; lock_V2V = <>} ;
  mkVA  v = v ** {lock_VA = <>} ;
  mkV2A v p q = v ** {c2 = p; c3 = q; lock_V2A = <>} ;
   mkVQ : V -> VQ ;
   mkVQ  v = v ** {lock_VQ = <>} ;
   mkV2Q : V -> Prep -> V2Q ;
   mkV2Q v p =  v ** {c2 = p ; lock_V2Q = <>} ;

  mkAS  v = v ** {lock_AS = <>} ; ---- more moods
  mkA2S v p = mkA2 v p ** {lock_A2S = <>} ;
  mkAV  v p = v ** {c = p.p1 ; s2 = p.p2 ; lock_AV = <>} ;
  mkA2V v p q = mkA2 v p ** {s3 = q.p2 ; c3 = q.p1 ; lock_A2V = <>} ;



 
mkOrd : A -> Ord ;
mkOrd a = {s = \\n,g,c => a.s ! AF g n Indef (convCase c)  ; isPre = a.isPre ; lock_Ord = <>} ;



mkDet = overload {
    mkDet : (_,_,_,_ : Str) -> Number -> Det = mkDetS ;          
    mkDet : (_,_,_,_,_,_,_,_ : Str) -> Number -> Det = mkD    
    } ;

mkDetS : (_,_,_,_ : Str) -> Number -> Det =
 \orice, oricare,oricarui, oricarei,n ->
 {s,sp = table { Masc => table {Da | Ge => oricarui ;
                                _       => orice } ;
                 Fem  => table {Da | Ge => oricarei ;
                                _       => oricare }
               };
 post = \\g,c => ""; size = "";
 n = n; isDef = False ; hasRef = False;
lock_Det = <>
};

mkD : (_,_,_,_,_,_,_,_ : Str) -> Number -> Det =
\multi, multe, multor, multorf,multiS,multeS, multora, multoraF, n ->
 { s = table { Masc => table {Da | Ge => multor ;
                                _     => multi } ;
               Fem  => table {Da | Ge => multorf ;
                                _     => multe }
               };
   sp = table  { Masc => table {Da | Ge => multora ;
                                _       => multiS } ;
                 Fem  => table {Da | Ge => multoraF ;
                                _       => multeS }
               };
post = \\g,c => ""; size = "";
  n = n; isDef = False ; hasRef = False;
lock_Det = <> 
};

mkNP = overload {
    mkNP : (_,_ : Str) -> Number -> Gender -> Bool -> NP = mkNPs ;          
    mkNP : (_,_,_ : Str) -> Number -> Gender -> Bool -> NP = mkNPa ;    
    mkNP : (_,_,_ : Str) -> Number -> Gender -> NP = mkNPspec
    } ;

mkNPspec : Str -> Str -> Str -> Number -> Gender -> NP = 
\cineva,cuiva,cinev, n, g -> let ag = agrP3 g n in
{ s = \\c => case c of
        {Da => {clit = \\cs => ((genCliticsCase ag Da).s ! cs) ;
                comp = cuiva
                };
         Ge => {clit = \\cs => [] ;
                comp = cuiva};
         Vo => {clit = \\cs => [] ;
                comp = cinev 
                };
         _  => {clit = \\cs => ((genCliticsCase ag c).s ! cs) ;
                comp = cineva
                }      
         };
a = ag ;
indForm = cineva ;
nForm = HasClit ;
isPronoun = False ;
lock_NP = <>
} ;

mkNPs : Str -> Str -> Number -> Gender -> Bool -> NP = 
\cineva, cuiva, n, g, b -> let ag = agrP3 g n in
{s = \\c => case c of
           {Da | Ge => {clit = \\cs => [] ;
                   comp = cuiva
                  };   
            _  => {clit = \\cs => [];
                   comp = cineva}
            };
 a = ag ;
 indForm = cineva ;
 isPronoun = False ;
 nForm = HasRef b ;
lock_NP = <>
};

mkNPa : Str -> Str -> Str -> Number -> Gender -> Bool -> NP =
\om,omului,omule, n, g, b -> let ag = agrP3 g n 
 in
{s = \\c => case c of 
           {Da | Ge => {clit = \\cs => [] ;
                   comp = omului
                   }; 
            Vo => {clit = \\_ => [];
                   comp = omule};
            _  => {clit = \\cs => [] ;
                   comp = om}
            };
 a = ag;
 nForm = HasRef b;
 isPronoun = False ;
 indForm = om ;
lock_NP = <>
};
mkPronoun :(_,_,_,_,_,_,_,_,_ : Str) -> Gender -> Number -> Person -> Pron =\eu, mine, mie, meu, euV, meuP, mea, mei, mele,g, n, p -> 
        {s = table
              {No => eu ; 
               Ac =>  mine ;  
               Da =>  mie ; 
               Ge =>  meu;  
               Vo =>  euV  
               } ; 
         c1 = \\c => (cliticsAc g n p).s ! c ; c2 = \\c => (cliticsDa g n p).s ! c ;
         a = {g = g ; n = n ; p = p} ;
         poss = table {Sg => table {Masc => meuP ; Fem => mea};
                       Pl => table {Masc => mei ; Fem => mele}
                      }; 
         lock_Pron = <>};




-- fix for Genitive, person 1 - 2
-- only problem is for genitive case demanded by prepositions (ex : beyond me), otherwise the possesive adjective is used. 
-- in this case we add a case to the complement, so that the right gender is chosen.
 



} ;
