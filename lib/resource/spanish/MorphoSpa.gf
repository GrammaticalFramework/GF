--# -path=.:../romance:../../prelude

--1 A Simple Spanish Resource Morphology
--
-- Aarne Ranta 2002--2003
--
-- This resource morphology contains definitions needed in the resource
-- syntax. It moreover contains the most usual inflectional patterns.
-- The patterns for verbs contain the complete "Bescherelle" conjugation
-- tables.
--
-- We use the parameter types and word classes defined in $TypesSpa.gf$.

resource MorphoSpa = open (Predef=Predef), Prelude, TypesSpa in {

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

  adjSolo : Str -> Adj = \solo -> 
    let 
      sol = Predef.tk 1 solo
    in
    mkAdj solo (sol + "a") (sol + "i") (sol + "e") (sol + "amente") ;

  adjTale : Str -> Adj = \tale -> 
    let 
      tal  = Predef.tk 1 tale ;
      tali = tal + "i" ;
      tala = if_then_Str (pbool2bool (Predef.occur (Predef.dp 1 tal) "lr")) tal tale
    in
    mkAdj tale tale tali tali (tala + "mente") ;

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
--3 The Bescherell conjugations.
--
-- The following conjugations tables were generated using FM software
-- from a Haskell source.
--
-- The verb "essere" is often used in syntax.

--  verbEssere  = verbPres (essere_5 "essere") AEsse ;
--  verbAvere   = verbPres (avere_6 "avere")  AHabere ;

-- machine-generated GF code



-- for Numerals

param DForm = unit  | teen  | ten  | hundred  ;
param Modif = mod  | unmod  | conj  ;
}
