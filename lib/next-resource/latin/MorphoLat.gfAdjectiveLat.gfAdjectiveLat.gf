--# -path=.:../../prelude

--1 A Simple Latlish Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsLat$, which
-- gives a higher-level access to this module.

resource MorphoLat = ResLat ** open Prelude, (Predef=Predef) in {

  flags optimize=all ;

--2 Phonology
--
-- To regulate the use of endings for both nouns, adjectives, and verbs:

oper
  y2ie : Str -> Str -> Str = \fly,s -> 
    let y = last (init fly) in
    case y of {
      "a" => fly + s ;
      "e" => fly + s ;
      "o" => fly + s ;
      "u" => fly + s ;
    _   => init fly + "ie" + s
    } ;


--2 Nouns
--
-- For conciseness and abstraction, we define a worst-case macro for
-- noun inflection. It is used for defining special case that
-- only need one string as argument.

oper
  CommonNoun : Type = {s : Number => Case => Str} ;

  nounGen : Str -> CommonNoun = \dog -> case last dog of {
    "y" => nounY "dog" ;
    "s" => nounS (init "dog") ;
    _   => nounReg "dog"
    } ;

-- These are auxiliaries to $nounGen$.

  nounReg : Str -> CommonNoun = \dog -> 
    mkNoun dog (dog + "s") (dog + "'s") (dog + "s'");
  nounS   : Str -> CommonNoun = \kiss -> 
    mkNoun kiss (kiss + "es") (kiss + "'s") (kiss + "es'") ;
  nounY   : Str -> CommonNoun = \fl -> 
    mkNoun (fl + "y") (fl + "ies") (fl + "y's") (fl + "ies'") ;


--3 Proper names
--
-- Regular proper names are inflected with "'s" in the genitive.

  nameReg : Str -> Gender -> {s : Case => Str} = \john,g -> 
    {s = table {Gen => john + "'s" ; _ => john} ; g = g} ;

--2 Determiners

  mkDeterminer : Number -> Str -> {s,sp : Str ; n : Number} = \n,s ->
    {s,sp = s ; n = n} ;

--2 Pronouns
--
-- Here we define personal pronouns. 
--
-- We record the form "mine" and the gender for later use.

  Pronoun : Type = 
    {s : Case => Str ; a : Agr} ;

  mkPronoun : (_,_,_,_ : Str) -> Number -> Person -> Gender -> Pronoun = 
   \I,me,my,mine,n,p,g -> 
    {s = table {Nom => I ; Acc => me ; Gen => my} ; 
     a = toAgr n p g
    } ;

  human : Gender = Masc ; --- doesn't matter

  pronI = mkPronoun "I" "me" "my" "mine" Sg P1 human ;
  pronYouSg = mkPronoun "you" "you" "your" "yours" Sg P2 human ; -- verb agr OK
  pronHe = mkPronoun "he" "him" "his" "his" Sg P3 Masc ;
  pronShe = mkPronoun "she" "her" "her" "hers" Sg P3 Fem ;
  pronIt = mkPronoun "it" "it" "its" "it" Sg P3 Neutr ;

  pronWe = mkPronoun "we" "us" "our" "ours" Pl P1 human ;
  pronYouPl = mkPronoun "you" "you" "your" "yours" Pl P2 human ;
  pronThey = mkPronoun "they" "them" "their" "theirs" Pl P3 human ; ---


--2 Adjectives
--
-- To form the adjectival and the adverbial forms, two strings are needed
-- in the worst case. (First without degrees.)

  Adjective = {s : AForm => Str} ;

-- However, most adjectives can be inflected using the final character.
-- N.B. this is not correct for "shy", but $mkAdjective$ has to be used.

  regAdjective : Str -> Adjective = \free -> 
    let 
      e   = last free ;
      fre = init free ;
      freely = case e of {
        "y" => fre + "ily" ;
        _   => free + "ly"
        } ;
      fre = case e of {
        "e" => fre ;
        "y" => fre + "i" ;
        _   => free
        }
    in 
    mkAdjective free (fre + "er") (fre + "est") freely ; 

-- Many adjectives are 'inflected' by adding a comparison word.

  adjDegrLong : Str -> Adjective = \ridiculous ->
    mkAdjective 
      ridiculous 
      ("more" ++ ridiculous) 
      ("most" ++ ridiculous) 
      ((regAdjective ridiculous).s ! AAdv) ;


--3 Verbs
--
-- The worst case needs five forms. (The verb "be" is treated separately.)

  mkVerb4 : (_,_,_,_: Str) -> Verb = \go,goes,went,gone -> 
    let going = case last go of {
      "e" => init go + "ing" ;
      _ => go + "ing"
      }
    in
    mkVerb go goes went gone going ;

-- This is what we use to derive the irregular forms in almost all cases

  mkVerbIrreg : (_,_,_ : Str) -> Verb = \bite,bit,bitten -> 
    let bites = case last bite of {
      "y" => y2ie bite "s" ;
      "s" => init bite + "es" ;
      _   => bite + "s"
      } 
    in mkVerb4 bite bites bit bitten ;

-- This is used to derive regular forms.

  mkVerbReg : Str -> Verb = \soak -> 
    let 
      soaks = case last soak of {
        "y" => y2ie soak "s" ;
        "s" => init soak + "es" ;
        _   => soak + "s"
        } ;
      soaked = case last soak of {
        "e" => init soak + "s" ;
        _   => soak + "ed"
        }
    in 
    mkVerb4 soak soaks soaked soaked ;

  verbGen : Str -> Verb = \kill -> case last kill of {
    "y" => verbP3y (init kill) ;
    "e" => verbP3e (init kill) ;
    "s" => verbP3s (init kill) ;
    _   => regVerbP3 kill
    } ;

-- These are just auxiliary to $verbGen$.

  regVerbP3 : Str -> Verb = \walk -> 
    mkVerbIrreg walk (walk + "ed") (walk + "ed") ;
  verbP3s   : Str -> Verb = \kiss -> 
    mkVerb4 kiss (kiss + "es") (kiss + "ed") (kiss + "ed") ;
  verbP3e   : Str -> Verb = \love -> 
    mkVerb4 love (love + "s") (love + "d") (love + "d") ;
  verbP3y   : Str -> Verb = \cr -> 
    mkVerb4 (cr + "y") (cr + "ies") (cr + "ied") (cr + "ied") ;

--- The particle always appears right after the verb.

  verbPart : Verb -> Str -> Verb = \v,p ->
    {s = \\f => v.s ! f ++ p ; isRefl = v.isRefl} ;

  verbNoPart : Verb -> Verb = \v -> verbPart v [] ;


} ;

