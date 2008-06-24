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
  (Predef=Predef), 
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

  mkPN  : Str -> Gender -> Animacy -> PN ;          -- "Иван", "Маша"
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

-- mkA : ( : Str) -> A ;

-- The regular function captures the variants for some popular adjective
-- endings below. The first string agrument is the masculine singular form, 
-- the second is comparative:
  
   regA : Str -> Str -> A ;


-- Invariable adjective is a special case.

   adjInvar : Str -> A ;          -- khaki, mini, hindi, netto

-- Some regular patterns depending on the ending.

   AStaruyj : Str -> Str -> A ;            -- ending with "-ый"
   AMalenkij : Str -> Str -> A ;           -- ending with "-ий", Gen - "маленьк-ого"
   AKhoroshij : Str -> Str -> A ;          -- ending with "-ий", Gen - "хорош-его"
   AMolodoj : Str -> Str -> A ;            -- ending with "-ой", 
                                           -- plural - молод-ые"
   AKakoj_Nibud : Str -> Str -> Str -> A ; -- ending with "-ой", 
                                           -- plural - "как-ие"

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
   mkV : Aspect -> (presentSgP1,presentSgP2,presentSgP3,
                         presentPlP1,presentPlP2,presentPlP3,
                         pastSgMasculine,imperative,infinitive: Str) -> V ;

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

   regV :Aspect -> Conjugation -> (stemPresentSgP1,endingPresentSgP1,
                         pastSgP1,imperative,infinitive : Str) -> V ; 


-- Two-place verbs, and the special case with direct object. Notice that
-- a particle can be included in a $V$.

   mkV2     : V   -> Str -> Case -> V2 ;   -- "войти в дом"; "в", accusative
   mkV3  : V -> Str -> Str -> Case -> Case -> V3 ; -- "сложить письмо в конверт"
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
  --  Degree     = Pos | Comp | Super ;
 -- Person     = P1 | P2 | P3 ;
 -- AfterPrep  = Yes | No ; 
 -- Possessive = NonPoss | Poss GenNum ;

-- Noun definitions

 mkN = overload {
    mkN : (karta : Str) -> N = regN ;
    mkN : (tigr : Str) -> Animacy -> N = \nom, anim -> case anim of { Animate   => animateN (regN nom) ;
								      Inanimate => regN nom } ;
    mkN : (nomSg, genSg, datSg, accSg, instSg, preposSg, prepos2Sg,
          nomPl, genPl, datPl, accPl, instPl, preposPl : Str) -> Gender -> Animacy -> N = mkWorstN
  } ;

  mkIndeclinableNoun = \s,g, anim ->
   {
     s = table { SF _ _ => s } ;
     g = g ;
     anim = anim 
   } ** {lock_N = <>};

  oper mkWorstN  : (nomSg, genSg, datSg, accSg, instSg, preposSg, prepos2Sg,
          nomPl, genPl, datPl, accPl, instPl, preposPl : Str) -> Gender -> Animacy -> N
    =  \nomSg, genSg, datSg, accSg, instSg, preposSg, prepos2Sg,
          nomPl, genPl, datPl, accPl, instPl, preposPl, g, anim ->
   {
     s = table { 
           SF Sg Nom => nomSg ;
           SF Sg Gen => genSg ;
           SF Sg Dat => datSg ;
           SF Sg Acc => accSg ;
           SF Sg Inst => instSg ;
           SF Sg (Prepos PrepOther) => preposSg ;
           SF Sg (Prepos PrepVNa) => prepos2Sg ;
           SF Pl Nom => nomPl ;
           SF Pl Gen => genPl ;
           SF Pl Dat => datPl ;
           SF Pl Acc => accPl ;
           SF Pl Inst => instPl ;
           SF Pl (Prepos _) => preposPl
     } ;                           
     g = g ;
     anim = anim
   } ** {lock_N = <>} ;

-- Makes a noun animate.
  oper animateN : N -> N = \n -> 
   {
     s = table { 
       SF Sg Acc => case n.g of {
                       Masc => n.s!(SF Sg Gen);
		       _    => n.s!(SF Sg Acc)
	            };
       SF Pl Acc => n.s!(SF Pl Gen);
       sf        => n.s!sf } ;
     g = n.g ;
     anim = Animate 
   } ** {lock_N = <>};

  oper regN : Str -> N = \x ->
        case x of {
--	  stem+"oнoк" => nDecl10 stem ;
--        stem+"aнин" => nDecl11 stem ;
          stem@(_+"и")+"й"   => nDecl7Masc stem;
          stem@(_+"и")+"я"   => nDecl7Fem stem;
	  stem@(_+"и")+"е"   => nDecl7Neut stem;
          stem@(_+("а"|"е"|"ё"|"о"|"у"|"ы"|"э"|"ю"|"я"))+"й" => nDecl6Masc stem ;
          stem@(_+("а"|"е"|"ё"|"о"|"у"|"ы"|"э"|"ю"|"я"))+"е" => nDecl6Neut stem ;
          stem@(_+("а"|"е"|"ё"|"о"|"у"|"ы"|"э"|"ю"|"я"))+"я" => nDecl6Fem stem ;
--	  stem+"ее"   => nAdj (regA (stem+"ий")) Neut;
--	  stem+"ое"   => nAdj (regA (stem+(iAfter stem)+"й")) Neut;
          stem+"мя"   => nDecl9 stem ;
          stem@(_+("ч"|"щ"|"ш"|"ж"|"п"|"эн"|"м"|"ф"))+"ь" => nDecl8 stem ;
          stem@(_+("д"|"т"|"ст"|"с"|"в"|"б"))+"ь"         => nDecl8 stem ;
	  stem@(_+"ш"|"ж"|"ч"|"щ"|"ц")+"е" => regHardNeut stem;
          stem+"е"                         => regSoftNeut stem ;
          stem+"я"                         => regSoftFem stem ;
          stem+"ь"                         => regSoftMasc stem ;
          stem+"о"                         => regHardNeut stem ; 
          stem+"а"                         => regHardFem stem ; 
          stem                             => regHardMasc stem
         };

{-

Paradigms:
1.  hard regular
    Masc  -Consonant
    Neut -o
    Fem   -a
1*. with vowel changes, Masc in Gen Sg, Fem and Neut in Gen Pl
2.  soft regular:
    Masc -ь
    Neut -е
    Fem -я
2*. with vowel changes, Masc in Gen Sg, Fem in Gen Pl (no Neut)
3.  stem ending in г, к, х 
    - Masc, Fem same as 1 but use и instead of ы (Nom/Acc Pl, Gen Sg)
    - Neut -кo has Nom Pl -ки instead of -кa
3*  with vowel changes, Masc in Gen Sg, Fem and Neut in Gen Pl
4.  stem ending in ш, ж, ч, щ, hard endings,
    use и instead of ы, and use е instead of unstressed o
5.  stem ending in ц, hard endings, use е instead of unstressed o
5*. with vowel changes, Masc in Gen Sg, Fem and Neut in Gen Pl
6.  Masc ending in -й, Fem stem ending in vowel, Neut ending in ь?
6*  with vowel changes
7.  stem ending in и
8.  F2, Fem ending in -ь
    all -чь, -щь, -шь, -жь
    all -пь, -энь, -мь, -фь, 
    most -дь, -ть, -сть, -сь, -вь, -бь, 
8*. with vowel changes in Ins Sg, Gen Sg
9.  Neut ending in -мя
10. Masc in -oнoк
11. Masc in -aнин
12. Nom Pl in -ья

-}

  oper iAfter : Str -> Str = \stem -> 
	 case stem of { 
	           _ + ("г"|"к"|"х")     => "и" ;
		   _ + ("ш"|"ж"|"ч"|"щ") => "и" ;
		   _                     => "ы"
	       };

  oper oAfter : Str -> Str = \stem -> 
	 case stem of { 
		   _ + ("ш"|"ж"|"ч"|"щ") => "е" ;
		   _ + "ц"               => "е" ;
		   _                     => "о"
	       };

  -- 1.  Hard regular masculine inanimate, e.g. spor.
  -- 3.  stem ending in г, к, х 
  -- 4.  stem ending in ш, ж, ч, щ
  -- 5.  stem ending in ц
  oper regHardMasc : Str -> N = \stem -> 
	 let i = iAfter stem in
	 let o = oAfter stem in
  { s = table {
	SF Sg Nom        => stem ;
	SF Sg Gen        => stem+"а" ;
	SF Sg Dat        => stem+"у" ;
	SF Sg Acc        => stem ;
	SF Sg Inst       => stem+o+"м" ;
	SF Sg (Prepos _) => stem+"е" ;
	SF Pl Nom        => stem+i ;
	SF Pl Gen        => stem+case stem of { _+("ш"|"ж"|"ч"|"щ") => "ей"; _ => "ов" } ;
	SF Pl Dat        => stem+"ам" ;
	SF Pl Acc        => stem+i ;
	SF Pl Inst       => stem+"ами" ;
	SF Pl (Prepos _) => stem+"ах" };
      g = Masc; anim = Inanimate } ** {lock_N = <>} ;

  -- 1. Hard regular neuter inanimate, e.g. pravilo.
  -- 3.  stem ending in г, к, х 
  -- 4.  stem ending in ш, ж, ч, щ
  -- 5.  stem ending in ц
  oper regHardNeut : Str -> N = \stem -> 
	 let o = oAfter stem in
    { s = table {
	SF Sg Nom        => stem+o ;
	SF Sg Gen        => stem+"а" ;
	SF Sg Dat        => stem+"у" ;
	SF Sg Acc        => stem+o ;
	SF Sg Inst       => stem+o+"м" ;
	SF Sg (Prepos _) => stem+"е" ;
	SF Pl Nom        => stem+case stem of { _+"к" => "и" ; _ => "а" } ;
	SF Pl Gen        => stem ;
	SF Pl Dat        => stem+"ам" ;
	SF Pl Acc        => stem+"а" ;
	SF Pl Inst       => stem+"ами" ;
	SF Pl (Prepos _) => stem+"ах" };
      g = Neut; anim = Inanimate } ** {lock_N = <>} ;

  -- 1. Hard regular feminine inanimate, e.g. karta.
  -- 3.  stem ending in г, к, х 
  -- 4.  stem ending in ш, ж, ч, щ
  -- 5.  stem ending in ц
  oper regHardFem : Str -> N = \stem -> 
	 let i = iAfter stem in
	 let o = oAfter stem in
    { s = table {
	SF Sg Nom        => stem+"а" ;
	SF Sg Gen        => stem+i ;
	SF Sg Dat        => stem+"е" ;
	SF Sg Acc        => stem+"у" ;
	SF Sg Inst       => stem+o+"й" ;
	SF Sg (Prepos _) => stem+"е" ;
	SF Pl Nom        => stem+i ;
	SF Pl Gen        => stem ;
	SF Pl Dat        => stem+"ам" ;
	SF Pl Acc        => stem+i ;
	SF Pl Inst       => stem+"ами" ;
	SF Pl (Prepos _) => stem+"ах" };
      g = Fem; anim = Inanimate } ** {lock_N = <>} ;

  -- 2. Soft regular masculine inanimate, e.g. vichr'
  oper regSoftMasc : Str -> N = \stem -> 
    { s = table {
	SF Sg Nom        => stem+"ь";
	SF Sg Gen        => stem+"я" ;
	SF Sg Dat        => stem+"ю" ;
	SF Sg Acc        => stem+"ь" ;
	SF Sg Inst       => stem+"ем" ;
	SF Sg (Prepos _) => stem+"е" ;
	SF Pl Nom        => stem+"и" ;
	SF Pl Gen        => stem+"ей" ;
	SF Pl Dat        => stem+"ям" ;
	SF Pl Acc        => stem+"и" ;
	SF Pl Inst       => stem+"ями" ;
	SF Pl (Prepos _) => stem+"ях" };
      g = Masc; anim = Inanimate } ** {lock_N = <>} ;

  -- 2. Soft regular neuter inanimate, e.g. more
  oper regSoftNeut : Str -> N = \stem -> 
    { s = table {
	SF Sg Nom        => stem+"е";
	SF Sg Gen        => stem+"я" ;
	SF Sg Dat        => stem+"ю" ;
	SF Sg Acc        => stem+"е" ;
	SF Sg Inst       => stem+"ем" ;
	SF Sg (Prepos _) => stem+"е" ;
	SF Pl Nom        => stem+"я" ;
	SF Pl Gen        => stem+"ей" ;
	SF Pl Dat        => stem+"ям" ;
	SF Pl Acc        => stem+"я" ;
	SF Pl Inst       => stem+"ями" ;
	SF Pl (Prepos _) => stem+"ях" };
      g = Neut; anim = Inanimate } ** {lock_N = <>} ;

  -- 2. Soft regular feminine inanimate, e.g. burya
  oper regSoftFem : Str -> N = \stem -> 
    { s = table {
	SF Sg Nom        => stem+"я";
	SF Sg Gen        => stem+"и" ;
	SF Sg Dat        => stem+"е" ;
	SF Sg Acc        => stem+"ю" ;
	SF Sg Inst       => stem+"ей" ;
	SF Sg (Prepos _) => stem+"е" ;
	SF Pl Nom        => stem+"и" ;
	SF Pl Gen        => stem+"ь" ;
	SF Pl Dat        => stem+"ям" ;
	SF Pl Acc        => stem+"и" ;
	SF Pl Inst       => stem+"ями" ;
	SF Pl (Prepos _) => stem+"ях" };
      g = Fem; anim = Inanimate } ** {lock_N = <>} ;

  -- 6.  Masc ending in -Vй (V = vowel)
  oper nDecl6Masc : Str -> N = \stem -> 
     let n = regSoftMasc stem in
    { s = table {
	SF Sg (Nom|Acc)  => stem+"й";
	SF Pl Gen        => stem+"ев" ;
        sf               => n.s!sf };
      g = n.g; anim = n.anim } ** {lock_N = <>} ;

  -- 6.  Neut ending in -Ve (V = vowel) (not adjectives)
  oper nDecl6Neut : Str -> N = \stem -> 
     let n = regSoftNeut stem in
    { s = table {
	SF Pl Gen        => stem+"й" ;
        sf               => n.s!sf };
      g = n.g; anim = n.anim } ** {lock_N = <>} ;

  -- 6.  Fem ending in -Vя (V = vowel)
  oper nDecl6Fem : Str -> N = \stem -> 
     let n = regSoftFem stem in
    { s = table {
	SF Pl Gen        => stem+"й" ;
        sf               => n.s!sf };
      g = n.g; anim = n.anim } ** {lock_N = <>} ;

  -- 7.  stem ending in и
  oper nDecl7Masc : Str -> N = \stem -> 
    let n = nDecl6Masc stem in
    { s = table {
	SF Sg (Prepos _) => stem+"и" ;
	sf               => n.s!sf };
      g = n.g; anim = n.anim } ** {lock_N = <>} ;

  -- 7.  stem ending in и
  oper nDecl7Neut : Str -> N = \stem -> 
    let n = nDecl6Neut stem in
    { s = table {
	SF Sg (Prepos _) => stem+"и" ;
	sf               => n.s!sf };
      g = n.g; anim = n.anim } ** {lock_N = <>} ;

  -- 7.  stem ending in и
  oper nDecl7Fem : Str -> N = \stem -> 
    let n = nDecl6Fem stem in
    { s = table {
	SF Sg (Dat|Prepos _) => stem+"и" ;
	sf                   => n.s!sf };
      g = n.g; anim = n.anim } ** {lock_N = <>} ;


  -- 8. Feminine ending in soft consonant
  oper nDecl8 : Str -> N = \stem -> 
      let a : Str = case stem of { _+("ч"|"щ"|"ш"|"ж") => "а"; _ => "я" } in
    { s = table {
	SF Sg Nom        => stem+"ь";
	SF Sg Gen        => stem+"и" ;
	SF Sg Dat        => stem+"и" ;
	SF Sg Acc        => stem+"ь" ;
	SF Sg Inst       => stem+"ью" ;
	SF Sg (Prepos _) => stem+"и" ;
	SF Pl Nom        => stem+"и" ;
	SF Pl Gen        => stem+"ей" ;
	SF Pl Dat        => stem+a+"м" ;
	SF Pl Acc        => stem+"и" ;
	SF Pl Inst       => stem+a+"ми" ;
	SF Pl (Prepos _) => stem+a+"х" };
      g = Fem; anim = Inanimate } ** {lock_N = <>} ;

  -- 9.  Neut ending in -мя
  oper nDecl9 : Str -> N = \stem ->
    { s = table {
	SF Sg Nom        => stem+"мя";
	SF Sg Gen        => stem+"мени" ;
	SF Sg Dat        => stem+"мени" ;
	SF Sg Acc        => stem+"мя" ;
	SF Sg Inst       => stem+"менем" ;
	SF Sg (Prepos _) => stem+"мени" ;
	SF Pl Nom        => stem+"мена" ;
	SF Pl Gen        => stem+"мён" ;
	SF Pl Dat        => stem+"менам" ;
	SF Pl Acc        => stem+"мена" ;
	SF Pl Inst       => stem+"менами" ;
	SF Pl (Prepos _) => stem+"менах" };
      g = Fem; anim = Inanimate } ** {lock_N = <>} ;

  -- Nouns inflected as adjectives.
  oper nAdj : A -> Gender -> N = \a,g -> 
    { s = table {
	SF Sg c           => a.s!Posit!AF c Inanimate (ASg g) ;
	SF Pl c           => a.s!Posit!AF c Inanimate APl };
      g = g; anim = Inanimate } ** {lock_N = <>} ;



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

  mkFun : N -> Prep -> N2 = \f,p -> (UseN f) ** {s2 = p.s ; c = p.c}** {lock_N2 = <>}  ;

  nullPrep : Prep = {s = []; c= Gen; lock_Prep=<>} ;  

  mkN3 f p r = (UseN f) ** {s2 = p.s ; c=p.c; s3=r.s ; c2=r.c; lock_N3 = <>} ; 


  mkPN = \ivan, g, anim -> 
    case g of { 
       Masc => mkProperNameMasc ivan anim ; 
       _ => mkProperNameFem ivan anim
    } ** {lock_PN =<>};
  nounPN n = {s=\\c => n.s! SF Sg c; anim=n.anim; g=n.g; lock_PN=<>};
    
-- On the top level, it is maybe $CN$ that is used rather than $N$, and
-- $NP$ rather than $PN$.

  makeCN  : N -> CN ;
  makeNP  : Str -> Gender -> Animacy -> NP ;


  makeCN = UseN;

  makeNP = \x,y,z -> UsePN (mkPN x y z) ;

-- Adjective definitions
  regA = \ray, comp -> 
    let
      ay  = Predef.dp 2 ray ;
      rays =
        case ay of {
          "ый" => AStaruyj ray comp; 
          "ой" => AMolodoj ray comp;
          "ий" =>  AMalenkij ray comp;
           _=>  AKhoroshij ray comp
         }
     in
       rays ;

  adjInvar = \s -> { s = \\_,_ => s } ** {lock_A= <>};

  AStaruyj s comp = mkAdjDeg (uy_j_EndDecl s) comp ** {lock_A = <>} ;       
  AKhoroshij s comp = mkAdjDeg (shij_End_Decl s) comp ** {lock_A= <>}; 
  AMalenkij s comp = mkAdjDeg (ij_EndK_G_KH_Decl s) comp ** {lock_A= <>};       
  AMolodoj s comp = mkAdjDeg (uy_oj_EndDecl s) comp ** {lock_A= <>};        
  AKakoj_Nibud s t  comp = mkAdjDeg (i_oj_EndDecl s t) comp ** {lock_A= <>}; 

  mkA2 a p c=  a ** {s2 = p ; c = c; lock_A2 = <>};
--  mkADeg a s = mkAdjDeg a s ** {lock_ADeg = <>}; -- defined in morpho.RusU

--  ap a p = mkAdjPhrase a p ** {lock_AP = <>};  -- defined in syntax module

  mkAdv x = ss x ** {lock_Adv = <>} ;

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
       PRF (ASg _) P1 => sgP1 ;
       PRF (ASg _) P2 => sgP2 ;
       PRF (ASg _) P3 => sgP3 ;
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
   mkV2 v p cas = v ** {s2 = p ; c = cas; lock_V2 = <>}; 
   dirV2 v = mkV2 v [] Acc;


   tvDirDir v = mkV3 v "" "" Acc Dat; 

-- *Ditransitive verbs* are verbs with three argument places.
-- We treat so far only the rule in which the ditransitive
-- verb takes both complements to form a verb phrase.

   mkV3 v s1 s2 c1 c2 = v ** {s2 = s1; c = c1; s4 = s2; c2=c2; lock_V3 = <>};  

} ;

