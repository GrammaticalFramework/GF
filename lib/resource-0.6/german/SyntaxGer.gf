--1 A Small German Resource Syntax
--
-- Aarne Ranta 2002
--
-- This resource grammar contains definitions needed to construct 
-- indicative, interrogative, and imperative sentences in German.
--
-- The following modules are presupposed:

resource SyntaxGer = MorphoGer ** open Prelude, (CO = Coordination) in {

--2 Common Nouns
--
-- Simple common nouns are defined as the type $CommNoun$ in $morpho.Deu.gf$.

--3 Common noun phrases

-- The need for this more complex type comes from the variation in the way in
-- which a modifying adjective is inflected after different determiners.
-- We use the $Adjf$ parameter for this ($Strong$/$Weak$).

oper

  CommNounPhrase : Type = {s : Adjf => Number => Case => Str ; g : Gender} ;

  noun2CommNounPhrase : CommNoun -> CommNounPhrase = \haus ->
    {s = \\_ => haus.s ; g = haus.g} ;

  n2n = noun2CommNounPhrase ;


--2 Noun phrases
--
-- The worst case is pronouns, which have inflection in the possessive
-- forms. Other noun phrases express all possessive forms with the genitive case.
-- The parameter $pro$ tells if the $NP$ is a pronoun, which is needed in e.g.
-- genitive constructions.

  NounPhrase : Type = {
    s : NPForm => Str ; 
    n : Number ; 
    p : Person ; 
    pro : Bool
    } ;

  pronNounPhrase : ProPN -> NounPhrase = \ich -> 
    ich ** {pro = True} ;

  caseNP : NPForm -> Case = \np -> case np of {
    NPCase c   => c ;
    NPPoss _ _ => Gen
    } ;

  normalNounPhrase : (Case => Str) -> Number -> NounPhrase = \cs,n ->
    {s = \\c => cs ! caseNP c ;
     n = n ;
     p = P3 ;    -- third person
     pro = False -- not a pronoun
    } ;

-- Proper names are a simple kind of noun phrases. They can usually
-- be constructed from strings in a regular way.

  ProperName : Type = {s : Case => Str} ;

  nameNounPhrase : ProperName -> NounPhrase = \john -> 
    {s = \\np => john.s ! caseNP np ; n = Sg ; p = P3 ; pro = False} ;

  mkProperName : Str -> ProperName = \horst ->
    {s = table {Gen => horst + "s" ; _ => horst}} ;

-- Numerals can be used as determiners or, more generally, as modifiers
-- of ones. They are not inflected, since we only consider numerals above 1.

  Numeral : Type = {s : Str} ;

  pronWithNum : ProPN -> Numeral -> ProPN = \wir,acht ->
    {s = \\c => wir.s ! c ++ acht.s ;
     n = wir.n ;
     p = wir.p
    } ;

  noNum : Numeral = {s = []} ;


--2 Mass nouns
--
-- Mass nouns are morphologically similar to nouns, but they have one special
-- rule of noun phrase formation, using the bare singular (in German).
-- Example: "Bier ist gut".
-- They can also be coerced to common nouns: "ein Mexikanisches Bier".

  MassNounPhrase : Type = CommNounPhrase ;

  massNounPhrase : MassNounPhrase -> NounPhrase = \bier -> {
     s = \\c => let {nc = caseNP c} in 
                bier.s ! adjfCas Strong nc ! Sg ! nc ;
     p = P3 ; 
     n = Sg ;
     pro = False
     } ;

  massCommNoun : MassNounPhrase -> CommNounPhrase = \x -> x ;


--2 Determiners
--
-- Determiners are inflected according to the nouns they determine.
-- The determiner determines the number and adjectival form from the determiner.

  Determiner : Type = {s : Gender => Case => Str ; n : Number ; a : Adjf} ;

  detNounPhrase : Determiner -> CommNounPhrase -> NounPhrase = \ein, mann -> {
     s = \\c => let {nc = caseNP c} in 
            ein.s ! mann.g ! nc ++ mann.s ! adjfCas ein.a nc ! ein.n ! nc ;
     p = P3 ; 
     n = ein.n ;
     pro = False
     } ;


-- The adjectival form after a determiner depends both on the inferent form
-- and on the case ("ein alter Mann" but "einem alten Mann").

  adjfCas : Adjf -> Case -> Adjf = \a,c -> case <a,c> of {
    <Strong,Nom> => Strong ;
    <Strong,Acc> => Strong ;
    _ => Weak
    } ;

-- The following macros are sufficient to define most determiners,
-- as shown by the examples that follow.

  DetSg = Gender => Case => Str ;
  DetPl = Case => Str ;

  mkDeterminerSg :  DetSg -> Adjf -> Determiner = \ein, a -> 
    {s = ein ; n = Sg ; a = a} ;

  mkDeterminerPl :  DetPl -> Adjf -> Determiner = \x,y ->
    mkDeterminerNum noNum x y ;

  mkDeterminerNum :  Numeral -> DetPl -> Adjf -> Determiner = \nu,alle,a -> 
    {s = \\_,c => alle ! c ++ nu.s ; n = Pl ; a = a} ;
  mkDeterminerNumReg :  Numeral -> Str -> Adjf -> Determiner = \nu,alle,a -> 
    mkDeterminerNum nu (caselist alle alle (alle + "n") (alle + "n")) a ;

  detLikeAdj : Str -> Determiner = \jed -> mkDeterminerSg
    (\\g,c => (adjReg jed).s ! AMod Strong (GSg g) c) Weak ;

  jederDet = detLikeAdj "jed" ;
  dieserDet = detLikeAdj "dies" ;
  jenerDet = detLikeAdj "jen" ;
  allesDet = detLikeAdj "all" ;
  alleDet : Numeral -> Determiner = \n ->
    mkDeterminerNum n (caselist "alle" "alle" "allen" "aller") Weak ;
  einDet = mkDeterminerSg artIndef Strong ;
  keinDet = mkDeterminerSg (\\g,c => "k" + artIndef ! g ! c) Strong ;
  derDet = mkDeterminerSg (table {g => artDef ! GSg g}) Weak ;
  dieDet : Numeral -> Determiner = \nu -> 
    mkDeterminerNum nu (artDef ! GPl) Weak ;

  meistDet = mkDeterminerSg 
    (\\g,c => artDef ! GSg g ! c ++ (adjReg "meist").s ! AMod Weak (GSg g) c) Weak ;
  meisteDet = mkDeterminerPl 
    (\\c => artDef ! GPl ! c ++ "meisten") Weak ;
  welcherDet = detLikeAdj "welch" ;
  welcheDet : Numeral -> Determiner = \n ->
    mkDeterminerNum n (caselist "welche" "welche" "welchen" "welcher") Weak ;

-- Choose "welcher"/"welche"

  welchDet : Number -> Determiner = \n -> 
    case n of {Sg => welcherDet ; Pl => welcheDet noNum} ;

-- Genitives of noun phrases can be used like determiners, to build noun phrases.
-- The number argument makes the difference between "mein Haus" - "meine Häuser".
--
-- If the 'owner' is a pronoun, only one form is available "mein Haus".
-- In other cases, two variants are available: "Johanns Haus" / "das Haus Johanns".

  npGenDet : Number -> Numeral -> NounPhrase -> CommNounPhrase -> NounPhrase = 
   \n,nu,haus,Wein -> 
   let {
     hauses  : Case   => Str = \\c => haus.s ! NPPoss (gNumber Wein.g n) c ;
     wein    : NPForm => Str = \\c => nu.s ++ Wein.s ! Strong ! n ! caseNP c ;
     derwein : NPForm => Str = (defNounPhraseNum nu n Wein).s
     }
   in
    {s = \\c => variants {
                  hauses ! caseNP c ++ wein ! c ;
                  if_then_else Str haus.pro
                    nonExist 
                    (derwein ! c ++ hauses ! Nom) -- the case does not matter
                  } ;
     p = P3 ;
     n = n ;
     pro = False
     } ;

-- *Bare plural noun phrases* like "Männer", "gute Häuser", are built without a 
-- determiner word.

  plurDet : CommNounPhrase -> NounPhrase = \cn -> 
    normalNounPhrase (cn.s ! Strong ! Pl) Pl ;

  plurDetNum : Numeral -> CommNounPhrase -> NounPhrase = \nu,cn -> 
    normalNounPhrase (\\c => nu.s ++ cn.s ! Strong ! Pl ! c) Pl ;

-- Macros for indef/def Sg/Pl noun phrases are needed in many places even
-- if they might not be constituents.

  indefNounPhrase : Number -> CommNounPhrase -> NounPhrase = \n,haus -> case n of {
    Sg => detNounPhrase einDet haus ;
    Pl => plurDet haus
    } ;

  defNounPhraseNum : Numeral -> Number -> CommNounPhrase -> NounPhrase = 
    \nu,n,haus -> case n of {
      Sg => detNounPhrase derDet haus ;
      Pl => detNounPhrase (dieDet nu) haus
      } ;

  defNounPhrase : Number -> CommNounPhrase -> NounPhrase = 
    defNounPhraseNum noNum ;

  indefNoun : Number -> CommNounPhrase -> Str = \n, mann -> case n of {
    Sg => (detNounPhrase einDet mann).s ! NPCase Nom ; 
    Pl => (plurDet mann).s ! NPCase Nom
    } ;

-- Constructions like "die Idee, dass zwei gerade ist" are formed at the
-- first place as common nouns, so that one can also have "ein Vorschlag, dass...".

  nounThatSentence : CommNounPhrase -> Sentence -> CommNounPhrase = \idee,x -> 
    {s = \\a,n,c => idee.s ! a! n ! c ++ [", dass"] ++ x.s ! Sub ; 
     g = idee.g
    } ;

--2 Adjectives
--
-- Adjectival phrases have a parameter $p$ telling if postposition is 
-- allowed (complex APs). 

  AdjPhrase : Type = Adjective ** {p : Bool} ;

  adj2adjPhrase : Adjective -> AdjPhrase = \ny -> ny ** {p = False} ;

--3 Comparison adjectives
--
-- The type is defined in $types.Deu.gf$.

  AdjDegr : Type = AdjComp ;

-- Each of the comparison forms has a characteristic use:
--
-- Positive forms are used alone, as adjectival phrases ("jung").

  positAdjPhrase : AdjDegr -> AdjPhrase = \jung ->
    {s = jung.s ! Pos ; p = False} ;

-- Comparative forms are used with an object of comparison, as
-- adjectival phrases ("besser als Rolf").

  comparAdjPhrase : AdjDegr -> NounPhrase -> AdjPhrase = \besser,rolf ->
    {s = \\a => besser.s ! Comp ! a ++ "als" ++ rolf.s ! NPCase Nom ;
     p = True
    } ;

-- Superlative forms are used with a common noun, picking out the
-- maximal representative of a domain ("der Jüngste Mann").

  superlNounPhrase : AdjDegr -> CommNounPhrase -> NounPhrase = \best,mann ->
    let {gen = mann.g} in
    {s = \\c => let {nc = caseNP c} in
                artDef ! gNumber gen Sg ! nc ++ 
                best.s ! Sup ! aMod Weak gen Sg nc ++
                mann.s ! Weak ! Sg ! nc ; 
     p = P3 ; 
     n = Sg ;
     pro = False
    } ;

--3 Two-place adjectives
--
-- A two-place adjective is an adjective with a preposition used before
-- the complement, and the complement case.

  AdjCompl = Adjective ** {s2 : Preposition ; c : Case} ;

  complAdj : AdjCompl -> NounPhrase -> AdjPhrase = \verwandt,dich ->
    {s = \\a => 
            bothWays (verwandt.s ! a) (verwandt.s2 ++ dich.s ! NPCase verwandt.c) ;
     p = True
    } ;

--3 Modification of common nouns
--
-- The two main functions of adjective are in predication ("Johann ist jung")
-- and in modification ("ein junger Mann"). Predication will be defined
-- later, in the chapter on verbs.
--
-- Modification must pay attention to pre- and post-noun
-- adjectives: "gutes Haus"; "besseres als X haus" / "haus besseres als X"

  modCommNounPhrase : AdjPhrase -> CommNounPhrase -> CommNounPhrase = \gut,haus ->
    {s = \\a,n,c => let {
             gutes = gut.s ! aMod a haus.g n c ; 
             Haus  = haus.s ! a ! n ! c
             } in
           if_then_else Str gut.p (bothWays gutes Haus) (gutes ++ Haus) ;
     g = haus.g} ;

--2 Function expressions

-- A function expression is a common noun together with the
-- preposition prefixed to its argument ("Mutter von x").
-- The type is analogous to two-place adjectives and transitive verbs.

  Function = CommNounPhrase ** {s2 : Preposition ; c : Case} ;

-- The application of a function gives, in the first place, a common noun:
-- "Mutter/Mütter von Johann". From this, other rules of the resource grammar 
-- give noun phrases, such as "die Mutter von Johann", "die Mütter von Johann",
-- "die Mütter von Johann und Maria", and "die Mutter von Johann und Maria" (the
-- latter two corresponding to distributive and collective functions,
-- respectively). Semantics will eventually tell when each
-- of the readings is meaningful.

  appFunComm : Function -> NounPhrase -> CommNounPhrase = \mutter,uwe -> 
      {s = \\a,n,c => mutter.s ! a ! n ! c ++ mutter.s2 ++ uwe.s ! NPCase mutter.c ;
       g = mutter.g
      } ;

-- It is possible to use a function word as a common noun; the semantics is
-- often existential or indexical.

  funAsCommNounPhrase : Function -> CommNounPhrase = \x -> x ; 

-- The following is an aggregate corresponding to the original function application
-- producing "Johanns Mutter" and "die Mutter von Johann". It does not appear in the
-- resource grammar API any longer.

  appFun : Bool -> Function -> NounPhrase -> NounPhrase = \coll, mutter, uwe ->
    let {n = uwe.n ; g = mutter.g ; nf = if_then_else Number coll Sg n} in 
    variants {
      defNounPhrase nf (appFunComm mutter uwe) ;
      npGenDet nf noNum uwe mutter
      } ;

-- The commonest cases are functions with "von" and functions with Genitive.

  mkFunC : CommNounPhrase -> Preposition -> Case -> Function = \f,p,c ->
    f ** {s2 = p ; c = c} ;

  funVonC : CommNounPhrase -> Function = \wert -> 
    mkFunC wert "von" Dat ;

  funGenC : CommNounPhrase -> Function = \wert -> 
    mkFunC wert [] Gen ;

-- Two-place functions add one argument place.

  Function2 = Function ** {s3 : Preposition ; c2 : Case} ;

-- There application starts by filling the first place.

  appFun2 : Function2 -> NounPhrase -> Function = \flug, paris ->
    {s  = \\a,n,c => flug.s ! a ! n ! c ++ flug.s2 ++ paris.s ! NPCase flug.c ;
     g  = flug.g ;
     s2 = flug.s3 ;
     c  = flug.c2
    } ;


--2 Verbs
--
--3 Verb phrases
--
-- Verb phrases are discontinuous: the parts of a verb phrase are
-- (s) an inflected verb, 
-- (s3) negation+complement+particle, and (s4) sentential adverbial. 
-- This discontinuity is needed in sentence formation
-- to account for word order variations.

  VerbPhrase = Verb ** {s3 : Number => Str ; s4 : Str} ; 
  VerbGroup = 
    {s : VForm => Str ; s2 : Str ; s3 : Bool => Number => Str ; s4 : Str} ;

  predVerbGroup : Bool -> VerbGroup -> VerbPhrase = \b,vg -> {
    s  = vg.s ;
    s2 = vg.s2 ;
    s3 = vg.s3 ! b ;
    s4 = vg.s4
    } ;

-- A simple verb can be made into a verb phrase with an empty complement.
-- There are two versions, depending on if we want to negate the verb.
-- N.B. negation is *not* a function applicable to a verb phrase, since
-- double negations with "nicht" are not grammatical.

  predVerb : Verb -> VerbGroup = \aussehen -> 
    aussehen ** {
     s3 = \\b,_ => negation b ;
     s4 = []
     } ;

  negation : Bool -> Str = \b -> if_then_else Str b [] "nicht" ;

-- Verb phrases can also be formed from adjectives ("ist gut"),
-- common nouns ("ist ein Mann"), and noun phrases ("ist der jüngste Mann").
-- The third rule is overgenerating: "ist jeder Mann" has to be ruled out
-- on semantic grounds.

  predAdjective : Adjective -> VerbGroup = \gut ->
    verbSein ** {
      s3 = \\b,_ => negation b ++ gut.s ! APred ;
      s4 = []
      } ;

  predCommNoun : CommNounPhrase -> VerbGroup = \man ->
    verbSein ** {
      s3 = \\b,n => negation b ++ indefNoun n man ;
      s4 = []
     } ;

  predNounPhrase : NounPhrase -> VerbGroup = \dermann ->
    verbSein ** {
      s3 = \\b,n => negation b ++ dermann.s ! NPCase Nom ;
      s4 = []
     } ;

  predAdverb : Adverb -> VerbGroup = \hier ->
    verbSein ** {
      s3 = \\b,_ => negation b ++ hier.s ;
      s4 = []
     } ;

--3 Transitive verbs
--
-- Transitive verbs are verbs with a preposition for the complement,
-- in analogy with two-place adjectives and functions.
-- One might prefer to use the term "2-place verb", since
-- "transitive" traditionally means that the inherent preposition is empty.
-- Such a verb is one with a *direct object* - which may still be accusative,
-- dative, or genitive.

  TransVerb = Verb ** {s3 : Preposition ; c : Case} ; 

  mkTransVerb : Verb -> Preposition -> Case -> TransVerb =
    \v,p,c -> v ** {s3 = p ; c = c} ;

  transDir : Verb -> TransVerb = \v ->
    mkTransVerb v [] Acc ;

-- The rule for using transitive verbs is the complementization rule:

  complTransVerb : TransVerb -> NounPhrase -> VerbGroup = \warten,dich ->
    let {
      aufdich = warten.s3 ++ dich.s ! NPCase warten.c
      } in
    {s  = warten.s ;
     s2 = warten.s2 ;
     s3 = \\b,_ => bothWays aufdich (negation b) ;
     s4 = []
    } ;

-- Transitive verbs with accusative objects can be used passively. 
-- The function does not check that the verb is transitive.
-- Therefore, the function can also be used for "es wird gelaufen", etc.

  passVerb : Verb -> VerbGroup = \lieben ->
    {s  = verbumWerden ;
     s2 = [] ; 
     s3 = \\b,_ => negation b ++ lieben.s2 ++ lieben.s ! VPart APred ;
     s4 = []
    } ;

-- Transitive verb can be used elliptically as a verb. The semantics
-- is left to applications. The definition is trivial, due to record
-- subtyping.

  transAsVerb : TransVerb -> Verb = \lieben -> 
    lieben ;

-- *Ditransitive verbs* are verbs with three argument places.
-- We treat so far only the rule in which the ditransitive
-- verb takes both complements to form a verb phrase.

  DitransVerb = TransVerb ** {s4 : Preposition ; c2 : Case} ; 

  mkDitransVerb : 
    Verb -> Preposition -> Case -> Preposition -> Case -> DitransVerb =
    \v,p1,c1,p2,c2 -> v ** {s3 = p1 ; c = c1 ; s4 = p2 ; c2 = c2} ;

  complDitransVerb : 
    DitransVerb -> NounPhrase -> NounPhrase -> VerbGroup = \geben,dir,bier ->
    let {
      zudir   = geben.s3 ++ dir.s ! NPCase geben.c ; 
      dasbier = geben.s4 ++ bier.s ! NPCase geben.c2 
      } in
    {s  = geben.s ; 
     s2 = geben.s2 ;
     s3 = \\b,_ => let nicht = negation b in
       variants {
         nicht ++ zudir ++ dasbier ;
         zudir ++ nicht ++ dasbier ;
         zudir ++ dasbier ++ nicht
         } ;
     s4 = []
    } ;
  

--2 Adverbials
--
-- Adverbials are not inflected (we ignore comparison, and treat
-- compared adverbials as separate expressions; this could be done another way).

  Adverb : Type = SS ;

  mkAdverb : Str -> Adverb = ss ;

-- This rule is the one that shows that we cannot glue the particle in the
-- $s3$ field.

  adVerbPhrase : VerbPhrase -> Adverb -> VerbPhrase = \spielt, gut ->
    {s  = spielt.s ; 
     s2 = spielt.s2 ;
     s3 = \\n => spielt.s3 ! n ++ gut.s ;
     s4 = spielt.s4
    } ;

  advAdjPhrase : Adverb -> AdjPhrase -> AdjPhrase = \sehr, gut ->
    {s = \\a => sehr.s ++ gut.s ! a ;
     p = gut.p
    } ;

-- Adverbials are typically generated by prefixing prepositions, of which
-- the case has to be specified.

  Prepos = {s : Str ; c : Case} ;

  prepPhrase : Prepos -> NounPhrase -> Adverb = \auf,ihm ->
    ss (auf.s ++ ihm.s ! NPCase auf.c) ;
 
  mkPrep : Str -> Case -> Prepos = \s,c -> 
    {s = s ; c = c} ;

-- This is a source of the "Mann mit einem Teleskop" ambiguity, and may produce
-- strange things, like "Autos immer" (while "Autos heute" is OK).
-- Semantics will have to make finer distinctions among adverbials.

  advCommNounPhrase : CommNounPhrase -> Adverb -> CommNounPhrase = \haus,heute ->
    {s = \\a, n, c => haus.s ! a ! n ! c ++ heute.s ;
     g = haus.g} ;    



--2 Sentences
--
-- Sentences depend on a *word order parameter* selecting between main clause,
-- inverted, and subordinate clause.

  Sentence : Type = SS1 Order ;

-- This is the traditional $S -> NP VP$ rule. It takes care of both
-- word order and agreement.

  predVerbPhrase : NounPhrase -> VerbPhrase -> Sentence = 
    \Ich,LiebeDichNichtAus -> 
    let {
      ich   = Ich.s ! NPCase Nom ; 
      liebe = LiebeDichNichtAus.s ! VInd Ich.n Ich.p ;
      aus   = LiebeDichNichtAus.s2 ;
      dichnichtgut = LiebeDichNichtAus.s3 ! Ich.n ;
      wennesregnet = LiebeDichNichtAus.s4
    } in
    {s = table {
       Main => ich ++ liebe ++ dichnichtgut ++ aus ++ wennesregnet ;
       Inv  => liebe ++ ich ++ dichnichtgut ++ aus ++ wennesregnet ;
       Sub  => ich ++ dichnichtgut ++ aus ++ liebe ++ wennesregnet
       }
    } ;

--3 Sentence-complement verbs
--
-- Sentence-complement verbs take sentences as complements.

  SentenceVerb : Type = Verb ;

  complSentVerb : SentenceVerb -> Sentence -> VerbGroup = \sage,duisst ->
    sage ** {
      s3 = \\b,_ => negation b ;
      s4 = "," ++ "dass" ++ duisst.s ! Sub
      } ;

--3 Verb-complement verbs
--
-- Verb-complement verbs take verb phrases as complements.
-- They can be auxiliaries ("können", "müssen") or ordinary verbs
-- ("versuchen"); this distinction cannot be done in the multilingual
-- API. The distinction shows in whether the infinitive particle "zu" is needed.

  VerbVerb : Type = Verb ** {isAux : Bool} ;

  complVerbVerb : VerbVerb -> VerbGroup -> VerbGroup = \will, essen ->
    will ** {
      s3 = \\b,n => essen.s3 ! True ! n ++ negation b ++ 
                    essen.s2 ++ zuInfinitive will.isAux ++ essen.s ! VInf ;
      s4 = essen.s4
      } ;

  zuInfinitive : Bool -> Str = \isAux -> 
    if_then_Str isAux [] "zu" ;

--2 Sentences missing noun phrases
--
-- This is one instance of Gazdar's *slash categories*, corresponding to his
-- $S/NP$.
-- We cannot have - nor would we want to have - a productive slash-category former.
-- Perhaps a handful more will be needed.
--
-- Notice that the slash category has the same relation to sentences as
-- transitive verbs have to verbs: it's like a *sentence taking a complement*.

  SentenceSlashNounPhrase : Type = Sentence ** {s2 : Preposition ; c : Case} ;

  slashTransVerb : Bool -> NounPhrase -> TransVerb -> SentenceSlashNounPhrase = 
    \b, Ich, sehen -> 
    let {
      ich   = Ich.s ! NPCase Nom ; 
      sehe  = sehen.s ! VInd Ich.n P3 ;
      aus   = sehen.s2 ;
      nicht = negation b
    } in
    {s = table {
       Main => ich ++ sehe ++ nicht ++ aus ;  
       Inv  => sehe ++ ich ++ nicht ++ aus ;
       Sub  => ich ++ nicht ++ aus ++ sehe
       } ;
     s2 = sehen.s3 ; 
     c = sehen.c
    } ;

--2 Relative pronouns and relative clauses
--
-- Relative pronouns are inflected in
-- gender, number, and case just like adjectives.

oper
  identRelPron : RelPron = relPron ;

  funRelPron : Function -> RelPron -> RelPron = \wert, der -> 
    {s = \\gn,c => let {nu = numGenNum gn} in
           artDef ! gNumber wert.g nu ! c ++ wert.s ! Weak ! nu ! c ++  
           wert.s2 ++ der.s ! gn ! wert.c
    } ;

-- Relative clauses can be formed from both verb phrases ("der schläft") and
-- slash expressions ("den ich sehe", "auf dem ich sitze"). 

  RelClause : Type = {s : GenNum => Str} ;

  relVerbPhrase : RelPron -> VerbPhrase -> RelClause = \der, geht ->
    {s = \\gn => (predVerbPhrase (normalNounPhrase (der.s ! gn) (numGenNum gn))
                                 geht
                 ).s ! Sub
    } ;

  relSlash : RelPron -> SentenceSlashNounPhrase -> RelClause = \den, ichSehe ->
    {s = \\gn => ichSehe.s2 ++ den.s ! gn ! ichSehe.c ++ ichSehe.s ! Sub
    } ;

-- A 'degenerate' relative clause is the one often used in mathematics, e.g.
-- "Zahl x derart, dass x gerade ist".

  relSuch : Sentence -> RelClause = \A ->
    {s = \\_ => "derart" ++ "dass" ++ A.s ! Sub} ;

-- The main use of relative clauses is to modify common nouns.
-- The result is a common noun, out of which noun phrases can be formed
-- by determiners. A comma is used before the relative clause.

  modRelClause : CommNounPhrase -> RelClause -> CommNounPhrase = \mann,dergeht ->
    {s = \\a,n,c => mann.s ! a ! n ! c ++ "," ++ dergeht.s ! gNumber mann.g n ;
     g = mann.g
    } ;


--2 Interrogative pronouns
--
-- If relative pronouns are adjective-like, interrogative pronouns are
-- noun-phrase-like. We use a simplified type, since we don't need the possessive
-- forms.

  IntPron : Type = ProperName ** {n : Number} ; 

-- In analogy with relative pronouns, we have a rule for applying a function
-- to a relative pronoun to create a new one. 

  funIntPron : Function -> IntPron -> IntPron = \wert, wer ->
    let {n = wer.n} in 
    {s = \\c => 
           artDef ! gNumber wert.g n ! c ++ wert.s ! Weak ! n ! c ++  
           wert.s2 ++ wer.s ! wert.c ;
     n = n
    } ;

-- There is a variety of simple interrogative pronouns:
-- "welches Haus", "wer", "was".

  nounIntPron : Number -> CommNounPhrase -> IntPron = \n,cn ->
    let {np = detNounPhrase (welchDet n) cn} in
      {s = \\c => np.s ! NPCase c ;
       n = np.n} ;

  intPronWho : Number -> IntPron = \num -> {
    s = caselist "wer" "wen" "wem" "weren" ;
    n = num
  } ;

  intPronWhat : Number -> IntPron = \num -> {
    s = caselist "was" "was" nonExist nonExist ; ---
    n = num
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
  
  indicUtt : Sentence -> Utterance = \x -> ss (x.s ! Main ++ ".") ;
  interrogUtt : Question -> Utterance = \x -> ss (x.s ! DirQ ++ "?") ;


--2 Questions
--
-- Questions are either direct ("bist du müde") or indirect 
-- ("ob du müde bist").

param 
  QuestForm = DirQ | IndirQ ;

oper
  Question = SS1 QuestForm ;

--3 Yes-no questions 
--
-- Yes-no questions are used both independently ("bist du müde")
-- and after interrogative adverbials ("warum bist du müde").
-- It is economical to handle with these two cases by the one
-- rule, $questVerbPhrase'$. The only difference is if "ob" appears
-- in the indirect form.

  questVerbPhrase : NounPhrase -> VerbPhrase -> Question = 
    questVerbPhrase' False ;

  questVerbPhrase' : Bool -> NounPhrase -> VerbPhrase -> Question = 
    \adv, du,gehst ->
    let {dugehst = (predVerbPhrase du gehst).s} in
    {s = table {
      DirQ   => dugehst ! Inv ;
      IndirQ => (if_then_else Str adv [] "ob") ++ dugehst ! Sub
      }
    } ;


--3 Wh-questions
--
-- Wh-questions are of two kinds: ones that are like $NP - VP$ sentences,
-- others that are line $S/NP - NP$ sentences.

  intVerbPhrase : IntPron -> VerbPhrase -> Question = \Wer,geht ->
    let {wer : NounPhrase = normalNounPhrase Wer.s Wer.n ;
         wergeht : Sentence = predVerbPhrase wer geht
        } in
    {s = table {
      DirQ   => wergeht.s ! Main ;
      IndirQ => wergeht.s ! Sub 
      }
    } ;

  intSlash : IntPron -> SentenceSlashNounPhrase -> Question = \wer, ichSehe ->
    let {zuwen = ichSehe.s2 ++ wer.s ! ichSehe.c} in
    {s = table {
      DirQ   => zuwen ++ ichSehe.s ! Inv ;
      IndirQ => zuwen ++ ichSehe.s ! Sub
      } 
    } ;


--3 Interrogative adverbials
--
-- These adverbials will be defined in the lexicon: they include
-- "wann", "war", "wie", "warum", etc, which are all invariant one-word
-- expressions. In addition, they can be formed by adding prepositions
-- to interrogative pronouns, in the same way as adverbials are formed
-- from noun phrases. 

  IntAdverb = SS ;

  prepIntAdverb : Case -> Preposition -> IntPron -> IntAdverb =\ c,auf,wem ->
    ss (auf ++ wem.s ! c) ;

-- A question adverbial can be applied to anything, and whether this makes
-- sense is a semantic question.

  questAdverbial : IntAdverb -> NounPhrase -> VerbPhrase -> Question = 
    \wie, du, tust ->
    {s = \\q => wie.s ++ (questVerbPhrase du tust).s ! q} ;


--2 Imperatives
--
-- We only consider second-person imperatives. No polite "Sie" form so far.

  Imperative = SS1 Number ;

  imperVerbPhrase : VerbPhrase -> Imperative = \komm -> 
    {s = \\n => komm.s ! VImp n ++ komm.s3 ! n ++ komm.s2 ++ komm.s4} ;  

  imperUtterance : Number -> Imperative -> Utterance = \n,I ->
    ss (I.s ! n ++ "!") ;

--2 Sentence adverbials
--
-- This class covers adverbials such as "sonst", "deshalb", which are prefixed
-- to a sentence to form a phrase; the sentence gets inverted word order.

  advSentence : Adverb -> Sentence -> Utterance = \sonst,ist1gerade ->
    ss (sonst.s ++ ist1gerade.s ! Inv ++ ".") ;

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
-- simple ("und", "oder") or distributed ("sowohl - als auch", "entweder - oder").
--
-- The conjunction has an inherent number, which is used when conjoining
-- noun phrases: "John und Mary sind..." vs. "John oder Mary ist..."; in the
-- case of "oder", the result is however plural if any of the disjuncts is.

  Conjunction = CO.Conjunction ** {n : Number} ;
  ConjunctionDistr = CO.ConjunctionDistr ** {n : Number} ;


--3 Coordinating sentences
--
-- We need a category of lists of sentences. It is a discontinuous
-- category, the parts corresponding to 'init' and 'last' segments
-- (rather than 'head' and 'tail', because we have to keep track of the slot between
-- the last two elements of the list). A list has at least two elements.

  ListSentence : Type = {s1,s2 : Order => Str} ; 

  twoSentence : (_,_ : Sentence) -> ListSentence = 
    CO.twoTable Order ;

  consSentence : ListSentence -> Sentence -> ListSentence = 
    CO.consTable Order CO.comma ;

-- To coordinate a list of sentences by a simple conjunction, we place
-- it between the last two elements; commas are put in the other slots,
-- e.g. "du rauchst, er trinkt und ich esse".

  conjunctSentence : Conjunction -> ListSentence -> Sentence = 
    CO.conjunctTable Order ;

-- To coordinate a list of sentences by a distributed conjunction, we place
-- the first part (e.g. "entweder") in front of the first element, the second
-- part ("oder") between the last two elements, and commas in the other slots.
-- For sentences this is really not used.

  conjunctDistrSentence : ConjunctionDistr -> ListSentence -> Sentence = 
    CO.conjunctDistrTable Order ;

--3 Coordinating adjective phrases
--
-- The structure is the same as for sentences. The result is a prefix adjective
-- if and only if all elements are prefix.

  ListAdjPhrase : Type = 
    {s1,s2 : AForm => Str ; p : Bool} ;

  twoAdjPhrase : (_,_ : AdjPhrase) -> ListAdjPhrase = \x,y ->
    CO.twoTable AForm x y ** {p = andB x.p y.p} ;
  consAdjPhrase : ListAdjPhrase -> AdjPhrase -> ListAdjPhrase =  \xs,x ->
    CO.consTable AForm CO.comma xs x ** {p = andB xs.p x.p} ;

  conjunctAdjPhrase : Conjunction -> ListAdjPhrase -> AdjPhrase = \c,xs ->
    CO.conjunctTable AForm c xs ** {p = xs.p} ;

  conjunctDistrAdjPhrase : ConjunctionDistr -> ListAdjPhrase -> AdjPhrase = \c,xs ->
    CO.conjunctDistrTable AForm c xs ** {p = xs.p} ;



--3 Coordinating noun phrases
--
-- The structure is the same as for sentences. The result is either always plural
-- or plural if any of the components is, depending on the conjunction.
-- The result is a pronoun if all components are.

  ListNounPhrase : Type = 
    {s1,s2 : NPForm => Str ; n : Number ; p : Person ; pro : Bool} ;

  twoNounPhrase : (_,_ : NounPhrase) -> ListNounPhrase = \x,y ->
    CO.twoTable NPForm x y ** 
    {n = conjNumber x.n y.n ; p = conjPerson x.p y.p ; pro = andB x.pro y.pro} ;

  consNounPhrase : ListNounPhrase -> NounPhrase -> ListNounPhrase =  \xs,x ->
    CO.consTable NPForm CO.comma xs x ** 
    {n = conjNumber xs.n x.n ; p = conjPerson xs.p x.p ; pro = andB xs.pro x.pro} ;

  conjunctNounPhrase : Conjunction -> ListNounPhrase -> NounPhrase = \c,xs ->
    CO.conjunctTable NPForm c xs ** 
    {n = conjNumber c.n xs.n ; p = xs.p ; pro = xs.pro} ;

  conjunctDistrNounPhrase : ConjunctionDistr -> ListNounPhrase -> NounPhrase = 
    \c,xs ->
    CO.conjunctDistrTable NPForm c xs ** 
    {n = conjNumber c.n xs.n ; p = xs.p ; pro = xs.pro} ;

-- We have to define a calculus of numbers of persons. For numbers,
-- it is like the conjunction with $Pl$ corresponding to $False$.

  conjNumber : Number -> Number -> Number = \m,n -> case <m,n> of {
    <Sg,Sg> => Sg ;
    _ => Pl 
    } ;

-- For persons, we go in the descending order:
-- "ich und dich sind stark", "er oder du bist stark".
-- This is not always quite clear.

  conjPerson : Person -> Person -> Person = \p,q -> case <p,q> of {
    <P3,P3> => P3 ;
    <P1,_>  => P1 ;
    <_,P1>  => P1 ;
    _       => P2
    } ;


--2 Subjunction
--
-- Subjunctions ("wenn", "falls", etc) 
-- are a different way to combine sentences than conjunctions.
-- The main clause can be a sentences, an imperatives, or a question,
-- but the subjoined clause must be a sentence.

  Subjunction = SS ;

  subjunctSentence : Subjunction -> Sentence -> Sentence -> Sentence = \if, A, B ->
    let {As = A.s ! Sub} in 
    {s = table {
           Main => variants {if.s ++ As ++ "," ++ B.s ! Inv ; 
                             B.s ! Main ++ "," ++ if.s ++ As} ;
           o    => B.s ! o ++ "," ++ if.s ++ As
           } 
     } ;

  subjunctImperative : Subjunction -> Sentence -> Imperative -> Imperative = 
    \if, A, B -> 
    {s = \\n => subjunctVariants if A (B.s ! n)} ;

  subjunctQuestion : Subjunction -> Sentence -> Question -> Question = \if, A, B ->
    {s = \\q => subjunctVariants if A (B.s ! q)} ;

-- There are uniformly two variant word orders, e.g. 
-- "wenn du rauchst, werde ish böse"
-- and "ich werde böse, wenn du rauchst".

  subjunctVariants : Subjunction -> Sentence -> Str -> Str = \if,A,B ->
    let {As = A.s ! Sub} in 
    variants {if.s ++ As ++ "," ++ B ; B ++ "," ++ if.s ++ As} ;

-- Subjunctions can be used for building adverbials, which can modify verb phrases
-- ("ich lache wenn ich gehe und singe wenn ich laufe"). , noun phrases, etc.
-- For reasons of word order, we treat this separately from other adverbials,
-- but this could be remedied by an extra parameter in adverbials.

  subjunctVerbPhrase : VerbPhrase -> Subjunction -> Sentence -> VerbPhrase = 
    \ruft,wenn,ergeht ->
    {s  = ruft.s ; 
     s2 = ruft.s2 ;
     s3 = ruft.s3 ;
     s4 = ruft.s4 ++ "," ++ wenn.s ++ ergeht.s ! Sub 
    } ;

--2 One-word utterances
-- 
-- An utterance can consist of one phrase of almost any category, 
-- the limiting case being one-word utterances. These
-- utterances are often (but not always) in what can be called the
-- default form of a category, e.g. the nominative.
-- This list is far from exhaustive.

  useNounPhrase : NounPhrase -> Utterance = \john ->
    postfixSS "." (defaultNounPhrase john) ;
  useCommonNounPhrase : Number -> CommNounPhrase -> Utterance = \n,car -> 
    useNounPhrase (indefNounPhrase n car) ;

-- Here are some default forms.

  defaultNounPhrase : NounPhrase -> SS = \john -> 
    ss (john.s ! NPCase Nom) ;

  defaultQuestion : Question -> SS = \whoareyou ->
    ss (whoareyou.s ! DirQ) ;

  defaultSentence : Sentence -> Utterance = \x -> ss (x.s ! Main) ;

--3 Puzzle
--
-- Adding some lexicon, we can generate the sentence
--
-- "der grösste alte Mann ist nicht ein Auto auf die Mutter von dem Männer warten"
--
-- which looks completely ungrammatical! What you should do to decipher it is
-- put parentheses around "auf die Mutter von dem".

} ;
