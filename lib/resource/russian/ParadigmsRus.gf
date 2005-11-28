--# -path=.:../abstract:../../prelude 

--1 Russian Lexical Paradigms
--
-- Aarne Ranta, Janna Khegai 2003
--
-- This is an API to the user of the resource grammar 
-- for adding lexical items. It give shortcuts for forming
-- expressions of basic categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $resource.Abs.gf$. 
--
--
-- The following files are presupposed:

resource ParadigmsRus = open (Predef=Predef), Prelude, MorphoRus, SyntaxRus, 
CategoriesRus, RulesRus in {
 
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

  mkN  : (_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Gender -> Animacy -> N ; 

     -- мужчина, мужчины, мужчине, мужчину, мужчиной, мужчине
     -- мужчины, мужчин, мужчинам, мужчин, мужчинами, мужчинах


-- Here are some common patterns. The list is far from complete.

-- Feminine patterns.

  nMashina   : Str -> N ;    -- feminine, inanimate, ending with "-а", Inst -"машин-ой"
  nEdinica   : Str -> N ;    -- feminine, inanimate, ending with "-а", Inst -"единиц-ей"
  nZhenchina : Str -> N ;    -- feminine, animate, ending with "-a"
  nNoga      : Str -> N ;    -- feminine, inanimate, ending with "г_к_х-a"
  nMalyariya  : Str -> N ;    -- feminine, inanimate, ending with "-ия"   
  nTetya     : Str -> N ;    -- feminine, animate, ending with "-я"   
  nBol       : Str -> N ;    -- feminine, inanimate, ending with "-ь"(soft sign)     

-- Neuter patterns. 

  nObezbolivauchee : Str -> N ;   -- neutral, inanimate, ending with "-ee" 
  nProizvedenie : Str -> N ;   -- neutral, inanimate, ending with "-e" 
  nChislo : Str -> N ;   -- neutral, inanimate, ending with "-o" 

-- Masculine patterns. 

--Ending with consonant: 
  nBrat: Str -> N ;   -- animate, брат-ья
  nStul: Str -> N ;    -- same as above, but inanimate
  nMalush : Str -> N ; -- малышей
  nPotolok : Str -> N ; -- потол-ок - потол-ка

 -- the next four differ in plural nominative and/or accusative form(s) :
  nBank: Str -> N ;    -- банк-и (Nom=Acc)
  nStomatolog : Str -> N ;  -- same as above, but animate
  nAdres     : Str -> N ;     -- адрес-а (Nom=Acc)
  nTelefon   : Str -> N ;     -- телефон-ы (Nom=Acc)

  nNol       : Str -> N ;    -- masculine, inanimate, ending with "-ь" (soft sign)
  nUroven    : Str -> N ;    -- masculine, inanimate, ending with "-ень"

-- Nouns used as functions need a preposition. The most common is with Genitive.

  mkFun  : N -> Preposition -> Case -> N2 ;
  mkN2 : N -> N2 ;
  mkN3 : N -> Preposition -> Preposition -> N3 ;

-- Proper names.

  mkPN  : Str -> Gender -> Animacy -> PN ;          -- "Иван", "Маша"
  nounPN : N -> PN ;
  
-- On the top level, it is maybe $CN$ that is used rather than $N$, and
-- $NP$ rather than $PN$.

  mkCN  : N -> CN ;
  mkNP  : Str -> Gender -> Animacy -> NP ;


--2 Adjectives

-- Non-comparison (only positive degree) one-place adjectives need 28 (4 by 7)
-- forms in the worst case:


--                        Masculine  | Feminine | Neutral | Plural
--  Nominative
--  Genitive
--  Dative
--  Accusative Inanimate
--  Accusative Animate
--  Instructive
--  Prepositional


-- Notice that 4 short forms, which exist for some adjectives are not included 
-- in the current description, otherwise there would be 32 forms for 
-- positive degree.

-- mkA : ( : Str) -> A ;

-- Invariable adjective is a special case.

   adjInvar : Str -> A ;          -- khaki, mini, hindi, netto

-- Some regular patterns depending on the ending.

   AStaruyj : Str -> A ;             -- ending with "-ый"
   AMalenkij : Str -> A ;            -- ending with "-ий", Gen - "маленьк-ого"
   AKhoroshij : Str -> A ;         --  ending with "-ий", Gen - "хорош-его"
     AMolodoj : Str -> A ;             -- ending with "-ой", 
                                           -- plural - молод-ые"
   AKakoj_Nibud : Str -> Str -> A ;  -- ending with "-ой", 
                                           -- plural - "как-ие"

-- Two-place adjectives need a preposition and a case as extra arguments.

   mkA2 : A -> Str -> Case -> A2 ;  -- "делим на"

-- Comparison adjectives need a positive adjective 
-- (28 forms without short forms). 
-- Taking only one comparative form (non-syntaxic) and 
-- only one superlative form (syntaxic) we can produce the
-- comparison adjective with only one extra argument -
-- non-syntaxic comparative form.
-- Syntaxic forms are based on the positive forms.


   mkADeg : A -> Str -> ADeg ;

-- On top level, there are adjectival phrases. The most common case is
-- just to use a one-place adjective. 

   ap : A  -> IsPostfixAdj -> AP ;

--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. Some can be preverbal (e.g. "always").

  mkAdv : Str -> Adv ;

--2 Verbs
--
-- In our lexicon description ("Verbum") there are 62 forms: 
-- 2 (Voice) by { 1 (infinitive) + [2(number) by 3 (person)](imperative) + 
-- [ [2(Number) by 3(Person)](present) + [2(Number) by 3(Person)](future) + 
-- 4(GenNum)(past) ](indicative)+ 4 (GenNum) (subjunctive) } 
-- Participles (Present and Past) and Gerund forms are not included, 
-- since they fuction more like Adjectives and Adverbs correspondingly
-- rather than verbs. Aspect regarded as an inherent parameter of a verb.
-- Notice, that some forms are never used for some verbs. Actually, 
-- the majority of verbs do not have many of the forms.
Voice: Type; 
Aspect: Type; 
Tense : Type;  
Bool: Type;
Conjugation: Type ;

first: Conjugation;
firstE: Conjugation;
second: Conjugation;
mixed: Conjugation;
dolzhen: Conjugation;

true: Bool;
false: Bool;
 
active: Voice ;
passive: Voice ;
imperfective: Aspect;
perfective: Aspect ;  
present : Tense ;
past : Tense ;


-- The worst case need 6 forms of the present tense in indicative mood
-- ("я бегу", "ты бежишь", "он бежит", "мы бежим", "вы бежите", "они бегут"),
-- a past form (singular, masculine: "я бежал"), an imperative form 
-- (singular, second person: "беги"), an infinitive ("бежать").
-- Inherent aspect should also be specified.

   mkVerbum : Aspect -> (_,_,_,_,_,_,_,_,_ : Str) -> V ;

-- Common conjugation patterns are two conjugations: 
--  first - verbs ending with "-ать/-ять" and second - "-ить/-еть".
-- Instead of 6 present forms of the worst case, we only need
-- a present stem and one ending (singular, first person):
-- "я люб-лю", "я жд-у", etc. To determine where the border
-- between stem and ending lies it is sufficient to compare 
-- first person from with second person form:
-- "я люб-лю", "ты люб-ишь". Stems shoud be the same.
-- So the definition for verb "любить"  looks like:
-- mkRegVerb Imperfective Second "люб" "лю" "любил" "люби" "любить";

   mkRegVerb :Aspect -> Conjugation -> (_,_,_,_,_ : Str) -> V ; 

-- For writing an application grammar one usualy doesn't need
-- the whole inflection table, since each verb is used in 
-- a particular context that determines some of the parameters
-- (Tense and Voice while Aspect is fixed from the beginning) for certain usage. 
-- The "V" type, that have these parameters fixed. 
-- We can extract the "V" from the lexicon.

--   mkV: Verbum -> Voice ->  V ;
--   mkPresentV: Verbum -> Voice -> V ;


-- Two-place verbs, and the special case with direct object. Notice that
-- a particle can be included in a $V$.

   mkTV     : V   -> Str -> Case -> V2 ;   -- "войти в дом"; "в", accusative
   mkV3  : V -> Str -> Str -> Case -> Case -> V3 ; -- "сложить письмо в конверт"
   tvDir    : V -> V2 ;                    -- "видеть", "любить"
   tvDirDir : V -> V3 ; 
                            
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.
--.
  Gender = SyntaxRus.Gender ;
  Case = SyntaxRus.Case ;
  Number = SyntaxRus.Number ;
  Animacy = SyntaxRus.Animacy;
  Aspect = SyntaxRus.Aspect;
  Voice = SyntaxRus.Voice ;
  Tense = SyntaxRus.RusTense ;
   Bool = Prelude.Bool ;
  Conjugation = MorphoRus.Conjugation;
first = First ;
firstE = FirstE ;
second = Second ;
mixed = Mixed ;
dolzhen = Dolzhen; 

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
  present = Present ;
  past = Past ;
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


  mkN =  \nomSg, genSg, datSg, accSg, instSg, preposSg,
          nomPl, genPl, datPl, accPl, instPl, preposPl, g, anim ->
   {
     s = table { 
           SF Sg Nom => nomSg ;
           SF Sg Gen => genSg ;
           SF Sg Dat => datSg ;
           SF Sg Acc => accSg ;
           SF Sg Inst => instSg ;
           SF Sg Prepos => preposSg ;
           SF Pl Nom => nomPl ;
           SF Pl Gen => genPl ;
           SF Pl Dat => datPl ;
           SF Pl Acc => accPl ;
           SF Pl Inst => instPl ;
           SF Pl Prepos => preposPl      
     } ;                           
     g = g ;
     anim = anim
   } ** {lock_N = <>}  ;

  nMashina   = \s -> aEndInAnimateDecl s ** {lock_N = <>};
  nEdinica   = \s -> ej_aEndInAnimateDecl s ** {lock_N = <>};
  nZhenchina = \s -> (aEndAnimateDecl s) ** { g = Fem ; anim = Animate } ** {lock_N = <>}; 
  nNoga      = \s -> aEndG_K_KH_Decl s ** {lock_N = <>};    
  nMalyariya  = \s -> i_yaEndDecl s ** {lock_N = <>};
  nTetya     = \s -> (yaEndAnimateDecl s) ** {g = Fem; anim = Animate; lock_N = <>} ;
  nBol       = \s -> softSignEndDeclFem  s ** {lock_N = <>};

-- Neuter patterns. 

  nObezbolivauchee = \s -> eeEndInAnimateDecl s ** {lock_N = <>};
  nProizvedenie = \s -> eEndInAnimateDecl s ** {lock_N = <>};
  nChislo = \s -> oEndInAnimateDecl s ** {lock_N = <>};


-- Masculine patterns. 
  nBank = \s -> nullEndInAnimateDecl s ** {lock_N = <>}; 
  nStomatolog = \s -> nullEndAnimateDecl s ** {lock_N = <>};
  nMalush = \s -> shEndDeclMasc s ** {lock_N = <>};
  nPotolok = \s ->okEndDeclMasc s ** {lock_N = <>};

  nBrat = \s -> nullEndAnimateDeclBrat s** {lock_N = <>}; 
  nStul = \s -> nullEndInAnimateDeclStul s** {lock_N = <>}; 

  nAdres     = \s -> nullEndInAnimateDecl2 s ** {lock_N = <>}; 
  nTelefon   = \s -> nullEndInAnimateDecl1 s ** {lock_N = <>}; 

  nNol       = \s -> softSignEndDeclMasc s ** {lock_N = <>};
  nUroven    = \s -> EN_softSignEndDeclMasc s ** {lock_N = <>};

-- mkFun     defined in syntax.RusU
 mkN2 n = funGen n ** {lock_N2 = <>} ; --   defined in syntax.RusU 

mkN3 n p r = mkCommNoun3 n p r ** {lock_N3 = <>} ; --   defined in syntax.RusU 

  mkPN = \ivan, g, anim -> 
    case g of { 
       Masc => mkProperNameMasc ivan anim ; 
       _ => mkProperNameFem ivan anim
    } ** {lock_PN =<>};
  nounPN  n = (mkCNProperName n)**{lock_PN=<>};

  mkCN = UseN ;
  mkNP = \x,y,z -> UsePN (mkPN x y z) ;

-- Adjective definitions

  adjInvar = \s -> { s = \\af => s } ** {lock_A= <>};

  AStaruyj s = uy_j_EndDecl s ** {lock_A = <>} ;       
    AKhoroshij s = shij_End_Decl s ** {lock_A= <>}; 
AMalenkij s = ij_EndK_G_KH_Decl s ** {lock_A= <>};       
  AMolodoj s = uy_oj_EndDecl s ** {lock_A= <>};        
  AKakoj_Nibud s t = i_oj_EndDecl s t ** {lock_A= <>}; 

  mkA2 a p c= mkAdjective2 a p c ** {lock_A2 = <>};
  mkADeg a s = mkAdjDeg a s ** {lock_ADeg = <>}; -- defined in morpho.RusU

  ap a p = mkAdjPhrase a p ** {lock_AP = <>};  -- defined in syntax module

  mkAdv x = ss x ** {lock_Adv = <>} ;

-- Verb definitions 

   mkVerbum = \asp, sgP1, sgP2, sgP3, plP1, plP2, plP3, 
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

    mkRegVerb a b c d e f g = verbDecl a b c d e f g ** {lock_V = <>} ;
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
   mkTV a b c = mkTransVerb a b c ** {lock_V2 = <>};                    -- defined in syntax.RusU.gf
   tvDir v = mkDirectVerb v ** {lock_V2 = <>};                           -- defined in syntax.RusU.gf
   tvDirDir v = mkDirDirectVerb v ** {lock_V3 = <>};                  -- defined in syntax.RusU.gf
mkV3 v s w c d = mkDitransVerb v s w c d ** {lock_V3 = <>};  -- defined in syntax.RusU.gf

} ;
