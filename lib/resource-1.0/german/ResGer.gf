--# -path=.:../abstract:../common:prelude

--1 German auxiliary operations.
--
-- (c) 2002-2006 Aarne Ranta and Harald Hammarstr�m
--
-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains some lexical
-- patterns needed for $Lex$.

resource ResGer = ParamGer ** open Prelude in {

  flags optimize=all ;

-- For $Lex$.

-- For conciseness and abstraction, we first define a method for
-- generating a case-dependent table from a list of four forms.

  oper
  caselist : (x1,_,_,x4 : Str) -> Case => Str = \n,a,d,g -> 
    table {
      Nom => n ; 
      Acc => a ; 
      Dat => d ; 
      Gen => g
      } ;

-- For each lexical category, here are the worst-case constructors and
-- some practical special cases.
-- More paradigms are given in $ParadigmsGer$.

-- The worst-case constructor for common nouns needs six forms: all plural forms
-- are always the same except for the dative. Actually the six forms are never
-- needed at the same time, but just subsets of them.

  Noun : Type = {s : Number => Case => Str ; g : Gender} ;

  mkN  : (x1,_,_,_,_,x6 : Str) -> Gender -> Noun = 
    \mann, mannen, manne, mannes, maenner, maennern, g -> {
     s = table {
       Sg => caselist mann mannen manne mannes ;
       Pl => caselist maenner maenner maennern maenner
       } ; 
     g = g
    } ;

-- Adjectives need four forms: two for the positive and one for the other degrees.

  Adjective : Type = {s : Degree => AForm => Str} ;

  mkA : (x1,_,_,x4 : Str) -> Adjective = \gut,gute,besser,best -> 
    {s = table {
       Posit  => adjForms gut gute ; 
       Compar => adjForms besser besser ; 
       Superl => adjForms best best
       }
    } ;

-- Verbs need as many as 12 forms, to cover the variations with
-- suffixes "t" and "st". Auxiliaries like "sein" will have to
-- make extra cases even for this.

  Verb : Type = {s : VForm => Str ; aux : VAux} ;

  mkV : (x1,_,_,_,_,_,_,_,_,_,_,x12 : Str) -> VAux -> Verb = 
    \geben,gebe,gibst,gibt,gebt,gib,gab,gabst,gaben,gabt,gaebe,gegeben,aux -> 
    {s = table {
       VInf            => geben ;
       VPresInd Sg P1  => gebe ;
       VPresInd Sg P2  => gibst ;
       VPresInd Sg P3  => gibt ;
       VPresInd Pl P2  => gebt ;
       VPresInd Pl _   => geben ;
       VImper Sg       => gib ;
       VImper Pl       => gebt ;
       VPresSubj Sg P2 => init geben + "st" ;
       VPresSubj Sg _  => init geben ;
       VPresSubj Pl P2 => init geben + "t" ;
       VPresSubj Pl _  => geben ;
       VPresPart a     => (regA (geben + "d")).s ! Posit ! a ;
       VImpfInd Sg P2  => gabst ;
       VImpfInd Sg _   => gab ;
       VImpfInd Pl P2  => gabt ;
       VImpfInd Pl _   => gaben ;
       VImpfSubj Sg P2 => gaebe + "st" ;
       VImpfSubj Sg _  => gaebe ;
       VImpfSubj Pl P2 => gaebe + "t" ;
       VImpfSubj Pl _  => gaebe + "n" ;
       VPastPart a     => (regA gegeben).s ! Posit ! a
       } ;
     aux = aux
     } ;

-- These functions cover many regular cases; full coverage inflectional patterns are
-- defined in $MorphoGer$.

  mkN4 : (x1,_,_,x4 : Str) -> Gender -> Noun = \wein,weines,weine,weinen ->
    mkN wein wein wein weines weine weinen ;

  regA : Str -> Adjective = \blau ->
    mkA blau blau (blau + "er") (blau + "est") ;

  regV : Str -> Verb = \legen ->
    let 
      lege  = init legen ;
      leg   = init lege ;
      legt  = leg + "t" ;
      legte = legt + "e"
    in
    mkV 
      legen lege (leg+"st") legt legt leg 
      legte (legte + "st") (legte + "n") (legte + "t")
      legte ("ge" + legt) 
      VHaben ;

-- Prepositions for complements indicate the complement case.

  Preposition : Type = {s : Str ; c : Case} ;

-- To apply a preposition to a complement.

  appPrep : Preposition -> (Case => Str) -> Str = \prep,arg ->
    prep.s ++ arg ! prep.c ;

-- To build a preposition from just a case.

  noPreposition : Case -> Preposition = \c -> 
    {s = [] ; c = c} ;

-- Pronouns and articles
-- Here we define personal and relative pronouns.
-- All personal pronouns, except "ihr", conform to the simple
-- pattern $mkPronPers$.

  mkPronPers : (x1,_,_,_,x5 : Str) -> Number -> Person -> 
               {s : NPForm => Str ; a : Agr} = 
    \ich,mich,mir,meiner,mein,n,p -> {
      s = table {
        NPCase c    => caselist ich mich mir meiner ! c ;
        NPPoss gn c => mein + pronEnding ! gn ! c
        } ;
      a = {n = n ; p = p}
      } ;

  pronEnding : GenNum => Case => Str = table {
    GSg Masc => caselist ""  "en" "em" "es" ;
    GSg Fem  => caselist "e" "e"  "er" "er" ;
    GSg Neut => caselist ""  ""   "em" "es" ;
    GPl      => caselist "e"  "e" "en" "er"
    } ;

  artDef : GenNum => Case => Str = table {
    GSg Masc => caselist "der" "den" "dem" "des" ;
    GSg Fem  => caselist "die" "die" "der" "der" ;
    GSg Neut => caselist "das" "das" "dem" "des" ;
    GPl      => caselist "die" "die" "den" "der"
    } ;

-- This is used when forming determiners that are like adjectives.

  appAdj : Adjective -> Number => Gender => Case => Str = \adj ->
    let
      ad : GenNum -> Case -> Str = \gn,c -> 
        adj.s ! Posit ! AMod Strong gn c
    in
    \\n,g,c => case n of {
       Sg => ad (GSg g) c ;
       _  => ad GPl c
     } ;

-- This auxiliary gives the forms in each degree of adjectives. 

  adjForms : (x1,x2 : Str) -> AForm => Str = \teuer,teur ->
   table {
    APred => teuer ;
    AMod Strong (GSg Masc) c => 
      caselist (teur+"er") (teur+"en") (teur+"em") (teur+"es") ! c ;
    AMod Strong (GSg Fem) c => 
      caselist (teur+"e") (teur+"e") (teur+"er") (teur+"er") ! c ;
    AMod Strong (GSg Neut) c => 
      caselist (teur+"es") (teur+"es") (teur+"em") (teur+"es") ! c ;
    AMod Strong GPl c => 
      caselist (teur+"e") (teur+"e") (teur+"en") (teur+"er") ! c ;
    AMod Weak (GSg g) c => case <g,c> of {
      <_,Nom>    => teur+"e" ;
      <Masc,Acc> => teur+"en" ;
      <_,Acc>    => teur+"e" ;
      _          => teur+"en" } ;
    AMod Weak GPl c => teur+"en"
    } ;

-- For $Verb$.

  VP : Type = {
      s : Agr => VPForm => {
        fin : Str ;          -- V1 hat
        inf : Str            -- V2 gesagt
        } ;
      a1 : Polarity => Str ; -- A1 nicht
      n2 : Agr => Str ;      -- N2 dich
      a2 : Str ;             -- A2 heute
      ext : Str              -- S-Ext dass sie kommt
      } ;

  predV : Verb -> VP = \verb ->
    let
      vfin : Tense -> Agr -> Str = \t,a -> verb.s ! vFin t a ;
      vpart = verb.s ! VPastPart APred ;
      vinf = verb.s ! VInf ;

      vHaben = auxPerfect verb ;
      hat : Tense -> Agr -> Str = \t,a -> vHaben ! vFin t a ;
      haben : Str = vHaben ! VInf ;

      wird : Agr -> Str = \a -> werden_V.s ! VPresInd a.n a.p ;  
      wuerde : Agr -> Str = \a -> werden_V.s ! VImpfSubj a.n a.p ;

      vf : Str -> Str -> {fin,inf : Str} = \fin,inf -> {
        fin = fin ; inf = inf
        } ;

    in {
    s = \\a => table {
      VPFinite t Simul => case t of {
        Pres | Past => vf (vfin t a) [] ;
        Fut  => vf (wird a) vinf ;
        Cond => vf (wuerde a) vinf
        } ;
      VPFinite t Anter => case t of {
        Pres | Past => vf (hat t a) vpart ;
        Fut  => vf (wird a) (vpart ++ haben) ;
        Cond => vf (wuerde a) (vpart ++ haben)
        } ;
      VPImperat => vf (verb.s ! VImper a.n) [] ;
      VPInfinit Simul => vf [] vinf ;
      VPInfinit Anter => vf [] (vpart ++ haben)
      } ;
    a1  : Polarity => Str = negation ;
    n2  : Agr  => Str = \\_ => [] ;
    a2  : Str = [] ;
    ext : Str = []
    } ;

  auxPerfect : Verb -> VForm => Str = \verb ->
    case verb.aux of {
      VHaben => haben_V.s ;
      VSein => sein_V.s
      } ;

  haben_V : Verb = 
    mkV 
      "haben" "habe" "hast" "hat" "habt" "hab" 
      "hatte" "hattest" "hatten" "hattet" 
      "hätte" "gehabt" 
      VHaben ;

  werden_V : Verb = 
    mkV 
      "werden" "werde" "wirst" "wird" "werdet" "werd" 
      "wurde" "wurdest" "wurden" "wurdet" 
      "würde" "geworden" 
      VSein ;

  sein_V : Verb = 
    let
      sein = mkV 
      "sein" "bin" "bist" "ist" "seid" "sei" 
      "war"  "warst" "waren" "wart" 
      "wäre" "gewesen" 
      VSein
    in
    {s = table {
      VPresInd Pl (P1 | P3) => "sind" ;
      VPresSubj Sg P2 => (variants {"seiest" ; "seist"}) ;
      VPresSubj Sg _  => "sei" ;
      VPresSubj Pl P2 => "seien" ;
      VPresSubj Pl _  => "seiet" ;
      VPresPart a => (regA "seiend").s ! Posit ! a ;
      v => sein.s ! v 
      } ;
     aux = VSein
    } ;

  auxVV : Verb -> Verb ** {part : Str} = \v -> v ** {part = []} ;

  negation : Polarity => Str = table {
      Pos => [] ;
      Neg => "nicht"
      } ;

-- Extending a verb phrase with new constituents.

  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n2 = \\a => vp.n2 ! a ++ obj ! a ;
    a2 = vp.a2 ;
    ext = vp.ext
    } ;

  insertAdv : Str -> VP -> VP = \adv,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n2 = vp.n2 ;
    a2 = vp.a2 ++ adv ;
    ext = vp.ext
    } ;

  insertExtrapos : Str -> VP -> VP = \ext,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n2 = vp.n2 ;
    a2 = vp.a2 ;
    ext = vp.ext ++ ext
    } ;

-- For $Sentence$.

  Clause : Type = {
    s : Tense => Anteriority => Polarity => Order => Str
    } ;

  mkClause : Str -> Agr -> VP -> Clause = \subj,agr,vp -> {
      s = \\t,a,b,o =>
        let
          verb  = vp.s  ! agr ! VPFinite t a ;
          neg   = vp.a1 ! b ;
          obj   = vp.n2 ! agr ++ vp.a2 ;
          compl = neg ++ obj ++ verb.inf ;
          extra = vp.ext ;
        in
        case o of {
          Main => subj ++ verb.fin ++ compl ++ extra ;
          Inv  => verb.fin ++ subj ++ compl ++ extra ;
          Sub  => subj ++ compl ++ verb.fin ++ extra
          }
    } ;

  reflPron : Agr => Str = table {
    {n = Sg ; p = P1} => "mich" ;
    {n = Sg ; p = P2} => "dich" ;
    {n = Sg ; p = P3} => "sich" ; --
    {n = Pl ; p = P1} => "uns" ;
    {n = Pl ; p = P2} => "euch" ;
    {n = Pl ; p = P3} => "sich"
    } ;

  conjThat : Str = "daß" ;

  conjThan : Str = "als" ;


-- For $Numeral$.
--
--  mkNum : Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Str} = 
--    \two, twelve, twenty, second ->
--    {s = table {
--       unit => table {NCard => two ; NOrd => second} ; 
--       teen => \\c => mkCard c twelve ; 
--       ten  => \\c => mkCard c twenty
--       }
--    } ;
--
--  regNum : Str -> {s : DForm => CardOrd => Str} = 
--    \six -> mkNum six (six + "teen") (six + "ty") (regOrd six) ;
--
--  regCardOrd : Str -> {s : CardOrd => Str} = \ten ->
--    {s = table {NCard => ten ; NOrd => regOrd ten}} ;
--
--  mkCard : CardOrd -> Str -> Str = \c,ten -> 
--    (regCardOrd ten).s ! c ; 
--
--  regOrd : Str -> Str = \ten -> 
--    case last ten of {
--      "y" => init ten + "ieth" ;
--      _   => ten + "th"
--      } ;
--
}
