--# -path=.:../abstract:../../prelude:../common

--1 Russian Lexical Paradigms
--
-- Janna Khegai 2003--2006
--
-- This is an API for the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The main difference with $MorphoRus.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, rather
-- than stems, as string arguments of the paradigms.
--
-- The structure of functions for each word class $C$ is the following:
-- first we give a handful of patterns that aim to cover all
-- regular cases. Then we give a worst-case function $mkC$, which serves as an
-- escape to construct the most irregular words of type $C$.
-- 
-- The following modules are presupposed:

resource ParadigmsRus = open 
  Prelude, 
  MorphoRus,
  CatRus,
  NounRus
  in {

flags  coding=utf8 ;

--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  Gender : Type ;
  masculine : Gender ;
  feminine  : Gender ;
  neuter    : Gender ;

-- To abstract over case names, we define the following.
  Case : Type ;

  nominative    : Case ;
  genitive      : Case ;
  dative        : Case ;
  accusative    : Case ; 
  instructive   : Case ;
  prepositional : Case ;

-- In some (written in English) textbooks accusative case 
-- is put on the second place. However, we follow the case order 
-- standard for Russian textbooks.

-- To abstract over number names, we define the following.
  Number : Type ;

  singular : Number ;
  plural   : Number ;

--2 Nouns

  Animacy: Type ; 
  
  animate: Animacy;
  inanimate: Animacy; 

-- Indeclinabe nouns: "кофе", "пальто", "ВУЗ".
 
  mkIndeclinableNoun: Str -> Gender -> Animacy -> N ; 

  mkNAltPl: Str -> Str -> Gender -> Animacy -> N ; 

  mkN : overload {

-- The regular function captures the variants for some common noun endings.

    mkN : (karta : Str) -> N ;
    mkN : (tigr : Str) -> Animacy -> N ;

-- Worst case - give six singular forms:
-- Nominative, Genetive, Dative, Accusative, Instructive and Prepositional;
-- and the prepositional form after в and на, and
-- the corresponding six plural forms and the gender and animacy.

    mkN : (nomSg, genSg, datSg, accSg, instSg, preposSg, prepos2Sg, nomPl, genPl, datPl, accPl, instPl, preposPl : Str) -> Gender -> Animacy -> N
  } ;

  mkN2 : overload {

-- Genitive with no preposition.

    mkN2 : N -> N2 ;
    mkN2 : N -> Prep -> N2 ;
  } ;


  mkN3 : N -> Prep -> Prep -> N3 ;

-- Proper names.

  mkPN  : Str -> Gender -> Number -> Animacy -> PN ;          -- "Иван", "Маша"
  nounPN : N -> PN ;
  

--2 Adjectives

-- Non-comparison (only positive degree) one-place adjectives need 28 (4 by 7)
-- forms in the worst case:


--  (Masculine  | Feminine | Neutral | Plural) *

--  (Nominative | Genitive | Dative | Accusative Inanimate | Accusative Animate |
--  Instructive | Prepositional)


-- Notice that 4 short forms, which exist for some adjectives are not included 
-- in the current description, otherwise there would be 32 forms for 
-- positive degree.

   mkA : overload {

-- Regular and invariant adjectives with regular comparative.

     mkA : (positive : Str) -> A ;

-- Adjectives with irregular comparative.

     mkA : (positive, comparative : Str) -> A ;

  } ;

-- Two-place adjectives need a preposition and a case as extra arguments.

   mkA2 : A -> Str -> Case -> A2 ;  -- "делим на"

-- Comparison adjectives need a positive adjective 
-- (28 forms without short forms). 
-- Taking only one comparative form (non-syntactic) and 
-- only one superlative form (syntactic) we can produce the
-- comparison adjective with only one extra argument -
-- non-syntactic comparative form.
-- Syntactic forms are based on the positive forms.


--   mkADeg : A -> Str -> ADeg ;

-- On top level, there are adjectival phrases. The most common case is
-- just to use a one-place adjective. 
--   ap : A  -> IsPostfixAdj -> AP ;

--2 Adverbs

-- Adverbs are not inflected.

  mkAdv : Str -> Adv ;

--2 Prepositions
  mkPrep : Str -> Case -> Prep ; -- as in German

--2 Verbs
--
-- In our lexicon description ("Verbum") there are 62 forms: 
-- 2 (Voice) by { 1 (infinitive) + [2(number) by 3 (person)](imperative) + 
-- [ [2(Number) by 3(Person)](present) + [2(Number) by 3(Person)](future) + 
-- 4(GenNum)(past) ](indicative)+ 4 (GenNum) (subjunctive) } 
-- Participles (Present and Past) and Gerund forms are not included, 
-- since they fuction more like Adjectives and Adverbs correspondingly
-- rather than verbs. Aspect is regarded as an inherent parameter of a verb.
-- Notice, that some forms are never used for some verbs. 

Voice: Type; 
Aspect: Type; 
Bool: Type;
Conjugation: Type ;

first:   Conjugation; -- "гуля-Ешь, гуля-Ем"
firstE:  Conjugation; -- Verbs with vowel "ё": "даёшь" (give), "пьёшь" (drink)  
second:  Conjugation; -- "вид-Ишь, вид-Им"
mixed:   Conjugation; -- "хоч-Ешь - хот-Им"
dolzhen: Conjugation; -- irregular
foreign: Conjugation; -- foreign words which are used in Russian, +++ MG_UR: added +++


true:  Bool;
false: Bool;
 
active: Voice ;
passive: Voice ;
imperfective: Aspect;
perfective: Aspect ;  


-- The worst case need 6 forms of the present tense in indicative mood
-- ("я бегу", "ты бежишь", "он бежит", "мы бежим", "вы бежите", "они бегут"),
-- a past form (singular, masculine: "я бежал"), an imperative form 
-- (singular, second person: "беги"), an infinitive ("бежать").
-- Inherent aspect should also be specified.

--   mkVerbum : Aspect -> (presentSgP1,presentSgP2,presentSgP3,
   mkV : Aspect -> (presSg1,presSg2,presSg3,presPl1,presPl2,presPl3,pastSgMasc,imp,inf: Str) -> V ;

-- Common conjugation patterns are two conjugations: 
--  first - verbs ending with "-ать/-ять" and second - "-ить/-еть".
-- Instead of 6 present forms of the worst case, we only need
-- a present stem and one ending (singular, first person):
-- "я люб-лю", "я жд-у", etc. To determine where the border
-- between stem and ending lies it is sufficient to compare 
-- first person from with second person form:
-- "я люб-лю", "ты люб-ишь". Stems shoud be the same.
-- So the definition for verb "любить"  looks like:
-- regV Imperfective Second "люб" "лю" "любил" "люби" "любить";

   regV :Aspect -> Conjugation -> (stemPresSg1,endPresSg1,pastSg1,imp,inf : Str) -> V ; 


-- Two-place verbs, and the special case with direct object. Notice that
-- a particle can be included in a $V$.

   mkV2     : V   -> Str -> Case -> V2 ;   -- "войти в дом"; "в", accusative
   mkV3  : V -> Str -> Str -> Case -> Case -> V3 ; -- "сложить письмо в конверт"
   mkVS  : V -> VS ;
   mkVQ  : V -> VQ ;   
   mkV2V : V -> Str -> Case -> V2V ;
   mkV2S : V -> Str -> Case -> V2S ;
   mkV2Q : V -> Str -> Case -> V2Q ;
   mkV2A : V -> Str -> Case -> V2A ;

   dirV2    : V -> V2 ;                    -- "видеть", "любить"
   tvDirDir : V -> V3 ; 
                            
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.
--.
  Gender = MorphoRus.Gender ;
  Case = MorphoRus.Case ;
  Number = MorphoRus.Number ;
  Animacy = MorphoRus.Animacy;
  Aspect = MorphoRus.Aspect;
  Voice = MorphoRus.Voice ;
  --Tense = Tense ;
   Bool = Prelude.Bool ;
  Conjugation = MorphoRus.Conjugation;
first = First ;
firstE = FirstE ;
second = Second ;
secondA = SecondA ;
mixed = Mixed ;
dolzhen = Dolzhen; 
foreign = Foreign; -- +++ MG_UR: added +++

  true = True;
  false = False ;
  masculine = Masc ;
  feminine  = Fem ;
  neuter = Neut ;
  nominative = Nom ;
  accusative = Acc ;
  dative = Dat ;
  genitive = Gen ;
  instructive = Inst ;
  prepositional = Prepos PrepOther ; -- FIXME: not correct for v and na
  singular = Sg ;
  plural = Pl ;
  animate = Animate ;
  inanimate = Inanimate ;
  active = Act ;
  passive = Pass ; 
  imperfective = Imperfective ;
  perfective = Perfective ;
 -- present = Present ;
  --past = Past ;
  Degree     = Posit | Compar | Superl ;
              
 -- Person     = P1 | P2 | P3 ;
 -- AfterPrep  = Yes | No ; 
 -- Possessive = NonPoss | Poss GenNum ;

-- Noun definitions

 mkN = overload {
    mkN : (karta : Str) -> N = mk1N ;
    mkN : (tigr : Str) -> Animacy -> N = \nom, anim -> case anim of { Animate   => lin N (nAnimate (mk1N nom)) ;
								      Inanimate => mk1N nom } ;
    mkN : (nomSg, genSg, datSg, accSg, instSg, preposSg, prepos2Sg,
          nomPl, genPl, datPl, accPl, instPl, preposPl : Str) -> Gender -> Animacy -> N = mkWorstN
  } ;

  mkIndeclinableNoun = \s,g, anim ->
   {
     s = table { NF _ _ _ => s } ;
     g = g ;
     anim = anim 
   } ** {lock_N = <>};

  mkNAltPl = \s, alt, g, anim ->
    let {singular = mkN s ; plural = mkN alt} in {
    s = table { NF Sg c size   => singular.s ! NF Sg c size;
		NF Pl c nom    => singular.s ! NF Sg c nom;
		NF Pl c nompl  => plural.s ! NF Sg c nompl;
		NF Pl c sgg    => plural.s ! NF Sg c sgg;
		NF Pl c plg    => plural.s ! NF Pl c plg } ;
    g = g ;
    anim = anim 
    } ** {lock_N = <>};

  oper mkWorstN  : (nomSg, genSg, datSg, accSg, instSg, preposSg, prepos2Sg,
          nomPl, genPl, datPl, accPl, instPl, preposPl : Str) -> Gender -> Animacy -> N
    =  \nomSg, genSg, datSg, accSg, instSg, preposSg, prepos2Sg,
          nomPl, genPl, datPl, accPl, instPl, preposPl, g, anim ->
   {
     s = table { 
           NF Sg Nom _ => nomSg ;
           NF Sg Gen _ => genSg ;
           NF Sg Dat _ => datSg ;
           NF Sg Acc _ => accSg ;
           NF Sg Inst _ => instSg ;
           NF Sg (Prepos PrepOther) _ => preposSg ;
           NF Sg (Prepos PrepVNa) _ => prepos2Sg ;
           NF Pl Nom _ => nomPl ;
           NF Pl Gen _ => genPl ;
           NF Pl Dat _ => datPl ;
           NF Pl Acc _ => accPl ;
           NF Pl Inst _ => instPl ;
           NF Pl (Prepos _) _ => preposPl
     } ;                           
     g = g ;
     anim = anim
   } ** {lock_N = <>} ;

  oper mk1N : Str -> N = \x ->
        case x of {
	  stem+"онок" => nDecl10Hard stem ;
	  stem+"ёнок" => nDecl10Soft stem ;
--        stem+"aнин" => nDecl11 stem ;
          stem@(_+"и")+"й"   => nDecl7Masc stem;
          stem@(_+"и")+"я"   => nDecl7Fem stem;
	  stem@(_+"и")+"е"   => nDecl7Neut stem;
	  stem+"ее"   => nAdj { s = (mk1A (stem+"ий")).s!Posit } Neut;
	  stem+"ое"   => nAdj { s = (mk1A (stem+(iAfter stem)+"й")).s!Posit } Neut;
          stem+"мя"   => nDecl9 stem ;
          stem@(_+("а"|"е"|"ё"|"о"|"у"|"ы"|"э"|"ю"|"я"))+"й" => nDecl6Masc stem ;
          stem@(_+("а"|"е"|"ё"|"о"|"у"|"ы"|"э"|"ю"|"я"))+"е" => nDecl6Neut stem ;
          stem@(_+("а"|"е"|"ё"|"о"|"у"|"ы"|"э"|"ю"|"я"))+"я" => nDecl6Fem stem ;
          stem@(_+("ч"|"щ"|"ш"|"ж"|"п"|"эн"|"м"|"ф"))+"ь" => nDecl8 stem ;
          stem@(_+("д"|"т"|"ст"|"с"|"в"|"б"))+"ь"         => nDecl8 stem ;
	  stem@(_+"ш"|"ж"|"ч"|"щ"|"ц")+"е" => nRegHardNeut stem;
          stem+"е"                         => nRegSoftNeut stem ;
          stem+"я"                         => nRegSoftFem stem ;
          stem+"ь"                         => nRegSoftMasc stem ;
          stem+"о"                         => nRegHardNeut stem ; 
          stem+"а"                         => nRegHardFem stem ; 
          stem                             => nRegHardMasc stem
         } ** {lock_N = <>} ;



-- An individual-valued function is a common noun together with the
-- preposition prefixed to its argument ("клZ+ о' дома").
-- The situation is analogous to two-place adjectives and transitive verbs.
--
-- We allow the genitive construction to be used as a variant of
-- all function applications. It would definitely be too restrictive only
-- to allow it when the required case is genitive. We don't know if there
-- are counterexamples to the liberal choice we've made.

  oper mkN2 = overload {
    mkN2 : N -> N2 = \n -> mkFun n nullPrep ;
    mkN2 : N -> Prep -> N2 = mkFun;
  } ;

  mkFun : N -> Prep -> N2 = \f,p -> f ** {c2 = p ; lock_N2 = <>} ;

  nullPrep : Prep = {s = []; c= Gen; lock_Prep=<>} ;  

  mkN3 f p2 p3 = f ** {c2 = p2; c3 = p3; lock_N3 = <>} ; 


  -- mkPN = \ivan, g, n, anim -> 
  --   case n of {
  --     Sg => case g of { 
  -- 	Masc => mkProperNameMasc ivan anim ; 
  -- 	Fem  => mkProperNameFem ivan anim ;
  -- 	_ => mkProperNameMasc ivan anim
  -- 	} ;
  --     Pl => mkProperNamePl ivan anim
  --   } ** {lock_PN =<>};

  mkPN ivan g n anim = nounPN (mk1N ivan);

  nounPN n = {s=\\c => n.s! NF Sg c nom; anim=n.anim; g=n.g; lock_PN=<>};
    
-- On the top level, it is maybe $CN$ that is used rather than $N$, and
-- $NP$ rather than $PN$.

  makeCN  : N -> CN ;
  makeNP  : Str -> Gender -> Animacy -> NP ;


  makeCN = UseN;

  makeNP = \x,y,z -> UsePN (mkPN x y singular z) ;

   mkA = overload {
     mkA : (positive : Str) -> A = mk1A ;
     mkA : (positive : Str) -> AdjType -> A = mk1Ab ;
     mkA : (positive, shortMasc, shortFem, shortNeut, shortPl : Str) -> A = mk3A ;  -- to make correct short forms (Liza Zimina 04/2018)
     mkA : (positive, comparative : Str) -> A = mk2A ;
     mkA : (positive : Str) -> ShortFormPreference -> A  = mk4A ; -- adjectives preferring full forms in conjunction 
                                                                  -- (e.g. "он классический и элегантный" vs "он классический и элегантен") Liza Zimina 04/2018
     mkA : (positive : Str) -> Bool -> A  = mk5A ; -- postfix adjectives (e.g. "цвета кости") Liza Zimina 04/2018
  } ;

  mk1A : Str -> A = \positive -> 
    let stem = Predef.tk 2 positive in mk2A positive (stem+"ее") ;

  mk2A : Str -> Str -> A = \positive, comparative -> 
    case positive of {
      stem+"ый"                        => mkAdjDeg (aRegHard StemStress Qual stem) comparative ;
      stem+"ой"                        => mkAdjDeg (aRegHard EndStress Qual stem) comparative ;
      stem@(_+("г"|"к"|"х"))+"ий"       => mkAdjDeg (aRegHard StemStress Qual stem) comparative;
      stem@(_+("ш"|"ж"|"ч"|"щ"))+"ий" => mkAdjDeg (aRegHard StemStress Qual stem) comparative;
      stem+"ий"                        => mkAdjDeg (aRegSoft Qual stem) comparative ;
      stem                             => mkAdjDeg (adjInvar stem) comparative
    } ;
    
  mk1Ab : Str -> AdjType -> A = \positive, at -> 
    let { stem = Predef.tk 2 positive;
	  comparative = stem + "ее"
	  } in case positive of {
      stem+"ый"                        => mkAdjDeg (aRegHard StemStress at stem) comparative ;
      stem+"ой"                        => mkAdjDeg (aRegHard EndStress at stem) comparative ;
      stem@(_+("г"|"к"|"х"))+"ий"       => mkAdjDeg (aRegHard StemStress at stem) comparative;
      stem@(_+("ш"|"ж"|"ч"|"щ"))+"ий" => mkAdjDeg (aRegHard StemStress at stem) comparative;
      stem+"ий"                        => mkAdjDeg (aRegSoft at stem) comparative ;
      stem                             => mkAdjDeg (adjInvar stem) comparative
    } ;


  -- khaki, mini, hindi, netto
  adjInvar : Str -> Adjective = \stem -> { s = \\_ => stem } ;

  oper mkAdjDeg: Adjective -> Str -> A = \adj, s ->
   {s = table
           {
              Posit => adj.s ;
              Compar => \\af => s ;
              Superl => \\af =>  samuj.s !af ++ adj.s ! af
           } ;
    p = False ;
    preferShort = PrefShort
  } ** {lock_A = <>};
  
  oper mkAdjDegFull: Adjective -> Str -> ShortFormPreference -> A = \adj, s,sfp ->
   {s = table
           {
              Posit => adj.s ;
              Compar => \\af => s ;
              Superl => \\af =>  samuj.s !af ++ adj.s ! af
           } ;
    p = False ;
    preferShort = sfp
  } ** {lock_A = <>};


  oper mkParticiple : Voice -> VTense -> V -> A = \voice, tense, v ->
	 let vstem = verbStem v in
	 let actpres = verbHasEnding v in
	 let actpast = stemHasEnding vstem in
	 let passpast = case hasConj v of {
	       (First|FirstE) => "ем" ;
	       (Second|SecondA) => "им" ;
	       _ => "ем"
	       } in
	 case <voice, tense> of {
	   <Act, VPresent _> => mkA (vstem + actpres + "ий") ;
	   <Act, VPast> => mkA (vstem + actpast + "ий") ;
	   <Pass, VPresent _> => mkA (vstem + "нный") ;
	   <Pass, VPast> => mkA (vstem + passpast + "ый") ;
	   _ => mkA "" -- Russian participles do not have a future tense
	 } ;

  oper mkActPresParticiple : V -> A = mkParticiple Act (VPresent P3) ;
  oper mkActPastParticiple : V -> A = mkParticiple Act (VPresent P3) ;
  oper mkPassPresParticiple : V -> A = mkParticiple Pass VPast ;
  oper mkPassPastParticiple : V -> A = mkParticiple Pass VPast ;

  oper mkGerund : VTense -> V -> Adv = \tense, v ->
	 let vstem = verbStem v in
	 let suffix = case hasConj v of {
	       SecondA => "а" ;
	       _ => "я"
	       } in
	 case tense of {
	   VPresent _ => mkAdv (vstem + suffix) ;
	   VPast => mkAdv (vstem + "в") ;
	   _ => mkAdv "" -- Russian gerunds do not have a future tense
	 } ;

  mkA2 a p c=  a ** {c2 = {s=p; c=c}; lock_A2 = <>};
--  mkADeg a s = mkAdjDeg a s ** {lock_ADeg = <>}; -- defined in morpho.RusU

--  ap a p = mkAdjPhrase a p ** {lock_AP = <>};  -- defined in syntax module

  mkAdv x = ss x ** {lock_Adv = <>} ;

-- Prepositions definitions
  mkPrep s c = {s = s ; c = c ; lock_Prep = <>} ;

-- Verb definitions 

--   mkVerbum = \asp, sgP1, sgP2, sgP3, plP1, plP2, plP3, 
   mkV = \asp, sgP1, sgP2, sgP3, plP1, plP2, plP3, 
     sgMascPast, imperSgP2, inf -> case asp of { 
       Perfective  =>  
         mkVerbPerfective inf imperSgP2 
         (presentConj sgP1 sgP2 sgP3 plP1 plP2 plP3) (pastConj sgMascPast)
         ** {    lock_V=<> };
       Imperfective  =>  
         mkVerbImperfective inf imperSgP2 
         (presentConj sgP1 sgP2 sgP3 plP1 plP2 plP3) (pastConj sgMascPast)
         ** {    lock_V=<> }
        }; 

   oper presentConj: (_,_,_,_,_,_: Str) -> PresentVerb = 
     \sgP1, sgP2, sgP3, plP1, plP2, plP3 ->
     table {
       PRF (GSg _) P1 => sgP1 ;
       PRF (GSg _) P2 => sgP2 ;
       PRF (GSg _) P3 => sgP3 ;
       PRF APl P1 => plP1 ;
       PRF APl P2 => plP2 ;
       PRF APl P3 => plP3   
     };

    regV a b c d e f g = verbDecl a b c d e f g ** {lock_V = <>} ;
   -- defined in morpho.RusU.gf
{-
   mkV a b = extVerb a b ** {lock_V = <>};                         -- defined in types.RusU.gf

   mkPresentV = \aller, vox -> 
    { s = table { 
       VFin gn p => aller.s ! VFORM vox (VIND (VPresent (numGNum gn) p)) ;
       VImper n p => aller.s ! VFORM vox (VIMP n p) ;
       VInf => aller.s ! VFORM vox VINF ;
       VSubj gn => aller.s ! VFORM vox (VSUB gn)
       }; t = Present ; a = aller.asp ; w = vox ; lock_V = <>} ;
-}
   mkV2 v p cas = v ** {c2 = {s=p; c=cas}; lock_V2 = <>}; 
   dirV2 v = mkV2 v [] Acc;


   tvDirDir v = mkV3 v "" "" Acc Dat; 

-- *Ditransitive verbs* are verbs with three argument places.
-- We treat so far only the rule in which the ditransitive
-- verb takes both complements to form a verb phrase.

   mkV3 v s1 s2 c1 c2 = v ** {c2 = {s=s1; c=c1}; c3={s=s2; c=c2}; lock_V3 = <>};  

   mkVS v = v ** {lock_VS = <>} ;
   mkVQ v = v ** {lock_VQ = <>} ;
   mkV2V v p cas = v ** {c2 = {s=p; c=cas}; lock_V2V = <>};
   mkV2S v p cas = v ** {c2 = {s=p; c=cas}; lock_V2S = <>};
   mkV2Q v p cas = v ** {c2 = {s=p; c=cas}; lock_V2Q = <>};
   mkV2A v p cas = v ** {c2 = {s=p; c=cas}; lock_V2A = <>};
  
-- Liza Zimina 04/2018: to make correct short forms of adjectives

  mk3A : Str -> Str -> Str -> Str -> Str -> A = \positive,shortMasc,shortFem,shortNeut,shortPl  -> 
    let {koren = Predef.tk 2 positive ;
         comparative = koren + "ее"} in  
    case positive of {
      stem+"ый"                        => mkAdjDeg (aRegHardWorstCase StemStress Qual stem shortMasc shortFem shortNeut shortPl) comparative ;
      stem+"ой"                        => mkAdjDeg (aRegHardWorstCase EndStress Qual stem shortMasc shortFem shortNeut shortPl) comparative ;
      stem@(_+("г"|"к"|"х"))+"ий"       => mkAdjDeg (aRegHardWorstCase StemStress Qual stem shortMasc shortFem shortNeut shortPl) comparative;
      stem@(_+("ш"|"ж"|"ч"|"щ"))+"ий" => mkAdjDeg (aRegHardWorstCase StemStress Qual stem shortMasc shortFem shortNeut shortPl) comparative;
      stem+"ий"                        => mkAdjDeg (aRegSoftWorstCase Qual stem shortMasc shortFem shortNeut shortPl) comparative ;
      stem                             => mkAdjDeg (adjInvar stem) comparative
    } ;
    
  mk4A : Str -> ShortFormPreference -> A = \positive,prefshort -> 
    let {koren = Predef.tk 2 positive ;
         comparative = koren + "ее"} in 
    case positive of {
      stem+"ый"                        => mkAdjDegFull (aRegHardFull StemStress Qual stem) comparative prefshort ;
      stem+"ой"                        => mkAdjDegFull (aRegHardFull EndStress Qual stem) comparative prefshort ;
      stem@(_+("г"|"к"|"х"))+"ий"       => mkAdjDegFull (aRegHardFull StemStress Qual stem) comparative prefshort ;
      stem@(_+("ш"|"ж"|"ч"|"щ"))+"ий" => mkAdjDegFull (aRegHardFull StemStress Qual stem) comparative prefshort ;
      stem+"ий"                        => mkAdjDegFull (aRegSoftFull Qual stem) comparative prefshort ;
      stem                             => mkAdjDegFull (adjInvar stem) comparative prefshort
    } ;
  
  mk5A : Str -> Bool -> A = \adj,postfix -> 
    case postfix of {
      False => mk1A adj ;
      True => lin A {
        s = \\d,af => adj ;
        p = True ; 
        preferShort = PrefFull
        }
      } ;
} ;
