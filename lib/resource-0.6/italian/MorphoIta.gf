--# -path=.:../romance:../../prelude

--1 A Simple Italian Resource Morphology
--
-- Aarne Ranta 2002--2003
--
-- This resource morphology contains definitions needed in the resource
-- syntax. It moreover contains the most usual inflectional patterns.
-- The patterns for verbs contain the complete "Bescherelle" conjugation
-- tables.
--
-- We use the parameter types and word classes defined in $TypesIta.gf$.

resource MorphoIta = open (Predef=Predef), Prelude, TypesIta in {

--2 Some phonology
--
--3 Elision
--
-- The phonological rule of *elision* can be defined as follows in GF.
-- In Italian it includes both vowels and the *impure 's'*.

oper 
  vocale : Strs = strs {
    "a" ; "e" ; "h" ; "i" ; "o" ; "u"
    } ;

  sImpuro : Strs = strs {
    "z" ; "sb" ; "sc" ; "sd" ; "sf" ; "sm" ; "sp" ; "sq" ; "sr" ; "st" ; "sv"
    } ;

  elision : (_,_,_ : Str) -> Str = \il, l', lo -> 
    pre {il ; l' / vocale ; lo / sImpuro} ;

  elisQue = "che" ; --- no elision in Italian
  elisDe = "de" ;

--2 Nouns
--
-- The following macro is useful for creating the forms of number-dependent
-- tables, such as common nouns.

  numForms : (_,_ : Str) -> Number => Str = \vino, vini ->
    table {Sg => vino ; Pl => vini} ; 

-- For example:

  nomVino : Str -> Number => Str = \vino -> let {vin = Predef.tk 1 vino} in
    numForms vino (vin + "i") ;

  nomRana : Str -> Number => Str = \rana -> let {ran = Predef.tk 1 rana} in
    numForms rana (ran + "e") ;

  nomSale : Str -> Number => Str = \sale -> let {sal = Predef.tk 1 sale} in
    numForms sale (sal + "i") ;

  nomTram : Str -> Number => Str = \tram ->
    numForms tram tram ;

-- Common nouns are inflected in number and have an inherent gender.

  mkCNom : (Number => Str) -> Gender -> CNom = \mecmecs,gen -> 
    {s = mecmecs ; g = gen} ;

  mkCNomIrreg : Str -> Str -> Gender -> CNom = \mec,mecs -> 
    mkCNom (numForms mec mecs) ;



--2 Adjectives
--
-- Adjectives are conveniently seen as gender-dependent nouns.
-- Here are some patterns. First one that describes the worst case.

  mkAdj : (_,_,_,_,_ : Str) -> Adj = \solo,sola,soli,sole,solamente ->
    {s = table {
       AF Masc n => numForms solo soli ! n ;
       AF Fem  n => numForms sola sole ! n ;
       AA        => solamente
       }
    } ;

-- Then the regular and invariant patterns.

  adjSolo : Str -> Adj = \solo -> let {sol = Predef.tk 1 solo} in
    mkAdj solo (sol + "a") (sol + "i") (sol + "e") (sol + "amente") ;

  adjTale : Str -> Adj = \tale -> let {tali = Predef.tk 1 tale + "i"} in
    mkAdj tale tale tali tali (Predef.tk 1 tale + "mente") ;

  adjBlu : Str -> Adj = \blu -> 
    mkAdj blu blu blu blu blu ; --- 


--2 Personal pronouns
--
-- All the eight personal pronouns can be built by the following macro.
-- The use of "ne" as atonic genitive is debatable.
-- We follow the rule that the atonic nominative is empty.

  mkPronoun : (_,_,_,_,_,_,_,_ : Str) -> 
              PronGen -> Number -> Person -> ClitType -> Pronoun =
    \il,le,lui,Lui,son,sa,ses,see,g,n,p,c ->
    {s = table {
       Ton Nom => il ;
       Ton x => prepCase x ++ Lui ;
       Aton Nom => il ; ---- [] ;
       Aton Acc => le ;
       Aton (CPrep P_di) => "ne" ; --- hmm
       Aton (CPrep P_a) => lui ;
       Aton (CPrep q) => strPrep q ++ Lui ; ---- GF bug with c or p! 
       Poss Sg Masc => son ;
       Poss Sg Fem  => sa ;
       Poss Pl Masc => ses ;
       Poss Pl Fem  => see
       } ;
     g = g ;
     n = n ;
     p = p ;
     c = c
    } ;


--2 Reflexive pronouns
--
-- It is simply a function depending on number and person.

  pronRefl : Number -> Person -> Str = \n,p -> case <n,p> of {
    <Sg,P1> => "mi" ;
    <Sg,P2> => "ti" ;
    <_, P3> => "si" ;
    <Pl,P1> => "ci" ;
    <Pl,P2> => "vi"
    } ;


--2 Determiners
--
-- Determiners, traditionally called indefinite pronouns, are inflected
-- in gender and number, like adjectives.

  pronForms : Adj -> Gender -> Number -> Str = \tale,g,n -> tale.s ! AF g n ;

  qualPron : Gender -> Number -> Str = pronForms (adjTale "quale") ;

  talPron : Gender -> Number -> Str = pronForms (adjTale "tale") ;

  tuttoPron : Gender -> Number -> Str = pronForms (adjSolo "tutto") ;

--2 Articles
--
-- The definite article has quite some variation: three parameters and
-- elision. This is the simples definition we have been able to find.

  artDefTable : Gender => Number => Case => Str = \\g,n,c => case <g,n,c> of {
    <_, _, CPrep P_di>  => prepArt g n "de" ;
    <_, _, CPrep P_da>  => prepArt g n "da" ;
    <_, _, CPrep P_a>   => prepArt g n "a" ;
    <_, _, CPrep P_in>  => prepArt g n "ne" ;
    <_, _, CPrep P_su>  => prepArt g n "su" ;
    <_, _, CPrep P_con> => prepArt g n "co" ;
    <Masc,Sg, Nom> => elision "il" "l'" "lo" ;
    <Masc,Sg, _> => elision "il" "l'" "lo" ;

    <Fem ,Sg, _> => elision "la" "l'" "la" ;
    <Masc,Pl, _> => elision "i" "gli" "gli" ;
    <Fem ,Pl, _> => "le"
    } ;

-- This auxiliary expresses the uniform rule.

  prepArt : Gender -> Number -> Tok -> Tok = \g,n,de -> case <g,n> of {
    <Masc,Sg> => elision (de + "l") (de + "ll'") (de + "llo") ;
    <Masc,Pl> => elision (de + "i") (de + "gli") (de + "gli") ;
    <Fem, Sg> => elision (de + "lla") (de + "ll'") (de + "lla") ;
    <Fem, Pl> => de + "lle"
    } ;

--2 Verbs
--
--3 The present tense
--
-- We first define some macros for the special case of present tense.
--
-- The verb "essere" is often used in syntax.

  verbEssere  = verbPres essere ;

-- We very often form the verb stem by dropping out the infinitive ending.

  troncVerb : Tok -> Tok = Predef.tk 3 ;

oper mkVerbPres : (_,_,_,_,_,_,_,_,_ : Str) -> VerbPres =
  \veng, viene, ven, venite, vengono, venga, vieni, venire, venuto -> 
  let 
    vien = Predef.tk 1 vieni ;
    venut = (adjSolo (Predef.tk 1 venuto)).s
  in
  {s = table {
     VFin Ind Sg P1 => veng + "o" ;
     VFin Ind Sg P2 => vien + "i" ;
     VFin Ind Sg P3 => viene ;
     VFin Ind Pl P1 => ven + "iamo" ;
     VFin Ind Pl P2 => venite ;
     VFin Ind Pl P3 => vengono ;
     VFin Con Sg _ => venga ;
     VFin Con Pl P1 => ven + "iamo" ;
     VFin Con Pl P2 => ven + "iate" ;
     VFin Con Pl P3 => venga + "no" ;
     VImper SgP2 => vieni ;
     VImper PlP1 => ven + "iamo" ;
     VImper PlP2 => venite ;
     VInfin => venire ;
     VPart g n => venut ! AF g n
     }
  } ;

-- The four main conjugations.

  verbAmare : Str -> VerbPres = \amare ->
    let {am = troncVerb amare ; ama = am + "a"} in
    mkVerbPres 
      am ama am (ama + "te") (ama + "no") 
      (am+"i") ama amare (ama + "to") ;

  verbDormire : Str -> VerbPres = \dormire ->
    let {dorm = troncVerb dormire} in
    mkVerbPres 
      dorm (dorm + "e") dorm (dorm + "ite") (dorm + "ino") (dorm+"a") 
      (dorm + "i") dormire (dorm + "ito") ;

  verbFinire : Str -> VerbPres = \finire ->
    let {fin = troncVerb finire ; fini = fin + "i" ; finisc = fini + "sc"} in
    mkVerbPres 
        finisc (finisc + "e") fin (fini + "te") (finisc + "ono") 
        (finisc + "a") (finisc + "i") finire (fini + "to") ;

  verbCorrere : Str -> Str -> VerbPres = \correre,corso ->
    let {corr = troncVerb correre ; corre = corr + "e"} in
    mkVerbPres corr corre corr (corre + "te") (corr + "ono") (corr+"a") (corr+"i") 
               correre corso ;

-- Some irregular verbs.

  verbPresSpegnere : VerbPres = 
    mkVerbPres "speng" "spegne" "spegn" "spegnete" "spengono" 
               "spenga" "spegni" "spegnere" "spento" ;

  verbPresDire : VerbPres = 
    mkVerbPres "dic" "dice" "dic" "dite" "dicono" 
               "dica" "di" "dire" "detto" ;


essere = {s = table {
  Inf => "essere" ;
  Indi Pres Sg P1 => "sono" ;
  Indi Pres Sg P2 => "sei" ;
  Indi Pres Sg P3 => "è" ;
  Indi Pres Pl P1 => "siamo" ;
  Indi Pres Pl P2 => "siete" ;
  Indi Pres Pl P3 => "sono" ;
  Cong Pres Sg P1 => "sia" ;
  Cong Pres Sg P2 => "sia" ;
  Cong Pres Sg P3 => "sia" ;
  Cong Pres Pl P1 => "siamo" ;
  Cong Pres Pl P2 => "siate" ;
  Cong Pres Pl P3 => "siano" ;
  Imper SgP2 => "sii" ;
  Imper PlP1 => "siamo" ;
  Imper PlP2 => "siate" ;
  _ => "essere" --- we just don't care
  }} ;


  avere = {s = table {
  Inf => "avere" ;
  Indi Pres Sg P1 => "ho" ;
  Indi Pres Sg P2 => "hai" ;
  Indi Pres Sg P3 => "ha" ;
  Indi Pres Pl P1 => "abbiamo" ;
  Indi Pres Pl P2 => "avete" ;
  Indi Pres Pl P3 => "hanno" ;
  Cong Pres Sg P1 => "abbia" ;
  Cong Pres Sg P2 => "abbia" ;
  Cong Pres Sg P3 => "abbia" ;
  Cong Pres Pl P1 => "abbiamo" ;
  Cong Pres Pl P2 => "abbiate" ;
  Cong Pres Pl P3 => "abbiano" ;
  Imper SgP2 => "abbi" ;
  Imper PlP1 => "abbiamo" ;
  Imper PlP2 => "abbiate" ;
  _ => "avere" --- we just don't care
  }} ;

}
