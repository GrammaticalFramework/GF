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

-- Best case: indeclinabe nouns: "кофе", "пальто", "ВУЗ".
  Animacy: Type ; 
  
  animate: Animacy;
  inanimate: Animacy; 
 
  mkIndeclinableNoun: Str -> Gender -> Animacy -> N ; 

-- Worst case - give six singular forms:
-- Nominative, Genetive, Dative, Accusative, Instructive and Prepositional;
-- corresponding six plural forms and the gender.
-- May be the number of forms needed can be reduced, 
-- but this requires a separate investigation.
-- Animacy parameter (determining whether the Accusative form is equal 
-- to the Nominative or the Genetive one) is actually of no help, 
-- since there are a lot of exceptions and the gain is just one form less.

  -- +++ MG_UR: new case Prepos2 introduced! +++
  mkN  : (nomSg, genSg, datSg, accSg, instSg, preposSg, prepos2Sg,
          nomPl, genPl, datPl, accPl, instPl, preposPl, prepos2Pl: Str) -> Gender -> Animacy -> N ; 

     -- мужчина, мужчины, мужчине, мужчину, мужчиной, мужчине
     -- мужчины, мужчин, мужчинам, мужчин, мужчинами, мужчинах

-- The regular function captures the variants for some popular nouns 
-- endings below:

  regN : Str -> N ;


-- Here are some common patterns. The list is far from complete.

-- Feminine patterns.

  nMashina   : Str -> N ;    -- feminine, inanimate, ending with "-а", Inst -"машин-ой"
  nEdinica   : Str -> N ;    -- feminine, inanimate, ending with "-а", Inst -"единиц-ей"
  nZhenchina : Str -> N ;    -- feminine, animate, ending with "-a"
  nNoga      : Str -> N ;    -- feminine, inanimate, ending with "г_к_х-a"
  nMalyariya : Str -> N ;    -- feminine, inanimate, ending with "-ия"   
  nTetya     : Str -> N ;    -- feminine, animate, ending with "-я"   
  nBol       : Str -> N ;    -- feminine, inanimate, ending with "-ь"(soft sign)     

-- further classes added by Magda Gerritsen and Ulrich Real
  nSvecha: Str -> N ; -- like nEdinica, but instrumental case with -oj
  nMat: Str -> N ; -- irregular, changing stem, other example 'daughter'
  nDoch: Str -> N ; -- like nMat but different instrumental case
  nLoshad: Str -> N ; -- i-declination but instrumental plural -mi
  nNoch: Str -> N ; -- like nBol but after ZH no "soft behaviour"


-- Neuter patterns. 

  nObezbolivauchee : Str -> N ;   -- neutral, inanimate, ending with "-ee" 
  nProizvedenie : Str -> N ;   -- neutral, inanimate, ending with "-e" 
  nChislo : Str -> Str -> N ;   -- neutral, inanimate, ending with "-o" +++ MG_UR: nChislo now expects two arguments +++
  nZhivotnoe : Str -> N ;    -- masculine, inanimate, ending with "-ень"

-- further classes added by Magda Gerritsen and Ulrich Real
  nSlovo: Str -> N ; -- hard consonants and zh, ending with -o
  nMorje: Str -> N ; -- weak consonants, ending with -e
  nUchilishe: Str -> N ; -- like nSlovo but because not stressed (betont) of with -e
-- nOkno: Str -> N ; -- like nSlovo but without -o- and genetive plural with -o- in between; no longer needed because of nChislo with two arguments +++
-- nKreslo: Str -> N ; -- like nSlovo but without -o- and genetive plural with -o- in between; no longer needed because of nChislo with two arguments +++
  nNebo: Str -> N ;   -- irregular, other example 'chudo' (wonder)
  nDerevo: Str -> N ; -- irregular, change of stem, other example 'krylo' (wing)
  nVremja: Str -> N ; -- irregular total, the most important ones: 'imja' (name), 'plamja' (flame), 'znamja' (flag), 'semja' (seed)


-- Masculine patterns. 

-- Ending with consonant: 
  nPepel : Str -> N ;    -- masculine, inanimate, ending with "-ел"- "пеп-ла"
  nBrat: Str -> N ;   -- animate, брат-ья
  nStul: Str -> N ;    -- same as above, but inanimate
  nMalush : Str -> N ; -- малышей
  nPotolok : Str -> N ; -- потол-ок - потол-ка

-- the next four differ in plural nominative and/or accusative form(s) :
  nBank: Str -> N ;    -- банк-и (Nom=Acc)
  nStomatolog : Str -> N ;  -- same as above, but animate
  nAdres     : Str -> N ;     -- адрес-а (Nom=Acc), +++ MG_UR: other examples: 'bereg, vecher, gorod, dom, lec, glaz, poezd' +++
  nTelefon   : Str -> N ;     -- телефон-ы (Nom=Acc)
  nNol       : Str -> N ;    -- masculine, inanimate, ending with "-ь" (soft sign)
  nUchitel   : Str -> N ;    -- masculine, animate, ending with "-ь" (soft sign) -- +++ MG_UR: added +++
  nUroven    : Str -> N ;    -- masculine, inanimate, ending with "-ень"

-- further classes added by Magda Gerritsen and Ulrich Real
  nStol: Str -> N ; -- masculine "standard" declination (most simple case), hard consonants
  nSlovar : Str -> N ; -- masculine, inanimate, ending soft ending, instrumental case with -jo-
  nMusej : Str -> N ; -- masculine, inanimate, without ending
  nDvorec : Str -> N ; -- masculine, inanimate, ending like nEtazh but genetive with -o- and with missing vowel
  nTovarish : Str -> N ; -- masculine, animate, ending like nEtazh but instrumental case with -e-
  nMesjac : Str -> N ; -- masculine, inanimate, ending like nDvorec but genitive wiht -e-
  nGrazhdanin : Str -> N ; -- masculine, animate, ending with "-anin" and change of stem
  nRebenok : Str -> N ; -- masculine, little beings, change of stem
  nPut : Str -> N ; -- unique irregular Form, frequent use of the word
  nGospodin : Str -> N ; -- like nGrazhdanin, but nominative plural ending with -a
  nDen : Str -> N ; -- masculine, animate, ending with "-ь" (soft sign) but without vowel
  nDrug : Str -> N ; -- like nBrat, but change of stemm 
  nSyn : Str -> N ; -- like nDrug, but another stem

-- further classes added by Magda Gerritsen and Ulrich Real
-- attention: these are not declension classes but classes in which
-- one case differs depending on the preposition used with it!
  nLes : Str -> N ; -- preposition 'v' requires the case Prepos2
  nMost : Str -> N ; -- preposition 'na' requires the case Prepos2

-- Nouns used as functions need a preposition. The most common is with Genitive.

  mkFun  : N -> Prep -> N2 ;
  mkN2 : N -> N2 ;
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
  prepositional = Prepos ;
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

  mkIndeclinableNoun = \s,g, anim ->
   {
     s = table { SF _ _ => s } ;
     g = g ;
     anim = anim 
   } ** {lock_N = <>};

  -- +++ MG_UR: new case Prepos2 introduced! +++
  mkN =  \nomSg, genSg, datSg, accSg, instSg, preposSg, prepos2Sg,
          nomPl, genPl, datPl, accPl, instPl, preposPl, prepos2Pl, g, anim ->
   {
     s = table { 
           SF Sg Nom => nomSg ;
           SF Sg Gen => genSg ;
           SF Sg Dat => datSg ;
           SF Sg Acc => accSg ;
           SF Sg Inst => instSg ;
           SF Sg Prepos => preposSg ;
           SF Sg Prepos2 => prepos2Sg ;
           SF Pl Nom => nomPl ;
           SF Pl Gen => genPl ;
           SF Pl Dat => datPl ;
           SF Pl Acc => accPl ;
           SF Pl Inst => instPl ;
           SF Pl Prepos => preposPl ;
           SF Pl Prepos2 => prepos2Pl
     } ;                           
     g = g ;
     anim = anim
   } ** {lock_N = <>} ;


regN = \ray ->
    let
      ra  = Predef.tk 1 ray ; 
      y   = Predef.dp 1 ray ; 
      r   = Predef.tk 2 ray ; 
      ay  = Predef.dp 2 ray ;
      rays =
        case y of {
          "а" => nMashina ray ; 
          "ь" => nBol ray ;
          "я" => case ay of { 
                   "ия" => nMalyariya ray; 
                    _  => nTetya ray };
          "е" => case ay of {
            "ее" => nObezbolivauchee ray ;
            "ое" => nZhivotnoe ray  ;
            _ => nProizvedenie ray  };
          -- "о" => nChislo ray ; +++ MG_UR: commented out +++
           _=>  nStomatolog ray
         }
     in
       rays ;

  
  nMashina   = \s -> aEndInAnimateDecl s ** {lock_N = <>};
  nEdinica   = \s -> ej_aEndInAnimateDecl s ** {lock_N = <>};
  nZhenchina = \s -> (aEndAnimateDecl s) ** { g = Fem ; anim = Animate } ** {lock_N = <>}; 
  nNoga      = \s -> aEndG_K_KH_Decl s ** {lock_N = <>};    
  nMalyariya = \s -> i_yaEndDecl s ** {lock_N = <>};
  nTetya     = \s -> (yaEndAnimateDecl s) ** {g = Fem; anim = Animate; lock_N = <>} ;
  nBol       = \s -> softSignEndDeclFem  s ** {lock_N = <>};

-- further classes added by Magda Gerritsen and Ulrich Real
  nSvecha  = \s -> oj_aEndInAnimateDecl s ** {lock_N = <>};
  nMat = \s -> irregStemAnimateDecl s ** {g = Fem; anim = Animate; lock_N = <>};
  nDoch = \s -> irregStemAnimateDeclInstr_MI s ** {g = Fem; anim = Animate; lock_N = <>};
  nLoshad = \s -> softSignEndDeclFemInstr_MI  s ** {g = Fem; anim = Animate; lock_N = <>};
  nNoch = \s -> softSignEndDeclFemInanimate_ZH  s ** {g = Fem; anim = Inanimate; lock_N = <>};


-- Neuter patterns. 
  nObezbolivauchee = \s -> eeEndInAnimateDecl s ** {lock_N = <>};
  nZhivotnoe = \s -> oeEndAnimateDecl s ** {lock_N = <>};
  nProizvedenie = \s -> eEndInAnimateDecl s ** {lock_N = <>};
  nChislo = \s, o -> oEndInAnimateDecl3 s o ** {lock_N = <>}; -- +++ MG_UR: nChislo now expects two arguments +++

-- further classes added by Magda Gerritsen and Ulrich Real
  nSlovo = \s -> hardCons_ZHInAnimateDecl s ** {lock_N = <>};
  nMorje = \s -> weakConsInAnimateDecl s ** {lock_N = <>};
  nUchilishe = \s -> hardCons_ZHInAnimateDeclE s ** {lock_N = <>};
  nNebo = \s -> irregPlInAnimateDecl s ** {lock_N = <>};
  nDerevo = \s -> irregPl_StemInAnimateDecl s ** {lock_N = <>};
  nVremja = \s -> irregTotalInAnimateDecl s ** {lock_N = <>};


-- Masculine patterns. 
  nBank = \s -> nullEndInAnimateDecl s ** {lock_N = <>}; 
  nStomatolog = \s -> nullEndAnimateDecl s ** {lock_N = <>};
  nMalush = \s -> shEndDeclMasc s ** {lock_N = <>};
  nPotolok = \s ->okEndDeclMasc s ** {lock_N = <>};

  nBrat = \s -> nullEndAnimateDeclBrat s** {lock_N = <>}; 
  nStul = \s -> nullEndInAnimateDeclStul s** {lock_N = <>}; 

  nAdres     = \s -> nullEndInAnimateDecl2 s ** {lock_N = <>}; 
  nTelefon   = \s -> nullEndInAnimateDecl1 s ** {lock_N = <>}; 
  nPepel   = \s -> nullEndInAnimateDeclPepel s ** {lock_N = <>}; 

  nNol       = \s -> softSignEndDeclMasc s ** {lock_N = <>};
  nUchitel   = \s -> softSignEndDeclMascAnimate s ** {lock_N = <>}; -- +++ MG_UR: added +++
  nUroven    = \s -> EN_softSignEndDeclMasc s ** {lock_N = <>};

-- further classes added by Magda Gerritsen and Ulrich Real
  nStol = \s -> nullEndDecl s ** {lock_N = <>};
  nSlovar   = \s -> softSignEndDeclMascInAnimateInstrJO s ** {lock_N = <>};
  nMusej = \s -> nullEndInAnimateDeclSoft s ** {lock_N = <>};
  nDvorec = \s -> ZH_EndInAnimateDeclSoftGenOWithout s ** {lock_N = <>};
  nTovarish = \s -> ZH_EndAnimateDeclSoftInstrE s ** {lock_N = <>};
  nMesjac = \s -> ZH_EndInAnimateDeclSoftGenE s ** {lock_N = <>};
  nGrazhdanin = \s -> PlStemChangeAnimateDecl s ** {lock_N = <>};
  nRebenok = \s -> LittleAnimalDecl s ** {lock_N = <>};
  nPut = \s -> UniqueIrregularDecl s ** {lock_N = <>};
  nGospodin = \s -> A_PlStemChangeAnimateDecl s ** {lock_N = <>};
  nDen = \s -> softSignEndDeclMascInAnimateGenEWithout s ** {lock_N = <>};
  nDrug = \s -> nullEndAnimateDeclDrug s** {lock_N = <>};
  nSyn = \s -> nullEndAnimateDeclSyn s** {lock_N = <>};

-- preposition types added by Magda Gerritsen and Ulrich Real
  nLes = \s -> preposition_V s ** {lock_N = <>};
  nMost = \s -> preposition_Na s ** {lock_N = <>};


-- An individual-valued function is a common noun together with the
-- preposition prefixed to its argument ("клZ+ о' дома").
-- The situation is analogous to two-place adjectives and transitive verbs.
--
-- We allow the genitive construction to be used as a variant of
-- all function applications. It would definitely be too restrictive only
-- to allow it when the required case is genitive. We don't know if there
-- are counterexamples to the liberal choice we've made.

  mkFun f p = (UseN f) ** {s2 = p.s ; c = p.c}** {lock_N2 = <>}  ;

-- The commonest cases are functions with Genitive.
  mkN2 n = mkFun n nullPrep ;
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
         mkVerb (perfectiveActivePattern inf imperSgP2 
         (presentConj sgP1 sgP2 sgP3 plP1 plP2 plP3) (pastConj sgMascPast))
         (pastConj sgMascPast) ** {    lock_V=<> };
       Imperfective  =>  
         mkVerb (imperfectiveActivePattern inf imperSgP2 
         (presentConj sgP1 sgP2 sgP3 plP1 plP2 plP3) (pastConj sgMascPast))
         (pastConj sgMascPast) ** {    lock_V=<> }
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
 

----2 Parameters 
----
---- To abstract over gender names, we define the following identifiers.
--
--oper
--  Gender : Type ; 
--
--  human     : Gender ;
--  nonhuman  : Gender ;
--  masculine : Gender ;
--
---- To abstract over number names, we define the following.
--
--  Number : Type ; 
--
--  singular : Number ;
--  plural   : Number ;
--
---- To abstract over case names, we define the following.
--
--  Case : Type ;
--
--  nominative : Case ;
--  genitive   : Case ;
--
---- Prepositions are used in many-argument functions for rection.
--
--  Preposition : Type ;
--
--
----2 Nouns
--
---- Worst case: give all four forms and the semantic gender.
--
--  mkN  : (man,men,man's,men's : Str) -> N ;
--
---- The regular function captures the variants for nouns ending with
---- "s","sh","x","z" or "y": "kiss - kisses", "flash - flashes"; 
---- "fly - flies" (but "toy - toys"),
--
--  regN : Str -> N ;
--
---- In practice the worst case is just: give singular and plural nominative.
--
--  mk2N : (man,men : Str) -> N ;
--
---- All nouns created by the previous functions are marked as
---- $nonhuman$. If you want a $human$ noun, wrap it with the following
---- function:
--
--  genderN : Gender -> N -> N ;
--
----3 Compound nouns 
----
---- A compound noun ia an uninflected string attached to an inflected noun,
---- such as "baby boom", "chief executive officer".
--
--  compoundN : Str -> N -> N ;
--
--
----3 Relational nouns 
---- 
---- Relational nouns ("daughter of x") need a preposition. 
--
--  mkN2 : N -> Preposition -> N2 ;
--
---- The most common preposition is "of", and the following is a
---- shortcut for regular relational nouns with "of".
--
--  regN2 : Str -> N2 ;
--
---- Use the function $mkPreposition$ or see the section on prepositions below to  
---- form other prepositions.
----
---- Three-place relational nouns ("the connection from x to y") need two prepositions.
--
--  mkN3 : N -> Preposition -> Preposition -> N3 ;
--
--
----3 Relational common noun phrases
----
---- In some cases, you may want to make a complex $CN$ into a
---- relational noun (e.g. "the old town hall of").
--
--  cnN2 : CN -> Preposition -> N2 ;
--  cnN3 : CN -> Preposition -> Preposition -> N3 ;
--
---- 
----3 Proper names and noun phrases
----
---- Proper names, with a regular genitive, are formed as follows
--
--  regPN : Str -> Gender -> PN ;          -- John, John's
--
---- Sometimes you can reuse a common noun as a proper name, e.g. "Bank".
--
--  nounPN : N -> PN ;
--
---- To form a noun phrase that can also be plural and have an irregular
---- genitive, you can use the worst-case function.
--
--  mkNP : Str -> Str -> Number -> Gender -> NP ; 
--
----2 Adjectives
--
---- Non-comparison one-place adjectives need two forms: one for
---- the adjectival and one for the adverbial form ("free - freely")
--
--  mkA : (free,freely : Str) -> A ;
--
---- For regular adjectives, the adverbial form is derived. This holds
---- even for cases with the variation "happy - happily".
--
--  regA : Str -> A ;
-- 
----3 Two-place adjectives
----
---- Two-place adjectives need a preposition for their second argument.
--
--  mkA2 : A -> Preposition -> A2 ;
--
---- Comparison adjectives may two more forms. 
--
--  ADeg : Type ;
--
--  mkADeg : (good,better,best,well : Str) -> ADeg ;
--
---- The regular pattern recognizes two common variations: 
---- "-e" ("rude" - "ruder" - "rudest") and
---- "-y" ("happy - happier - happiest - happily")
--
--  regADeg : Str -> ADeg ;      -- long, longer, longest
--
---- However, the duplication of the final consonant is nor predicted,
---- but a separate pattern is used:
--
--  duplADeg : Str -> ADeg ;      -- fat, fatter, fattest
--
---- If comparison is formed by "more, "most", as in general for
---- long adjective, the following pattern is used:
--
--  compoundADeg : A -> ADeg ; -- -/more/most ridiculous
--
---- From a given $ADeg$, it is possible to get back to $A$.
--
--  adegA : ADeg -> A ;
--
--
----2 Adverbs
--
---- Adverbs are not inflected. Most lexical ones have position
---- after the verb. Some can be preverbal (e.g. "always").
--
--  mkAdv : Str -> Adv ;
--  mkAdV : Str -> AdV ;
--
---- Adverbs modifying adjectives and sentences can also be formed.
--
--  mkAdA : Str -> AdA ;
--
----2 Prepositions
----
---- A preposition as used for rection in the lexicon, as well as to
---- build $PP$s in the resource API, just requires a string.
--
--  mkPreposition : Str -> Preposition ;
--  mkPrep        : Str -> Prep ;
--
---- (These two functions are synonyms.)
--
----2 Verbs
----
---- Except for "be", the worst case needs five forms: the infinitive and
---- the third person singular present, the past indicative, and the
---- past and present participles.
--
--  mkV : (go, goes, went, gone, going : Str) -> V ;
--
---- The regular verb function recognizes the special cases where the last
---- character is "y" ("cry - cries" but "buy - buys") or "s", "sh", "x", "z"
---- ("fix - fixes", etc).
--
--  regV : Str -> V ;
--
---- The following variant duplicates the last letter in the forms like
---- "rip - ripped - ripping".
--
--  regDuplV : Str -> V ;
--
---- There is an extensive list of irregular verbs in the module $IrregularEng$.
---- In practice, it is enough to give three forms, 
---- e.g. "drink - drank - drunk", with a variant indicating consonant
---- duplication in the present participle.
--
--  irregV     : (drink, drank, drunk  : Str) -> V ;
--  irregDuplV : (get,   got,   gotten : Str) -> V ;
--
--
----3 Verbs with a particle.
----
---- The particle, such as in "switch on", is given as a string.
--
--  partV  : V -> Str -> V ;
--
----3 Reflexive verbs
----
---- By default, verbs are not reflexive; this function makes them that.
--
--  reflV  : V -> V ;
--
----3 Two-place verbs
----
---- Two-place verbs need a preposition, except the special case with direct object.
---- (transitive verbs). Notice that a particle comes from the $V$.
--
--  mkV2  : V -> Preposition -> V2 ;
--
--  dirV2 : V -> V2 ;
--
----3 Three-place verbs
----
---- Three-place (ditransitive) verbs need two prepositions, of which
---- the first one or both can be absent.
--
--  mkV3     : V -> Preposition -> Preposition -> V3 ; -- speak, with, about
--  dirV3    : V -> Preposition -> V3 ;                -- give,_,to
--  dirdirV3 : V -> V3 ;                               -- give,_,_
--
----3 Other complement patterns
----
---- Verbs and adjectives can take complements such as sentences,
---- questions, verb phrases, and adjectives.
--
--  mkV0  : V -> V0 ;
--  mkVS  : V -> VS ;
--  mkV2S : V -> Str -> V2S ;
--  mkVV  : V -> VV ;
--  mkV2V : V -> Str -> Str -> V2V ;
--  mkVA  : V -> VA ;
--  mkV2A : V -> Str -> V2A ;
--  mkVQ  : V -> VQ ;
--  mkV2Q : V -> Str -> V2Q ;
--
--  mkAS  : A -> AS ;
--  mkA2S : A -> Str -> A2S ;
--  mkAV  : A -> AV ;
--  mkA2V : A -> Str -> A2V ;
--
---- Notice: categories $V2S, V2V, V2A, V2Q$ are in v 1.0 treated
---- just as synonyms of $V2$, and the second argument is given
---- as an adverb. Likewise $AS, A2S, AV, A2V$ are just $A$.
---- $V0$ is just $V$.
--
--  V0, V2S, V2V, V2A, V2Q : Type ;
--  AS, A2S, AV, A2V : Type ;
--
--
----2 Definitions of paradigms
----
---- The definitions should not bother the user of the API. So they are
---- hidden from the document.
----.
--
--  Gender = MorphoEng.Gender ; 
--  Number = MorphoEng.Number ;
--  Case = MorphoEng.Case ;
--  human = Masc ; 
--  nonhuman = Neutr ;
--  masculine = Masc ;
--  feminine = Fem ;
--  singular = Sg ;
--  plural = Pl ;
--  nominative = Nom ;
--  genitive = Gen ;
--
--  Preposition = Str ;
--
--  regN = \ray -> 
--    let
--      ra  = Predef.tk 1 ray ; 
--      y   = Predef.dp 1 ray ; 
--      r   = Predef.tk 2 ray ; 
--      ay  = Predef.dp 2 ray ;
--      rays =
--        case y of {
--          "y" => y2ie ray "s" ; 
--          "s" => ray + "es" ;
--          "z" => ray + "es" ;
--          "x" => ray + "es" ;
--          _ => case ay of {
--            "sh" => ray + "es" ;
--            "ch" => ray + "es" ;
--            _    => ray + "s"
--            }
--         }
--     in
--       mk2N ray rays ;
--
--  mk2N = \man,men -> 
--    let mens = case last men of {
--      "s" => men + "'" ;
--      _   => men + "'s"
--      }
--    in
--    mkN man men (man + "'s") mens ;
--
--  mkN = \man,men,man's,men's -> 
--    mkNoun man man's men men's ** {g = Neutr ; lock_N = <>} ;
--
--  genderN g man = {s = man.s ; g = g ; lock_N = <>} ;
--
--  compoundN s n = {s = \\x,y => s ++ n.s ! x ! y ; g=n.g ; lock_N = <>} ;
--
--  mkN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p} ;
--  regN2 n = mkN2 (regN n) (mkPreposition "of") ;
--  mkN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p ; c3 = q} ;
--  cnN2 = \n,p -> n ** {lock_N2 = <> ; c2 = p} ;
--  cnN3 = \n,p,q -> n ** {lock_N3 = <> ; c2 = p ; c3 = q} ;
--
--  regPN n g = nameReg n g ** {lock_PN = <>} ;
--  nounPN n = {s = n.s ! singular ; g = n.g ; lock_PN = <>} ;
--  mkNP x y n g = {s = table {Gen => x ; _ => y} ; a = agrP3 n ;
--  lock_NP = <>} ;
--
--  mkA a b = mkAdjective a a a b ** {lock_A = <>} ;
--  regA a = regAdjective a ** {lock_A = <>} ;
--
--  mkA2 a p = a ** {c2 = p ; lock_A2 = <>} ;
--
--  ADeg = A ; ----
--
--  mkADeg a b c d = mkAdjective a b c d ** {lock_A = <>} ;
--
--  regADeg happy = 
--    let
--      happ = init happy ;
--      y    = last happy ;
--      happie = case y of {
--        "y" => happ + "ie" ;
--        "e" => happy ;
--        _   => happy + "e"
--        } ;
--      happily = case y of {
--        "y" => happ + "ily" ;
--        _   => happy + "ly"
--        } ;
--    in mkADeg happy (happie + "r") (happie + "st") happily ;
--
--  duplADeg fat = 
--    mkADeg fat 
--    (fat + last fat + "er") (fat + last fat + "est") (fat + "ly") ;
--
--  compoundADeg a =
--    let ad = (a.s ! AAdj Posit) 
--    in mkADeg ad ("more" ++ ad) ("most" ++ ad) (a.s ! AAdv) ;
--
--  adegA a = a ;
--
--  mkAdv x = ss x ** {lock_Adv = <>} ;
--  mkAdV x = ss x ** {lock_AdV = <>} ;
--  mkAdA x = ss x ** {lock_AdA = <>} ;
--
--  mkPreposition p = p ;
--  mkPrep p = ss p ** {lock_Prep = <>} ;
--
--  mkV a b c d e = mkVerb a b c d e ** {s1 = [] ; lock_V = <>} ;
--
--  regV cry = 
--    let
--      cr = init cry ;
--      y  = last cry ;
--      cries = (regN cry).s ! Pl ! Nom ; -- !
--      crie  = init cries ;
--      cried = case last crie of {
--        "e" => crie + "d" ;
--        _   => crie + "ed"
--        } ;
--      crying = case y of {
--        "e" => case last cr of {
--           "e" => cry + "ing" ; 
--           _ => cr + "ing" 
--           } ;
--        _   => cry + "ing"
--        }
--    in mkV cry cries cried cried crying ;
--
--  regDuplV fit = 
--    let fitt = fit + last fit in
--    mkV fit (fit + "s") (fitt + "ed") (fitt + "ed") (fitt + "ing") ;
--
--  irregV x y z = let reg = (regV x).s in
--    mkV x (reg ! VPres) y z (reg ! VPresPart) ** {s1 = [] ; lock_V = <>} ;
--
--  irregDuplV fit y z = 
--    let 
--      fitting = (regDuplV fit).s ! VPresPart
--    in
--    mkV fit (fit + "s") y z fitting ;
--
--  partV v p = verbPart v p ** {lock_V = <>} ;
--  reflV v = {s = v.s ; part = v.part ; lock_V = v.lock_V ; isRefl = True} ;
--
--  mkV2 v p = v ** {s = v.s ; s1 = v.s1 ; c2 = p ; lock_V2 = <>} ;
--  dirV2 v = mkV2 v [] ;
--
--  mkV3 v p q = v ** {s = v.s ; s1 = v.s1 ; c2 = p ; c3 = q ; lock_V3 = <>} ;
--  dirV3 v p = mkV3 v [] p ;
--  dirdirV3 v = dirV3 v [] ;
--
--  mkVS  v = v ** {lock_VS = <>} ;
--  mkVV  v = {
--    s = table {VVF vf => v.s ! vf ; _ => variants {}} ; 
--    isAux = False ; lock_VV = <>
--    } ;
--  mkVQ  v = v ** {lock_VQ = <>} ;
--
--  V0 : Type = V ;
--  V2S, V2V, V2Q, V2A : Type = V2 ;
--  AS, A2S, AV : Type = A ;
--  A2V : Type = A2 ;
--
--  mkV0  v = v ** {lock_V = <>} ;
--  mkV2S v p = mkV2 v p ** {lock_V2 = <>} ;
--  mkV2V v p t = mkV2 v p ** {s4 = t ; lock_V2 = <>} ;
--  mkVA  v = v ** {lock_VA = <>} ;
--  mkV2A v p = mkV2 v p ** {lock_V2A = <>} ;
--  mkV2Q v p = mkV2 v p ** {lock_V2 = <>} ;
--
--  mkAS  v = v ** {lock_A = <>} ;
--  mkA2S v p = mkA2 v p ** {lock_A = <>} ;
--  mkAV  v = v ** {lock_A = <>} ;
--  mkA2V v p = mkA2 v p ** {lock_A2 = <>} ;
--
} ;

