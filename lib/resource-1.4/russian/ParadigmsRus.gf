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
          nomPl, genPl, datPl, accPl, instPl, preposPl : Str) -> Gender -> Animacy -> N ; 

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

} ;

