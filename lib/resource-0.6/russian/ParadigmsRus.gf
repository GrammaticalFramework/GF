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

resource ParadigmsRus = open (Predef=Predef), Prelude, SyntaxRus, ResourceRus in {
 
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

  singular : Number ;
  plural   : Number ;

--2 Nouns

-- Best case: indeclinabe nouns: "кофе", "пальто", "ВУЗ".
 
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

  nStomatolog : Str -> N ;    -- masculine, animate, ending with consonant
                              
                              -- the next two differ only in 
                              -- plural nominative (= accusative) form(s) :
  nAdres     : Str -> N ;     -- адрес-а
  nTelefon   : Str -> N ;     -- телефон-ы
                              -- masculine, inanimate, ending with consonant

  nNol       : Str -> N ;    -- masculine, inanimate, ending with "-ь" (soft sign)
  nUroven    : Str -> N ;    -- masculine, inanimate, ending with "-ень"

-- Nouns used as functions need a preposition. The most common is with Genitive.

  mkFun  : N -> Preposition -> Case -> Fun ;
  funGen : N -> Fun ;

-- Proper names.

  mkPN  : Str -> Gender -> Animacy -> PN ;          -- "Иван", "Маша"

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

-- mkAdj1 : ( : Str) -> Adj1 ;

-- Invariable adjective is a special case.

   adjInvar : Str -> Adj1 ;          -- khaki, mini, hindi, netto

-- Some regular patterns depending on the ending.

   adj1Staruyj : Str -> Adj1 ;             -- ending with "-ый"
   adj1Malenkij : Str -> Adj1 ;            -- endign with "-ий"
   adj1Molodoj : Str -> Adj1 ;             -- ending with "-ой", 
                                           -- plural - молод-ые"
   adj1Kakoj_Nibud : Str -> Str -> Adj1 ;  -- ending with "-ой", 
                                           -- plural - "как-ие"

-- Two-place adjectives need a preposition and a case as extra arguments.

   mkAdj2 : Adj1 -> Str -> Case -> Adj2 ;  -- "делим на"

-- Comparison adjectives need a positive adjective 
-- (28 forms without short forms). 
-- Taking only one comparative form (non-syntaxic) and 
-- only one superlative form (syntaxic) we can produce the
-- comparison adjective with only one extra argument -
-- non-syntaxic comparative form.
-- Syntaxic forms are based on the positive forms.


   mkAdjDeg : Adj1 -> Str -> AdjDeg ;

-- On top level, there are adjectival phrases. The most common case is
-- just to use a one-place adjective. 

   ap : Adj1  -> IsPostfixAdj -> AP ;


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

-- The worst case need 6 forms of the present tense in indicative mood
-- ("я бегу", "ты бежишь", "он бежит", "мы бежим", "вы бежите", "они бегут"),
-- a past form (singular, masculine: "я бежал"), an imperative form 
-- (singular, second person: "беги"), an infinitive ("бежать").
-- Inherent aspect should also be specified.

   mkVerbum : Aspect -> (_,_,_,_,_,_,_,_,_ : Str) -> Verbum ;

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

   mkRegVerb :Aspect -> Conjugation -> (_,_,_,_,_ : Str) -> Verbum ; 

-- For writing an application grammar one usualy doesn't need
-- the whole inflection table, since each verb is used in 
-- a particular context that determines some of the parameters
-- (Tense and Voice while Aspect is fixed from the beginning) for certain usage. 
-- The "V" type, that have these parameters fixed. 
-- We can extract the "V" from the lexicon.

   mkV: Verbum -> Voice -> Tense -> V ;
   mkPresentV: Verbum -> Voice -> V ;


-- Two-place verbs, and the special case with direct object. Notice that
-- a particle can be included in a $V$.

   mkTV     : V   -> Str -> Case -> TV ;   -- "войти в дом"; "в", accusative
   tvDir    : V -> TV ;                    -- "видеть", "любить"
                               
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.
--.
  Gender = SyntaxRus.Gender ;

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

  nStomatolog = \s -> nullEndAnimateDecl s ** {lock_N = <>}; 
                              
  nAdres     = \s -> nullEndInAnimateDecl2 s ** {lock_N = <>}; 
  nTelefon   = \s -> nullEndInAnimateDecl1 s ** {lock_N = <>}; 

  nNol       = \s -> softSignEndDeclMasc s ** {lock_N = <>};
  nUroven    = \s -> EN_softSignEndDeclMasc s ** {lock_N = <>};

-- mkFun     defined in syntax.RusU
-- funGen    defined in syntax.RusU 

  mkPN = \ivan, g, anim -> 
    case g of { 
       Masc => mkProperNameMasc ivan anim ; 
       _ => mkProperNameFem ivan anim
    } ** {lock_PN =<>};
  mkCN = UseN ;
  mkNP = \x,y,z -> UsePN (mkPN x y z) ;

-- Adjective definitions

  adjInvar = \s -> { s = \\af => s } ** {lock_Adj1= <>};

  adj1Staruyj s = uy_j_EndDecl s ** {lock_Adj1 = <>} ;       
  adj1Malenkij s = ij_EndK_G_KH_Decl s ** {lock_Adj1= <>};       
  adj1Molodoj s = uy_oj_EndDecl s ** {lock_Adj1= <>};        
  adj1Kakoj_Nibud s t = i_oj_EndDecl s t ** {lock_Adj1= <>}; 

  mkAdj2 a p c= mkAdjective2 a p c ** {lock_Adj2 = <>};
  -- mkAdjDeg defined in morpho.RusU

  ap a p = mkAdjPhrase a p ** {lock_AP = <>};  -- defined in syntax module

-- Verb definitions 

   mkVerbum = \asp, sgP1, sgP2, sgP3, plP1, plP2, plP3, 
     sgMascPast, imperSgP2, inf -> case asp of { 
       Perfective  =>  
         mkVerb (perfectiveActivePattern inf imperSgP2 
         (presentConj sgP1 sgP2 sgP3 plP1 plP2 plP3) (pastConj sgMascPast))
         (pastConj sgMascPast);
       Imperfective  =>  
         mkVerb (imperfectiveActivePattern inf imperSgP2 
         (presentConj sgP1 sgP2 sgP3 plP1 plP2 plP3) (pastConj sgMascPast))
         (pastConj sgMascPast)
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


   mkRegVerb = verbDecl ;                  -- defined in morpho.RusU.gf

   mkV a b c = extVerb a b c ** {lock_V = <>};                         -- defined in types.RusU.gf

   mkPresentV = \aller, vox -> 
    { s = table { 
       VFin gn p => aller.s ! VFORM vox (VIND (VPresent (numGNum gn) p)) ;
       VImper n p => aller.s ! VFORM vox (VIMP n p) ;
       VInf => aller.s ! VFORM vox VINF ;
       VSubj gn => aller.s ! VFORM vox (VSUB gn)
       }; t = Present ; a = aller.asp ; w = vox ; lock_V = <>} ;

   mkTV a b c = mkTransVerb a b c ** {lock_TV = <>};                    -- defined in syntax.RusU.gf
   tvDir v = mkDirectVerb v ** {lock_TV = <>};                           -- defined in syntax.RusU.gf

} ;
