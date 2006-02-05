--# -path=.:../abstract:../common:prelude

--1 German auxiliary operations.
--
-- (c) 2002-2006 Aarne Ranta and Harald Hammarstr�m
--
-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains some lexical
-- patterns needed for $Lex$.

resource ResGer = ParamX ** open Prelude in {

  flags optimize=all ;

--2 For $Noun$

-- These are the standard four-value case and three-value gender.

  param
    Case = Nom | Acc | Dat | Gen ;
    Gender = Masc | Fem | Neutr ;

-- Complex $CN$s, like adjectives, have strong and weak forms.

    Adjf = Strong | Weak ;

-- Gender distinctions are only made in the singular. 

    GenNum = GSg Gender | GPl ;

-- Agreement of $NP$ is a record.

  oper Agr = {n : Number ; p : Person} ;

-- Pronouns are the worst-case noun phrases, which have both case
-- and possessive forms.

  param NPForm = NPCase Case | NPPoss GenNum Case ;

--2 For $Adjective$

-- The predicative form of adjectives is not inflected further.

  param AForm = APred | AMod GenNum Case ;  


--2 For $Verb$

  param VForm = 
     VInf 
   | VPresInd  Number Person
   | VPresSubj Number Person
   | VImper    Number
   | VImpfInd  Number Person 
   | VImpfSubj Number Person 
   | VPresPart AForm 
   | VPastPart AForm ;

  param VPForm =
     VPFinite Tense Anteriority
   | VPImperat
   | VPInfinit Anteriority ;

  param VAux = VHaben | VSein ;

  param VType = VAct | VRefl Case ;

-- The order of sentence is depends on whether it is used as a main
-- clause, inverted, or subordinate.

  param  
    Order = Main | Inv | Sub ;


--2 For $Relative$
 
    RAgr = RNoAg | RAg {n : Number ; p : Person} ;

--2 For $Numeral$

    CardOrd = NCard | NOrd AForm ;
    DForm = DUnit  | DTeen  | DTen ;

--2 Transformations between parameter types

  oper
    agrP3 : Number -> Agr = \n -> 
      {n = n ; p = P3} ;

    gennum : Gender -> Number -> GenNum = \g,n ->
      case n of {
        Sg => GSg g ;
        Pl => GPl
        } ;

-- Needed in $RelativeGer$.

    numGenNum : GenNum -> Number = \gn -> 
      case gn of {
        GSg _ => Sg ;
        GPl   => Pl
        } ;

-- Used in $NounGer$.

    agrAdj : Gender -> Adjf -> Number -> Case -> AForm = \g,a,n,c ->
      let
        gn = gennum g n ;
        e  = AMod (GSg Fem) Nom ;
        en = AMod (GSg Masc) Acc ;
      in
      case a of {
        Strong => AMod gn c ;
        _ => case <gn,c> of {
          <GSg _,   Nom> => e ;
          <GSg Masc,Acc> => en ;
          <GSg _,   Acc> => e ;
          _              => en 
        }
      } ;

-- This is used twice in NounGer.

    adjfCase : Adjf -> Case -> Adjf = \a,c -> case <a,c> of {
         <Strong, Nom|Acc> => Strong ;
         _ => Weak
         } ;      

    vFin : Tense -> Agr -> VForm = \t,a ->
      case t of {
        Pres => VPresInd  a.n a.p ;
        Past => VImpfInd  a.n a.p ;
        _ => VInf --- never used
        } ;

    conjAgr : Agr -> Agr -> Agr = \a,b -> {
      n = conjNumber a.n b.n ;
      p = conjPerson a.p b.p
      } ;

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

  Verb : Type = {
    s : VForm => Str ; 
    prefix : Str ; 
    aux : VAux ; 
    vtype : VType
    } ;

  mkV : (x1,_,_,_,_,_,_,_,_,_,_,x12 : Str) -> Str -> VAux -> Verb = 
    \geben,gebe,gibst,gibt,gebt,gib,gab,gabst,gaben,gabt,gaebe,gegeben,ein,aux -> 
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
     prefix = ein ;
     aux = aux ;
     vtype = VAct
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
      [] VHaben ;

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
        adj.s ! Posit ! AMod gn c
    in
    \\n,g,c => case n of {
       Sg => ad (GSg g) c ;
       _  => ad GPl c
     } ;

-- This auxiliary gives the forms in each degree of adjectives. 

  adjForms : (x1,x2 : Str) -> AForm => Str = \teuer,teur ->
   table {
    APred => teuer ;
    AMod (GSg Masc) c => 
      caselist (teur+"er") (teur+"en") (teur+"em") (teur+"es") ! c ;
    AMod (GSg Fem) c => 
      caselist (teur+"e") (teur+"e") (teur+"er") (teur+"er") ! c ;
    AMod (GSg Neut) c => 
      caselist (teur+"es") (teur+"es") (teur+"em") (teur+"es") ! c ;
    AMod GPl c => 
      caselist (teur+"e") (teur+"e") (teur+"en") (teur+"er") ! c
    } ;

-- For $Verb$.

  VP : Type = {
      s : Agr => VPForm => {
        fin : Str ;          -- hat
        inf : Str            -- wollen
        } ;
      a1 : Polarity => Str ; -- nicht
      n2 : Agr => Str ;      -- dich
      a2 : Str ;             -- heute
      isAux : Bool ;      -- is a double infinitive
      inf : Str ;            -- sagen
      ext : Str              -- dass sie kommt
      } ;

  predV : Verb -> VP = predVGen False ;

  predVGen : Bool -> Verb -> VP = \isAux, verb ->
    let
      vfin : Tense -> Agr -> Str = \t,a -> verb.s ! vFin t a ;
      vinf = verb.s ! VInf ;
      vpart = if_then_Str isAux vinf (verb.s ! VPastPart APred) ;

      vHaben = auxPerfect verb ;
      hat : Tense -> Agr -> Str = \t,a -> vHaben ! vFin t a ;
      haben : Str = vHaben ! VInf ;

      wird : Agr -> Str = \a -> werden_V.s ! VPresInd a.n a.p ;  
      wuerde : Agr -> Str = \a -> werden_V.s ! VImpfSubj a.n a.p ;

      auf = verb.prefix ;

      vf : Str -> Str -> {fin,inf : Str} = \fin,inf -> {
        fin = fin ; inf = auf ++ inf
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
    n2  : Agr => Str = case verb.vtype of {
      VAct => \\_ => [] ;
      VRefl c => \\a => reflPron ! a ! c
      } ;
    a2  : Str = [] ;
    isAux = isAux ; ----
    inf,ext : Str = []
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
      [] VHaben ;

  werden_V : Verb = 
    mkV 
      "werden" "werde" "wirst" "wird" "werdet" "werd" 
      "wurde" "wurdest" "wurden" "wurdet" 
      "würde" "geworden" 
      [] VSein ;

  werdenPass : Verb = 
    mkV 
      "werden" "werde" "wirst" "wird" "werdet" "werd" 
      "wurde" "wurdest" "wurden" "wurdet" 
      "würde" "worden" 
      [] VSein ;

  sein_V : Verb = 
    let
      sein = mkV 
      "sein" "bin" "bist" "ist" "seid" "sei" 
      "war"  "warst" "waren" "wart" 
      "wäre" "gewesen" 
      [] VSein
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
     prefix = [] ;
     aux = VSein ;
     vtype = VAct
    } ;

  auxVV : Verb -> Verb ** {isAux : Bool} = \v -> v ** {isAux = True} ;

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
    isAux = vp.isAux ;
    inf = vp.inf ;
    ext = vp.ext
    } ;

  insertAdV : Str -> VP -> VP = \adv,vp -> {
    s = vp.s ;
    a1 = \\a => vp.a1 ! a ++ adv ;
    n2 = vp.n2 ;
    a2 = vp.a2 ;
    isAux = vp.isAux ;
    inf = vp.inf ;
    ext = vp.ext
    } ;

  insertAdv : Str -> VP -> VP = \adv,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n2 = vp.n2 ;
    a2 = vp.a2 ++ adv ;
    isAux = vp.isAux ;
    inf = vp.inf ;
    ext = vp.ext
    } ;

  insertExtrapos : Str -> VP -> VP = \ext,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n2 = vp.n2 ;
    a2 = vp.a2 ;
    isAux = vp.isAux ;
    inf = vp.inf ;
    ext = vp.ext ++ ext
    } ;

  insertInf : Str -> VP -> VP = \inf,vp -> {
    s = vp.s ;
    a1 = vp.a1 ;
    n2 = vp.n2 ;
    a2 = vp.a2 ;
    isAux = vp.isAux ; ----
    inf = vp.inf ++ inf ;
    ext = vp.ext
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
          obj   = vp.n2 ! agr ;
          compl = obj ++ neg ++ vp.a2 ;
          inf   = vp.inf ++ verb.inf ;
          extra = vp.ext ;
          inffin = case <a,vp.isAux> of {
            <Anter,True> => verb.fin ++ inf ; -- double infinitive
            _ => inf ++ verb.fin              --- or just auxiliary vp
            }
        in
        case o of {
          Main => subj ++ verb.fin ++ compl ++ inf ++ extra ;
          Inv  => verb.fin ++ subj ++ compl ++ inf ++ extra ;
          Sub  => subj ++ compl ++ inffin ++ extra
          }
    } ;

-- The nominative case is not used as reflexive, but defined here
-- so that we can reuse this in personal pronouns. 
-- The missing Sg "ihrer" shows that a dependence on gender would
-- be needed.

  reflPron : Agr => Case => Str = table {
    {n = Sg ; p = P1} => caselist "ich" "mich" "mir"  "meiner" ;
    {n = Sg ; p = P2} => caselist "du"  "dich" "dir"  "deiner" ;
    {n = Sg ; p = P3} => caselist "er" "sich" "sich" "seiner" ; --- ihrer
    {n = Pl ; p = P1} => caselist "wir" "uns"  "uns"  "unser" ;
    {n = Pl ; p = P2} => caselist "ihr" "euch" "euch" "euer" ;
    {n = Pl ; p = P3} => caselist "sie" "sich" "sich" "ihrer"
    } ;

  conjThat : Str = "daß" ;

  conjThan : Str = "als" ;

-- The infinitive particle "zu" is used if and only if $vv.isAux = False$.
 
  infPart : Bool -> Str = \b -> if_then_Str b [] "zu" ;

}
