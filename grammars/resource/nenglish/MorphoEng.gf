--1 A Simple English Resource Morphology
--
-- Aarne Ranta 2002
--
-- This resource morphology contains definitions needed in the resource
-- syntax. It moreover contains the most usual inflectional patterns.
--
-- We use the parameter types and word classes defined in $Types.gf$.

resource MorphoEng = TypesEng ** open Prelude in {

--2 Nouns
--
-- For conciseness and abstraction, we define a worst-case macro for
-- noun inflection. It is used for defining special case that
-- only need one string as argument.

oper
  mkNoun  : (_,_,_,_ : Str) -> CommonNoun = 
    \man,men, mans, mens -> {s = table {
       Sg => table {Nom => man ; Gen => mans} ;
       Pl => table {Nom => men ; Gen => mens}
      }} ;

  nounReg : Str -> CommonNoun = \dog -> 
    mkNoun dog (dog + "s") (dog + "'s") (dog + "s'");

  nounS   : Str -> CommonNoun = \kiss -> 
    mkNoun kiss (kiss + "es") (kiss + "'s") (kiss + "es'") ;

  nounY   : Str -> CommonNoun = \fl -> 
    mkNoun (fl + "y") (fl + "ies") (fl + "y's") (fl + "ies'") ;

--3 Proper names
--
-- Regular proper names are inflected with "'s" in the genitive.

  nameReg : Str -> ProperName = \john -> 
    {s = table {Nom => john ; Gen => john + "'s"}} ;


--2 Pronouns
--
-- Here we define personal and relative pronouns.

  mkPronoun : (_,_,_,_ : Str) -> Number -> Person -> Pronoun = \I,me,my,mine,n,p -> 
    {s = table {NomP => I ; AccP => me ; GenP => my ; GenSP => mine} ; 
     n = n ; p = p} ;

  pronI = mkPronoun "I" "me" "my" "mine" Sg P1 ;
  pronYouSg = mkPronoun "you" "you" "your" "yours" Sg P2 ; -- verb form still OK
  pronHe = mkPronoun "he" "him" "his" "his" Sg P3 ;
  pronShe = mkPronoun "she" "her" "her" "hers" Sg P3 ;
  pronIt = mkPronoun "it" "it" "its" "it" Sg P3 ;

  pronWe = mkPronoun "we" "us" "our" "ours" Pl P1 ;
  pronYouPl = mkPronoun "you" "you" "your" "yours" Pl P2 ;
  pronThey = mkPronoun "they" "them" "their" "theirs" Pl P3 ;

-- Relative pronouns in the accusative have the 'no pronoun' variant.
-- The simple pronouns do not really depend on number.

  relPron : RelPron = {s = table {
    NoHum => \\_ => table {
      NomP => variants {"that" ; "which"} ;
      AccP => variants {"that" ; "which" ; []} ;
      GenP => variants {"whose"} ;
      GenSP => variants {"which"}
      } ;
    Hum => \\_ => table {
      NomP => variants {"that" ; "who"} ;
      AccP => variants {"that" ; "who" ; "whom" ; []} ;
      GenP => variants {"whose"} ;
      GenSP => variants {"whom"}
      }
    }
  } ;


--3 Determiners
--
-- We have just a heuristic definition of the indefinite article.
-- There are lots of exceptions: consonantic "e" ("euphemism"), consonantic
-- "o" ("one-sided"), vocalic "u" ("umbrella").

  artIndef = pre {"a" ; 
                  "an" / strs {"a" ; "e" ; "i" ; "o" ; "A" ; "E" ; "I" ; "O" }} ;

  artDef = "the" ;

--2 Adjectives
--
-- For the comparison of adjectives, three forms are needed in the worst case.

  mkAdjDegr : (_,_,_ : Str) -> AdjDegr = \good,better,best -> 
    {s = table {Pos => good ; Comp => better ; Sup => best}} ;

  adjDegrReg : Str -> AdjDegr = \long ->
    mkAdjDegr long (long + "er") (long + "est") ;

  adjDegrY : Str -> AdjDegr = \lovel ->
    mkAdjDegr (lovel + "y") (lovel + "ier") (lovel + "iest") ;

-- Many adjectives are 'inflected' by adding a comparison word.

  adjDegrLong : Str -> AdjDegr = \ridiculous ->
    mkAdjDegr ridiculous ("more" ++ ridiculous) ("most" ++ ridiculous) ;

-- simple adjectives are just strings

  simpleAdj : Str -> Adjective = ss ;

--3 Verbs
--
-- Except for "be", the worst case needs four forms.

  mkVerbP3 : (_,_,_,_: Str) -> VerbP3 = \go,goes,went,gone -> 
    {s = table {
       InfImp => go ; 
       Indic P3 => goes ; 
       Indic _ => go ; 
       Past _ => went ;
       PPart => gone
       }
    } ;

  mkVerb : (_,_,_ : Str) -> VerbP3 = \ring,rang,rung ->
    mkVerbP3 ring (ring + "s") rang rung ;

  regVerbP3 : Str -> VerbP3 = \walk -> 
    mkVerb walk (walk + "ed") (walk + "ed") ;

  verbP3s   : Str -> VerbP3 = \kiss -> 
    mkVerbP3 kiss (kiss + "es") (kiss + "ed") (kiss + "ed") ;

  verbP3e   : Str -> VerbP3 = \love -> 
    mkVerbP3 love (love + "s") (love + "d") (love + "d") ;

  verbP3y   : Str -> VerbP3 = \cr -> 
    mkVerbP3 (cr + "y") (cr + "ies") (cr + "ied") (cr + "ied") ;

  verbP3Have = mkVerbP3 "have" "has" "had" "had" ;

  verbP3Do   = mkVerbP3 "do" "does" "did" "done" ;

  verbBe : VerbP3 = {s = table {
    InfImp => "be" ; 
    Indic P1 => "am" ; 
    Indic P2 => "are" ;
    Indic P3 => "is" ;
    Past Sg  => "was" ;
    Past Pl  => "were" ;
    PPart => "been"
    }} ;

  verbPart : VerbP3 -> Particle -> Verb = \v,p ->
    v ** {s1 = p} ;

  verbNoPart : VerbP3 -> Verb = \v -> verbPart v [] ;

-- The optional negation contraction is a useful macro e.g. for "do".

  contractNot : Str -> Str = \is -> variants {is ++ "not" ; is + "n't"} ;

  dont = contractNot (verbP3Do.s ! InfImp) ;
} ;

