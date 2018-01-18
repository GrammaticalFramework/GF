--# -path=.:../abstract:../../prelude:../common

--1 English Lexical Paradigms
--
-- Aarne Ranta 2003--2005
--
-- This is an API for the user of the resource grammar 
-- for adding lexical items. It gives functions for forming
-- expressions of open categories: nouns, adjectives, verbs.
-- 
-- Closed categories (determiners, pronouns, conjunctions) are
-- accessed through the resource syntax API, $Structural.gf$. 
--
-- The main difference with $MorphoEng.gf$ is that the types
-- referred to are compiled resource grammar types. We have moreover
-- had the design principle of always having existing forms, rather
-- than stems, as string arguments of the paradigms.
--
-- The structure of functions for each word class $C$ is the following:
-- first we give a handful of patterns that aim to cover all
-- regular cases. Then we give a worst-case function $mkC$, which serves as an
-- escape to construct the most irregular words of type $C$.
-- However, this function should only seldom be needed: we have a
-- separate module [``IrregEng`` ../../english/IrregEng.gf], 
-- which covers irregular verbss.

resource ParadigmsEng = open 
  (Predef=Predef), 
  Prelude, 
  MorphoEng,
  ResEng,
  CatEng
  in {
--2 Parameters 
--
-- To abstract over gender names, we define the following identifiers.

oper
  Gender : Type ; 

  human     : Gender ;
  nonhuman  : Gender ;
  masculine : Gender ; --%
  feminine : Gender ; --%

-- To abstract over number names, we define the following.

  Number : Type ; 

  singular : Number ; 
  plural   : Number ;

-- To abstract over case names, we define the following.

  Case : Type ; --%

  nominative : Case ; --%
  genitive   : Case ; --%

-- Prepositions are used in many-argument functions for rection.
-- The resource category $Prep$ is used.

-- The number of a noun phrase can be extracted with the following
-- function.

  npNumber : NP -> Number ; -- exctract the number of a noun phrase


--2 Nouns

-- Nouns are constructed by the function $mkN$, which takes a varying
-- number of arguments.

  mkN : overload {

-- The regular function captures the variants for nouns ending with
-- "s","sh","x","z" or "y": "kiss - kisses", "flash - flashes"; 
-- "fly - flies" (but "toy - toys"),

    mkN : (flash : Str) -> N ;  -- plural s, incl. flash-flashes, fly-flies 

-- In practice the worst case is to give singular and plural nominative.

    mkN : (man,men : Str) -> N ; -- irregular plural

-- The theoretical worst case: give all four forms.

    mkN : (man,men,man's,men's : Str) -> N ; -- irregular genitives

-- Change gender from the default $nonhuman$.

    mkN : Gender -> N -> N ;  -- default nonhuman

--3 Compound nouns 
--
-- A compound noun is an uninflected string attached to an inflected noun,
-- such as "baby boom", "chief executive officer".

    mkN : Str -> N -> N -- e.g. baby + boom
  } ;


--3 Relational nouns 

  mkN2 : overload {
    mkN2 : Str -> N2 ; -- reg. noun, prep. "of" --% 
    mkN2 : N -> N2 ; -- e.g. wife of (default prep. to)
    mkN2 : N -> Str -> N2 ; -- access to --%
    mkN2 : N -> Prep -> N2 ; -- e.g. access to
    mkN2 : Str -> Str -> N2 ; -- access to (regular noun) --%
  } ;

-- Use the function $mkPrep$ or see the section on prepositions below to  
-- form other prepositions.
--
-- Three-place relational nouns ("the connection from x to y") need two prepositions.

  mkN3 : N -> Prep -> Prep -> N3 ; -- e.g. connection from x to y



--3 Proper names and noun phrases
--
-- Proper names, with a regular genitive, are formed from strings.

  mkPN : overload {

    mkPN : Str -> PN ;

-- Sometimes a common noun can be reused as a proper name, e.g. "Bank"

    mkPN : N -> PN --%
  } ;

--3 Determiners and quantifiers

  mkQuant : overload {
    mkQuant : (this, these : Str) -> Quant ; --%
    mkQuant : (no_sg, no_pl, none_sg, non_pl : Str) -> Quant ; --%
  } ;

  mkOrd : Str -> Ord ; --%

--2 Adjectives

  mkA : overload {

-- For regular adjectives, the adverbial and comparison forms are derived. This holds
-- even for cases with the variations "happy - happily - happier - happiest",
-- "free - freely - freer - freest", and "rude - rudest".

    mkA : (happy : Str) -> A ; -- regular adj, incl. happy-happier, rude-ruder

-- However, the duplication of the final consonant cannot be predicted,
-- but a separate case is used to give the comparative

    mkA : (fat,fatter : Str) -> A ; -- irreg. comparative

-- As many as four forms may be needed.

    mkA : (good,better,best,well : Str) -> A  -- completely irreg.
    } ;

-- Regular comparison is formed by "more - most" for words with two vowels separated
-- and terminated by some other letters. To force this or the opposite, 
-- the following can be used:  

    compoundA : A -> A ; -- force comparison with more/most
    simpleA   : A -> A ; -- force comparison with -er,-est
    irregAdv  : A -> Str -> A ;  -- adverb irreg, e.g. "fast"

--3 Two-place adjectives

  mkA2 : overload {
    mkA2 : A -> Prep -> A2 ; -- absent from 
    mkA2 : A -> Str -> A2 ; -- absent from --%
    mkA2 : Str -> Prep -> A2 ; -- absent from --%
    mkA2 : Str -> Str -> A2 -- absent from --%

  } ;


--2 Adverbs

-- Adverbs are not inflected. Most lexical ones have position
-- after the verb. Some can be preverbal (e.g. "always").

  mkAdv : Str -> Adv ; -- e.g. today
  mkAdV : Str -> AdV ; -- e.g. always

-- Adverbs modifying adjectives and sentences can also be formed.

  mkAdA : Str -> AdA ; -- e.g. quite

-- Adverbs modifying numerals

  mkAdN : Str -> AdN ; -- e.g. approximately

--2 Prepositions
--
-- A preposition as used for rection in the lexicon, as well as to
-- build $PP$s in the resource API, just requires a string.

  mkPrep : Str -> Prep ; -- e.g. "in front of"
  mkPost : Str -> Prep ; -- e.g. "ago"
  noPrep : Prep ;  -- no preposition

-- (These two functions are synonyms.)

--2 Conjunctions
--

  mkConj : overload {
    mkConj : Str -> Conj ;                  -- and (plural agreement) --%
    mkConj : Str -> Number -> Conj ;        -- or (agrement number given as argument) --%
    mkConj : Str -> Str -> Conj ;           -- both ... and (plural) --%
    mkConj : Str -> Str -> Number -> Conj ; -- either ... or (agrement number given as argument) --%
  } ;

--2 Verbs
--

-- Verbs are constructed by the function $mkV$, which takes a varying
-- number of arguments.

  mkV : overload {

-- The regular verb function recognizes the special cases where the last
-- character is "y" ("cry-cries" but "buy-buys") or a sibilant
-- ("kiss-"kisses", "jazz-jazzes", "rush-rushes", "munch - munches", 
-- "fix - fixes").

    mkV : (cry : Str) -> V ; -- regular, incl. cry-cries, kiss-kisses etc

-- Give the present and past forms for regular verbs where
-- the last letter is duplicated in some forms,
-- e.g. "rip - ripped - ripping".

    mkV : (stop, stopped : Str) -> V ; -- reg. with consonant duplication

-- There is an extensive list of irregular verbs in the module $IrregularEng$.
-- In practice, it is enough to give three forms, 
-- e.g. "drink - drank - drunk".

    mkV : (drink, drank, drunk  : Str) -> V ; -- ordinary irregular

-- Irregular verbs with duplicated consonant in the present participle.
 
    mkV : (run, ran, run, running  : Str) -> V ; -- irregular with duplication --%

-- Except for "be", the worst case needs five forms: the infinitive and
-- the third person singular present, the past indicative, and the
-- past and present participles.

    mkV : (go, goes, went, gone, going : Str) -> V ; -- totally irregular

-- Adds a prefix to an exisiting verb. This is most useful to create
-- prefix-variants of irregular verbs from $IrregEng$, e.g. "undertake".

    mkV : Str -> V -> V ;  -- fix compound, e.g. under+take
  };

-- Verbs with a particle.
-- The particle, such as in "switch on", is given as a string.

  partV  : V -> Str -> V ; -- with particle, e.g. switch + on

-- Reflexive verbs.
-- By default, verbs are not reflexive; this function makes them that.

  reflV  : V -> V ;  -- reflexive e.g. behave oneself

-- Verbs with variant American-British spelling

  us_britishV : Str -> V ;  -- travel - traveled/travelled

--3 Two-place verbs
--
-- Two-place verbs need a preposition, except the special case with direct object.
-- (transitive verbs). Notice that a particle comes from the $V$.

  mkV2 : overload {
    mkV2  : Str -> V2 ;       -- kill --%
    mkV2  : V -> V2 ;         -- transitive, e.g. hit
    mkV2  : V -> Prep -> V2 ; -- with preposiiton, e.g. believe in
    mkV2  : V -> Str -> V2 ;  -- believe in --%
    mkV2  : Str -> Prep -> V2 ; -- believe in --%
    mkV2  : Str -> Str -> V2  -- believe in --%
  };

--3 Three-place verbs
--
-- Three-place (ditransitive) verbs need two prepositions, of which
-- the first one or both can be absent.

  mkV3 : overload {
    mkV3  : V -> V3 ;                   -- ditransitive, e.g. give,_,_
    mkV3  : V -> Prep -> Prep -> V3 ;   -- two prepositions, e.g. speak, with, about
    mkV3  : V -> Prep -> V3 ;           -- give,_,to --%
    mkV3  : V -> Str -> V3 ;            -- give,_,to --%
    mkV3  : Str -> Str -> V3 ;          -- give,_,to --%
    mkV3  : Str -> V3 ;                 -- give,_,_ --%
  };

--3 Other complement patterns
--
-- Verbs and adjectives can take complements such as sentences,
-- questions, verb phrases, and adjectives.

  mkV0  : V -> V0 ; --%
  mkVS  : V -> VS ; -- sentence-compl e.g. say (that S)
  mkV2S : V -> Prep -> V2S ; -- e.g. tell (NP) (that S)
  mkVV  : V -> VV ; -- e.g. want (to VP)
  infVV : V -> VV ; -- e.g. want (to VP)
  ingVV : V -> VV ; -- e.g. start (VPing)
  mkV2V : overload {
    mkV2V : Str -> V2V ;
    mkV2V : V -> V2V ;
    mkV2V : V -> Prep -> Prep -> V2V ;  -- e.g. want (noPrep NP) (to VP)
    } ;
  ingV2V : V -> Prep -> Prep -> V2V ; -- e.g. prevent (noPrep NP) (from VP-ing)
  mkVA  : V -> VA ; -- e.g. become (AP)
  mkV2A : V -> Prep -> V2A ; -- e.g. paint (NP) (AP)
  mkVQ  : V -> VQ ; -- e.g. wonder (QS)
  mkV2Q : V -> Prep -> V2Q ; -- e.g. ask (NP) (QS)

  mkAS  : A -> AS ; --%
  mkA2S : A -> Prep -> A2S ; --%
  mkAV  : A -> AV ; --%
  mkA2V : A -> Prep -> A2V ; --%

-- Notice: Categories $V0, AS, A2S, AV, A2V$ are just $A$.
-- $V0$ is just $V$; the second argument is treated as adverb.

  V0 : Type ; --%
  AS, A2S, AV, A2V : Type ; --%

--2 Other categories

mkSubj : Str -> Subj = \s -> lin Subj {s = s} ; --%
mkInterj : Str -> Interj
  = \s -> lin Interj (ss s) ;

--.
--2 Definitions of paradigms
--
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.

  Gender = ResEng.Gender ; 
  Number = ResEng.Number ;
  Case = ResEng.NPCase ;
  human = Masc ; 
  nonhuman = Neutr ;
  masculine = Masc ;
  feminine = Fem ;
  singular = Sg ;
  plural = Pl ;
  nominative = npNom ;
  genitive = npGen ;

  npNumber np = (fromAgr np.a).n ;

  Preposition : Type = Str ; -- obsolete

  regN = \ray -> 
    let rays = add_s ray
     in
       mk2N ray rays ;


  add_s : Str -> Str = \w -> case w of {
    _ + ("io" | "oo")                         => w + "s" ;   -- radio, bamboo
    _ + ("s" | "z" | "x" | "sh" | "ch" | "o") => w + "es" ;  -- bus, hero
    _ + ("a" | "o" | "u" | "e") + "y"  => w + "s" ;   -- boy
    x + "y"                            => x + "ies" ; -- fly
    _                                  => w + "s"     -- car
    } ;

  duplFinal : Str -> Str = \w -> case w of {
    _ + ("a" | "e" | "o") + ("a" | "e" | "i" | "o" | "u") + ? => w ; -- waited, needed
    _ + ("a" | "e" | "i" | "o" | "u") + 
      c@("b"|"d"|"g"|"m"|"n"|"p"|"r"|"t") => w + c ; -- omitted, manned
    _ => w
    } ;

  mk2N = \man,men -> 
    let mens = case last men of {
      "s" => men + "'" ;
      _   => men + "'s"
      }
    in
    mk4N man men (man + "'s") mens ;

  mk4N = \man,men,man's,men's -> 
    lin N (mkNoun man man's men men's ** {g = Neutr}) ;

  genderN g man = lin N {s = man.s ; g = g} ;

  compoundN s n = lin N {s = \\x,y => s ++ n.s ! x ! y ; g=n.g} ;

  mkPN = overload {
    mkPN : Str -> PN = regPN ;
    mkPN : N -> PN = nounPN
  } ;

  mkN2 = overload {
    mkN2 : N -> Prep -> N2 = prepN2 ;
    mkN2 : N -> Str -> N2 = \n,s -> prepN2 n (mkPrep s);
    mkN2 : Str -> Str -> N2 = \n,s -> prepN2 (regN n) (mkPrep s);
    mkN2 : N -> N2         = \n -> prepN2 n (mkPrep "of") ;
    mkN2 : Str -> N2       = \s -> prepN2 (regN s) (mkPrep "of") 
  } ;

  prepN2 = \n,p -> lin N2 (n ** {c2 = p.s}) ;
  regN2 n = prepN2 (regN n) (mkPrep "of") ;

  mkN3 = \n,p,q -> lin N3 (n ** {c2 = p.s ; c3 = q.s}) ;

--3 Relational common noun phrases
--
-- In some cases, you may want to make a complex $CN$ into a
-- relational noun (e.g. "the old town hall of").

  cnN2 : CN -> Prep -> N2 ;
  cnN3 : CN -> Prep -> Prep -> N3 ;

-- This is obsolete.
  cnN2 = \n,p -> lin N2 (n ** {c2 = p.s}) ;
  cnN3 = \n,p,q -> lin N3 (n ** {c2 = p.s ; c3 = q.s}) ;

  regPN n = regGenPN n human ;
  regGenPN n g = lin PN {s = table {Gen => n + "'s" ; _ => n} ; g = g} ;
  nounPN n = lin PN {s = n.s ! singular ; g = n.g} ;

  mkQuant = overload {
    mkQuant : (this, these : Str) -> Quant = \sg,pl -> mkQuantifier sg pl sg pl;
    mkQuant : (no_sg, no_pl, none_sg, non_pl : Str) -> Quant = mkQuantifier;
  } ;

  mkQuantifier : Str -> Str -> Str -> Str -> Quant = 
   \sg,pl,sg',pl' -> lin Quant {
    s = \\_  => table { Sg => sg ; Pl => pl } ;
    sp = \\_ => table { 
      Sg => \\c => regGenitiveS sg' ! npcase2case c ; Pl => \\c => regGenitiveS pl' ! npcase2case c}
    } ;

  mkOrd : Str -> Ord = \x -> lin Ord { s = regGenitiveS x};

  mk2A a b = mkAdjective a a a b ;
  regA a = case a of {
    _ + ("a" | "e" | "i" | "o" | "u" | "y") + ? + _ + 
        ("a" | "e" | "i" | "o" | "u" | "y") + ? + _  => 
         lin A (compoundADeg (regADeg a)) ;
    _ => lin A (regADeg a)
    } ;

  prepA2 a p = lin A2 (a ** {c2 = p.s}) ;

  ADeg = A ; ----

  mkADeg a b c d = mkAdjective a b c d ;

  regADeg happy = 
    let
      happ = init happy ;
      y    = last happy ;
      happie = case y of {
        "y" => happ + "ie" ;
        "e" => happy ;
        _   => duplFinal happy + "e"
        } ;
    in mkADeg happy (happie + "r") (happie + "st") (adj2adv happy) ;
    
  adj2adv : Str -> Str = \happy ->
    case happy of {
      _ + "ble" => init happy + "y" ;
      _ + "y"   => init happy + "ily" ;
      _ + "ll"  => happy + "y" ;
      _         => happy + "ly"
      } ;

  duplADeg fat = 
    mkADeg fat 
    (fat + last fat + "er") (fat + last fat + "est") (adj2adv fat) ;

  compoundADeg a =
    let ad = (a.s ! AAdj Posit Nom) 
    in mkADeg ad ("more" ++ ad) ("most" ++ ad) (a.s ! AAdv) ;

  adegA a = a ;

  mkAdv x = lin Adv (ss x) ;
  mkAdV x = lin AdV (ss x) ;
  mkAdA x = lin AdA (ss x) ;
  mkAdN x = lin AdN (ss x) ;

  mkPrep p = lin Prep {s=p; isPre=True} ;
  mkPost p = lin Prep {s=p; isPre=False} ;
  noPrep = mkPrep [] ;

  mk5V a b c d e = lin V (mkVerb a b c d e ** {s1 = []}) ;

  regV cry = 
    let
      cries = (regN cry).s ! Pl ! Nom ; -- !
      cried : Str = case cries of {
        _ + "es" => init cries + "d" ;
        _ + "ers" => init cries + "ed" ;
        _        => duplFinal cry + "ed"
        } ;
      crying : Str = case cry of {
        _  + "ee" => cry + "ing" ;
        d  + "ie" => d  + "ying" ;
        us + "e"  => us + "ing" ; 
        ent + "er" => ent + "ering" ;
        _         => duplFinal cry + "ing"
        }
    in mk5V cry cries cried cried crying ;

  reg2V fit fitted =
   let fitt = Predef.tk 2 fitted ;
   in 
     if_then_else V (pbool2bool (Predef.eqStr (last fit) (last fitt)))
       (mk5V fit (fit + "s") (fitt + "ed") (fitt + "ed") (fitt + "ing")) 
       (regV fit) ;

  regDuplV fit = 
    case last fit of {
      ("a" | "e" | "i" | "o" | "u" | "y") => 
        Predef.error (["final duplication makes no sense for"] ++ fit) ;
      t =>
       let fitt = fit + t in
       mk5V fit (fit + "s") (fitt + "ed") (fitt + "ed") (fitt + "ing")
      } ;

  irregV x y z = let reg = (regV x).s in
    mk5V x (reg ! VPres) y z (reg ! VPresPart) ** {s1 = []} ;

  irreg4V x y z w = let reg = (regV x).s in
    mk5V x (reg ! VPres) y z w ** {s1 = []} ;

  irregDuplV fit y z = 
    let 
      fitting = (regDuplV fit).s ! VPresPart
    in
    mk5V fit (fit + "s") y z fitting ;

  partV v p = lin V {s = \\f => v.s ! f ; p = p ; isRefl = v.isRefl} ;
  reflV v = lin V {s = v.s ; p = v.p ; isRefl = True} ;

  us_britishV : Str -> V = \s -> case s of {
    _ + ("el" | "al" | "ol") => regV s | mkV s (s + "s") (s + "led") (s + "led") (s + "ling") ;
    _ + "or" => regV s | regV (Predef.tk 2 s + "our") ;
    _ => regV s
    } ;

  prepV2 v p = lin V2 {s = v.s ; p = v.p ; c2 = p.s ; isRefl = v.isRefl} ;
  dirV2 v = prepV2 v noPrep ;

  prepPrepV3 v p q = 
    lin V3 {s = v.s ; p = v.p ; c2 = p.s ; c3 = q.s ; isRefl = v.isRefl} ;
  dirV3 v p = prepPrepV3 v noPrep p ;
  dirdirV3 v = dirV3 v noPrep ;

  mkVS  v = lin VS v ;
  mkVV  v = lin VV {
    s = table {VVF vf => v.s ! vf ; _ => v.s ! VInf} ;
    p = v.p ; 
    typ = VVInf
    } ;
  infVV  v = lin VV {
    s = table {VVF vf => v.s ! vf ; _ => v.s ! VInf} ;
    p = v.p ; 
    typ = VVAux
    } ;
  ingVV  v = lin VV {
    s = table {VVF vf => v.s ! vf ; _ => v.s ! VInf} ;
    p = v.p ; 
    typ = VVPresPart
    } ;
  mkVQ  v = lin VQ v ;

  V0 : Type = V ;
--  V2S, V2V, V2Q : Type = V2 ;
  AS, A2S, AV : Type = A ;
  A2V : Type = A2 ;

  mkV0  v = v ;
  mkV2S v p = lin V2S (prepV2 v p) ;
  mkV2V = overload {
    mkV2V : Str -> V2V = \s -> lin V2V (dirV2 (regV s) ** {c3 = [] ; typ = VVAux}) ;
    mkV2V : V -> V2V = \v -> lin V2V (dirV2 v ** {c3 = [] ; typ = VVAux}) ;
    mkV2V : V -> Prep -> Prep -> V2V = \v,p,t -> lin V2V (prepV2 v p ** {c3 = t.s ; typ = VVAux}) ;
    } ;

  ingV2V v p t = lin V2V (prepV2 v p ** {c3 = t.s ; typ = VVPresPart}) ;
  mkVA  v = lin VA v ;
  mkV2A v p = lin V2A (prepV2 v p) ;
  mkV2Q v p = lin V2Q (prepV2 v p) ;

  mkAS  v = v ;
  mkA2S v p = lin A (prepA2 v p) ;
  mkAV  v = v ;
  mkA2V v p = prepA2 v p ;


-- pre-overload API and overload definitions

  mk4N : (man,men,man's,men's : Str) -> N ;
  regN : Str -> N ;
  mk2N : (man,men : Str) -> N ;
  genderN : Gender -> N -> N ;
  compoundN : Str -> N -> N ;

  mkN = overload {
    mkN : (man,men,man's,men's : Str) -> N = mk4N ;
    mkN : Str -> N = regN ;
    mkN : (man,men : Str) -> N = mk2N ;
    mkN : Gender -> N -> N = genderN ;
    mkN : Str -> N -> N = compoundN
    } ;

-- Relational nouns ("daughter of x") need a preposition. 

  prepN2 : N -> Prep -> N2 ;

-- The most common preposition is "of", and the following is a
-- shortcut for regular relational nouns with "of".

  regN2 : Str -> N2 ;

  mk2A : (free,freely : Str) -> A ;
  regA : Str -> A ;

  mkA = overload {
    mkA : Str -> A = regA ;
    mkA : (fat,fatter : Str) -> A = \fat,fatter -> 
      mkAdjective fat fatter (init fatter + "st") (adj2adv fat) ;
    mkA : (good,better,best,well : Str) -> A = \a,b,c,d ->
      mkAdjective a b c d
    } ;

  compoundA = compoundADeg ;
  simpleA a = 
    let ad = (a.s ! AAdj Posit Nom) 
    in regADeg ad ;
    
  irregAdv a adv = lin A {s = table {AAdv => adv; aform => a.s ! aform}} ;

  prepA2 : A -> Prep -> A2 ;

  mkA2 = overload {
    mkA2 : A -> Prep -> A2   = prepA2 ;
    mkA2 : A -> Str -> A2    = \a,p -> prepA2 a (mkPrep p) ;
    mkA2 : Str -> Prep -> A2 = \a,p -> prepA2 (regA a) p;
    mkA2 : Str -> Str -> A2  = \a,p -> prepA2 (regA a) (mkPrep p);
  } ;

  mk5V : (go, goes, went, gone, going : Str) -> V ;
  regV : (cry : Str) -> V ;
  reg2V : (stop, stopped : Str) -> V;
  irregV : (drink, drank, drunk  : Str) -> V ;
  irreg4V : (run, ran, run, running  : Str) -> V ;

  -- Use reg2V instead
  regDuplV : Str -> V ;
  -- Use irreg4V instead
  irregDuplV : (get,   got,   gotten : Str) -> V ;

  mkV = overload {
    mkV : (cry : Str) -> V = regV ;
    mkV : (stop, stopped : Str) -> V = reg2V ;
    mkV : (drink, drank, drunk  : Str) -> V = irregV ;
    mkV : (run, ran, run, running  : Str) -> V = irreg4V ;
    mkV : (go, goes, went, gone, going : Str) -> V = mk5V ;
    mkV : Str -> V -> V = prefixV
  };

  prepV2 : V -> Prep -> V2 ;
  dirV2 : V -> V2 ;
  prefixV : Str -> V -> V = \p,v -> lin V { s = \\vform => p + v.s ! vform; p = v.p ; isRefl = v.isRefl } ;

  mkV2 = overload {
    mkV2  : V -> V2 = dirV2 ;
    mkV2  : Str -> V2 = \s -> dirV2 (regV s) ;
    mkV2  : V -> Prep -> V2 = prepV2 ;
    mkV2  : V -> Str -> V2 = \v,p -> prepV2 v (mkPrep p) ;
    mkV2  : Str -> Prep -> V2 = \v,p -> prepV2 (regV v) p ;
    mkV2  : Str -> Str -> V2 = \v,p -> prepV2 (regV v) (mkPrep p)
  }; 

  prepPrepV3 : V -> Prep -> Prep -> V3 ;
  dirV3 : V -> Prep -> V3 ;
  dirdirV3 : V -> V3 ;

  mkV3 = overload {
    mkV3 : V -> Prep -> Prep -> V3 = prepPrepV3 ;
    mkV3 : V -> Prep -> V3 = dirV3 ;
    mkV3 : V -> Str -> V3 = \v,s -> dirV3 v (mkPrep s);
    mkV3 : Str -> Str -> V3 = \v,s -> dirV3 (regV v) (mkPrep s);
    mkV3 : V -> V3 = dirdirV3 ;
    mkV3 : Str -> V3 = \v -> dirdirV3 (regV v) ;
  } ;

  mkConj = overload {
    mkConj : Str -> Conj = \y -> mk2Conj [] y plural ;
    mkConj : Str -> Number -> Conj = \y,n -> mk2Conj [] y n ;
    mkConj : Str -> Str -> Conj = \x,y -> mk2Conj x y plural ;
    mkConj : Str -> Str -> Number -> Conj = mk2Conj ;
  } ;

  mk2Conj : Str -> Str -> Number -> Conj = \x,y,n -> 
    lin Conj (sd2 x y ** {n = n}) ;

---- obsolete

-- Comparison adjectives may two more forms. 

  ADeg : Type ;

  mkADeg : (good,better,best,well : Str) -> ADeg ;

-- The regular pattern recognizes two common variations: 
-- "-e" ("rude" - "ruder" - "rudest") and
-- "-y" ("happy - happier - happiest - happily")

  regADeg : Str -> ADeg ;      -- long, longer, longest

-- However, the duplication of the final consonant is nor predicted,
-- but a separate pattern is used:

  duplADeg : Str -> ADeg ;      -- fat, fatter, fattest

-- If comparison is formed by "more", "most", as in general for
-- long adjective, the following pattern is used:

  compoundADeg : A -> ADeg ; -- -/more/most ridiculous

-- From a given $ADeg$, it is possible to get back to $A$.

  adegA : ADeg -> A ;


  regPN    : Str -> PN ;          
  regGenPN : Str -> Gender -> PN ;     -- John, John's

-- Sometimes you can reuse a common noun as a proper name, e.g. "Bank".

  nounPN : N -> PN ;



} ;
