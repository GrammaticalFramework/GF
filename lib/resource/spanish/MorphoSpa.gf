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

resource MorphoSpa = open (Predef=Predef), Prelude, TypesSpa, BeschSpa in {

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

  elisQue = "que" ; --- no elision in Italian
  elisDe = "de" ;

--2 Nouns
--
-- The following macro is useful for creating the forms of number-dependent
-- tables, such as common nouns.

  numForms : (_,_ : Str) -> Number => Str = \vino, vini ->
    table {Sg => vino ; Pl => vini} ; 

-- For example:

  nomVino : Str -> Number => Str = \vino -> 
    numForms vino (vino + "s") ;

  nomPilar : Str -> Number => Str = \pilar -> 
    numForms pilar (pilar + "es") ;

  nomTram : Str -> Number => Str = \tram ->
    numForms tram tram ;

-- Common nouns are inflected in number and have an inherent gender.

  mkCNom : (Number => Str) -> Gender -> CNom = \mecmecs,gen -> 
    {s = mecmecs ; g = gen} ;

  mkCNomIrreg : Str -> Str -> Gender -> CNom = \mec,mecs -> 
    mkCNom (numForms mec mecs) ;

  mkNomReg : Str -> CNom = \mec ->
    case last mec of {
      "o" | "e" => mkCNom (nomVino mec) Masc ; 
      "a" => mkCNom (nomVino mec) Fem ;
      "z" => mkCNomIrreg mec (init mec + "ces") Fem ;
      _   => mkCNom (nomPilar mec) Masc
      } ;

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
    mkAdj solo (sol + "a") (sol + "os") (sol + "as") (sol + "amente") ;

  adjUtil : Str -> Str -> Adj = \util,utiles -> 
    mkAdj util util utiles utiles (util + "mente") ;

  adjBlu : Str -> Adj = \blu -> 
    mkAdj blu blu blu blu blu ; --- 

  mkAdjReg : Str -> Adj = \solo -> 
    case last solo of {
      "o" => adjSolo solo ;
      "e" => adjUtil solo (solo + "s") ;
      _   => adjUtil solo (solo + "es")
----      _   => adjBlu solo
      } ;

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
----       Aton (CPrep P_de) => "ne" ; --- hmm
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
    <Sg,P1> => "me" ;
    <Sg,P2> => "te" ;
    <_, P3> => "se" ;
    <Pl,P1> => "nos" ;
    <Pl,P2> => "vos"
    } ;


--2 Determiners
--
-- Determiners, traditionally called indefinite pronouns, are inflected
-- in gender and number, like adjectives.

  pronForms : Adj -> Gender -> Number -> Str = \tale,g,n -> tale.s ! AF g n ;

  qualPron : Gender -> Number -> Str = pronForms (adjUtil "cuál" "cuales") ;

  talPron : Gender -> Number -> Str = pronForms (adjUtil "tál" "tales") ;

  tuttoPron : Gender -> Number -> Str = pronForms (adjSolo "todo") ;

--2 Articles
--
-- The definite article has quite some variation: three parameters and
-- elision. This is the simples definition we have been able to find.

  artDefTable : Gender => Number => Case => Str = \\g,n,c => case <g,n,c> of {
    <Masc,Sg, CPrep P_de> => "del" ;
    <Masc,Sg, CPrep P_a>  => "al" ;
    <Masc,Sg, _>          => prepCase c ++ "el" ;

    <Fem ,Sg, _> => prepCase c ++ "la" ;
    <Masc,Pl, _> => prepCase c ++ "los" ;
    <Fem ,Pl, _> => prepCase c ++ "las"
    } ;

--2 Verbs
--
--3 The Bescherelle conjugations.
--
-- The following conjugations tables were generated using FM software
-- from a Haskell source.
--
-- The verb "essere" is often used in syntax.

  verbSer   = verbPres (ser_7 "ser") AHabere ;
  verbHaber = verbPres (haber_10 "haber")  AHabere ;

-- for bw compatibility

ser_7 : Str -> Verbum = ser_1 ;
haber_10 : Str -> Verbum = haber_3 ;

-- for Numerals

param DForm = unit  | teen  | ten  | hundred  ;
param Modif = mod  | unmod  | conj  ;

oper spl : Str -> {s : Gender => Str ; n : Number} = \s -> {s = \\_ =>
  s ; n = Pl} ;

  uno  : Gender => Str = table {Masc => "uno" ; Fem => "una"} ;
  yuno : Gender => Str = \\g => "y" ++ uno ! g ;

}
