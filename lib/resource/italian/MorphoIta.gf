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

  mkNomReg : Str -> {s : Number => Str ; g : Gender} = \vino -> 
   let
     o = last vino ;
     vin = init vino ;
     n = last vin
   in
   case o of {
     "o" => {s = case n of {
       "c" | "g" => numForms vino (vin + "hi") ;
       "i"       => numForms vino vin ;
       _         => numForms vino (vin + "i")
       } ; g = Masc} ;
     "a" => {s = case n of {
       "c" | "g" => numForms vino (vin + "he") ;
       _         => numForms vino (vin + "e")
       } ; g = Fem} ;
     "e" => {s = numForms vino (vin + "i")
       ; g = Masc} ;
     "à" | "ù" => {s = numForms vino vino
       ; g = Fem} ;
     _ => {s = numForms vino vino
       ; g = Masc}
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


  mkAdjReg : Str -> Adj = \solo ->
   let
     o = last solo ;
     sol = init solo ;
     l = last sol ;
     solamente = (sol + "amente")
   in
   case o of {
     "o" => case l of {
       "c" | "g" => mkAdj solo (sol + "a") (sol + "hi") (sol + "he") solamente ;
       "i"       => mkAdj solo (sol + "a") sol (sol + "e") solamente ;
       _         => mkAdj solo (sol + "a") (sol + "i") (sol + "e") solamente
       } ;
     "e" => mkAdj solo solo (sol + "i") (sol + "i") (case l of {
       "l" => sol + "mente" ;
       _   => solo + "mente"
       }) ;
     _ => mkAdj solo solo solo solo (sol + "mente")
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
  pronJe = mkPronoun
    "io"   --- (variants {"io" ; []}) etc
    "mi"
    "mi"
    "me"
    "mio" "mia" "miei" "mie"
    PNoGen     -- gender cannot be known from pronoun alone
    Sg
    P1
    Clit1 ;

  pronTu = mkPronoun
    "tu"
    "ti"
    "ti"
    "te"
    "tuo" "tua" "tuoi" "tue"
    PNoGen
    Sg
    P2
    Clit1 ;

  pronIl = mkPronoun
    "lui"
    "lo"
    "gli"
    "lui"
    "suo" "sua" "suoi" "sue"
    (PGen Masc)
    Sg
    P3
    Clit2 ;

  pronElle = mkPronoun
    "lei"
    "la"
    "le"
    "lei"
    "suo" "sua" "suoi" "sue"
    (PGen Fem)
    Sg
    P3
    Clit2 ;

  pronNous = mkPronoun
    "noi"
    "ci"
    "ci"
    "noi"
    "nostro" "nostra" "nostri" "nostre"
    PNoGen
    Pl
    P1
    Clit3 ;

  pronVous = mkPronoun
    "voi"
    "vi"
    "vi"
    "voi"
    "vostro" "vostra" "vostri" "vostre"
    PNoGen
    Pl   --- depends!
    P2
    Clit3 ;

  pronIls = mkPronoun
    "loro"
    "loro"
    "li"   --- le !
    "loro"
    "loro" "loro" "loro" "loro"
    PNoGen
    Pl
    P3
    Clit1 ;

  personPron : Gender -> Number -> Person -> Pronoun = \g,n,p -> 
    case <n,p> of {
      <Sg,P1> => pronJe ;
      <Sg,P2> => pronTu ;
      <Sg,P3> => case g of {
        Masc => pronIl ;
        Fem  => pronElle 
        } ;
      <Pl,P1> => pronNous ;
      <Pl,P2> => pronVous ;
      <Pl,P3> => case g of {
        Masc => pronIls ;
        Fem  => pronIls 
        } 
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

  verbEssere  = verbPres (essere_5 "essere") AEsse ;
  verbAvere   = verbPres (avere_6 "avere")  AHabere ;

-- machine-generated GF code

oper essere_5 : Str -> Verbum = \essere -> 
  let x_ = Predef.tk 6 essere in
 {s = table {
    Inf => x_ + "essere" ;
    InfClit => x_ + "r" ;
    Indi Pres Sg P1 => x_ + "sono" ;
    Indi Pres Sg P2 => x_ + "sei" ;
    Indi Pres Sg P3 => x_ + "è" ;
    Indi Pres Pl P1 => x_ + "siamo" ;
    Indi Pres Pl P2 => x_ + "siete" ;
    Indi Pres Pl P3 => x_ + "sono" ;
    Indi Imperf Sg P1 => x_ + "ero" ;
    Indi Imperf Sg P2 => x_ + "eri" ;
    Indi Imperf Sg P3 => x_ + "era" ;
    Indi Imperf Pl P1 => x_ + "eravamo" ;
    Indi Imperf Pl P2 => x_ + "eravate" ;
    Indi Imperf Pl P3 => x_ + "erano" ;
    Pass Sg P1 => x_ + "fui" ;
    Pass Sg P2 => x_ + "fosti" ;
    Pass Sg P3 => x_ + "fu" ;
    Pass Pl P1 => x_ + "fummo" ;
    Pass Pl P2 => x_ + "foste" ;
    Pass Pl P3 => x_ + "furono" ;
    Fut Sg P1 => x_ + "sarò" ;
    Fut Sg P2 => x_ + "sarai" ;
    Fut Sg P3 => x_ + "sarà" ;
    Fut Pl P1 => x_ + "saremo" ;
    Fut Pl P2 => x_ + "sarete" ;
    Fut Pl P3 => x_ + "saranno" ;
    Cong Pres Sg P1 => x_ + "sia" ;
    Cong Pres Sg P2 => x_ + "sia" ;
    Cong Pres Sg P3 => x_ + "sia" ;
    Cong Pres Pl P1 => x_ + "siamo" ;
    Cong Pres Pl P2 => x_ + "siate" ;
    Cong Pres Pl P3 => x_ + "siano" ;
    Cong Imperf Sg P1 => x_ + "fossi" ;
    Cong Imperf Sg P2 => x_ + "fossi" ;
    Cong Imperf Sg P3 => x_ + "fosse" ;
    Cong Imperf Pl P1 => x_ + "fossimo" ;
    Cong Imperf Pl P2 => x_ + "foste" ;
    Cong Imperf Pl P3 => x_ + "fossero" ;
    Cond Sg P1 => x_ + "sarei" ;
    Cond Sg P2 => x_ + "saresti" ;
    Cond Sg P3 => x_ + "sarebbe" ;
    Cond Pl P1 => x_ + "saremmo" ;
    Cond Pl P2 => x_ + "sareste" ;
    Cond Pl P3 => x_ + "sarebbero" ;
    Imper SgP2 => x_ + "sii" ;
    --Imper IPs3 => x_ + "sia" ;
    Imper PlP1 => x_ + "siamo" ;
    Imper PlP2 => x_ + "siate" ;
    --Imper IPp3 => x_ + "siano" ;
    Ger => x_ + "essendo" ;
    Part PresP Masc Sg => variants {} ;
    Part PresP Masc Pl => variants {} ;
    Part PresP Fem Sg => variants {} ;
    Part PresP Fem Pl => variants {} ;
    Part PassP Masc Sg => x_ + "stato" ;
    Part PassP Masc Pl => x_ + "stati" ;
    Part PassP Fem Sg => x_ + "stata" ;
    Part PassP Fem Pl => x_ + "state"
    }
  } ;

oper avere_6 : Str -> Verbum = \avere -> 
  let x_ = Predef.tk 5 avere in
 {s = table {
    Inf => x_ + "avere" ;
    InfClit => x_ + "aver" ;
    Indi Pres Sg P1 => x_ + "ho" ;
    Indi Pres Sg P2 => x_ + "hai" ;
    Indi Pres Sg P3 => x_ + "ha" ;
    Indi Pres Pl P1 => x_ + "abbiamo" ;
    Indi Pres Pl P2 => x_ + "avete" ;
    Indi Pres Pl P3 => x_ + "hanno" ;
    Indi Imperf Sg P1 => x_ + "avevo" ;
    Indi Imperf Sg P2 => x_ + "avevi" ;
    Indi Imperf Sg P3 => x_ + "aveva" ;
    Indi Imperf Pl P1 => x_ + "avevamo" ;
    Indi Imperf Pl P2 => x_ + "avevate" ;
    Indi Imperf Pl P3 => x_ + "avevano" ;
    Pass Sg P1 => x_ + "ebbi" ;
    Pass Sg P2 => x_ + "avesti" ;
    Pass Sg P3 => x_ + "ebbe" ;
    Pass Pl P1 => x_ + "avemmo" ;
    Pass Pl P2 => x_ + "aveste" ;
    Pass Pl P3 => x_ + "ebbero" ;
    Fut Sg P1 => x_ + "avrò" ;
    Fut Sg P2 => x_ + "avrai" ;
    Fut Sg P3 => x_ + "avrà" ;
    Fut Pl P1 => x_ + "avremo" ;
    Fut Pl P2 => x_ + "avrete" ;
    Fut Pl P3 => x_ + "avranno" ;
    Cong Pres Sg P1 => x_ + "abbia" ;
    Cong Pres Sg P2 => x_ + "abbia" ;
    Cong Pres Sg P3 => x_ + "abbia" ;
    Cong Pres Pl P1 => x_ + "abbiamo" ;
    Cong Pres Pl P2 => x_ + "abbiate" ;
    Cong Pres Pl P3 => x_ + "abbiano" ;
    Cong Imperf Sg P1 => x_ + "avessi" ;
    Cong Imperf Sg P2 => x_ + "avessi" ;
    Cong Imperf Sg P3 => x_ + "avesse" ;
    Cong Imperf Pl P1 => x_ + "avessimo" ;
    Cong Imperf Pl P2 => x_ + "aveste" ;
    Cong Imperf Pl P3 => x_ + "avessero" ;
    Cond Sg P1 => x_ + "avrei" ;
    Cond Sg P2 => x_ + "avresti" ;
    Cond Sg P3 => x_ + "avrebbe" ;
    Cond Pl P1 => x_ + "avremmo" ;
    Cond Pl P2 => x_ + "avreste" ;
    Cond Pl P3 => x_ + "avrebbero" ;
    Imper SgP2 => x_ + "abbi" ;
    --Imper IPs3 => x_ + "abbia" ;
    Imper PlP1 => x_ + "abbiamo" ;
    Imper PlP2 => x_ + "abbiate" ;
    --Imper IPp3 => x_ + "abbiano" ;
    Ger => x_ + "avendo" ;
    Part PresP Masc Sg => x_ + "avente" ;
    Part PresP Masc Pl => x_ + "aventi" ;
    Part PresP Fem Sg => x_ + "avente" ;
    Part PresP Fem Pl => x_ + "aventi" ;
    Part PassP Masc Sg => x_ + "avuto" ;
    Part PassP Masc Pl => x_ + "avuti" ;
    Part PassP Fem Sg => x_ + "avuta" ;
    Part PassP Fem Pl => x_ + "avute"
    }
  } ;


-- for Numerals

param DForm = ental Pred | ton | tiotal  ;
param Pred = pred | indip ;

oper mkTal : Str -> Str -> Str -> {s : DForm => Str} = 
  \två -> \tolv -> \tjugo -> 
  {s = table {ental _ => två ; ton => tolv ; tiotal => tjugo}} ;
oper spl : Str -> {s : Gender => Str ; n : Number} = \s -> {s = \\_ =>
  s ; n = Pl} ;
oper mille : Number => Str = table {Sg => "mille" ; Pl => "mila"} ;
}
