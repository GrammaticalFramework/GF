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
    <_, _, CPrep P_de>  => prepArt g n "de" ;
    <_, _, CPrep P_a>   => prepArt g n "a" ;
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

oper zurrar_3 : Str -> Verbum = \zurrar -> 
  let zurr_ = Predef.tk 2 zurrar in
 {s = table {
    VI Infn=> zurr_ + "ar" ;
    VI Ger => zurr_ + "ando" ;
    VI Part => zurr_ + "ado" ;
    VP (Pres Ind Sg P1) => zurr_ + "o" ;
    VP (Pres Ind Sg P2) => zurr_ + "as" ;
    VP (Pres Ind Sg P3) => zurr_ + "a" ;
    VP (Pres Ind Pl P1) => zurr_ + "amos" ;
    VP (Pres Ind Pl P2) => zurr_ + "áis" ;
    VP (Pres Ind Pl P3) => zurr_ + "an" ;
    VP (Pres Subj Sg P1) => zurr_ + "e" ;
    VP (Pres Subj Sg P2) => zurr_ + "es" ;
    VP (Pres Subj Sg P3) => zurr_ + "e" ;
    VP (Pres Subj Pl P1) => zurr_ + "emos" ;
    VP (Pres Subj Pl P2) => zurr_ + "éis" ;
    VP (Pres Subj Pl P3) => zurr_ + "en" ;
    VP (Past Ind Sg P1) => zurr_ + "aba" ;
    VP (Past Ind Sg P2) => zurr_ + "abas" ;
    VP (Past Ind Sg P3) => zurr_ + "aba" ;
    VP (Past Ind Pl P1) => zurr_ + "ábamos" ;
    VP (Past Ind Pl P2) => zurr_ + "abais" ;
    VP (Past Ind Pl P3) => zurr_ + "aban" ;
    VP (Past Subj Sg P1) => variants {zurr_ + "ara" ; zurr_ + "ase"} ;
    VP (Past Subj Sg P2) => variants {zurr_ + "aras" ; zurr_ + "ases"} ;
    VP (Past Subj Sg P3) => variants {zurr_ + "ara" ; zurr_ + "ase"} ;
    VP (Past Subj Pl P1) => variants {zurr_ + "áramos" ; zurr_ + "ásemos"} ;
    VP (Past Subj Pl P2) => variants {zurr_ + "arais" ; zurr_ + "aseis"} ;
    VP (Past Subj Pl P3) => variants {zurr_ + "aran" ; zurr_ + "asen"} ;
    VP (Pret Sg P1) => zurr_ + "é" ;
    VP (Pret Sg P2) => zurr_ + "aste" ;
    VP (Pret Sg P3) => zurr_ + "ó" ;
    VP (Pret Pl P1) => zurr_ + "amos" ;
    VP (Pret Pl P2) => zurr_ + "asteis" ;
    VP (Pret Pl P3) => zurr_ + "aron" ;
    VP (Fut Ind Sg P1) => zurr_ + "aré" ;
    VP (Fut Ind Sg P2) => zurr_ + "arás" ;
    VP (Fut Ind Sg P3) => zurr_ + "ará" ;
    VP (Fut Ind Pl P1) => zurr_ + "aremos" ;
    VP (Fut Ind Pl P2) => zurr_ + "aréis" ;
    VP (Fut Ind Pl P3) => zurr_ + "arán" ;
    VP (Fut Subj Sg P1) => zurr_ + "are" ;
    VP (Fut Subj Sg P2) => zurr_ + "ares" ;
    VP (Fut Subj Sg P3) => zurr_ + "are" ;
    VP (Fut Subj Pl P1) => zurr_ + "áremos" ;
    VP (Fut Subj Pl P2) => zurr_ + "areis" ;
    VP (Fut Subj Pl P3) => zurr_ + "aren" ;
    VP (Cond Sg P1) => zurr_ + "aría" ;
    VP (Cond Sg P2) => zurr_ + "arías" ;
    VP (Cond Sg P3) => zurr_ + "aría" ;
    VP (Cond Pl P1) => zurr_ + "aríamos" ;
    VP (Cond Pl P2) => zurr_ + "aríais" ;
    VP (Cond Pl P3) => zurr_ + "arían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => zurr_ + "a" ;
    VP (Imp Sg P3) => zurr_ + "e" ;
    VP (Imp Pl P1) => zurr_ + "emos" ;
    VP (Imp Pl P2) => zurr_ + "ad" ;
    VP (Imp Pl P3) => zurr_ + "en" ;
    VP (Pass Sg Masc) => zurr_ + "ado" ;
    VP (Pass Sg Fem) => zurr_ + "ada" ;
    VP (Pass Pl Masc) => zurr_ + "ados" ;
    VP (Pass Pl Fem) => zurr_ + "adas"
    }
  } ;

oper vender_4 : Str -> Verbum = \vender -> 
  let vend_ = Predef.tk 2 vender in
 {s = table {
    VI Infn=> vend_ + "er" ;
    VI Ger => vend_ + "iendo" ;
    VI Part => vend_ + "ido" ;
    VP (Pres Ind Sg P1) => vend_ + "o" ;
    VP (Pres Ind Sg P2) => vend_ + "es" ;
    VP (Pres Ind Sg P3) => vend_ + "e" ;
    VP (Pres Ind Pl P1) => vend_ + "emos" ;
    VP (Pres Ind Pl P2) => vend_ + "éis" ;
    VP (Pres Ind Pl P3) => vend_ + "en" ;
    VP (Pres Subj Sg P1) => vend_ + "a" ;
    VP (Pres Subj Sg P2) => vend_ + "as" ;
    VP (Pres Subj Sg P3) => vend_ + "a" ;
    VP (Pres Subj Pl P1) => vend_ + "amos" ;
    VP (Pres Subj Pl P2) => vend_ + "áis" ;
    VP (Pres Subj Pl P3) => vend_ + "an" ;
    VP (Past Ind Sg P1) => vend_ + "ía" ;
    VP (Past Ind Sg P2) => vend_ + "ías" ;
    VP (Past Ind Sg P3) => vend_ + "ía" ;
    VP (Past Ind Pl P1) => vend_ + "íamos" ;
    VP (Past Ind Pl P2) => vend_ + "íais" ;
    VP (Past Ind Pl P3) => vend_ + "ían" ;
    VP (Past Subj Sg P1) => variants {vend_ + "iera" ; vend_ + "iese"} ;
    VP (Past Subj Sg P2) => variants {vend_ + "ieras" ; vend_ + "ieses"} ;
    VP (Past Subj Sg P3) => variants {vend_ + "iera" ; vend_ + "iese"} ;
    VP (Past Subj Pl P1) => variants {vend_ + "iéramos" ; vend_ + "iésemos"} ;
    VP (Past Subj Pl P2) => variants {vend_ + "ierais" ; vend_ + "ieseis"} ;
    VP (Past Subj Pl P3) => variants {vend_ + "ieran" ; vend_ + "iesen"} ;
    VP (Pret Sg P1) => vend_ + "í" ;
    VP (Pret Sg P2) => vend_ + "iste" ;
    VP (Pret Sg P3) => vend_ + "ió" ;
    VP (Pret Pl P1) => vend_ + "imos" ;
    VP (Pret Pl P2) => vend_ + "isteis" ;
    VP (Pret Pl P3) => vend_ + "ieron" ;
    VP (Fut Ind Sg P1) => vend_ + "eré" ;
    VP (Fut Ind Sg P2) => vend_ + "erás" ;
    VP (Fut Ind Sg P3) => vend_ + "erá" ;
    VP (Fut Ind Pl P1) => vend_ + "eremos" ;
    VP (Fut Ind Pl P2) => vend_ + "eréis" ;
    VP (Fut Ind Pl P3) => vend_ + "erán" ;
    VP (Fut Subj Sg P1) => vend_ + "iere" ;
    VP (Fut Subj Sg P2) => vend_ + "ieres" ;
    VP (Fut Subj Sg P3) => vend_ + "iere" ;
    VP (Fut Subj Pl P1) => vend_ + "iéremos" ;
    VP (Fut Subj Pl P2) => vend_ + "iereis" ;
    VP (Fut Subj Pl P3) => vend_ + "ieren" ;
    VP (Cond Sg P1) => vend_ + "ería" ;
    VP (Cond Sg P2) => vend_ + "erías" ;
    VP (Cond Sg P3) => vend_ + "ería" ;
    VP (Cond Pl P1) => vend_ + "eríamos" ;
    VP (Cond Pl P2) => vend_ + "eríais" ;
    VP (Cond Pl P3) => vend_ + "erían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => vend_ + "e" ;
    VP (Imp Sg P3) => vend_ + "a" ;
    VP (Imp Pl P1) => vend_ + "amos" ;
    VP (Imp Pl P2) => vend_ + "ed" ;
    VP (Imp Pl P3) => vend_ + "an" ;
    VP (Pass Sg Masc) => vend_ + "ido" ;
    VP (Pass Sg Fem) => vend_ + "ida" ;
    VP (Pass Pl Masc) => vend_ + "idos" ;
    VP (Pass Pl Fem) => vend_ + "idas"
    }
  } ;

oper zurrir_5 : Str -> Verbum = \zurrir -> 
  let zurr_ = Predef.tk 2 zurrir in
 {s = table {
    VI Infn=> zurr_ + "ir" ;
    VI Ger => zurr_ + "iendo" ;
    VI Part => zurr_ + "ido" ;
    VP (Pres Ind Sg P1) => zurr_ + "o" ;
    VP (Pres Ind Sg P2) => zurr_ + "es" ;
    VP (Pres Ind Sg P3) => zurr_ + "e" ;
    VP (Pres Ind Pl P1) => zurr_ + "imos" ;
    VP (Pres Ind Pl P2) => zurr_ + "ís" ;
    VP (Pres Ind Pl P3) => zurr_ + "en" ;
    VP (Pres Subj Sg P1) => zurr_ + "a" ;
    VP (Pres Subj Sg P2) => zurr_ + "as" ;
    VP (Pres Subj Sg P3) => zurr_ + "a" ;
    VP (Pres Subj Pl P1) => zurr_ + "amos" ;
    VP (Pres Subj Pl P2) => zurr_ + "áis" ;
    VP (Pres Subj Pl P3) => zurr_ + "an" ;
    VP (Past Ind Sg P1) => zurr_ + "ía" ;
    VP (Past Ind Sg P2) => zurr_ + "ías" ;
    VP (Past Ind Sg P3) => zurr_ + "ía" ;
    VP (Past Ind Pl P1) => zurr_ + "íamos" ;
    VP (Past Ind Pl P2) => zurr_ + "íais" ;
    VP (Past Ind Pl P3) => zurr_ + "ían" ;
    VP (Past Subj Sg P1) => variants {zurr_ + "iera" ; zurr_ + "iese"} ;
    VP (Past Subj Sg P2) => variants {zurr_ + "ieras" ; zurr_ + "ieses"} ;
    VP (Past Subj Sg P3) => variants {zurr_ + "iera" ; zurr_ + "iese"} ;
    VP (Past Subj Pl P1) => variants {zurr_ + "iéramos" ; zurr_ + "iésemos"} ;
    VP (Past Subj Pl P2) => variants {zurr_ + "ierais" ; zurr_ + "ieseis"} ;
    VP (Past Subj Pl P3) => variants {zurr_ + "ieran" ; zurr_ + "iesen"} ;
    VP (Pret Sg P1) => zurr_ + "í" ;
    VP (Pret Sg P2) => zurr_ + "iste" ;
    VP (Pret Sg P3) => zurr_ + "ió" ;
    VP (Pret Pl P1) => zurr_ + "imos" ;
    VP (Pret Pl P2) => zurr_ + "isteis" ;
    VP (Pret Pl P3) => zurr_ + "ieron" ;
    VP (Fut Ind Sg P1) => zurr_ + "iré" ;
    VP (Fut Ind Sg P2) => zurr_ + "irás" ;
    VP (Fut Ind Sg P3) => zurr_ + "irá" ;
    VP (Fut Ind Pl P1) => zurr_ + "iremos" ;
    VP (Fut Ind Pl P2) => zurr_ + "iréis" ;
    VP (Fut Ind Pl P3) => zurr_ + "irán" ;
    VP (Fut Subj Sg P1) => zurr_ + "iere" ;
    VP (Fut Subj Sg P2) => zurr_ + "ieres" ;
    VP (Fut Subj Sg P3) => zurr_ + "iere" ;
    VP (Fut Subj Pl P1) => zurr_ + "iéremos" ;
    VP (Fut Subj Pl P2) => zurr_ + "iereis" ;
    VP (Fut Subj Pl P3) => zurr_ + "ieren" ;
    VP (Cond Sg P1) => zurr_ + "iría" ;
    VP (Cond Sg P2) => zurr_ + "irías" ;
    VP (Cond Sg P3) => zurr_ + "iría" ;
    VP (Cond Pl P1) => zurr_ + "iríamos" ;
    VP (Cond Pl P2) => zurr_ + "iríais" ;
    VP (Cond Pl P3) => zurr_ + "irían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => zurr_ + "e" ;
    VP (Imp Sg P3) => zurr_ + "a" ;
    VP (Imp Pl P1) => zurr_ + "amos" ;
    VP (Imp Pl P2) => zurr_ + "id" ;
    VP (Imp Pl P3) => zurr_ + "an" ;
    VP (Pass Sg Masc) => zurr_ + "ido" ;
    VP (Pass Sg Fem) => zurr_ + "ida" ;
    VP (Pass Pl Masc) => zurr_ + "idos" ;
    VP (Pass Pl Fem) => zurr_ + "idas"
    }
  } ;

oper zullarse_6 : Str -> Verbum = \zullarse -> 
  let zull_ = Predef.tk 4 zullarse in
 {s = table {
    VI Infn=> zull_ + "arse" ;
    VI Ger => zull_ + "ando" ;
    VI Part => zull_ + "ado" ;
    VP (Pres Ind Sg P1) => zull_ + "o" ;
    VP (Pres Ind Sg P2) => zull_ + "as" ;
    VP (Pres Ind Sg P3) => zull_ + "a" ;
    VP (Pres Ind Pl P1) => zull_ + "amos" ;
    VP (Pres Ind Pl P2) => zull_ + "áis" ;
    VP (Pres Ind Pl P3) => zull_ + "an" ;
    VP (Pres Subj Sg P1) => zull_ + "e" ;
    VP (Pres Subj Sg P2) => zull_ + "es" ;
    VP (Pres Subj Sg P3) => zull_ + "e" ;
    VP (Pres Subj Pl P1) => zull_ + "emos" ;
    VP (Pres Subj Pl P2) => zull_ + "éis" ;
    VP (Pres Subj Pl P3) => zull_ + "en" ;
    VP (Past Ind Sg P1) => zull_ + "aba" ;
    VP (Past Ind Sg P2) => zull_ + "abas" ;
    VP (Past Ind Sg P3) => zull_ + "aba" ;
    VP (Past Ind Pl P1) => zull_ + "ábamos" ;
    VP (Past Ind Pl P2) => zull_ + "abais" ;
    VP (Past Ind Pl P3) => zull_ + "aban" ;
    VP (Past Subj Sg P1) => variants {zull_ + "ara" ; zull_ + "ase"} ;
    VP (Past Subj Sg P2) => variants {zull_ + "aras" ; zull_ + "ases"} ;
    VP (Past Subj Sg P3) => variants {zull_ + "ara" ; zull_ + "ase"} ;
    VP (Past Subj Pl P1) => variants {zull_ + "áramos" ; zull_ + "ásemos"} ;
    VP (Past Subj Pl P2) => variants {zull_ + "arais" ; zull_ + "aseis"} ;
    VP (Past Subj Pl P3) => variants {zull_ + "aran" ; zull_ + "asen"} ;
    VP (Pret Sg P1) => zull_ + "é" ;
    VP (Pret Sg P2) => zull_ + "aste" ;
    VP (Pret Sg P3) => zull_ + "ó" ;
    VP (Pret Pl P1) => zull_ + "amos" ;
    VP (Pret Pl P2) => zull_ + "asteis" ;
    VP (Pret Pl P3) => zull_ + "aron" ;
    VP (Fut Ind Sg P1) => zull_ + "aré" ;
    VP (Fut Ind Sg P2) => zull_ + "arás" ;
    VP (Fut Ind Sg P3) => zull_ + "ará" ;
    VP (Fut Ind Pl P1) => zull_ + "aremos" ;
    VP (Fut Ind Pl P2) => zull_ + "aréis" ;
    VP (Fut Ind Pl P3) => zull_ + "arán" ;
    VP (Fut Subj Sg P1) => zull_ + "are" ;
    VP (Fut Subj Sg P2) => zull_ + "ares" ;
    VP (Fut Subj Sg P3) => zull_ + "are" ;
    VP (Fut Subj Pl P1) => zull_ + "áremos" ;
    VP (Fut Subj Pl P2) => zull_ + "areis" ;
    VP (Fut Subj Pl P3) => zull_ + "aren" ;
    VP (Cond Sg P1) => zull_ + "aría" ;
    VP (Cond Sg P2) => zull_ + "arías" ;
    VP (Cond Sg P3) => zull_ + "aría" ;
    VP (Cond Pl P1) => zull_ + "aríamos" ;
    VP (Cond Pl P2) => zull_ + "aríais" ;
    VP (Cond Pl P3) => zull_ + "arían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => zull_ + "a" ;
    VP (Imp Sg P3) => zull_ + "e" ;
    VP (Imp Pl P1) => zull_ + "emos" ;
    VP (Imp Pl P2) => zull_ + "ad" ;
    VP (Imp Pl P3) => zull_ + "en" ;
    VP (Pass Sg Masc) => zull_ + "ado" ;
    VP (Pass Sg Fem) => zull_ + "ada" ;
    VP (Pass Pl Masc) => zull_ + "ados" ;
    VP (Pass Pl Fem) => zull_ + "adas"
    }
  } ;

oper ser_7 : Str -> Verbum = \ser -> 
  let x_ = Predef.tk 3 ser in
 {s = table {
    VI Infn=> x_ + "ser" ;
    VI Ger => x_ + "siendo" ;
    VI Part => x_ + "sido" ;
    VP (Pres Ind Sg P1) => x_ + "soy" ;
    VP (Pres Ind Sg P2) => x_ + "eres" ;
    VP (Pres Ind Sg P3) => x_ + "es" ;
    VP (Pres Ind Pl P1) => x_ + "somos" ;
    VP (Pres Ind Pl P2) => x_ + "sois" ;
    VP (Pres Ind Pl P3) => x_ + "son" ;
    VP (Pres Subj Sg P1) => x_ + "sea" ;
    VP (Pres Subj Sg P2) => x_ + "seas" ;
    VP (Pres Subj Sg P3) => x_ + "sea" ;
    VP (Pres Subj Pl P1) => x_ + "seamos" ;
    VP (Pres Subj Pl P2) => x_ + "seáis" ;
    VP (Pres Subj Pl P3) => x_ + "sean" ;
    VP (Past Ind Sg P1) => x_ + "era" ;
    VP (Past Ind Sg P2) => x_ + "eras" ;
    VP (Past Ind Sg P3) => x_ + "era" ;
    VP (Past Ind Pl P1) => x_ + "éramos" ;
    VP (Past Ind Pl P2) => x_ + "erais" ;
    VP (Past Ind Pl P3) => x_ + "eran" ;
    VP (Past Subj Sg P1) => variants {x_ + "fuera" ; x_ + "fuese"} ;
    VP (Past Subj Sg P2) => variants {x_ + "fueras" ; x_ + "fueses"} ;
    VP (Past Subj Sg P3) => variants {x_ + "fuera" ; x_ + "fuese"} ;
    VP (Past Subj Pl P1) => variants {x_ + "fuéramos" ; x_ + "fuésemos"} ;
    VP (Past Subj Pl P2) => variants {x_ + "fuerais" ; x_ + "fueseis"} ;
    VP (Past Subj Pl P3) => variants {x_ + "fueran" ; x_ + "fuesen"} ;
    VP (Pret Sg P1) => x_ + "fui" ;
    VP (Pret Sg P2) => x_ + "fuiste" ;
    VP (Pret Sg P3) => x_ + "fue" ;
    VP (Pret Pl P1) => x_ + "fuimos" ;
    VP (Pret Pl P2) => x_ + "fuisteis" ;
    VP (Pret Pl P3) => x_ + "fueron" ;
    VP (Fut Ind Sg P1) => x_ + "seré" ;
    VP (Fut Ind Sg P2) => x_ + "serás" ;
    VP (Fut Ind Sg P3) => x_ + "será" ;
    VP (Fut Ind Pl P1) => x_ + "seremos" ;
    VP (Fut Ind Pl P2) => x_ + "seréis" ;
    VP (Fut Ind Pl P3) => x_ + "serán" ;
    VP (Fut Subj Sg P1) => x_ + "fuere" ;
    VP (Fut Subj Sg P2) => x_ + "fueres" ;
    VP (Fut Subj Sg P3) => x_ + "fuere" ;
    VP (Fut Subj Pl P1) => x_ + "fuéremos" ;
    VP (Fut Subj Pl P2) => x_ + "fuereis" ;
    VP (Fut Subj Pl P3) => x_ + "fueren" ;
    VP (Cond Sg P1) => x_ + "sería" ;
    VP (Cond Sg P2) => x_ + "serías" ;
    VP (Cond Sg P3) => x_ + "sería" ;
    VP (Cond Pl P1) => x_ + "seríamos" ;
    VP (Cond Pl P2) => x_ + "seríais" ;
    VP (Cond Pl P3) => x_ + "serían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => x_ + "sé" ;
    VP (Imp Sg P3) => x_ + "sea" ;
    VP (Imp Pl P1) => x_ + "seamos" ;
    VP (Imp Pl P2) => x_ + "sed" ;
    VP (Imp Pl P3) => x_ + "sean" ;
    VP (Pass Sg Masc) => x_ + "sido" ;
    VP (Pass Sg Fem) => x_ + "sida" ;
    VP (Pass Pl Masc) => x_ + "sidos" ;
    VP (Pass Pl Fem) => x_ + "sidas"
    }
  } ;

oper ir_8 : Str -> Verbum = \ir -> 
  let x_ = Predef.tk 2 ir in
 {s = table {
    VI Infn=> x_ + "ir" ;
    VI Ger => x_ + "yendo" ;
    VI Part => x_ + "ido" ;
    VP (Pres Ind Sg P1) => x_ + "voy" ;
    VP (Pres Ind Sg P2) => x_ + "vas" ;
    VP (Pres Ind Sg P3) => x_ + "va" ;
    VP (Pres Ind Pl P1) => x_ + "vamos" ;
    VP (Pres Ind Pl P2) => x_ + "vais" ;
    VP (Pres Ind Pl P3) => x_ + "van" ;
    VP (Pres Subj Sg P1) => x_ + "vaya" ;
    VP (Pres Subj Sg P2) => x_ + "vayas" ;
    VP (Pres Subj Sg P3) => x_ + "vaya" ;
    VP (Pres Subj Pl P1) => x_ + "vayamos" ;
    VP (Pres Subj Pl P2) => x_ + "vayáis" ;
    VP (Pres Subj Pl P3) => x_ + "vayan" ;
    VP (Past Ind Sg P1) => x_ + "iba" ;
    VP (Past Ind Sg P2) => x_ + "ibas" ;
    VP (Past Ind Sg P3) => x_ + "iba" ;
    VP (Past Ind Pl P1) => x_ + "íbamos" ;
    VP (Past Ind Pl P2) => x_ + "ibais" ;
    VP (Past Ind Pl P3) => x_ + "iban" ;
    VP (Past Subj Sg P1) => variants {x_ + "fuera" ; x_ + "fuese"} ;
    VP (Past Subj Sg P2) => variants {x_ + "fueras" ; x_ + "fueses"} ;
    VP (Past Subj Sg P3) => variants {x_ + "fuera" ; x_ + "fuese"} ;
    VP (Past Subj Pl P1) => variants {x_ + "fuéramos" ; x_ + "fuésemos"} ;
    VP (Past Subj Pl P2) => variants {x_ + "fuerais" ; x_ + "fueseis"} ;
    VP (Past Subj Pl P3) => variants {x_ + "fueran" ; x_ + "fuesen"} ;
    VP (Pret Sg P1) => x_ + "fui" ;
    VP (Pret Sg P2) => x_ + "fuiste" ;
    VP (Pret Sg P3) => x_ + "fue" ;
    VP (Pret Pl P1) => x_ + "fuimos" ;
    VP (Pret Pl P2) => x_ + "fuisteis" ;
    VP (Pret Pl P3) => x_ + "fueron" ;
    VP (Fut Ind Sg P1) => x_ + "iré" ;
    VP (Fut Ind Sg P2) => x_ + "irás" ;
    VP (Fut Ind Sg P3) => x_ + "irá" ;
    VP (Fut Ind Pl P1) => x_ + "iremos" ;
    VP (Fut Ind Pl P2) => x_ + "iréis" ;
    VP (Fut Ind Pl P3) => x_ + "irán" ;
    VP (Fut Subj Sg P1) => x_ + "fuere" ;
    VP (Fut Subj Sg P2) => x_ + "fueres" ;
    VP (Fut Subj Sg P3) => x_ + "fuere" ;
    VP (Fut Subj Pl P1) => x_ + "fuéremos" ;
    VP (Fut Subj Pl P2) => x_ + "fuereis" ;
    VP (Fut Subj Pl P3) => x_ + "fueren" ;
    VP (Cond Sg P1) => x_ + "iría" ;
    VP (Cond Sg P2) => x_ + "irías" ;
    VP (Cond Sg P3) => x_ + "iría" ;
    VP (Cond Pl P1) => x_ + "iríamos" ;
    VP (Cond Pl P2) => x_ + "iríais" ;
    VP (Cond Pl P3) => x_ + "irían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => x_ + "ve" ;
    VP (Imp Sg P3) => x_ + "vaya" ;
    VP (Imp Pl P1) => variants {x_ + "vamos" ; x_ + "vayamos"} ;
    VP (Imp Pl P2) => x_ + "id" ;
    VP (Imp Pl P3) => x_ + "vayan" ;
    VP (Pass Sg Masc) => x_ + "ido" ;
    VP (Pass Sg Fem) => x_ + "ida" ;
    VP (Pass Pl Masc) => x_ + "idos" ;
    VP (Pass Pl Fem) => x_ + "idas"
    }
  } ;

oper estar_9 : Str -> Verbum = \estar -> 
  let est_ = Predef.tk 2 estar in
 {s = table {
    VI Infn=> est_ + "ar" ;
    VI Ger => est_ + "ando" ;
    VI Part => est_ + "ado" ;
    VP (Pres Ind Sg P1) => est_ + "oy" ;
    VP (Pres Ind Sg P2) => est_ + "ás" ;
    VP (Pres Ind Sg P3) => est_ + "á" ;
    VP (Pres Ind Pl P1) => est_ + "amos" ;
    VP (Pres Ind Pl P2) => est_ + "áis" ;
    VP (Pres Ind Pl P3) => est_ + "án" ;
    VP (Pres Subj Sg P1) => est_ + "é" ;
    VP (Pres Subj Sg P2) => est_ + "és" ;
    VP (Pres Subj Sg P3) => est_ + "é" ;
    VP (Pres Subj Pl P1) => est_ + "emos" ;
    VP (Pres Subj Pl P2) => est_ + "éis" ;
    VP (Pres Subj Pl P3) => est_ + "én" ;
    VP (Past Ind Sg P1) => est_ + "aba" ;
    VP (Past Ind Sg P2) => est_ + "abas" ;
    VP (Past Ind Sg P3) => est_ + "aba" ;
    VP (Past Ind Pl P1) => est_ + "ábamos" ;
    VP (Past Ind Pl P2) => est_ + "abais" ;
    VP (Past Ind Pl P3) => est_ + "aban" ;
    VP (Past Subj Sg P1) => variants {est_ + "uviera" ; est_ + "uviese"} ;
    VP (Past Subj Sg P2) => variants {est_ + "uvieras" ; est_ + "uvieses"} ;
    VP (Past Subj Sg P3) => variants {est_ + "uviera" ; est_ + "uviese"} ;
    VP (Past Subj Pl P1) => variants {est_ + "uviéramos" ; est_ + "uviésemos"} ;
    VP (Past Subj Pl P2) => variants {est_ + "uvierais" ; est_ + "uvieseis"} ;
    VP (Past Subj Pl P3) => variants {est_ + "uvieran" ; est_ + "uviesen"} ;
    VP (Pret Sg P1) => est_ + "uve" ;
    VP (Pret Sg P2) => est_ + "uviste" ;
    VP (Pret Sg P3) => est_ + "uvo" ;
    VP (Pret Pl P1) => est_ + "uvimos" ;
    VP (Pret Pl P2) => est_ + "uvisteis" ;
    VP (Pret Pl P3) => est_ + "uvieron" ;
    VP (Fut Ind Sg P1) => est_ + "aré" ;
    VP (Fut Ind Sg P2) => est_ + "arás" ;
    VP (Fut Ind Sg P3) => est_ + "ará" ;
    VP (Fut Ind Pl P1) => est_ + "aremos" ;
    VP (Fut Ind Pl P2) => est_ + "aréis" ;
    VP (Fut Ind Pl P3) => est_ + "arán" ;
    VP (Fut Subj Sg P1) => est_ + "uviere" ;
    VP (Fut Subj Sg P2) => est_ + "uvieres" ;
    VP (Fut Subj Sg P3) => est_ + "uviere" ;
    VP (Fut Subj Pl P1) => est_ + "uviéremos" ;
    VP (Fut Subj Pl P2) => est_ + "uviereis" ;
    VP (Fut Subj Pl P3) => est_ + "uvieren" ;
    VP (Cond Sg P1) => est_ + "aría" ;
    VP (Cond Sg P2) => est_ + "arías" ;
    VP (Cond Sg P3) => est_ + "aría" ;
    VP (Cond Pl P1) => est_ + "aríamos" ;
    VP (Cond Pl P2) => est_ + "aríais" ;
    VP (Cond Pl P3) => est_ + "arían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => est_ + "á" ;
    VP (Imp Sg P3) => est_ + "é" ;
    VP (Imp Pl P1) => est_ + "emos" ;
    VP (Imp Pl P2) => est_ + "ad" ;
    VP (Imp Pl P3) => est_ + "én" ;
    VP (Pass Sg Masc) => est_ + "ado" ;
    VP (Pass Sg Fem) => est_ + "ada" ;
    VP (Pass Pl Masc) => est_ + "ados" ;
    VP (Pass Pl Fem) => est_ + "adas"
    }
  } ;

oper haber_10 : Str -> Verbum = \haber -> 
  let h_ = Predef.tk 4 haber in
 {s = table {
    VI Infn=> h_ + "aber" ;
    VI Ger => h_ + "abiendo" ;
    VI Part => h_ + "abido" ;
    VP (Pres Ind Sg P1) => h_ + "e" ;
    VP (Pres Ind Sg P2) => h_ + "as" ;
    VP (Pres Ind Sg P3) => variants {h_ + "a" ; h_ + "ay"} ;
    VP (Pres Ind Pl P1) => h_ + "emos" ;
    VP (Pres Ind Pl P2) => h_ + "abéis" ;
    VP (Pres Ind Pl P3) => h_ + "an" ;
    VP (Pres Subj Sg P1) => h_ + "aya" ;
    VP (Pres Subj Sg P2) => h_ + "ayas" ;
    VP (Pres Subj Sg P3) => h_ + "aya" ;
    VP (Pres Subj Pl P1) => h_ + "ayamos" ;
    VP (Pres Subj Pl P2) => h_ + "ayáis" ;
    VP (Pres Subj Pl P3) => h_ + "ayan" ;
    VP (Past Ind Sg P1) => h_ + "abía" ;
    VP (Past Ind Sg P2) => h_ + "abías" ;
    VP (Past Ind Sg P3) => h_ + "abía" ;
    VP (Past Ind Pl P1) => h_ + "abíamos" ;
    VP (Past Ind Pl P2) => h_ + "abíais" ;
    VP (Past Ind Pl P3) => h_ + "abían" ;
    VP (Past Subj Sg P1) => variants {h_ + "ubiera" ; h_ + "ubiese"} ;
    VP (Past Subj Sg P2) => variants {h_ + "ubieras" ; h_ + "ubieses"} ;
    VP (Past Subj Sg P3) => variants {h_ + "ubiera" ; h_ + "ubiese"} ;
    VP (Past Subj Pl P1) => variants {h_ + "ubiéramos" ; h_ + "ubiésemos"} ;
    VP (Past Subj Pl P2) => variants {h_ + "ubierais" ; h_ + "ubieseis"} ;
    VP (Past Subj Pl P3) => variants {h_ + "ubieran" ; h_ + "ubiesen"} ;
    VP (Pret Sg P1) => h_ + "ube" ;
    VP (Pret Sg P2) => h_ + "ubiste" ;
    VP (Pret Sg P3) => h_ + "ubo" ;
    VP (Pret Pl P1) => h_ + "ubimos" ;
    VP (Pret Pl P2) => h_ + "ubisteis" ;
    VP (Pret Pl P3) => h_ + "ubieron" ;
    VP (Fut Ind Sg P1) => h_ + "abré" ;
    VP (Fut Ind Sg P2) => h_ + "abrás" ;
    VP (Fut Ind Sg P3) => h_ + "abrá" ;
    VP (Fut Ind Pl P1) => h_ + "abremos" ;
    VP (Fut Ind Pl P2) => h_ + "abréis" ;
    VP (Fut Ind Pl P3) => h_ + "abrán" ;
    VP (Fut Subj Sg P1) => h_ + "ubiere" ;
    VP (Fut Subj Sg P2) => h_ + "ubieres" ;
    VP (Fut Subj Sg P3) => h_ + "ubiere" ;
    VP (Fut Subj Pl P1) => h_ + "ubiéremos" ;
    VP (Fut Subj Pl P2) => h_ + "ubiereis" ;
    VP (Fut Subj Pl P3) => h_ + "ubieren" ;
    VP (Cond Sg P1) => h_ + "abría" ;
    VP (Cond Sg P2) => h_ + "abrías" ;
    VP (Cond Sg P3) => h_ + "abría" ;
    VP (Cond Pl P1) => h_ + "abríamos" ;
    VP (Cond Pl P2) => h_ + "abríais" ;
    VP (Cond Pl P3) => h_ + "abrían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => variants {} ;
    VP (Imp Sg P3) => variants {} ;
    VP (Imp Pl P1) => variants {} ;
    VP (Imp Pl P2) => variants {} ;
    VP (Imp Pl P3) => variants {} ;
    VP (Pass Sg Masc) => h_ + "abido" ;
    VP (Pass Sg Fem) => h_ + "abida" ;
    VP (Pass Pl Masc) => h_ + "abidos" ;
    VP (Pass Pl Fem) => h_ + "abidas"
    }
  } ;

oper saber_11 : Str -> Verbum = \saber -> 
  let s_ = Predef.tk 4 saber in
 {s = table {
    VI Infn=> s_ + "aber" ;
    VI Ger => s_ + "abiendo" ;
    VI Part => s_ + "abido" ;
    VP (Pres Ind Sg P1) => s_ + "é" ;
    VP (Pres Ind Sg P2) => s_ + "abes" ;
    VP (Pres Ind Sg P3) => s_ + "abe" ;
    VP (Pres Ind Pl P1) => s_ + "abemos" ;
    VP (Pres Ind Pl P2) => s_ + "abéis" ;
    VP (Pres Ind Pl P3) => s_ + "aben" ;
    VP (Pres Subj Sg P1) => s_ + "epa" ;
    VP (Pres Subj Sg P2) => s_ + "epas" ;
    VP (Pres Subj Sg P3) => s_ + "epa" ;
    VP (Pres Subj Pl P1) => s_ + "epamos" ;
    VP (Pres Subj Pl P2) => s_ + "epáis" ;
    VP (Pres Subj Pl P3) => s_ + "epan" ;
    VP (Past Ind Sg P1) => s_ + "abía" ;
    VP (Past Ind Sg P2) => s_ + "abías" ;
    VP (Past Ind Sg P3) => s_ + "abía" ;
    VP (Past Ind Pl P1) => s_ + "abíamos" ;
    VP (Past Ind Pl P2) => s_ + "abíais" ;
    VP (Past Ind Pl P3) => s_ + "abían" ;
    VP (Past Subj Sg P1) => variants {s_ + "upiera" ; s_ + "upiese"} ;
    VP (Past Subj Sg P2) => variants {s_ + "upieras" ; s_ + "upieses"} ;
    VP (Past Subj Sg P3) => variants {s_ + "upiera" ; s_ + "upiese"} ;
    VP (Past Subj Pl P1) => variants {s_ + "upiéramos" ; s_ + "upiésemos"} ;
    VP (Past Subj Pl P2) => variants {s_ + "upierais" ; s_ + "upieseis"} ;
    VP (Past Subj Pl P3) => variants {s_ + "upieran" ; s_ + "upiesen"} ;
    VP (Pret Sg P1) => s_ + "upe" ;
    VP (Pret Sg P2) => s_ + "upiste" ;
    VP (Pret Sg P3) => s_ + "upo" ;
    VP (Pret Pl P1) => s_ + "upimos" ;
    VP (Pret Pl P2) => s_ + "upisteis" ;
    VP (Pret Pl P3) => s_ + "upieron" ;
    VP (Fut Ind Sg P1) => s_ + "abré" ;
    VP (Fut Ind Sg P2) => s_ + "abrás" ;
    VP (Fut Ind Sg P3) => s_ + "abrá" ;
    VP (Fut Ind Pl P1) => s_ + "abremos" ;
    VP (Fut Ind Pl P2) => s_ + "abréis" ;
    VP (Fut Ind Pl P3) => s_ + "abrán" ;
    VP (Fut Subj Sg P1) => s_ + "upiere" ;
    VP (Fut Subj Sg P2) => s_ + "upieres" ;
    VP (Fut Subj Sg P3) => s_ + "upiere" ;
    VP (Fut Subj Pl P1) => s_ + "upiéremos" ;
    VP (Fut Subj Pl P2) => s_ + "upiereis" ;
    VP (Fut Subj Pl P3) => s_ + "upieren" ;
    VP (Cond Sg P1) => s_ + "abría" ;
    VP (Cond Sg P2) => s_ + "abrías" ;
    VP (Cond Sg P3) => s_ + "abría" ;
    VP (Cond Pl P1) => s_ + "abríamos" ;
    VP (Cond Pl P2) => s_ + "abríais" ;
    VP (Cond Pl P3) => s_ + "abrían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => s_ + "abe" ;
    VP (Imp Sg P3) => s_ + "epa" ;
    VP (Imp Pl P1) => s_ + "epamos" ;
    VP (Imp Pl P2) => s_ + "abed" ;
    VP (Imp Pl P3) => s_ + "epan" ;
    VP (Pass Sg Masc) => s_ + "abido" ;
    VP (Pass Sg Fem) => s_ + "abida" ;
    VP (Pass Pl Masc) => s_ + "abidos" ;
    VP (Pass Pl Fem) => s_ + "abidas"
    }
  } ;

oper venir_12 : Str -> Verbum = \venir -> 
  let v_ = Predef.tk 4 venir in
 {s = table {
    VI Infn=> v_ + "enir" ;
    VI Ger => v_ + "iniendo" ;
    VI Part => v_ + "enido" ;
    VP (Pres Ind Sg P1) => v_ + "engo" ;
    VP (Pres Ind Sg P2) => v_ + "ienes" ;
    VP (Pres Ind Sg P3) => v_ + "iene" ;
    VP (Pres Ind Pl P1) => v_ + "enimos" ;
    VP (Pres Ind Pl P2) => v_ + "enís" ;
    VP (Pres Ind Pl P3) => v_ + "ienen" ;
    VP (Pres Subj Sg P1) => v_ + "enga" ;
    VP (Pres Subj Sg P2) => v_ + "engas" ;
    VP (Pres Subj Sg P3) => v_ + "enga" ;
    VP (Pres Subj Pl P1) => v_ + "engamos" ;
    VP (Pres Subj Pl P2) => v_ + "engáis" ;
    VP (Pres Subj Pl P3) => v_ + "engan" ;
    VP (Past Ind Sg P1) => v_ + "enía" ;
    VP (Past Ind Sg P2) => v_ + "enías" ;
    VP (Past Ind Sg P3) => v_ + "enía" ;
    VP (Past Ind Pl P1) => v_ + "eníamos" ;
    VP (Past Ind Pl P2) => v_ + "eníais" ;
    VP (Past Ind Pl P3) => v_ + "enían" ;
    VP (Past Subj Sg P1) => variants {v_ + "iniera" ; v_ + "iniese"} ;
    VP (Past Subj Sg P2) => variants {v_ + "inieras" ; v_ + "inieses"} ;
    VP (Past Subj Sg P3) => variants {v_ + "iniera" ; v_ + "iniese"} ;
    VP (Past Subj Pl P1) => variants {v_ + "iniéramos" ; v_ + "iniésemos"} ;
    VP (Past Subj Pl P2) => variants {v_ + "inierais" ; v_ + "inieseis"} ;
    VP (Past Subj Pl P3) => variants {v_ + "inieran" ; v_ + "iniesen"} ;
    VP (Pret Sg P1) => v_ + "ine" ;
    VP (Pret Sg P2) => v_ + "iniste" ;
    VP (Pret Sg P3) => v_ + "ino" ;
    VP (Pret Pl P1) => v_ + "inimos" ;
    VP (Pret Pl P2) => v_ + "inisteis" ;
    VP (Pret Pl P3) => v_ + "inieron" ;
    VP (Fut Ind Sg P1) => v_ + "endré" ;
    VP (Fut Ind Sg P2) => v_ + "endrás" ;
    VP (Fut Ind Sg P3) => v_ + "endrá" ;
    VP (Fut Ind Pl P1) => v_ + "endremos" ;
    VP (Fut Ind Pl P2) => v_ + "endréis" ;
    VP (Fut Ind Pl P3) => v_ + "endrán" ;
    VP (Fut Subj Sg P1) => v_ + "iniere" ;
    VP (Fut Subj Sg P2) => v_ + "inieres" ;
    VP (Fut Subj Sg P3) => v_ + "iniere" ;
    VP (Fut Subj Pl P1) => v_ + "iniéremos" ;
    VP (Fut Subj Pl P2) => v_ + "iniereis" ;
    VP (Fut Subj Pl P3) => v_ + "inieren" ;
    VP (Cond Sg P1) => v_ + "endría" ;
    VP (Cond Sg P2) => v_ + "endrías" ;
    VP (Cond Sg P3) => v_ + "endría" ;
    VP (Cond Pl P1) => v_ + "endríamos" ;
    VP (Cond Pl P2) => v_ + "endríais" ;
    VP (Cond Pl P3) => v_ + "endrían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => v_ + "en" ;
    VP (Imp Sg P3) => v_ + "enga" ;
    VP (Imp Pl P1) => v_ + "engamos" ;
    VP (Imp Pl P2) => v_ + "enid" ;
    VP (Imp Pl P3) => v_ + "engan" ;
    VP (Pass Sg Masc) => v_ + "enido" ;
    VP (Pass Sg Fem) => v_ + "enida" ;
    VP (Pass Pl Masc) => v_ + "enidos" ;
    VP (Pass Pl Fem) => v_ + "enidas"
    }
  } ;

oper romper_13 : Str -> Verbum = \romper -> 
  let ro_ = Predef.tk 4 romper in
 {s = table {
    VI Infn=> ro_ + "mper" ;
    VI Ger => ro_ + "mpiendo" ;
    VI Part => ro_ + "to" ;
    VP (Pres Ind Sg P1) => ro_ + "mpo" ;
    VP (Pres Ind Sg P2) => ro_ + "mpes" ;
    VP (Pres Ind Sg P3) => ro_ + "mpe" ;
    VP (Pres Ind Pl P1) => ro_ + "mpemos" ;
    VP (Pres Ind Pl P2) => ro_ + "mpéis" ;
    VP (Pres Ind Pl P3) => ro_ + "mpen" ;
    VP (Pres Subj Sg P1) => ro_ + "mpa" ;
    VP (Pres Subj Sg P2) => ro_ + "mpas" ;
    VP (Pres Subj Sg P3) => ro_ + "mpa" ;
    VP (Pres Subj Pl P1) => ro_ + "mpamos" ;
    VP (Pres Subj Pl P2) => ro_ + "mpáis" ;
    VP (Pres Subj Pl P3) => ro_ + "mpan" ;
    VP (Past Ind Sg P1) => ro_ + "mpía" ;
    VP (Past Ind Sg P2) => ro_ + "mpías" ;
    VP (Past Ind Sg P3) => ro_ + "mpía" ;
    VP (Past Ind Pl P1) => ro_ + "mpíamos" ;
    VP (Past Ind Pl P2) => ro_ + "mpíais" ;
    VP (Past Ind Pl P3) => ro_ + "mpían" ;
    VP (Past Subj Sg P1) => variants {ro_ + "mpiera" ; ro_ + "mpiese"} ;
    VP (Past Subj Sg P2) => variants {ro_ + "mpieras" ; ro_ + "mpieses"} ;
    VP (Past Subj Sg P3) => variants {ro_ + "mpiera" ; ro_ + "mpiese"} ;
    VP (Past Subj Pl P1) => variants {ro_ + "mpiéramos" ; ro_ + "mpiésemos"} ;
    VP (Past Subj Pl P2) => variants {ro_ + "mpierais" ; ro_ + "mpieseis"} ;
    VP (Past Subj Pl P3) => variants {ro_ + "mpieran" ; ro_ + "mpiesen"} ;
    VP (Pret Sg P1) => ro_ + "mpí" ;
    VP (Pret Sg P2) => ro_ + "mpiste" ;
    VP (Pret Sg P3) => ro_ + "mpió" ;
    VP (Pret Pl P1) => ro_ + "mpimos" ;
    VP (Pret Pl P2) => ro_ + "mpisteis" ;
    VP (Pret Pl P3) => ro_ + "mpieron" ;
    VP (Fut Ind Sg P1) => ro_ + "mperé" ;
    VP (Fut Ind Sg P2) => ro_ + "mperás" ;
    VP (Fut Ind Sg P3) => ro_ + "mperá" ;
    VP (Fut Ind Pl P1) => ro_ + "mperemos" ;
    VP (Fut Ind Pl P2) => ro_ + "mperéis" ;
    VP (Fut Ind Pl P3) => ro_ + "mperán" ;
    VP (Fut Subj Sg P1) => ro_ + "mpiere" ;
    VP (Fut Subj Sg P2) => ro_ + "mpieres" ;
    VP (Fut Subj Sg P3) => ro_ + "mpiere" ;
    VP (Fut Subj Pl P1) => ro_ + "mpiéremos" ;
    VP (Fut Subj Pl P2) => ro_ + "mpiereis" ;
    VP (Fut Subj Pl P3) => ro_ + "mpieren" ;
    VP (Cond Sg P1) => ro_ + "mpería" ;
    VP (Cond Sg P2) => ro_ + "mperías" ;
    VP (Cond Sg P3) => ro_ + "mpería" ;
    VP (Cond Pl P1) => ro_ + "mperíamos" ;
    VP (Cond Pl P2) => ro_ + "mperíais" ;
    VP (Cond Pl P3) => ro_ + "mperían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => ro_ + "mpe" ;
    VP (Imp Sg P3) => ro_ + "mpa" ;
    VP (Imp Pl P1) => ro_ + "mpamos" ;
    VP (Imp Pl P2) => ro_ + "mped" ;
    VP (Imp Pl P3) => ro_ + "mpan" ;
    VP (Pass Sg Masc) => ro_ + "to" ;
    VP (Pass Sg Fem) => ro_ + "ta" ;
    VP (Pass Pl Masc) => ro_ + "tos" ;
    VP (Pass Pl Fem) => ro_ + "tas"
    }
  } ;

oper adir_14 : Str -> Verbum = \adir -> 
  let adir_ = Predef.tk 0 adir in
 {s = table {
    VI Infn=> adir_ + "" ;
    VI Ger => variants {} ;
    VI Part => variants {} ;
    VP (Pres Ind Sg P1) => variants {} ;
    VP (Pres Ind Sg P2) => variants {} ;
    VP (Pres Ind Sg P3) => variants {} ;
    VP (Pres Ind Pl P1) => variants {} ;
    VP (Pres Ind Pl P2) => variants {} ;
    VP (Pres Ind Pl P3) => variants {} ;
    VP (Pres Subj Sg P1) => variants {} ;
    VP (Pres Subj Sg P2) => variants {} ;
    VP (Pres Subj Sg P3) => variants {} ;
    VP (Pres Subj Pl P1) => variants {} ;
    VP (Pres Subj Pl P2) => variants {} ;
    VP (Pres Subj Pl P3) => variants {} ;
    VP (Past Ind Sg P1) => variants {} ;
    VP (Past Ind Sg P2) => variants {} ;
    VP (Past Ind Sg P3) => variants {} ;
    VP (Past Ind Pl P1) => variants {} ;
    VP (Past Ind Pl P2) => variants {} ;
    VP (Past Ind Pl P3) => variants {} ;
    VP (Past Subj Sg P1) => variants {} ;
    VP (Past Subj Sg P2) => variants {} ;
    VP (Past Subj Sg P3) => variants {} ;
    VP (Past Subj Pl P1) => variants {} ;
    VP (Past Subj Pl P2) => variants {} ;
    VP (Past Subj Pl P3) => variants {} ;
    VP (Pret Sg P1) => variants {} ;
    VP (Pret Sg P2) => variants {} ;
    VP (Pret Sg P3) => variants {} ;
    VP (Pret Pl P1) => variants {} ;
    VP (Pret Pl P2) => variants {} ;
    VP (Pret Pl P3) => variants {} ;
    VP (Fut Ind Sg P1) => variants {} ;
    VP (Fut Ind Sg P2) => variants {} ;
    VP (Fut Ind Sg P3) => variants {} ;
    VP (Fut Ind Pl P1) => variants {} ;
    VP (Fut Ind Pl P2) => variants {} ;
    VP (Fut Ind Pl P3) => variants {} ;
    VP (Fut Subj Sg P1) => variants {} ;
    VP (Fut Subj Sg P2) => variants {} ;
    VP (Fut Subj Sg P3) => variants {} ;
    VP (Fut Subj Pl P1) => variants {} ;
    VP (Fut Subj Pl P2) => variants {} ;
    VP (Fut Subj Pl P3) => variants {} ;
    VP (Cond Sg P1) => variants {} ;
    VP (Cond Sg P2) => variants {} ;
    VP (Cond Sg P3) => variants {} ;
    VP (Cond Pl P1) => variants {} ;
    VP (Cond Pl P2) => variants {} ;
    VP (Cond Pl P3) => variants {} ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => variants {} ;
    VP (Imp Sg P3) => variants {} ;
    VP (Imp Pl P1) => variants {} ;
    VP (Imp Pl P2) => variants {} ;
    VP (Imp Pl P3) => variants {} ;
    VP (Pass Sg Masc) => variants {} ;
    VP (Pass Sg Fem) => variants {} ;
    VP (Pass Pl Masc) => variants {} ;
    VP (Pass Pl Fem) => variants {}
    }
  } ;

oper abrir_15 : Str -> Verbum = \abrir -> 
  let ab_ = Predef.tk 3 abrir in
 {s = table {
    VI Infn=> ab_ + "rir" ;
    VI Ger => ab_ + "riendo" ;
    VI Part => ab_ + "ierto" ;
    VP (Pres Ind Sg P1) => ab_ + "ro" ;
    VP (Pres Ind Sg P2) => ab_ + "res" ;
    VP (Pres Ind Sg P3) => ab_ + "re" ;
    VP (Pres Ind Pl P1) => ab_ + "rimos" ;
    VP (Pres Ind Pl P2) => ab_ + "rís" ;
    VP (Pres Ind Pl P3) => ab_ + "ren" ;
    VP (Pres Subj Sg P1) => ab_ + "ra" ;
    VP (Pres Subj Sg P2) => ab_ + "ras" ;
    VP (Pres Subj Sg P3) => ab_ + "ra" ;
    VP (Pres Subj Pl P1) => ab_ + "ramos" ;
    VP (Pres Subj Pl P2) => ab_ + "ráis" ;
    VP (Pres Subj Pl P3) => ab_ + "ran" ;
    VP (Past Ind Sg P1) => ab_ + "ría" ;
    VP (Past Ind Sg P2) => ab_ + "rías" ;
    VP (Past Ind Sg P3) => ab_ + "ría" ;
    VP (Past Ind Pl P1) => ab_ + "ríamos" ;
    VP (Past Ind Pl P2) => ab_ + "ríais" ;
    VP (Past Ind Pl P3) => ab_ + "rían" ;
    VP (Past Subj Sg P1) => variants {ab_ + "riera" ; ab_ + "riese"} ;
    VP (Past Subj Sg P2) => variants {ab_ + "rieras" ; ab_ + "rieses"} ;
    VP (Past Subj Sg P3) => variants {ab_ + "riera" ; ab_ + "riese"} ;
    VP (Past Subj Pl P1) => variants {ab_ + "riéramos" ; ab_ + "riésemos"} ;
    VP (Past Subj Pl P2) => variants {ab_ + "rierais" ; ab_ + "rieseis"} ;
    VP (Past Subj Pl P3) => variants {ab_ + "rieran" ; ab_ + "riesen"} ;
    VP (Pret Sg P1) => ab_ + "rí" ;
    VP (Pret Sg P2) => ab_ + "riste" ;
    VP (Pret Sg P3) => ab_ + "rió" ;
    VP (Pret Pl P1) => ab_ + "rimos" ;
    VP (Pret Pl P2) => ab_ + "risteis" ;
    VP (Pret Pl P3) => ab_ + "rieron" ;
    VP (Fut Ind Sg P1) => ab_ + "riré" ;
    VP (Fut Ind Sg P2) => ab_ + "rirás" ;
    VP (Fut Ind Sg P3) => ab_ + "rirá" ;
    VP (Fut Ind Pl P1) => ab_ + "riremos" ;
    VP (Fut Ind Pl P2) => ab_ + "riréis" ;
    VP (Fut Ind Pl P3) => ab_ + "rirán" ;
    VP (Fut Subj Sg P1) => ab_ + "riere" ;
    VP (Fut Subj Sg P2) => ab_ + "rieres" ;
    VP (Fut Subj Sg P3) => ab_ + "riere" ;
    VP (Fut Subj Pl P1) => ab_ + "riéremos" ;
    VP (Fut Subj Pl P2) => ab_ + "riereis" ;
    VP (Fut Subj Pl P3) => ab_ + "rieren" ;
    VP (Cond Sg P1) => ab_ + "riría" ;
    VP (Cond Sg P2) => ab_ + "rirías" ;
    VP (Cond Sg P3) => ab_ + "riría" ;
    VP (Cond Pl P1) => ab_ + "riríamos" ;
    VP (Cond Pl P2) => ab_ + "riríais" ;
    VP (Cond Pl P3) => ab_ + "rirían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => ab_ + "re" ;
    VP (Imp Sg P3) => ab_ + "ra" ;
    VP (Imp Pl P1) => ab_ + "ramos" ;
    VP (Imp Pl P2) => ab_ + "rid" ;
    VP (Imp Pl P3) => ab_ + "ran" ;
    VP (Pass Sg Masc) => ab_ + "rido" ;
    VP (Pass Sg Fem) => ab_ + "rida" ;
    VP (Pass Pl Masc) => ab_ + "ridos" ;
    VP (Pass Pl Fem) => ab_ + "ridas"
    }
  } ;

oper abolir_16 : Str -> Verbum = \abolir -> 
  let abol_ = Predef.tk 2 abolir in
 {s = table {
    VI Infn=> abol_ + "ir" ;
    VI Ger => abol_ + "iendo" ;
    VI Part => abol_ + "ido" ;
    VP (Pres Ind Sg P1) => variants {} ;
    VP (Pres Ind Sg P2) => variants {} ;
    VP (Pres Ind Sg P3) => variants {} ;
    VP (Pres Ind Pl P1) => abol_ + "imos" ;
    VP (Pres Ind Pl P2) => abol_ + "ís" ;
    VP (Pres Ind Pl P3) => variants {} ;
    VP (Pres Subj Sg P1) => variants {} ;
    VP (Pres Subj Sg P2) => variants {} ;
    VP (Pres Subj Sg P3) => variants {} ;
    VP (Pres Subj Pl P1) => variants {} ;
    VP (Pres Subj Pl P2) => variants {} ;
    VP (Pres Subj Pl P3) => variants {} ;
    VP (Past Ind Sg P1) => abol_ + "ía" ;
    VP (Past Ind Sg P2) => abol_ + "ías" ;
    VP (Past Ind Sg P3) => abol_ + "ía" ;
    VP (Past Ind Pl P1) => abol_ + "íamos" ;
    VP (Past Ind Pl P2) => abol_ + "íais" ;
    VP (Past Ind Pl P3) => abol_ + "ían" ;
    VP (Past Subj Sg P1) => variants {abol_ + "iera" ; abol_ + "iese"} ;
    VP (Past Subj Sg P2) => variants {abol_ + "ieras" ; abol_ + "ieses"} ;
    VP (Past Subj Sg P3) => variants {abol_ + "iera" ; abol_ + "iese"} ;
    VP (Past Subj Pl P1) => variants {abol_ + "iéramos" ; abol_ + "iésemos"} ;
    VP (Past Subj Pl P2) => variants {abol_ + "ierais" ; abol_ + "ieseis"} ;
    VP (Past Subj Pl P3) => variants {abol_ + "ieran" ; abol_ + "iesen"} ;
    VP (Pret Sg P1) => abol_ + "í" ;
    VP (Pret Sg P2) => abol_ + "iste" ;
    VP (Pret Sg P3) => abol_ + "ió" ;
    VP (Pret Pl P1) => abol_ + "imos" ;
    VP (Pret Pl P2) => abol_ + "isteis" ;
    VP (Pret Pl P3) => abol_ + "ieron" ;
    VP (Fut Ind Sg P1) => abol_ + "iré" ;
    VP (Fut Ind Sg P2) => abol_ + "irás" ;
    VP (Fut Ind Sg P3) => abol_ + "irá" ;
    VP (Fut Ind Pl P1) => abol_ + "iremos" ;
    VP (Fut Ind Pl P2) => abol_ + "iréis" ;
    VP (Fut Ind Pl P3) => abol_ + "irán" ;
    VP (Fut Subj Sg P1) => abol_ + "iere" ;
    VP (Fut Subj Sg P2) => abol_ + "ieres" ;
    VP (Fut Subj Sg P3) => abol_ + "iere" ;
    VP (Fut Subj Pl P1) => abol_ + "iéremos" ;
    VP (Fut Subj Pl P2) => abol_ + "iereis" ;
    VP (Fut Subj Pl P3) => abol_ + "ieren" ;
    VP (Cond Sg P1) => abol_ + "iría" ;
    VP (Cond Sg P2) => abol_ + "irías" ;
    VP (Cond Sg P3) => abol_ + "iría" ;
    VP (Cond Pl P1) => abol_ + "iríamos" ;
    VP (Cond Pl P2) => abol_ + "iríais" ;
    VP (Cond Pl P3) => abol_ + "irían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => variants {} ;
    VP (Imp Sg P3) => variants {} ;
    VP (Imp Pl P1) => variants {} ;
    VP (Imp Pl P2) => abol_ + "id" ;
    VP (Imp Pl P3) => variants {} ;
    VP (Pass Sg Masc) => abol_ + "ido" ;
    VP (Pass Sg Fem) => abol_ + "ida" ;
    VP (Pass Pl Masc) => abol_ + "idos" ;
    VP (Pass Pl Fem) => abol_ + "idas"
    }
  } ;

oper ahincar_17 : Str -> Verbum = \ahincar -> 
  let ah_ = Predef.tk 5 ahincar in
 {s = table {
    VI Infn=> ah_ + "incar" ;
    VI Ger => ah_ + "incando" ;
    VI Part => ah_ + "incado" ;
    VP (Pres Ind Sg P1) => ah_ + "ínco" ;
    VP (Pres Ind Sg P2) => ah_ + "íncas" ;
    VP (Pres Ind Sg P3) => ah_ + "ínca" ;
    VP (Pres Ind Pl P1) => ah_ + "incamos" ;
    VP (Pres Ind Pl P2) => ah_ + "incáis" ;
    VP (Pres Ind Pl P3) => ah_ + "íncan" ;
    VP (Pres Subj Sg P1) => ah_ + "ínque" ;
    VP (Pres Subj Sg P2) => ah_ + "ínques" ;
    VP (Pres Subj Sg P3) => ah_ + "ínque" ;
    VP (Pres Subj Pl P1) => ah_ + "inquemos" ;
    VP (Pres Subj Pl P2) => ah_ + "inquéis" ;
    VP (Pres Subj Pl P3) => ah_ + "ínquen" ;
    VP (Past Ind Sg P1) => ah_ + "incaba" ;
    VP (Past Ind Sg P2) => ah_ + "incabas" ;
    VP (Past Ind Sg P3) => ah_ + "incaba" ;
    VP (Past Ind Pl P1) => ah_ + "incábamos" ;
    VP (Past Ind Pl P2) => ah_ + "incabais" ;
    VP (Past Ind Pl P3) => ah_ + "incaban" ;
    VP (Past Subj Sg P1) => variants {ah_ + "incara" ; ah_ + "incase"} ;
    VP (Past Subj Sg P2) => variants {ah_ + "incaras" ; ah_ + "incases"} ;
    VP (Past Subj Sg P3) => variants {ah_ + "incara" ; ah_ + "incase"} ;
    VP (Past Subj Pl P1) => variants {ah_ + "incáramos" ; ah_ + "incásemos"} ;
    VP (Past Subj Pl P2) => variants {ah_ + "incarais" ; ah_ + "incaseis"} ;
    VP (Past Subj Pl P3) => variants {ah_ + "incaran" ; ah_ + "incasen"} ;
    VP (Pret Sg P1) => ah_ + "inqué" ;
    VP (Pret Sg P2) => ah_ + "incaste" ;
    VP (Pret Sg P3) => ah_ + "incó" ;
    VP (Pret Pl P1) => ah_ + "incamos" ;
    VP (Pret Pl P2) => ah_ + "incasteis" ;
    VP (Pret Pl P3) => ah_ + "incaron" ;
    VP (Fut Ind Sg P1) => ah_ + "incaré" ;
    VP (Fut Ind Sg P2) => ah_ + "incarás" ;
    VP (Fut Ind Sg P3) => ah_ + "incará" ;
    VP (Fut Ind Pl P1) => ah_ + "incaremos" ;
    VP (Fut Ind Pl P2) => ah_ + "incaréis" ;
    VP (Fut Ind Pl P3) => ah_ + "incarán" ;
    VP (Fut Subj Sg P1) => ah_ + "incare" ;
    VP (Fut Subj Sg P2) => ah_ + "incares" ;
    VP (Fut Subj Sg P3) => ah_ + "incare" ;
    VP (Fut Subj Pl P1) => ah_ + "incáremos" ;
    VP (Fut Subj Pl P2) => ah_ + "incareis" ;
    VP (Fut Subj Pl P3) => ah_ + "incaren" ;
    VP (Cond Sg P1) => ah_ + "incaría" ;
    VP (Cond Sg P2) => ah_ + "incarías" ;
    VP (Cond Sg P3) => ah_ + "incaría" ;
    VP (Cond Pl P1) => ah_ + "incaríamos" ;
    VP (Cond Pl P2) => ah_ + "incaríais" ;
    VP (Cond Pl P3) => ah_ + "incarían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => ah_ + "ínca" ;
    VP (Imp Sg P3) => ah_ + "ínque" ;
    VP (Imp Pl P1) => ah_ + "inquemos" ;
    VP (Imp Pl P2) => ah_ + "incad" ;
    VP (Imp Pl P3) => ah_ + "ínquen" ;
    VP (Pass Sg Masc) => ah_ + "incado" ;
    VP (Pass Sg Fem) => ah_ + "incada" ;
    VP (Pass Pl Masc) => ah_ + "incados" ;
    VP (Pass Pl Fem) => ah_ + "incadas"
    }
  } ;

oper andar_18 : Str -> Verbum = \andar -> 
  let and_ = Predef.tk 2 andar in
 {s = table {
    VI Infn=> and_ + "ar" ;
    VI Ger => and_ + "ando" ;
    VI Part => and_ + "ado" ;
    VP (Pres Ind Sg P1) => and_ + "o" ;
    VP (Pres Ind Sg P2) => and_ + "as" ;
    VP (Pres Ind Sg P3) => and_ + "a" ;
    VP (Pres Ind Pl P1) => and_ + "amos" ;
    VP (Pres Ind Pl P2) => and_ + "áis" ;
    VP (Pres Ind Pl P3) => and_ + "an" ;
    VP (Pres Subj Sg P1) => and_ + "e" ;
    VP (Pres Subj Sg P2) => and_ + "es" ;
    VP (Pres Subj Sg P3) => and_ + "e" ;
    VP (Pres Subj Pl P1) => and_ + "emos" ;
    VP (Pres Subj Pl P2) => and_ + "éis" ;
    VP (Pres Subj Pl P3) => and_ + "en" ;
    VP (Past Ind Sg P1) => and_ + "aba" ;
    VP (Past Ind Sg P2) => and_ + "abas" ;
    VP (Past Ind Sg P3) => and_ + "aba" ;
    VP (Past Ind Pl P1) => and_ + "ábamos" ;
    VP (Past Ind Pl P2) => and_ + "abais" ;
    VP (Past Ind Pl P3) => and_ + "aban" ;
    VP (Past Subj Sg P1) => variants {and_ + "uviera" ; and_ + "uviese"} ;
    VP (Past Subj Sg P2) => variants {and_ + "uvieras" ; and_ + "uvieses"} ;
    VP (Past Subj Sg P3) => variants {and_ + "uviera" ; and_ + "uviese"} ;
    VP (Past Subj Pl P1) => variants {and_ + "uviéramos" ; and_ + "uviésemos"} ;
    VP (Past Subj Pl P2) => variants {and_ + "uvierais" ; and_ + "uvieseis"} ;
    VP (Past Subj Pl P3) => variants {and_ + "uvieran" ; and_ + "uviesen"} ;
    VP (Pret Sg P1) => and_ + "uve" ;
    VP (Pret Sg P2) => and_ + "uviste" ;
    VP (Pret Sg P3) => and_ + "uvo" ;
    VP (Pret Pl P1) => and_ + "uvimos" ;
    VP (Pret Pl P2) => and_ + "uvisteis" ;
    VP (Pret Pl P3) => and_ + "uvieron" ;
    VP (Fut Ind Sg P1) => and_ + "aré" ;
    VP (Fut Ind Sg P2) => and_ + "arás" ;
    VP (Fut Ind Sg P3) => and_ + "ará" ;
    VP (Fut Ind Pl P1) => and_ + "aremos" ;
    VP (Fut Ind Pl P2) => and_ + "aréis" ;
    VP (Fut Ind Pl P3) => and_ + "arán" ;
    VP (Fut Subj Sg P1) => and_ + "uviere" ;
    VP (Fut Subj Sg P2) => and_ + "uvieres" ;
    VP (Fut Subj Sg P3) => and_ + "uviere" ;
    VP (Fut Subj Pl P1) => and_ + "uviéremos" ;
    VP (Fut Subj Pl P2) => and_ + "uviereis" ;
    VP (Fut Subj Pl P3) => and_ + "uvieren" ;
    VP (Cond Sg P1) => and_ + "aría" ;
    VP (Cond Sg P2) => and_ + "arías" ;
    VP (Cond Sg P3) => and_ + "aría" ;
    VP (Cond Pl P1) => and_ + "aríamos" ;
    VP (Cond Pl P2) => and_ + "aríais" ;
    VP (Cond Pl P3) => and_ + "arían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => and_ + "a" ;
    VP (Imp Sg P3) => and_ + "e" ;
    VP (Imp Pl P1) => and_ + "emos" ;
    VP (Imp Pl P2) => and_ + "ad" ;
    VP (Imp Pl P3) => and_ + "en" ;
    VP (Pass Sg Masc) => and_ + "ado" ;
    VP (Pass Sg Fem) => and_ + "ada" ;
    VP (Pass Pl Masc) => and_ + "ados" ;
    VP (Pass Pl Fem) => and_ + "adas"
    }
  } ;

oper astriñir_19 : Str -> Verbum = \astriñir -> 
  let astriñ_ = Predef.tk 2 astriñir in
 {s = table {
    VI Infn=> astriñ_ + "ir" ;
    VI Ger => astriñ_ + "endo" ;
    VI Part => astriñ_ + "ido" ;
    VP (Pres Ind Sg P1) => astriñ_ + "o" ;
    VP (Pres Ind Sg P2) => astriñ_ + "es" ;
    VP (Pres Ind Sg P3) => astriñ_ + "e" ;
    VP (Pres Ind Pl P1) => astriñ_ + "imos" ;
    VP (Pres Ind Pl P2) => astriñ_ + "ís" ;
    VP (Pres Ind Pl P3) => astriñ_ + "en" ;
    VP (Pres Subj Sg P1) => astriñ_ + "a" ;
    VP (Pres Subj Sg P2) => astriñ_ + "as" ;
    VP (Pres Subj Sg P3) => astriñ_ + "a" ;
    VP (Pres Subj Pl P1) => astriñ_ + "amos" ;
    VP (Pres Subj Pl P2) => astriñ_ + "áis" ;
    VP (Pres Subj Pl P3) => astriñ_ + "an" ;
    VP (Past Ind Sg P1) => astriñ_ + "ía" ;
    VP (Past Ind Sg P2) => astriñ_ + "ías" ;
    VP (Past Ind Sg P3) => astriñ_ + "ía" ;
    VP (Past Ind Pl P1) => astriñ_ + "íamos" ;
    VP (Past Ind Pl P2) => astriñ_ + "íais" ;
    VP (Past Ind Pl P3) => astriñ_ + "ían" ;
    VP (Past Subj Sg P1) => variants {astriñ_ + "era" ; astriñ_ + "ese"} ;
    VP (Past Subj Sg P2) => variants {astriñ_ + "eras" ; astriñ_ + "eses"} ;
    VP (Past Subj Sg P3) => variants {astriñ_ + "era" ; astriñ_ + "ese"} ;
    VP (Past Subj Pl P1) => variants {astriñ_ + "éramos" ; astriñ_ + "ésemos"} ;
    VP (Past Subj Pl P2) => variants {astriñ_ + "erais" ; astriñ_ + "eseis"} ;
    VP (Past Subj Pl P3) => variants {astriñ_ + "eran" ; astriñ_ + "esen"} ;
    VP (Pret Sg P1) => astriñ_ + "í" ;
    VP (Pret Sg P2) => astriñ_ + "iste" ;
    VP (Pret Sg P3) => astriñ_ + "ó" ;
    VP (Pret Pl P1) => astriñ_ + "imos" ;
    VP (Pret Pl P2) => astriñ_ + "isteis" ;
    VP (Pret Pl P3) => astriñ_ + "eron" ;
    VP (Fut Ind Sg P1) => astriñ_ + "iré" ;
    VP (Fut Ind Sg P2) => astriñ_ + "irás" ;
    VP (Fut Ind Sg P3) => astriñ_ + "irá" ;
    VP (Fut Ind Pl P1) => astriñ_ + "iremos" ;
    VP (Fut Ind Pl P2) => astriñ_ + "iréis" ;
    VP (Fut Ind Pl P3) => astriñ_ + "irán" ;
    VP (Fut Subj Sg P1) => astriñ_ + "ere" ;
    VP (Fut Subj Sg P2) => astriñ_ + "eres" ;
    VP (Fut Subj Sg P3) => astriñ_ + "ere" ;
    VP (Fut Subj Pl P1) => astriñ_ + "éremos" ;
    VP (Fut Subj Pl P2) => astriñ_ + "ereis" ;
    VP (Fut Subj Pl P3) => astriñ_ + "eren" ;
    VP (Cond Sg P1) => astriñ_ + "iría" ;
    VP (Cond Sg P2) => astriñ_ + "irías" ;
    VP (Cond Sg P3) => astriñ_ + "iría" ;
    VP (Cond Pl P1) => astriñ_ + "iríamos" ;
    VP (Cond Pl P2) => astriñ_ + "iríais" ;
    VP (Cond Pl P3) => astriñ_ + "irían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => astriñ_ + "e" ;
    VP (Imp Sg P3) => astriñ_ + "a" ;
    VP (Imp Pl P1) => astriñ_ + "amos" ;
    VP (Imp Pl P2) => astriñ_ + "id" ;
    VP (Imp Pl P3) => astriñ_ + "an" ;
    VP (Pass Sg Masc) => astriñ_ + "ido" ;
    VP (Pass Sg Fem) => astriñ_ + "ida" ;
    VP (Pass Pl Masc) => astriñ_ + "idos" ;
    VP (Pass Pl Fem) => astriñ_ + "idas"
    }
  } ;

oper abstraer_20 : Str -> Verbum = \abstraer -> 
  let abstra_ = Predef.tk 2 abstraer in
 {s = table {
    VI Infn=> abstra_ + "er" ;
    VI Ger => abstra_ + "yendo" ;
    VI Part => abstra_ + "ído" ;
    VP (Pres Ind Sg P1) => abstra_ + "o" ;
    VP (Pres Ind Sg P2) => abstra_ + "es" ;
    VP (Pres Ind Sg P3) => abstra_ + "e" ;
    VP (Pres Ind Pl P1) => abstra_ + "emos" ;
    VP (Pres Ind Pl P2) => abstra_ + "éis" ;
    VP (Pres Ind Pl P3) => abstra_ + "en" ;
    VP (Pres Subj Sg P1) => abstra_ + "a" ;
    VP (Pres Subj Sg P2) => abstra_ + "as" ;
    VP (Pres Subj Sg P3) => abstra_ + "a" ;
    VP (Pres Subj Pl P1) => abstra_ + "amos" ;
    VP (Pres Subj Pl P2) => abstra_ + "áis" ;
    VP (Pres Subj Pl P3) => abstra_ + "an" ;
    VP (Past Ind Sg P1) => abstra_ + "ía" ;
    VP (Past Ind Sg P2) => abstra_ + "ías" ;
    VP (Past Ind Sg P3) => abstra_ + "ía" ;
    VP (Past Ind Pl P1) => abstra_ + "íamos" ;
    VP (Past Ind Pl P2) => abstra_ + "íais" ;
    VP (Past Ind Pl P3) => abstra_ + "ían" ;
    VP (Past Subj Sg P1) => variants {abstra_ + "yera" ; abstra_ + "yese"} ;
    VP (Past Subj Sg P2) => variants {abstra_ + "yeras" ; abstra_ + "yeses"} ;
    VP (Past Subj Sg P3) => variants {abstra_ + "yera" ; abstra_ + "yese"} ;
    VP (Past Subj Pl P1) => variants {abstra_ + "yéramos" ; abstra_ + "yésemos"} ;
    VP (Past Subj Pl P2) => variants {abstra_ + "yerais" ; abstra_ + "yeseis"} ;
    VP (Past Subj Pl P3) => variants {abstra_ + "yeran" ; abstra_ + "yesen"} ;
    VP (Pret Sg P1) => abstra_ + "í" ;
    VP (Pret Sg P2) => abstra_ + "íste" ;
    VP (Pret Sg P3) => abstra_ + "yó" ;
    VP (Pret Pl P1) => abstra_ + "ímos" ;
    VP (Pret Pl P2) => abstra_ + "ísteis" ;
    VP (Pret Pl P3) => abstra_ + "yeron" ;
    VP (Fut Ind Sg P1) => abstra_ + "eré" ;
    VP (Fut Ind Sg P2) => abstra_ + "erás" ;
    VP (Fut Ind Sg P3) => abstra_ + "erá" ;
    VP (Fut Ind Pl P1) => abstra_ + "eremos" ;
    VP (Fut Ind Pl P2) => abstra_ + "eréis" ;
    VP (Fut Ind Pl P3) => abstra_ + "erán" ;
    VP (Fut Subj Sg P1) => abstra_ + "yere" ;
    VP (Fut Subj Sg P2) => abstra_ + "yeres" ;
    VP (Fut Subj Sg P3) => abstra_ + "yere" ;
    VP (Fut Subj Pl P1) => abstra_ + "yéremos" ;
    VP (Fut Subj Pl P2) => abstra_ + "yereis" ;
    VP (Fut Subj Pl P3) => abstra_ + "yeren" ;
    VP (Cond Sg P1) => abstra_ + "ería" ;
    VP (Cond Sg P2) => abstra_ + "erías" ;
    VP (Cond Sg P3) => abstra_ + "ería" ;
    VP (Cond Pl P1) => abstra_ + "eríamos" ;
    VP (Cond Pl P2) => abstra_ + "eríais" ;
    VP (Cond Pl P3) => abstra_ + "erían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => abstra_ + "e" ;
    VP (Imp Sg P3) => abstra_ + "a" ;
    VP (Imp Pl P1) => abstra_ + "amos" ;
    VP (Imp Pl P2) => abstra_ + "ed" ;
    VP (Imp Pl P3) => abstra_ + "an" ;
    VP (Pass Sg Masc) => abstra_ + "ído" ;
    VP (Pass Sg Fem) => abstra_ + "ída" ;
    VP (Pass Pl Masc) => abstra_ + "ídos" ;
    VP (Pass Pl Fem) => abstra_ + "ídas"
    }
  } ;

oper cocer_21 : Str -> Verbum = \cocer -> 
  let c_ = Predef.tk 4 cocer in
 {s = table {
    VI Infn=> c_ + "ocer" ;
    VI Ger => c_ + "ociendo" ;
    VI Part => c_ + "ocido" ;
    VP (Pres Ind Sg P1) => c_ + "uezo" ;
    VP (Pres Ind Sg P2) => c_ + "ueces" ;
    VP (Pres Ind Sg P3) => c_ + "uece" ;
    VP (Pres Ind Pl P1) => c_ + "ocemos" ;
    VP (Pres Ind Pl P2) => c_ + "océis" ;
    VP (Pres Ind Pl P3) => c_ + "uecen" ;
    VP (Pres Subj Sg P1) => c_ + "ueza" ;
    VP (Pres Subj Sg P2) => c_ + "uezas" ;
    VP (Pres Subj Sg P3) => c_ + "ueza" ;
    VP (Pres Subj Pl P1) => c_ + "ozamos" ;
    VP (Pres Subj Pl P2) => c_ + "ozáis" ;
    VP (Pres Subj Pl P3) => c_ + "uezan" ;
    VP (Past Ind Sg P1) => c_ + "ocía" ;
    VP (Past Ind Sg P2) => c_ + "ocías" ;
    VP (Past Ind Sg P3) => c_ + "ocía" ;
    VP (Past Ind Pl P1) => c_ + "ocíamos" ;
    VP (Past Ind Pl P2) => c_ + "ocíais" ;
    VP (Past Ind Pl P3) => c_ + "ocían" ;
    VP (Past Subj Sg P1) => variants {c_ + "ociera" ; c_ + "ociese"} ;
    VP (Past Subj Sg P2) => variants {c_ + "ocieras" ; c_ + "ocieses"} ;
    VP (Past Subj Sg P3) => variants {c_ + "ociera" ; c_ + "ociese"} ;
    VP (Past Subj Pl P1) => variants {c_ + "ociéramos" ; c_ + "ociésemos"} ;
    VP (Past Subj Pl P2) => variants {c_ + "ocierais" ; c_ + "ocieseis"} ;
    VP (Past Subj Pl P3) => variants {c_ + "ocieran" ; c_ + "ociesen"} ;
    VP (Pret Sg P1) => c_ + "ocí" ;
    VP (Pret Sg P2) => c_ + "ociste" ;
    VP (Pret Sg P3) => c_ + "oció" ;
    VP (Pret Pl P1) => c_ + "ocimos" ;
    VP (Pret Pl P2) => c_ + "ocisteis" ;
    VP (Pret Pl P3) => c_ + "ocieron" ;
    VP (Fut Ind Sg P1) => c_ + "oceré" ;
    VP (Fut Ind Sg P2) => c_ + "ocerás" ;
    VP (Fut Ind Sg P3) => c_ + "ocerá" ;
    VP (Fut Ind Pl P1) => c_ + "oceremos" ;
    VP (Fut Ind Pl P2) => c_ + "oceréis" ;
    VP (Fut Ind Pl P3) => c_ + "ocerán" ;
    VP (Fut Subj Sg P1) => c_ + "ociere" ;
    VP (Fut Subj Sg P2) => c_ + "ocieres" ;
    VP (Fut Subj Sg P3) => c_ + "ociere" ;
    VP (Fut Subj Pl P1) => c_ + "ociéremos" ;
    VP (Fut Subj Pl P2) => c_ + "ociereis" ;
    VP (Fut Subj Pl P3) => c_ + "ocieren" ;
    VP (Cond Sg P1) => c_ + "ocería" ;
    VP (Cond Sg P2) => c_ + "ocerías" ;
    VP (Cond Sg P3) => c_ + "ocería" ;
    VP (Cond Pl P1) => c_ + "oceríamos" ;
    VP (Cond Pl P2) => c_ + "oceríais" ;
    VP (Cond Pl P3) => c_ + "ocerían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => c_ + "uece" ;
    VP (Imp Sg P3) => c_ + "ueza" ;
    VP (Imp Pl P1) => c_ + "ozamos" ;
    VP (Imp Pl P2) => c_ + "oced" ;
    VP (Imp Pl P3) => c_ + "uezan" ;
    VP (Pass Sg Masc) => c_ + "ocido" ;
    VP (Pass Sg Fem) => c_ + "ocida" ;
    VP (Pass Pl Masc) => c_ + "ocidos" ;
    VP (Pass Pl Fem) => c_ + "ocidas"
    }
  } ;

oper abnegar_22 : Str -> Verbum = \abnegar -> 
  let abn_ = Predef.tk 4 abnegar in
 {s = table {
    VI Infn=> abn_ + "egar" ;
    VI Ger => abn_ + "egando" ;
    VI Part => abn_ + "egado" ;
    VP (Pres Ind Sg P1) => abn_ + "iego" ;
    VP (Pres Ind Sg P2) => abn_ + "iegas" ;
    VP (Pres Ind Sg P3) => abn_ + "iega" ;
    VP (Pres Ind Pl P1) => abn_ + "egamos" ;
    VP (Pres Ind Pl P2) => abn_ + "egáis" ;
    VP (Pres Ind Pl P3) => abn_ + "iegan" ;
    VP (Pres Subj Sg P1) => abn_ + "iegue" ;
    VP (Pres Subj Sg P2) => abn_ + "iegues" ;
    VP (Pres Subj Sg P3) => abn_ + "iegue" ;
    VP (Pres Subj Pl P1) => abn_ + "eguemos" ;
    VP (Pres Subj Pl P2) => abn_ + "eguéis" ;
    VP (Pres Subj Pl P3) => abn_ + "ieguen" ;
    VP (Past Ind Sg P1) => abn_ + "egaba" ;
    VP (Past Ind Sg P2) => abn_ + "egabas" ;
    VP (Past Ind Sg P3) => abn_ + "egaba" ;
    VP (Past Ind Pl P1) => abn_ + "egábamos" ;
    VP (Past Ind Pl P2) => abn_ + "egabais" ;
    VP (Past Ind Pl P3) => abn_ + "egaban" ;
    VP (Past Subj Sg P1) => variants {abn_ + "egara" ; abn_ + "egase"} ;
    VP (Past Subj Sg P2) => variants {abn_ + "egaras" ; abn_ + "egases"} ;
    VP (Past Subj Sg P3) => variants {abn_ + "egara" ; abn_ + "egase"} ;
    VP (Past Subj Pl P1) => variants {abn_ + "egáramos" ; abn_ + "egásemos"} ;
    VP (Past Subj Pl P2) => variants {abn_ + "egarais" ; abn_ + "egaseis"} ;
    VP (Past Subj Pl P3) => variants {abn_ + "egaran" ; abn_ + "egasen"} ;
    VP (Pret Sg P1) => abn_ + "egué" ;
    VP (Pret Sg P2) => abn_ + "egaste" ;
    VP (Pret Sg P3) => abn_ + "egó" ;
    VP (Pret Pl P1) => abn_ + "egamos" ;
    VP (Pret Pl P2) => abn_ + "egasteis" ;
    VP (Pret Pl P3) => abn_ + "egaron" ;
    VP (Fut Ind Sg P1) => abn_ + "egaré" ;
    VP (Fut Ind Sg P2) => abn_ + "egarás" ;
    VP (Fut Ind Sg P3) => abn_ + "egará" ;
    VP (Fut Ind Pl P1) => abn_ + "egaremos" ;
    VP (Fut Ind Pl P2) => abn_ + "egaréis" ;
    VP (Fut Ind Pl P3) => abn_ + "egarán" ;
    VP (Fut Subj Sg P1) => abn_ + "egare" ;
    VP (Fut Subj Sg P2) => abn_ + "egares" ;
    VP (Fut Subj Sg P3) => abn_ + "egare" ;
    VP (Fut Subj Pl P1) => abn_ + "egáremos" ;
    VP (Fut Subj Pl P2) => abn_ + "egareis" ;
    VP (Fut Subj Pl P3) => abn_ + "egaren" ;
    VP (Cond Sg P1) => abn_ + "egaría" ;
    VP (Cond Sg P2) => abn_ + "egarías" ;
    VP (Cond Sg P3) => abn_ + "egaría" ;
    VP (Cond Pl P1) => abn_ + "egaríamos" ;
    VP (Cond Pl P2) => abn_ + "egaríais" ;
    VP (Cond Pl P3) => abn_ + "egarían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => abn_ + "iega" ;
    VP (Imp Sg P3) => abn_ + "iegue" ;
    VP (Imp Pl P1) => abn_ + "eguemos" ;
    VP (Imp Pl P2) => abn_ + "egad" ;
    VP (Imp Pl P3) => abn_ + "ieguen" ;
    VP (Pass Sg Masc) => abn_ + "egado" ;
    VP (Pass Sg Fem) => abn_ + "egada" ;
    VP (Pass Pl Masc) => abn_ + "egados" ;
    VP (Pass Pl Fem) => abn_ + "egadas"
    }
  } ;

oper adormir_23 : Str -> Verbum = \adormir -> 
  let ad_ = Predef.tk 5 adormir in
 {s = table {
    VI Infn=> ad_ + "ormir" ;
    VI Ger => ad_ + "urmiendo" ;
    VI Part => ad_ + "ormido" ;
    VP (Pres Ind Sg P1) => ad_ + "uermo" ;
    VP (Pres Ind Sg P2) => ad_ + "uermes" ;
    VP (Pres Ind Sg P3) => ad_ + "uerme" ;
    VP (Pres Ind Pl P1) => ad_ + "ormimos" ;
    VP (Pres Ind Pl P2) => ad_ + "ormís" ;
    VP (Pres Ind Pl P3) => ad_ + "uermen" ;
    VP (Pres Subj Sg P1) => ad_ + "uerma" ;
    VP (Pres Subj Sg P2) => ad_ + "uermas" ;
    VP (Pres Subj Sg P3) => ad_ + "uerma" ;
    VP (Pres Subj Pl P1) => ad_ + "urmamos" ;
    VP (Pres Subj Pl P2) => ad_ + "urmáis" ;
    VP (Pres Subj Pl P3) => ad_ + "uerman" ;
    VP (Past Ind Sg P1) => ad_ + "ormía" ;
    VP (Past Ind Sg P2) => ad_ + "ormías" ;
    VP (Past Ind Sg P3) => ad_ + "ormía" ;
    VP (Past Ind Pl P1) => ad_ + "ormíamos" ;
    VP (Past Ind Pl P2) => ad_ + "ormíais" ;
    VP (Past Ind Pl P3) => ad_ + "ormían" ;
    VP (Past Subj Sg P1) => variants {ad_ + "urmiera" ; ad_ + "urmiese"} ;
    VP (Past Subj Sg P2) => variants {ad_ + "urmieras" ; ad_ + "urmieses"} ;
    VP (Past Subj Sg P3) => variants {ad_ + "urmiera" ; ad_ + "urmiese"} ;
    VP (Past Subj Pl P1) => variants {ad_ + "urmiéramos" ; ad_ + "urmiésemos"} ;
    VP (Past Subj Pl P2) => variants {ad_ + "urmierais" ; ad_ + "urmieseis"} ;
    VP (Past Subj Pl P3) => variants {ad_ + "urmieran" ; ad_ + "urmiesen"} ;
    VP (Pret Sg P1) => ad_ + "ormí" ;
    VP (Pret Sg P2) => ad_ + "ormiste" ;
    VP (Pret Sg P3) => ad_ + "urmió" ;
    VP (Pret Pl P1) => ad_ + "ormimos" ;
    VP (Pret Pl P2) => ad_ + "ormisteis" ;
    VP (Pret Pl P3) => ad_ + "urmieron" ;
    VP (Fut Ind Sg P1) => ad_ + "ormiré" ;
    VP (Fut Ind Sg P2) => ad_ + "ormirás" ;
    VP (Fut Ind Sg P3) => ad_ + "ormirá" ;
    VP (Fut Ind Pl P1) => ad_ + "ormiremos" ;
    VP (Fut Ind Pl P2) => ad_ + "ormiréis" ;
    VP (Fut Ind Pl P3) => ad_ + "ormirán" ;
    VP (Fut Subj Sg P1) => ad_ + "urmiere" ;
    VP (Fut Subj Sg P2) => ad_ + "urmieres" ;
    VP (Fut Subj Sg P3) => ad_ + "urmiere" ;
    VP (Fut Subj Pl P1) => ad_ + "urmiéremos" ;
    VP (Fut Subj Pl P2) => ad_ + "urmiereis" ;
    VP (Fut Subj Pl P3) => ad_ + "urmieren" ;
    VP (Cond Sg P1) => ad_ + "ormiría" ;
    VP (Cond Sg P2) => ad_ + "ormirías" ;
    VP (Cond Sg P3) => ad_ + "ormiría" ;
    VP (Cond Pl P1) => ad_ + "ormiríamos" ;
    VP (Cond Pl P2) => ad_ + "ormiríais" ;
    VP (Cond Pl P3) => ad_ + "ormirían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => ad_ + "uerme" ;
    VP (Imp Sg P3) => ad_ + "uerma" ;
    VP (Imp Pl P1) => ad_ + "urmamos" ;
    VP (Imp Pl P2) => ad_ + "ormid" ;
    VP (Imp Pl P3) => ad_ + "uerman" ;
    VP (Pass Sg Masc) => ad_ + "ormido" ;
    VP (Pass Sg Fem) => ad_ + "ormida" ;
    VP (Pass Pl Masc) => ad_ + "ormidos" ;
    VP (Pass Pl Fem) => ad_ + "ormidas"
    }
  } ;

oper colegir_24 : Str -> Verbum = \colegir -> 
  let col_ = Predef.tk 4 colegir in
 {s = table {
    VI Infn => col_ + "egir" ;
    VI Ger => col_ + "igiendo" ;
    VI Part => col_ + "egido" ;
    VP (Pres Ind Sg P1) => col_ + "ijo" ;
    VP (Pres Ind Sg P2) => col_ + "iges" ;
    VP (Pres Ind Sg P3) => col_ + "ige" ;
    VP (Pres Ind Pl P1) => col_ + "egimos" ;
    VP (Pres Ind Pl P2) => col_ + "egís" ;
    VP (Pres Ind Pl P3) => col_ + "igen" ;
    VP (Pres Subj Sg P1) => col_ + "ija" ;
    VP (Pres Subj Sg P2) => col_ + "ijas" ;
    VP (Pres Subj Sg P3) => col_ + "ija" ;
    VP (Pres Subj Pl P1) => col_ + "ijamos" ;
    VP (Pres Subj Pl P2) => col_ + "ijáis" ;
    VP (Pres Subj Pl P3) => col_ + "ijan" ;
    VP (Past Ind Sg P1) => col_ + "egía" ;
    VP (Past Ind Sg P2) => col_ + "egías" ;
    VP (Past Ind Sg P3) => col_ + "egía" ;
    VP (Past Ind Pl P1) => col_ + "egíamos" ;
    VP (Past Ind Pl P2) => col_ + "egíais" ;
    VP (Past Ind Pl P3) => col_ + "egían" ;
    VP (Past Subj Sg P1) => variants {col_ + "igiera" ; col_ + "igiese"} ;
    VP (Past Subj Sg P2) => variants {col_ + "igieras" ; col_ + "igieses"} ;
    VP (Past Subj Sg P3) => variants {col_ + "igiera" ; col_ + "igiese"} ;
    VP (Past Subj Pl P1) => variants {col_ + "igiéramos" ; col_ + "igiésemos"} ;
    VP (Past Subj Pl P2) => variants {col_ + "igierais" ; col_ + "igieseis"} ;
    VP (Past Subj Pl P3) => variants {col_ + "igieran" ; col_ + "igiesen"} ;
    VP (Pret Sg P1) => col_ + "egí" ;
    VP (Pret Sg P2) => col_ + "egiste" ;
    VP (Pret Sg P3) => col_ + "igió" ;
    VP (Pret Pl P1) => col_ + "egimos" ;
    VP (Pret Pl P2) => col_ + "egisteis" ;
    VP (Pret Pl P3) => col_ + "igieron" ;
    VP (Fut Ind Sg P1) => col_ + "egiré" ;
    VP (Fut Ind Sg P2) => col_ + "egirás" ;
    VP (Fut Ind Sg P3) => col_ + "egirá" ;
    VP (Fut Ind Pl P1) => col_ + "egiremos" ;
    VP (Fut Ind Pl P2) => col_ + "egiréis" ;
    VP (Fut Ind Pl P3) => col_ + "egirán" ;
    VP (Fut Subj Sg P1) => col_ + "igiere" ;
    VP (Fut Subj Sg P2) => col_ + "igieres" ;
    VP (Fut Subj Sg P3) => col_ + "igiere" ;
    VP (Fut Subj Pl P1) => col_ + "igiéremos" ;
    VP (Fut Subj Pl P2) => col_ + "igiereis" ;
    VP (Fut Subj Pl P3) => col_ + "igieren" ;
    VP (Cond Sg P1) => col_ + "egiría" ;
    VP (Cond Sg P2) => col_ + "egirías" ;
    VP (Cond Sg P3) => col_ + "egiría" ;
    VP (Cond Pl P1) => col_ + "egiríamos" ;
    VP (Cond Pl P2) => col_ + "egiríais" ;
    VP (Cond Pl P3) => col_ + "egirían" ;
    VP (Imp Sg P1) => variants {} ;
    VP (Imp Sg P2) => col_ + "ige" ;
    VP (Imp Sg P3) => col_ + "ija" ;
    VP (Imp Pl P1) => col_ + "ijamos" ;
    VP (Imp Pl P2) => col_ + "egid" ;
    VP (Imp Pl P3) => col_ + "ijan" ;
    VP (Pass Sg Masc) => col_ + "egido" ;
    VP (Pass Sg Fem) => col_ + "egida" ;
    VP (Pass Pl Masc) => col_ + "egidos" ;
    VP (Pass Pl Fem) => col_ + "egidas"
    }
  } ;






-- for Numerals

param DForm = unit  | teen  | ten  | hundred  ;
param Modif = mod  | unmod  | conj  ;
}
