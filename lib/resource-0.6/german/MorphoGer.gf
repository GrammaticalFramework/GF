--1 A Simple German Resource Morphology
--
-- Aarne Ranta 2002
--
-- This resource morphology contains definitions needed in the resource
-- syntax. It moreover contains the most usual inflectional patterns.
--
-- We use the parameter types and word classes defined in $types.Deu.gf$.

resource MorphoGer = TypesGer ** open (Predef=Predef), Prelude in {

--2 Nouns
--
-- For conciseness and abstraction, we define a method for
-- generating a case-dependent table from a list of four forms.

oper
  caselist : (_,_,_,_ : Str) -> Case => Str = \n,a,d,g -> table {
    Nom => n ; Acc => a ; Dat => d ; Gen => g} ;

-- The *worst-case macro* for common nouns needs six forms: all plural forms
-- are always the same except for the dative.

  mkNoun  : (_,_,_,_,_,_ : Str) -> Gender -> CommNoun = 
    \mann, mannen, manne, mannes, männer, männern, g -> {s = table {
       Sg => caselist mann mannen manne mannes ;
       Pl => caselist männer männer männern männer
       } ; g = g} ;

-- But we never need all the six forms at the same time. Often
-- we need just two, three, or four forms.

  mkNoun4 : (_,_,_,_ : Str) -> Gender -> CommNoun = \kuh,kuhes,kühe,kühen ->
      mkNoun kuh kuh kuh kuhes kühe kühen ;

  mkNoun3 : (_,_,_ : Str) -> Gender -> CommNoun = \kuh,kühe,kühen ->
      mkNoun kuh kuh kuh kuh kühe kühen ;

  mkNoun2n : (_,_ : Str) -> Gender -> CommNoun = \zahl, zahlen -> 
      mkNoun3 zahl zahlen zahlen ;

  mkNoun2es : (_,_ : Str) -> Gender -> CommNoun = \wort, wörter -> 
      mkNoun wort wort wort (wort + "es") wörter (wörter + "n") ;

  mkNoun2s : (_,_ : Str) -> Gender -> CommNoun = \vater, väter -> 
      mkNoun vater vater vater (vater + "s") väter (väter + "n") ;

  mkNoun2ses : (_,_ : Str) -> Gender -> CommNoun = \wort,wörter -> 
      mkNoun wort wort wort (wort + variants {"es" ; "s"}) wörter (wörter + "n") ;

-- Here are the school grammar declensions with their commonest variations.
-- Unfortunately we cannot define *Umlaut* in GF, but have to give two forms.
--
-- First declension, with plural "en"/"n", including weak masculins:

  declN1  : Str -> CommNoun = \zahl  -> 
    mkNoun2n zahl  (zahl + "en") Fem ;

  declN1e : Str -> CommNoun = \stufe -> 
    mkNoun2n stufe (stufe + "n") Fem ;  

  declN1M : Str -> CommNoun = \junge -> let {jungen = junge + "n"} in
    mkNoun junge jungen jungen jungen jungen jungen Masc ;

  declN1eM : Str -> CommNoun = \soldat -> let {soldaten = soldat + "en"} in
    mkNoun soldat soldaten soldaten soldaten soldaten soldaten Masc ;

-- Second declension, with plural "e":

  declN2  : Str -> CommNoun = \punkt -> 
    mkNoun2es punkt (punkt+"e") Masc ;

  declN2i  : Str -> CommNoun = \onkel -> 
    mkNoun2s onkel onkel Masc ;

  declN2u : (_,_ : Str) -> CommNoun = \raum,räume -> 
    mkNoun2es raum räume Masc ;

  declN2uF : (_,_ : Str) -> CommNoun = \kuh,kühe -> 
    mkNoun3 kuh kühe (kühe + "n") Fem ;

-- Third declension, with plural "er":

  declN3  : Str -> CommNoun = \punkt -> 
    mkNoun2es punkt (punkt+"er") Neut ;

  declN3u : (_,_ : Str) -> CommNoun = \buch,bücher -> 
    mkNoun2ses buch bücher Neut ;

  declN3uS : (_,_ : Str) -> CommNoun = \haus,häuser -> 
    mkNoun2es haus häuser Neut ;

-- Plural with "s":

  declNs : Str -> CommNoun = \restaurant -> 
    mkNoun3 restaurant (restaurant+"s") (restaurant+"s") Neut ;


--2 Pronouns
--
-- Here we define personal and relative pronouns.
-- All personal pronouns, except "ihr", conform to the simple
-- pattern $mkPronPers$.

  ProPN = {s : NPForm => Str ; n : Number ; p : Person} ;

  mkPronPers : (_,_,_,_,_ : Str) -> Number -> Person -> ProPN = 
    \ich,mich,mir,meines,mein,n,p -> {
      s = table {
        NPCase c    => caselist ich mich mir meines ! c ;
        NPPoss gn c => mein + pronEnding ! gn ! c
        } ;
      n = n ;
      p = p
      } ;

  pronEnding : GenNum => Case => Str = table {
    GSg Masc => caselist ""  "en" "em" "es" ;
    GSg Fem  => caselist "e" "e"  "er" "er" ;
    GSg Neut => caselist ""  ""   "em" "es" ;
    GPl      => caselist "e"  "e" "en" "er"
    } ;

  pronIch  = mkPronPers "ich" "mich" "mir"   "meines" "mein"  Sg P1 ;
  pronDu   = mkPronPers "du"  "dich" "dir"   "deines" "dein"  Sg P2 ;
  pronEr   = mkPronPers "er"  "ihn"  "ihm"   "seines" "sein"  Sg P3 ;
  pronSie  = mkPronPers "sie" "sie"  "ihr"   "ihres"  "ihr"   Sg P3 ;
  pronEs   = mkPronPers "es"  "es"   "ihm"   "seines" "sein"  Sg P3 ;
  pronWir  = mkPronPers "wir" "uns"  "uns"   "unser"  "unser" Pl P1 ;

  pronSiePl = mkPronPers "sie" "sie"  "ihnen" "ihrer"  "ihr"   Pl P3 ;
  pronSSie  = mkPronPers "Sie" "Sie"  "Ihnen" "Ihrer"  "Ihr"   Pl P3 ; ---

-- We still have wrong agreement with the complement of the polite "Sie":
-- it is in plural, like the verb, although it should be in singular.

-- The peculiarity with "ihr" is the presence of "e" in forms without an ending.

  pronIhr  = 
     {s = table {
        NPPoss (GSg Masc) Nom => "euer" ;
        NPPoss (GSg Neut) Nom => "euer" ;
        NPPoss (GSg Neut) Acc => "euer" ;
        pf => (mkPronPers "ihr" "euch" "euch"  "euer"  "eur"  Pl P2).s ! pf
        } ;
      n = Pl ;
      p = P2
      } ;

-- Relative pronouns are like the definite article, except in the genitive and
-- the plural dative. The function $artDef$ will be defined right below.

  RelPron : Type = {s : GenNum => Case => Str} ;

  relPron : RelPron = {s = \\gn,c => 
    case <gn,c> of {
      <GSg Fem,Gen> => "deren" ;
      <GSg g,Gen>   => "dessen" ;
      <GPl,Dat>     => "denen" ;
      <GPl,Gen>     => "deren" ;
      _ => artDef ! gn ! c
    } 
  } ;


--2 Articles
--
-- Here are all forms the indefinite and definite article.
-- The indefinite article is like a large class of pronouns.
-- The definite article is more peculiar; we don't try to
-- subsume it to any general rule.

  artIndef : Gender => Case => Str = \\g,c => "ein" + pronEnding ! GSg g ! c ;

  artDef : GenNum => Case => Str = table {
    GSg Masc => caselist "der" "den" "dem" "des" ;
    GSg Fem  => caselist "die" "die" "der" "der" ;
    GSg Neut => caselist "das" "das" "dem" "des" ;
    GPl      => caselist "die" "die" "den" "der"
    } ;


--2 Adjectives
--
-- As explained in $types.Deu.gf$, it
-- would be superfluous to use the cross product of gender and number,
-- since there is no gender distinction in the plural. But it is handy to have
-- a function that constructs gender-number complexes.
  
  gNumber : Gender -> Number -> GenNum = \g,n -> 
    case n of {
      Sg => GSg g ;
      Pl => GPl
      } ;

-- It's also handy to have a function that finds out the number from such a complex.

  numGenNum : GenNum -> Number = \gn -> 
    case gn of {
      GSg _ => Sg ;
      GPl => Pl
      } ;

-- This function costructs parameters in the complex type of adjective forms.

  aMod : Adjf -> Gender -> Number -> Case -> AForm = \a,g,n,c -> 
    AMod a (gNumber g n) c ;

-- The worst-case macro for adjectives (positive degree) only needs
-- two forms.
  
  mkAdjective : (_,_ : Str) -> Adjective = \böse,bös -> {s = table {
    APred => böse ;
    AMod Strong (GSg Masc) c => 
      caselist (bös+"er") (bös+"en") (bös+"em") (bös+"es") ! c ;
    AMod Strong (GSg Fem) c => 
      caselist (bös+"e") (bös+"e") (bös+"er") (bös+"er") ! c ;
    AMod Strong (GSg Neut) c => 
      caselist (bös+"es") (bös+"es") (bös+"em") (bös+"es") ! c ;
    AMod Strong GPl c => 
      caselist (bös+"e") (bös+"e") (bös+"en") (bös+"er") ! c ;
    AMod Weak (GSg g) c => case <g,c> of {
      <_,Nom>    => bös+"e" ;
      <Masc,Acc> => bös+"en" ;
      <_,Acc>    => bös+"e" ;
      _          => bös+"en" } ;
    AMod Weak GPl c => bös+"en"
    }} ;

-- Here are some classes of adjectives:
 
  adjReg   : Str -> Adjective = \gut -> mkAdjective gut gut ;
  adjE     : Str -> Adjective = \bös -> mkAdjective (bös+"e") bös ;
  adjEr    : Str -> Adjective = \teu -> mkAdjective (teu+"er") (teu+"r") ;
  adjInvar : Str -> Adjective = \prima -> {s = table {_ => prima}} ;

-- The first three classes can be recognized from the end of the word, depending
-- on if it is "e", "er", or something else.

  adjGen : Str -> Adjective = \gut -> let {
    er  = Predef.dp 2 gut ;
    teu = Predef.tk 2 gut ;
    e   = Predef.dp 1 gut ;
    bös = Predef.tk 1 gut
  } in
  ifTok Adjective er "er" (adjEr  teu) (
  ifTok Adjective e  "e"  (adjE   bös) (
                          (adjReg gut))) ;


-- The comparison of adjectives needs three adjectives in the worst case.

  mkAdjComp : (_,_,_ : Adjective) -> AdjComp = \gut,besser,best -> 
    {s = table {Pos => gut.s ; Comp => besser.s ; Sup => best.s}} ;

-- It can be done by just three strings, if each of the comparison
-- forms taken separately is a regular adjective.

  adjCompReg3 : (_,_,_ : Str) -> AdjComp = \gut,besser,best ->
    mkAdjComp (adjReg gut) (adjReg besser) (adjReg best) ;

-- If also the comparison forms are regular, one string is enough.

  adjCompReg : Str -> AdjComp = \billig ->
    adjCompReg3 billig (billig+"er") (billig+"st") ;


--2 Verbs
--
-- We limit ourselves to verbs in present tense infinitive, indicative, 
-- and imperative, and past participle. Other forms will be introduced later.
--
-- The worst-case macro needs three forms: the infinitive, the third person
-- singular indicative, and the second person singular imperative. 
-- We take care of the special cases "ten", "sen", "ln", "rn".
--
-- A famous law about Germanic languages says that plural first and third person
-- are similar.

  mkVerbum : (_,_,_,_ : Str) -> Verbum = \geben, gib, gb, gegeben -> 
    let {
       en = Predef.dp 2 geben ;
       geb = ifTok Tok (Predef.tk 1 en) "e" (Predef.tk 2 geben)(Predef.tk 1 geben) ;
       gebt = ifTok Tok (Predef.dp 1 geb) "t" (geb + "et") (geb + "t") ;
       gibst = ifTok Tok (Predef.dp 1 gib) "s" (gib + "t") (gib + "st") ;
       gegebener = (adjReg gegeben).s
    } in table {
           VInf       => geben ;
           VInd Sg P1 => geb + "e" ;
           VInd Sg P2 => gibst ;
           VInd Sg P3 => gib + "t" ;
           VInd Pl P2 => gebt ;
           VInd Pl _  => geben ; -- the famous law
           VImp Sg    => gb ;
           VImp Pl    => gebt ;
           VPart a    => gegebener ! a
           } ;

-- Regular verbs:

  regVerb : Str -> Verbum = \legen ->
    let {lege = ifTok Tok (Predef.dp 3 legen) "ten" (Predef.tk 1 legen) (
                ifTok Tok (Predef.dp 2 legen) "en"  (Predef.tk 2 legen) (
                                                     Predef.tk 1 legen))} in
    mkVerbum legen lege lege ("ge" + (lege + "t")) ;

-- Verbs ending with "t"; now recognized in $mkVerbum$.

  verbWarten : Str -> Verbum = regVerb ;

-- Verbs with Umlaut in the second and third person singular and imperative:

  verbSehen : Str -> Str -> Str -> Verbum = \sehen, sieht, gesehen -> 
    let {sieh = Predef.tk 1 sieht} in mkVerbum sehen sieh sieh gesehen ;

-- Verbs with Umlaut in the second and third person singular but not imperative:

  verbLaufen : Str -> Str -> Str -> Verbum = \laufen, läuft, gelaufen -> 
    let {läuf = Predef.tk 1 läuft ; laufe = Predef.tk 1 laufen} 
    in mkVerbum laufen läuf laufe gelaufen ;

-- The verb "be":

  verbumSein : Verbum = let {
    gewesen = (adjReg "gewesen").s
  } in
  table {
    VInf       => "sein" ;
    VInd Sg P1 => "bin" ;
    VInd Sg P2 => "bist" ;
    VInd Sg P3 => "ist" ;
    VInd Pl P2 => "seid" ;
    VInd Pl _  => "sind" ;
    VImp Sg    => "sei" ;
    VImp Pl    => "seiet" ;
    VPart a    => gewesen ! a
    } ;

-- The verb "have":

  verbumHaben :  Verbum = let {
    haben = (regVerb "haben")
    } in 
    table {
      VInd Sg P2 => "hast" ;
      VInd Sg P3 => "hat" ;
      v          => haben ! v
      } ;

-- The verb "become", used as the passive auxiliary:

  verbumWerden :  Verbum = let {
    werden = regVerb "werden" ;
    geworden = (adjReg "geworden").s
    } in 
    table {
      VInd Sg P2 => "wirst" ;
      VInd Sg P3 => "wird" ;
      VPart a    => geworden ! a ;
      v          => werden ! v
      } ;

-- A *full verb* ($Verb$) consists of the inflection forms ($Verbum$) and
-- a *particle* (e.g. "aus-sehen"). Simple verbs are the ones that have no 
-- such particle.

  mkVerb : Verbum -> Particle -> Verb = \v,p -> {s = v ; s2 = p} ;

  mkVerbSimple : Verbum -> Verb = \v -> mkVerb v [] ;

  verbSein = mkVerbSimple verbumSein ;
  verbHaben = mkVerbSimple verbumHaben ;
  verbWerden = mkVerbSimple verbumWerden ;
  verbGeben = mkVerbSimple (verbSehen "geben" "gibt" "gegeben") ;

{-
  -- tests for optimizer
  verbumSein2 : Verbum = 
  table {
    VInf       => "sein" ;
    VInd Sg P1 => "bin" ;
    VInd Sg P2 => "bist" ;
    VInd Sg P3 => "ist" ;
    VInd Pl P2 => "seid" ;
    VInd Pl _  => "sind" ;
    VImp Sg    => "sei" ;
    VImp Pl    => "seiet" ;
    VPart a    => (adjReg "gewesen").s ! a
    } ;

  verbumHaben2 :  Verbum = 
    table {
      VInd Sg P2 => "hast" ;
      VInd Sg P3 => "hat" ;
      v          => regVerb "haben" ! v
      } ;
-}

} ;
