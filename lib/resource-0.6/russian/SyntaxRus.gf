--1 A Small Russian Resource Syntax          
--
-- Aarne Ranta, Janna Khegai 2003
--
-- This resource grammar contains definitions needed to construct 
-- indicative, interrogative, and imperative sentences in Russian.
--
-- The following files are presupposed:
resource SyntaxRus = MorphoRus ** open Prelude, (CO = Coordination) in {
flags  coding=utf8 ;
  
--2 Common Nouns
--
--
--3 Common noun phrases
--
-- Complex common nouns ($Comm'NounPhrase$)  have in principle
-- the same parameters as simple ones.

oper
  CommNounPhrase: Type = {s : Number => Case => Str; g : Gender; anim : Animacy}  ;

  noun2CommNounPhrase : CommNoun -> CommNounPhrase = \sb ->
    {s = \\n,c => sb.s ! SF n c ; 
     g = sb.g ; 
     anim = sb.anim
    } ;

  commNounPhrase2CommNoun : CommNounPhrase -> CommNoun = \sb ->
    {s = \\sf => sb.s ! (numSF sf) ! (caseSF sf) ; 
     g = sb.g ; 
     anim = sb.anim
    } ;

  n2n = noun2CommNounPhrase;
  n2n2 = commNounPhrase2CommNoun ;

--2 Noun Phrases
--

oper

  NounPhrase : Type = { s : PronForm => Str ; n : Number ; 
   p : Person ; g: PronGen ; anim : Animacy ;  pron: Bool} ;

-- The following construction has to be refined for genitive forms:
-- "we two", "us two" are OK, but "our two" is not.
--  actually also "Animacy" for numerals 1-4 should be resent

  Numeral : Type = {s : Case => Gender => Str} ;

  pronWithNum : NounPhrase -> Numeral -> NounPhrase = \mu,dva ->
    {s = \\pf => mu.s!pf ++ dva.s ! (extCase pf) ! (pgen2gen mu.g) ; 
     n = mu.n ; p = mu.p; g = mu.g ; pron = mu.pron; anim = mu.anim } ;

 noNum : Numeral = {s = \\_,_ => []} ;

-- unclear how to tell apart the numbers from their string representation,
-- so just leave a decimal representation, without case-suffixes:

 useInt : Str -> Numeral = \i -> 
    {s = table { _ => table {_ => i }
--        Nom => table {_ => i }; 
 --       Gen => table {_ => i ++ "-х"};
 --       Dat => table {_ => i ++ "'-м"};
 --       Acc => table {_ => i };
 --       Inst => table {_ => i ++ "-мя"};
 --       Prepos => table {_ => i ++ "-х"}
         }
    } ;

  -- A function specific for Russian for setting the gender for 
  -- personal pronouns in first and second person, singular :
  setNPGender : Gender -> NounPhrase -> NounPhrase = \gen, pronI -> 
    { s = pronI.s ; g = PGen gen; anim = pronI.anim ;
      n = pronI.n ; nComp = pronI.nComp ; p = pronI.p ; pron = pronI.pron } ;  


  mkNounPhrase : Number -> CommNounPhrase -> NounPhrase = \n,chelovek -> 
    {s = \\cas => chelovek.s ! n ! (extCase cas) ;
     n = n ; g = PGen chelovek.g ; p = P3 ; pron =False ;
     anim = chelovek.anim 
    } ;
  pron2NounPhrase : Pronoun -> Animacy -> NounPhrase = \ona, anim -> 
    {s = ona.s ; n = ona.n ; g =  ona.g ; 
     pron = ona.pron; p = ona.p ; anim = anim } ;

  det2NounPhrase : Adjective -> NounPhrase = \eto -> 
    {s = \\pf => eto.s ! (AF (extCase pf) Inanimate (ASg Neut)); n = Sg ; g = PGen Neut ; pron = False ; p = P3 ; anim = Inanimate } ;

  nameNounPhrase : ProperName -> NounPhrase = 
    \masha -> {s = \\c => masha.s ! (extCase c) ; 
      p = P3; g = PGen masha.g ; anim = masha.anim ; 
      n = Sg; nComp = Sg; pron = False} ;


--2 Determiners
--
-- Determiners (only determinative pronouns 
-- (or even indefinite numerals: "много" (many)) in Russian) are inflected 
-- according to the gender of nouns they determine.
-- extra parameters (Number and Case) are added for the sake of                            	
-- the determinative pronoun "bolshinstvo" ("most");
-- Gender parameter is due to multiple determiners (Numerals in Russian)
-- like "mnogo"
-- The determined noun has the case parameter specific for the determiner:

  Determiner : Type = Adjective ** { n: Number; g: PronGen; c : Case } ;

  anyPlDet = kakojNibudDet ** {n = Pl;  c= Nom} ; 

  mkDeterminerNum : Determiner -> Numeral -> Determiner = \vse,dva -> 
    {s =\\af => vse.s ! af ++ dva.s ! (caseAF af) ! (genAF af) ; 
     n = vse.n; g = vse.g; c=vse.c
    } ;

  detNounPhrase : Determiner -> CommNounPhrase -> NounPhrase = \kazhduj, okhotnik -> 
    {s = \\c => case kazhduj.c of {
       Nom => 
        kazhduj.s ! AF (extCase c) okhotnik.anim (gNum okhotnik.g kazhduj.n) ++ 
         okhotnik.s ! kazhduj.n ! (extCase c) ; 
       _ => 
        kazhduj.s ! AF (extCase c) okhotnik.anim (gNum okhotnik.g kazhduj.n) ++ 
         okhotnik.s ! kazhduj.n ! kazhduj.c };
     n = kazhduj.n ; 
     p = P3 ;
     pron = False;
     g = kazhduj.g ;
     anim = okhotnik.anim 
    } ;

 indefNounPhrase : Number -> CommNounPhrase -> NounPhrase = \n ->
    indefNounPhraseNum n noNum ; 

-- a problem: "2 бутылки", but "5 бутылок" in Nominative case! Ignored for the moment:
  indefNounPhraseNum : Number -> Numeral ->CommNounPhrase -> NounPhrase = 
    \n,dva,mashina -> 
    {s = \\c =>  dva.s ! (extCase c) ! mashina.g ++  mashina.s ! n !  (extCase c) ;
     n = n ; p = P3; g = PGen mashina.g ; anim = mashina.anim ; 
     pron = False
    } ;

-- Genitives of noun phrases can be used like determiners, 
-- to build noun phrases.
-- The number argument makes the difference between "мой дом" - "мои дома".
--
-- The variation like in "the car of John / John's car" in English is
-- not equally natural for proper names and pronouns and the rest of nouns.
-- Compare "дверца машины" and "машины дверца", while 
-- "Ванина мама" and "мама Вани" or "моя мама" and "мама моя".
-- Here we have to make a choice of a universal form, which will be
-- "моя мама" - "Вани мама" - "машины дверца", which sounds
-- the best for pronouns, a little worse for proper names and 
-- the worst for the rest of nouns. The reason is the fact that 
-- possession/genetive is more a human category and pronouns are 
-- used very often, so we try to suit this case in the first place.

  npGenDet : Number -> Numeral -> NounPhrase -> CommNounPhrase -> NounPhrase = 
    \n,dva, masha,mashina -> 
      {s = \\c => case masha.pron of 
           { True =>  masha.s ! (mkPronForm  (extCase c) No (Poss (gNum mashina.g n))) ++ 
                   dva.s ! (extCase c) ! mashina.g ++ mashina.s ! n ! (extCase c)  ;
             False =>  dva.s ! (extCase c) ! mashina.g ++ mashina.s ! n ! (extCase c)  ++         
                             masha.s ! (mkPronForm Gen No (Poss (gNum mashina.g n))) 
       } ;
       n = n ; p = P3 ;  g = PGen mashina.g ; anim = mashina.anim ; pron = False
      } ;

-- Constructions like "the idea that two is even" are formed at the
-- first place as common nouns, so that one can also have "a suggestion that...".

  nounThatSentence : CommNounPhrase -> Sentence -> CommNounPhrase = \idea,x -> 
    {s = \\n,c => idea.s ! n ! c ++ ["о том, что"] ++ x.s ; 
     g = idea.g; anim = idea.anim
    } ;
           
--2 Adjectives
--3 Simple adjectives
--
-- A special type of adjectives just having positive forms 
-- (for semantic reasons)  is useful, e.g. "русский".
 
oper 
   extAdjective : AdjDegr -> Adjective = \adj ->
    { s = \\af => adj.s ! Pos ! af } ;

  -- Coercions between the compound gen-num type and gender and number:

  gNum : Gender -> Number -> GenNum = \g,n -> 
    case n of 
   {   Sg => case g of 
                 { Fem => ASg Fem ;
                   Masc => ASg Masc ;
                   Neut => ASg Neut  } ;
       Pl => APl
   } ;

pgNum : PronGen -> Number -> GenNum = \g,n -> 
    case n of 
   {   Sg => case g of 
                 { PGen Fem => ASg Fem ;
                   PGen Masc => ASg Masc ;
                   PGen Neut => ASg Neut ;
                   _ => ASg Masc } ; 
        Pl => APl
   } ;
              --    _  => variants {ASg Masc ; ASg Fem}  } ; 
              --  "variants" version cause "no term variants" error during linearization


--3 Adjective phrases
-- 
-- An adjective phrase may contain a complement, e.g. "моложе Риты".
-- Then it is used as postfix in modification, e.g. "человек, моложе Риты".

  IsPostfixAdj = Bool ;

  AdjPhrase : Type = Adjective ** {p : IsPostfixAdj} ;

-- Simple adjectives are not postfix:

  adj2adjPhrase : Adjective -> AdjPhrase = \novuj -> novuj ** {p = False} ;

  mkAdjPhrase : Adjective -> IsPostfixAdj  -> AdjPhrase = \novuj ,p -> novuj ** {p = p} ;

  mkAdjective2: Adjective-> Str-> Case -> AdjCompl =  \a,p,c -> a ** {s2 = p ; c = c} ;

--3 Comparison adjectives
--
-- Each of the comparison forms has a characteristic use:
--
-- Positive forms are used alone, as adjectival phrases ("большой").

  positAdjPhrase : AdjDegr -> AdjPhrase = \bolshoj -> 
    adj2adjPhrase (extAdjective bolshoj) ;

-- Comparative forms are used with an object of comparison, as
-- adjectival phrases ("больше тебя").

  comparAdjPhrase : AdjDegr -> NounPhrase -> AdjPhrase = \bolshoj, tu ->
    {s = \\af => bolshoj.s ! Comp ! af ++ tu.s ! (mkPronForm Gen Yes NonPoss) ; 
     p = True
    } ;

-- Superlative forms are used with a modified noun, picking out the
-- maximal representative of a domain ("самый большой дом").

  superlNounPhrase : AdjDegr -> CommNounPhrase -> NounPhrase = \bolshoj, dom ->
    {s = \\pf => bolshoj.s ! Super ! AF (extCase pf) dom.anim (gNum dom.g Sg) ++ 
         dom.s  ! Sg ! (extCase pf) ; 
     n = Sg ;
     p = P3 ;
     pron = False;
     anim = dom.anim ;
     g = PGen dom.g
    } ;


--3 Two-place adjectives
--
-- A two-place adjective is an adjective with a preposition used before
-- the complement. (Rem. $Complement =  {s2 : Str ; c : Case} $).

  
  AdjCompl = Adjective ** Complement ;

  complAdj : AdjCompl -> NounPhrase -> AdjPhrase = \vlublen,tu ->
    {s = \\af => vlublen.s ! af ++ vlublen.s2 ++ 
          tu.s ! (mkPronForm vlublen.c No NonPoss) ;
     p = True
    } ;

--3 Complements
--

  Complement =  {s2 : Str ; c : Case} ;

  complement : Str -> Complement = \cherez ->
    {s2 = cherez ; c = Nom} ;

  complementDir : Complement = complement [] ;

  complementCas : Case -> Complement = \c ->
    {s2 = [] ; c = c} ;

--2 Individual-valued functions

-- An individual-valued function is a common noun together with the
-- preposition prefixed to its argument ("ключ от дома").
-- The situation is analogous to two-place adjectives and transitive verbs.
--
-- We allow the genitive construction to be used as a variant of
-- all function applications. It would definitely be too restrictive only
-- to allow it when the required case is genitive. We don't know if there
-- are counterexamples to the liberal choice we've made.

  Function = CommNounPhrase ** Complement ;


-- The application of a function gives, in the first place, a common noun:
-- "ключ от дома". From this, other rules of the resource grammar 
-- give noun phrases, such as "ключи от дома", "ключи от дома
-- и от машины", and "ключ от дома и машины" (the
-- latter two corresponding to distributive and collective functions,
-- respectively). Semantics will eventually tell when each
-- of the readings is meaningful.

  appFunComm : Function -> NounPhrase -> CommNounPhrase = \mama,ivan -> 
     {s = \\n, cas =>  case ivan.pron of 
       { True => ivan.s ! (mkPronForm cas No (Poss (gNum mama.g n))) ++ mama.s ! n ! cas;
         False => mama.s ! n ! cas ++ mama.s2 ++ 
         ivan.s ! (mkPronForm mama.c Yes (Poss (gNum mama.g n)))
       };
       g = mama.g ;
       anim = mama.anim
      } ;

-- It is possible to use a function word as a common noun; the semantics is
-- often existential or indexical.

  funAsCommNounPhrase : Function -> CommNounPhrase = \x -> x ;

  mkFun : CommNoun -> Str -> Case -> Function = \f,p,c ->
    (n2n f) ** {s2 = p ; c = c} ;


-- The commonest cases are functions with Genitive.

  funGen : CommNoun -> Function = \urovenCen -> 
    mkFun urovenCen [] Gen ;

-- The following is an aggregate corresponding to the original function application
-- producing "детство Ивана" and "Иваново детство". It does not appear in the
-- resource abstract syntax any longer.
-- Both versions return "детсво Ивана" although "Иваново детство"
-- must also be included 
-- Such possesive form is only possible with proper names in Russian :

appFun : Bool -> Function -> NounPhrase -> NounPhrase = \coll,detstvo, ivan -> 
let {n = ivan.n ; nf = if_then_else Number coll Sg n} in 
  variants {
    indefNounPhrase nf (appFunComm detstvo ivan) ; -- detstvoIvana
    npGenDet nf noNum ivan detstvo
 } ;


--3 Modification of common nouns
--
-- The two main functions of adjective are in predication ("Иван - молод")
-- and in modification ("молодой человек"). Predication will be defined
-- later, in the chapter on verbs.

  modCommNounPhrase : AdjPhrase -> CommNounPhrase -> CommNounPhrase = 
    \khoroshij,novayaMashina ->
    {s = \\n, c => 
         khoroshij.s ! AF c novayaMashina.anim (gNum novayaMashina.g n) ++ 
         novayaMashina.s ! n ! c ;
         g = novayaMashina.g ; 
         anim = novayaMashina.anim
     } ;                          

--2 Verbs

--3 Transitive verbs
--
-- Transitive verbs are verbs with a preposition for the complement,
-- in analogy with two-place adjectives and functions.
-- One might prefer to use the term "2-place verb", since
-- "transitive" traditionally means that the inherent preposition is empty
-- and the case is accusative. 
-- Such a verb is one with a *direct object*.
-- Note: Direct verb phrases where the Genitive case is also possible 
-- ("купить хлеба", "не читать газет") are overlooked in mkDirectVerb
-- and can be expressed via more a general rule mkTransVerb.

  TransVerb : Type = Verb ** {s2 : Str ; c: Case } ; 

  complementOfTransVerb : TransVerb -> Complement = \v -> {s2 = v.s2 ; c = v.c} ;
  verbOfTransVerb       : TransVerb -> Verb   = \v -> 
    {s = v.s; t = v.t; a = v.a ; w = v.w } ;

  mkTransVerb : Verb -> Str  -> Case -> TransVerb = \v,p,cas -> 
    v ** {s2 = p ; c = cas } ;

  mkDirectVerb : Verb -> TransVerb = \v -> 
    mkTransVerb v nullPrep Acc;

  nullPrep : Str = [] ;

-- The rule for using transitive verbs is the complementization rule:

  complTransVerb :TransVerb -> NounPhrase -> VerbGroup = \se,tu ->
    {s =\\vf =>  se.s ! vf ++ se.s2 ++ tu.s ! (mkPronForm se.c No NonPoss) ; 
      a = se.a ; t = se.t ; w = se.w   } ;

--3 Verb phrases
--
-- Verb phrases are discontinuous: the parts of a verb phrase are
-- (s) an inflected verb, (s2) verb adverbials (such as negation), and
-- (s3) complement. This discontinuity is needed in sentence formation
-- to account for word order variations.

  VerbGroup = Verb  ;

  VerbPhrase : Type = Verb ** {s2 : Str ; s3 : Gender => Number => Str ;
    negBefore: Bool} ;

-- A simple verb can be made into a verb phrase with an empty complement.
-- There are two versions, depending on if we want to negate the verb.
  predVerbGroup : Bool -> VerbGroup -> VerbPhrase = \b,vidit -> 
    vidit ** {
     s2 = negation b ; 
     s3 = \\_,_ => [] ;
     negBefore = True --  this should be a parameter !
     } ;

  negation : Bool -> Str = \b -> if_then_else Str b [] "не" ; 

-- Sometimes we want to extract the verb part of a verb phrase.

  verbOfPhrase : VerbPhrase -> Verb = \v -> 
    {s = v.s; t = v.t ; a = v.a ; w =v.w} ;

-- Verb phrases can also be formed from adjectives (" молод"),
-- common nouns (" человек"), and noun phrases (" самый молодой").
-- The third rule is overgenerating: " каждый человек" has to be ruled out
-- on semantic grounds.
-- Note: we omit a dash "-" because it will cause problems with negation word order:
-- "Я не - волшебник". Alternatively, we can consider verb-based VP and
-- all the rest.

  predAdverb : Adverb -> VerbGroup = \zloj ->
    { s= \\vf => case vf of {
          VFin _ _ =>  zloj.s ;
          VImper Sg _ => "будь" ++ zloj.s;
          VImper Pl _ => "будьте" ++ zloj.s;
          -- person is ignored !
          VInf  => "быть" ++ zloj.s;
          VSubj _ => ""
          } ;        
      t = Present ; 
      a = Imperfective ;
      w = Act 
    } ;

  predAdjective : AdjPhrase -> VerbGroup = \zloj ->
    { s= \\vf => case vf of {
          VFin gn _ => case (numGNum gn) of { 
             Sg => zloj.s ! AF Nom Animate (ASg (genGNum gn)) ;
              Pl => zloj.s ! AF Nom Animate APl  
          } ;
          VImper Sg _ => "будь" ++ zloj.s ! AF Inst Animate (ASg Masc);
          VImper Pl _ => "будьте" ++ zloj.s ! AF Inst Animate APl  ;
          -- person is ignored !
          VInf  => "быть" ++ zloj.s ! AF Inst Animate (ASg Masc) ;
-- infinitive does not save GenNum info!
          VSubj _ => ""
          } ;        
      t = Present ; 
      a = Imperfective ;
      w = Act 
    } ;

  predCommNoun : CommNounPhrase -> VerbGroup = \chelovek ->
   {  s= \\vf => case vf of {
          VFin gn _ => (indefNounPhrase (numGNum gn) chelovek ).s ! (mkPronForm Nom No NonPoss) ;
          VImper Sg _ => "будь"++ (indefNounPhrase Sg chelovek ).s ! (mkPronForm Inst No NonPoss) ;
          VImper Pl _ => "будьте"++(indefNounPhrase Pl chelovek ).s ! (mkPronForm Inst No NonPoss);
          -- person is ignored !
          VInf  => "быть" ++ (indefNounPhrase Sg chelovek ).s ! (mkPronForm Inst No NonPoss) ;
          VSubj _ => ""
          } ;        
      t = Present ; 
      a = Imperfective ;
      w = Act 
           } ;

  predNounPhrase : NounPhrase -> VerbGroup = \masha ->
    { s= \\vf => case vf of {
          VFin _ _ =>  masha.s ! (mkPronForm Nom No NonPoss) ;
          VImper Sg _ => "будь" ++ masha.s ! (mkPronForm Inst No NonPoss);
          VImper Pl _ => "будьте" ++ masha.s ! (mkPronForm Inst No NonPoss);
          VInf  => "быть" ++ masha.s ! (mkPronForm Inst No NonPoss);
-- infinitive does not save Number parameter!
          VSubj _ => ""
          } ;        
      t = Present ; 
      a = Imperfective ;
      w = Act 
    } ;

  -- A function specific for Russian :
  predNeedShortAdjective: Bool -> NounPhrase -> CommNounPhrase -> Sentence = 
     \ b, Jag, Dig -> { s =
    let {
      mne  = Jag.s ! (mkPronForm Dat No NonPoss) ; 
      nuzhen  = need.s ! AF Nom Inanimate (gNum Dig.g Sg)  ;
      doctor = Dig.s ! Sg ! Nom ;
      ne = negation b
    } in
       mne ++ ne ++ nuzhen ++ doctor 
    } ;

-- Two-place functions add one argument place.

  Function2 = Function ** {s3 : Str; c2: Case} ;

-- There application starts by filling the first place.

  appFun2 : Function2 -> NounPhrase -> Function = \poezd, paris ->
    {s  = \\n,c => poezd.s ! n ! c ++ poezd.s2 ++ paris.s ! (PF poezd.c Yes NonPoss) ;
     g  = poezd.g ; anim = poezd.anim;
     s2 = poezd.s3; c = poezd.c2 
    } ;

-- *Ditransitive verbs* are verbs with three argument places.
-- We treat so far only the rule in which the ditransitive
-- verb takes both complements to form a verb phrase.

  DitransVerb = TransVerb ** {s4 : Str; c2: Case} ; 

  mkDitransVerb : Verb -> Case ->  Case -> DitransVerb = \v,c1,c2 -> 
    v ** {s2 = ""; c = c1; s4 = ""; c2=c2 } ;

  complDitransVerb : DitransVerb -> NounPhrase -> NounPhrase -> VerbGroup = 
    \dat,tu,pivo ->
      let
        tebepivo = dat.s2 ++
         tu.s ! PF dat.c No NonPoss ++ dat.s4 ++ pivo.s ! PF dat.c2 Yes NonPoss 
      in
      {s  = \\vf => (dat.s ! vf) ++ tebepivo ;
      t = dat.t ; 
      a = dat.a ;
      w = dat.w
    } ;


--2 Adverbials
--
  adVerbPhrase : VerbPhrase -> Adverb -> VerbPhrase = \poet, khorosho ->
    {s = \\vf => khorosho.s ++ poet.s ! vf ; s2 = poet.s2; s3 = poet.s3;
     a = poet.a; w = poet.w; t = poet.t ; negBefore = poet.negBefore } ;
                   
-- Adverbials are typically generated by prefixing prepositions.
-- The rule for creating locative noun phrases by the preposition "в"
-- is a little shaky: "в России" but "на острове".
-- Adverbials are typically generated by prefixing prepositions.
-- The rule for creating locative noun phrases by the preposition "in"
-- is a little shaky, since other prepositions may be preferred ("on", "at").

  prepPhrase : Preposition -> NounPhrase -> Adverb = \na, stol ->
    mkAdverb (na.s2 ++ stol.s ! PF na.c Yes NonPoss) ;

  locativeNounPhrase : NounPhrase -> Adverb = \ivan ->
    {s = "в" ++ ivan.s ! (mkPronForm Prepos Yes NonPoss) } ;

   mkAdverb : Str -> Adverb = \well   -> ss well  ;
-- This is a source of the "man with a telescope" ambiguity, and may produce
-- strange things, like "машины всегда".
-- Semantics will have to make finer distinctions among adverbials.

  advCommNounPhrase : CommNounPhrase -> Adverb -> CommNounPhrase = \chelovek,uTelevizora ->
    {s = \\n,c => chelovek.s ! n ! c ++ uTelevizora.s ;
     g = chelovek.g ;
     anim = chelovek.anim 
    } ;

  advAdjPhrase : SS -> AdjPhrase -> AdjPhrase = \ochen, khorosho ->
    {s = \\a => ochen.s ++ khorosho.s ! a ;
     p = khorosho.p
    } ; 

--2 Sentences
--
-- We do not introduce the word order parameter for sentences in Russian
-- although there exist several word orders, but they are too specific
-- to capture on the level we work here. 

oper
   Sentence : Type = { s : Str } ;

-- This is the traditional $S -> NP VP$ rule. 

    predVerbPhrase : NounPhrase -> VerbPhrase -> Sentence = 
    \Ya, tebyaNeVizhu -> { s =
       let 
       { ya = Ya.s ! (mkPronForm Nom No NonPoss);
         ne = tebyaNeVizhu.s2;
        vizhu = tebyaNeVizhu.s ! VFin (pgNum Ya.g Ya.n) Ya.p;
         tebya = tebyaNeVizhu.s3 ! (pgen2gen Ya.g) ! Ya.n 
       }
       in
       if_then_else Str tebyaNeVizhu.negBefore  
        (ya ++ ne ++ vizhu ++ tebya)
        (ya ++ vizhu ++ ne ++ tebya)
       
    } ;

  -- A function specific for Russian: 
  U_predTransVerb : Bool -> TransVerb -> NounPhrase -> NounPhrase -> Sentence = 
    \b,Ser,Jag,Dig -> { s =
    let {
      menya  =  Jag.s ! (mkPronForm Gen Yes NonPoss) ; 
      bolit  = Ser.s ! VFin (gNum (pgen2gen Dig.g) Dig.n) Dig.p ;
      golova = Dig.s ! (mkPronForm Nom No NonPoss) ;
      ne = negation b
    } in
       "у" ++ menya ++ ne ++ bolit  ++ golova 
    } ;


-- This is a macro for simultaneous predication and complementation.

  predTransVerb : Bool -> TransVerb -> NounPhrase -> NounPhrase -> Sentence = 
    \b,vizhu,ya,tu -> predVerbPhrase ya (predVerbGroup b (complTransVerb vizhu tu)) ;
 
--3 Sentence-complement verbs
--
-- Sentence-complement verbs take sentences as complements.

  SentenceVerb : Type = Verb ;

-- To generate "сказал, что Иван гуляет" / "не сказал, что Иван гуляет":

  complSentVerb : SentenceVerb -> Sentence -> VerbGroup = 
    \vidit,tuUlubaeshsya ->
    {s = \\vf => vidit.s ! vf ++ [", что"] ++ tuUlubaeshsya.s ;
     t = vidit.t ; w = vidit.w ; a = vidit.a } ;

--3 Verb-complement verbs
--
-- Sentence-complement verbs take verb phrases as complements.
-- They can be auxiliaries ("can", "must") or ordinary verbs
-- ("try"); this distinction cannot be done in the multilingual
-- API and leads to some anomalies in English, such as the necessity
-- to create the infinitive form "to be able to" for "can" so that
-- the construction can be iterated, and the corresponding complication
-- in the parameter structure.

  VerbVerb : Type = Verb ;

-- To generate "can walk"/"can't walk"; "tries to walk"/"does not try to walk":
-- The contraction of "not" is not provided, since it would require changing
-- the verb parameter type.

  complVerbVerb : VerbVerb -> VerbGroup -> VerbGroup = \putatsya,bezhat ->
  { s =  \\vf => putatsya.s ! vf  ++ bezhat.s ! VInf ; 
      t = putatsya.t ; 
      a = putatsya.a ;
      w = putatsya.w
  } ;

--2 Sentences missing noun phrases
--
-- This is one instance of Gazdar's *slash categories*, corresponding to his
-- $S/NP$.
-- We cannot have - nor would we want to have - a productive slash-category former.
-- Perhaps a handful more will be needed.
--
-- Notice that the slash category has the same relation to sentences as
-- transitive verbs have to verbs: it's like a *sentence taking a complement*.

  SentenceSlashNounPhrase = Sentence ** Complement ;

  slashTransVerb : Bool -> NounPhrase -> TransVerb -> SentenceSlashNounPhrase = 
    \b,ivan,lubit ->
    predVerbPhrase ivan (predVerbGroup b (verbOfTransVerb lubit)) ** 
    complementOfTransVerb lubit ;

thereIs : NounPhrase -> Sentence = \bar ->
    {s = "есть" ++ bar.s ! PF Nom No NonPoss} ;

--2 Coordination
--
-- Coordination is to some extent orthogonal to the rest of syntax, and
-- has been treated in a generic way in the module $CO$ in the file
-- $coordination.gf$. The overall structure is independent of category,
-- but there can be differences in parameter dependencies.
--
--3 Conjunctions
--
-- Coordinated phrases are built by using conjunctions, which are either
-- simple ("и", "или") or distributed ("как - так", "либо - либо").
--
-- The conjunction has an inherent number, which is used when conjoining
-- noun phrases: "Иван и Маша поют" vs. "Иван или Маша поет"; in the
-- case of "или", the result is however plural if any of the disjuncts is.

  Conjunction = CO.Conjunction ** {n : Number} ;
  ConjunctionDistr = CO.ConjunctionDistr ** {n : Number} ;

--2 Relative pronouns and relative clauses
--

oper
  identRelPron : RelPron = { s  = \\gn, c, anim => 
     kotorujDet.s ! (AF c anim gn )} ;

  funRelPron : Function -> RelPron -> RelPron = \mama, kotoruj -> 
    {s = \\gn,c, anim => let {nu = numGNum gn} in
           mama.s ! nu ! c ++  
           mama.s2 ++ kotoruj.s !  gn ! mama.c ! anim
    } ;

-- Relative clauses can be formed from both verb phrases ("видит Машу") and
-- slash expressions ("я вижу"). 

  RelClause : Type = RelPron ;

  relVerbPhrase : RelPron -> VerbPhrase -> RelClause = \kotoruj, gulyaet ->
    { s = \\gn, c, anim =>  let { nu = numGNum gn } in
      kotoruj.s ! gn ! c ! anim ++ gulyaet.s2 ++ gulyaet.s ! VFin gn P3 ++ 
       gulyaet.s3 ! genGNum gn ! nu
    } ;

  relSlash : RelPron -> SentenceSlashNounPhrase -> RelClause = 
   \kotoruj, yaVizhu ->
    {s = \\gn, _ , anim => yaVizhu.s2 ++ kotoruj.s ! gn ! yaVizhu.c ! anim 
         ++ yaVizhu.s 
    } ;

-- A 'degenerate' relative clause is the one often used in mathematics, e.g.
-- "число x, такое что x - четное".

  relSuch : Sentence -> RelClause = \A ->
    {s = \\gn,c, anim => takoj.s ! AF c anim gn ++ "что" ++ A.s } ;

-- The main use of relative clauses is to modify common nouns.
-- The result is a common noun, out of which noun phrases can be formed
-- by determiners. A comma is used before the relative clause.

  modRelClause : CommNounPhrase -> RelClause -> CommNounPhrase = 
    \chelovek,kotorujSmeetsya ->
    { s = \\n,c => chelovek.s ! n ! c ++ "," ++ 
           kotorujSmeetsya.s ! gNum chelovek.g n ! Nom ! chelovek.anim;
      g = chelovek.g ;
      anim = chelovek.anim
    } ;


--2 Interrogative pronouns
--
-- If relative pronouns are adjective-like, interrogative pronouns are
-- noun-phrase-like. Actually we can use the very same type!

  IntPron : Type = NounPhrase ; 

-- In analogy with relative pronouns, we have a rule for applying a function
-- to a relative pronoun to create a new one. We can reuse the rule applying
-- functions to noun phrases!

 funIntPron : Function -> NounPhrase -> NounPhrase = \detstvo, ivan -> 
          indefNounPhrase ivan.n (appFunComm detstvo ivan) ; -- detstvoIvana
-- bug version:
--  funIntPron : Function -> IntPron -> IntPron = 
--    appFun False ; 


-- There is a variety of simple interrogative pronouns:
-- "какая машина", "кто", "что".

  nounIntPron : Number -> CommNounPhrase -> IntPron = \n, x ->
    detNounPhrase (kakojDet ** {n = n ; g = PNoGen;  c = Nom}) x ;

  intPronKto : Number -> IntPron = \num -> 
  { s = table {
    PF Nom _ _ => "кто"  ; 
    PF Gen _ _ => "кого" ;
    PF Dat _  _ => "кому" ; 
    PF Acc _ _ => "кого" ; 
    PF Inst _ _ => "кем" ;
    PF Prepos _ _ => ["о ком"] 
    } ;
    g = PGen Masc ;
    anim = Animate ;
    n = num ;
    p = P3  ;
    pron = False
  } ;
 


  intPronChto : Number -> IntPron = \num -> 
  { s = table {
    PF Nom _ _ => "что"  ; 
    PF Gen _ _ => "чего" ;
    PF Dat _ _ => "чему" ; 
    PF Acc _ _ => "что" ; 
    PF Inst _ _ => "чем" ;
    PF Prepos _ _=> ["о чем"] 
    } ;
    g = PGen Neut ;
    anim = Inanimate ;
    n = num ;
    p = P3  ;
    pron = False
  } ;


--2 Utterances

-- By utterances we mean whole phrases, such as 
-- 'can be used as moves in a language game': indicatives, questions, imperative,
-- and one-word utterances. The rules are far from complete.
--
-- N.B. we have not included rules for texts, which we find we cannot say much
-- about on this level. In semantically rich GF grammars, texts, dialogues, etc, 
-- will of course play an important role as categories not reducible to utterances.
-- An example is proof texts, whose semantics show a dependence between premises
-- and conclusions. Another example is intersentential anaphora.

  Utterance = SS ;

  indicUtt : Sentence -> Utterance = \x -> postfixSS "." (defaultSentence x) ;
  interrogUtt : Question -> Utterance = \x -> postfixSS "?" (defaultQuestion x) ;

--2 Questions
--
-- Questions are either direct ("Ты счастлив?") 
-- or indirect ("Потом он спросил счастлив ли ты").

param 
  QuestForm = DirQ | IndirQ ;

oper
  Question = SS1 QuestForm ;

--3 Yes-no questions 
--
-- Yes-no questions are used both independently ("Ты взял мяч?")
-- and after interrogative adverbials ("Почему ты взял мяч?").

-- Note: The particle "ли" can also be used in direct questions:
-- Видел ли ты что-нибудь подобное?
-- but we are not considering this case.

  questVerbPhrase : NounPhrase -> VerbPhrase -> Question = 
  \tu,spish -> 
    let { vu = tu.s ! (mkPronForm Nom No NonPoss); 
         spish = spish.s2 ++ spish.s ! VFin (gNum (pgen2gen tu.g) tu.n) tu.p 
              ++ spish.s3 ! (pgen2gen tu.g) ! tu.n } in
     { s = table {
       DirQ   =>  vu ++ spish  ;
       IndirQ => spish ++ "ли" ++ vu 
      }
    } ;

isThere : NounPhrase -> Question = \bar ->
    questVerbPhrase 
    ({s = \\_ => ["есть ли"] ; n = bar.n ; p = P3; g = bar.g; anim = bar.anim; pron = bar.pron})
      (predVerbGroup True (predNounPhrase bar)) ;

--3 Wh-questions
--
-- Wh-questions are of two kinds: ones that are like $NP - VP$ sentences,
-- others that are like $S/NP - NP$ sentences.

  intVerbPhrase : IntPron -> VerbPhrase -> Question = \kto,spit ->
    {s = table { _  => (predVerbPhrase kto spit).s }
    } ;

  intSlash : IntPron -> SentenceSlashNounPhrase -> Question = \Kto, yaGovoru ->
    let {  kom = Kto.s ! (mkPronForm yaGovoru.c No NonPoss) ; o = yaGovoru.s2 } in
    {s = table {  _ => o ++ kom ++ yaGovoru.s  } 
    } ;

--3 Interrogative adverbials
--
-- These adverbials will be defined in the lexicon: they include
-- "когда", "где", "как", "почему", etc, which are all invariant one-word
-- expressions. In addition, they can be formed by adding prepositions
-- to interrogative pronouns, in the same way as adverbials are formed
-- from noun phrases. N.B. we rely on record subtyping when ignoring the
-- position component.

  IntAdverb = SS ;

-- A question adverbial can be applied to anything, and whether this makes
-- sense is a semantic question.

  questAdverbial : IntAdverb -> NounPhrase -> VerbPhrase -> Question = 
    \kak, tu, pozhivaesh ->
    {s = \\q => kak.s ++ tu.s ! (mkPronForm Nom No NonPoss) ++ 
       pozhivaesh.s2 ++ pozhivaesh.s ! VFin (gNum (pgen2gen tu.g) tu.n) tu.p ++ 
       pozhivaesh.s3 ! (pgen2gen tu.g) ! tu.n } ; 
 
--2 Imperatives
--
-- We only consider second-person imperatives. 

  Imperative: Type = { s: Gender => Number => Str } ;

  imperVerbPhrase : VerbPhrase -> Imperative = \budGotov -> 
    {s = \\g, n => budGotov.s2 ++ budGotov.s ! VImper n P2 ++ budGotov.s3 ! g ! n} ;  

  imperUtterance : Gender -> Number -> Imperative -> Utterance = \g,n,I ->
    ss (I.s ! g ! n ++ "!") ;
--2 Sentence adverbials
--
-- This class covers adverbials such as "otherwise", "therefore", which are prefixed
-- to a sentence to form a phrase.

  advSentence : SS -> Sentence -> Utterance = \sledovatelno, mamaMulaRamu ->
    ss (sledovatelno.s ++ mamaMulaRamu.s ++ ".") ;

--3 Coordinating sentences
--
-- We need a category of lists of sentences. It is a discontinuous
-- category, the parts corresponding to 'init' and 'last' segments
-- (rather than 'head' and 'tail', because we have to keep track of the slot between
-- the last two elements of the list). A list has at least two elements.

  ListSentence : Type = SD2 ;

  twoSentence : (_,_ : Sentence) -> ListSentence = CO.twoSS ;

  consSentence : ListSentence -> Sentence -> ListSentence =
    CO.consSS CO.comma ;

-- To coordinate a list of sentences by a simple conjunction, we place
-- it between the last two elements; commas are put in the other slots,
-- e.g. "ты куришь, вы пьете и я ем".

  conjunctSentence : Conjunction -> ListSentence -> Sentence = \c,xs ->
    ss (CO.conjunctX c xs) ;

-- To coordinate a list of sentences by a distributed conjunction, we place
-- the first part (e.g. "как") in front of the first element, the second
-- part ("так и") between the last two elements, and commas in the other slots.
-- For sentences this is really not used.

  conjunctDistrSentence : ConjunctionDistr -> ListSentence -> Sentence = 
    \c,xs ->
    ss (CO.conjunctDistrX c xs) ;

--3 Coordinating adjective phrases
--
-- The structure is the same as for sentences. The result is a prefix adjective
-- if and only if all elements are prefix.

  ListAdjPhrase : Type = 
    {s1,s2 : AdjForm => Str ; p : Bool} ;

  twoAdjPhrase : (_,_ : AdjPhrase) -> ListAdjPhrase = \x,y ->
    CO.twoTable AdjForm x y ** {p = andB x.p y.p} ;

  consAdjPhrase : ListAdjPhrase -> AdjPhrase -> ListAdjPhrase =  \xs,x ->
    CO.consTable AdjForm CO.comma xs x ** {p = andB xs.p x.p} ;

  conjunctAdjPhrase : Conjunction -> ListAdjPhrase -> AdjPhrase = \c,xs ->
    CO.conjunctTable AdjForm c xs ** {p = xs.p} ;

  conjunctDistrAdjPhrase : ConjunctionDistr -> ListAdjPhrase -> AdjPhrase = \c,xs ->
    CO.conjunctDistrTable AdjForm c xs ** {p = xs.p} ;


--3 Coordinating noun phrases
--
-- The structure is the same as for sentences. The result is either always plural
-- or plural if any of the components is, depending on the conjunction.

  ListNounPhrase : Type = { s1,s2 : PronForm => Str ; g: PronGen ; 
                   anim : Animacy ; n : Number ; p : Person ;  pron : Bool } ;

  twoNounPhrase : (_,_ : NounPhrase) -> ListNounPhrase = \x,y ->
    CO.twoTable PronForm x y ** {n = conjNumber x.n y.n ; 
       g = conjPGender x.g y.g ; p = conjPerson x.p y.p ;
       pron = conjPron x.pron y.pron ; anim = conjAnim x.anim y.anim } ;

  consNounPhrase : ListNounPhrase -> NounPhrase -> ListNounPhrase =  \xs,x ->
    CO.consTable PronForm CO.comma xs x ** 
       {n = conjNumber xs.n x.n ; g = conjPGender x.g xs.g ;
          anim = conjAnim x.anim xs.anim ;
          p = conjPerson xs.p x.p; pron = conjPron xs.pron x.pron} ;

  conjunctNounPhrase : Conjunction -> ListNounPhrase -> NounPhrase = \c,xs ->
    CO.conjunctTable PronForm c xs ** {n = conjNumber c.n xs.n ;
      anim = xs.anim ;
       p = xs.p; g = xs.g ; pron = xs.pron} ;

  conjunctDistrNounPhrase : ConjunctionDistr -> ListNounPhrase -> NounPhrase = 
    \c,xs ->
    CO.conjunctDistrTable PronForm c xs ** {n = conjNumber c.n xs.n ; 
      p = xs.p ; pron = xs.pron ; anim = xs.anim ; 
       g = xs.g } ;

-- We have to define a calculus of numbers of persons. For numbers,
-- it is like the conjunction with $Pl$ corresponding to $False$.

  conjNumber : Number -> Number -> Number = \m,n -> case <m,n> of {
    <Sg,Sg> => Sg ;
    _ => Pl 
    } ;

-- For persons, we let the latter argument win ("либо ты, либо я пойду"
-- but "либо я, либо ты пойдешь"). This is not quite clear.

  conjPerson : Person -> Person -> Person = \_,p -> 
    p ;

-- For pron, we let the latter argument win - "Маша или моя мама" (Nominative case)
-- but - "моей или Машина мама" (Genetive case) both corresponds to 
-- "Masha's or my mother"), which is actually not exactly correct, since
-- different cases should be used - "Машина или моя мама".

  conjPron : Bool -> Bool -> Bool = \_,p -> 
    p ;

-- For gender in a similar manner as for person:
-- Needed for adjective predicates like:
-- "Маша или Оля - красивая", "Антон или Олег - красивый",
-- "Маша или Олег - красивый".
-- The later is not totally correct, but there is no correct way to say that.

  conjGender : Gender -> Gender -> Gender = \_,m -> m ; 
 conjPGender : PronGen -> PronGen -> PronGen = \_,m -> m ; 

  conjAnim : Animacy -> Animacy -> Animacy = \_,m -> m ; 

--2 Subjunction
--
-- Subjunctions ("когда", "если", etc) 
-- are a different way to combine sentences than conjunctions.
-- The main clause can be a sentence, an imperative, or a question,
-- but the subjoined clause must be a sentence.
--
-- There are uniformly two variant word orders, e.g. 
-- "если ты закуришь, я рассержусь"
-- and "я рассержусь, если ты закуришь".

  Subjunction = SS ;

  subjunctSentence : Subjunction -> Sentence -> Sentence -> Sentence = 
    \if, A, B -> 
    ss (subjunctVariants if A.s B.s) ;

  subjunctImperative : Subjunction -> Sentence -> Imperative -> Imperative = 
    \if, A, B -> 
    {s = \\g,n => subjunctVariants if A.s (B.s ! g ! n)} ;

  subjunctQuestion : Subjunction -> Sentence -> Question -> Question = 
    \if, A, B ->
    {s = \\q => subjunctVariants if A.s (B.s ! q)} ;

  subjunctVerbPhrase: VerbPhrase -> Subjunction -> Sentence -> VerbPhrase =
   \V, if, A -> adVerbPhrase V (mkAdverb (if.s ++ A.s)) ;

  subjunctVariants : Subjunction -> Str -> Str -> Str = \if,A,B ->
    variants {if.s ++ A ++ "," ++ B ; B ++ "," ++ if.s ++ A} ;

--2 One-word utterances
-- 
-- An utterance can consist of one phrase of almost any category, 
-- the limiting case being one-word utterances. These
-- utterances are often (but not always) in what can be called the
-- default form of a category, e.g. the nominative.
-- This list is far from exhaustive.

  useNounPhrase : NounPhrase -> Utterance = \masha ->
    postfixSS "." (defaultNounPhrase masha) ;

  useCommonNounPhrase : Number -> CommNounPhrase -> Utterance = \n,mashina -> 
    useNounPhrase (indefNounPhrase n mashina) ;

  useRegularName : Gender -> SS -> NounPhrase = \g, masha -> 
    nameNounPhrase (case g of { Masc => mkProperNameMasc masha.s Animate;
        _ => mkProperNameFem masha.s Animate }) ;

-- Here are some default forms.

  defaultNounPhrase : NounPhrase -> SS = \masha -> 
    ss (masha.s ! PF Nom No NonPoss) ;

  defaultQuestion : Question -> SS = \ktoTu ->
    ss (ktoTu.s ! DirQ) ;

  defaultSentence : Sentence -> Utterance = \x -> 
    x ;
};
