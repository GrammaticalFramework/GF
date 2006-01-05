--# -path=.:../abstract:../common:prelude

--1 German auxiliary operations.
--
-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.
--

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

-- This auxiliary gives the forms in each degree. 

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

-- This is used e.g. when forming determiners.

  appAdj : Adjective -> Number => Gender => Case => Str = \adj ->
    let
      ad : GenNum -> Case -> Str = \gn,c -> 
        adj.s ! Posit ! AMod Strong gn c
    in
    \\n,g,c => case n of {
       Sg => ad (GSg g) c ;
       _  => ad GPl c
     } ;

  Verb : Type = {s : VForm => Str ; aux : VAux} ;

  mkV : (x1,_,_,_,_,x6 : Str) -> VAux -> Verb = 
    \geben,gibt,gib,gab,gaebe,gegeben,aux -> 
    let
      ifSibilant : Str -> Str -> Str -> Str = \u,b1,b2 -> 
        case u of {
          "s" | "x" | "z" | "ß" => b1 ;
          _   => b2 
          } ; 
      en = Predef.dp 2 geben ;
      geb = case Predef.tk 1 en of {
        "e" => Predef.tk 2 geben ;
         _  => Predef.tk 1 geben
         } ;
      gebt = addE geb + "t" ;
      gebte = ifTok Tok (Predef.dp 1 gab) "e" gab (gab + "e") ;
      gibst = ifSibilant (Predef.dp 1 gib) (gib + "t") (gib + "st") ;
      gegebener = (regA gegeben).s ! Posit ;
      gabe = addE gab ;
      gibe = ifTok Str (Predef.dp 2 gib) "ig" "e" [] ++ addE gib
    in {s = table {

       VInf       => geben ;

       VPresInd Sg P1 => geb + "e" ;
       VPresInd Sg P2 => gibst ;
       VPresInd Sg P3 => gibt ;
       VPresInd Pl P2 => gebt ;
       VPresInd Pl _  => geben ; -- the famous law

       VImper Sg    => gibe ;
       VImper Pl    => gebt ;

       VPresSubj Sg P2 => geb + "est" ;
       VPresSubj Sg _  => geb + "e" ;
       VPresSubj Pl P2 => geb + "et" ;
       VPresSubj Pl _  => geben ;

       VPresPart a => (regA (geben + "d")).s ! Posit ! a ;

       VImpfInd Sg P2 => gabe + "st" ;
       VImpfInd Sg _  => gab ;
       VImpfInd Pl P2 => gabe + "t" ;
       VImpfInd Pl _  => gebte + "n" ;

       VImpfSubj Sg P2 => gaebe + "st" ;
       VImpfSubj Sg _  => gaebe ;
       VImpfSubj Pl P2 => gaebe + "t" ;
       VImpfSubj Pl _  => gaebe + "n" ;

       VPastPart a    => gegebener ! a
       } ;
     aux = aux
     } ;
 
-- This function decides whether to add an "e" to the stem before "t".
-- Examples: "töten - tötet", "kehren - kehrt", "lernen - lernt", "atmen - atmet".

  addE : Str -> Str = \stem ->
    let
      r = init (Predef.dp 2 stem) ;
      n = last stem ;
      e = case n of {
        "t" | "d" => "e" ;
        "e" | "h" => [] ;
        _ => case r of {
          "l" | "r" | "a" | "o" | "u" | "e" | "i" | "Ã¼" | "Ã¤" | "Ã¶"|"h" => [] ;
          _ => "e" 
          }
        }
    in 
      stem + e ;

-- Prepositions for complements indicate the complement case.

  Preposition : Type = {s : Str ; c : Case} ;

-- To apply a preposition to a complement.

  appPrep : Preposition -> (Case => Str) -> Str = \prep,arg ->
    prep.s ++ arg ! prep.c ;

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


--
--    mkIP : (i,me,my : Str) -> Number -> {s : Case => Str ; n : Number} =
--     \i,me,my,n -> let who = mkNP i me my n P3 in {s = who.s ; n = n} ;
--
--    mkNP : (i,me,my : Str) -> Number -> Person -> {s : Case => Str ; a : Agr} =
--     \i,me,my,n,p -> {
--     s = table {
--       Nom => i ;
--       Acc => me ;
--       Gen => my
--       } ;
--     a = {
--       n = n ;
--       p = p
--       }
--     } ;
--
-- These functions cover many cases; full coverage inflectional patterns are
-- in $MorphoGer$.

  mkN4 : (x1,_,_,x4 : Str) -> Gender -> Noun = \wein,weines,weine,weinen ->
    mkN wein wein wein weines weine weinen ;

  mkN2 : (x1,x2 : Str) -> Gender -> Noun = \frau,frauen ->
    mkN4 frau frau frauen frauen ;

  regA : Str -> Adjective = \blau ->
    mkA blau blau (blau + "er") (blau + "est") ;

  regV : Str -> Verb = \legen ->
    let 
       leg = case Predef.dp 2 legen of {
         "en" => Predef.tk 2 legen ;
         _  => Predef.tk 1 legen
         } ;
       lege = addE leg ;
       legte = lege + "te"
    in
       mkV legen (lege+"t") leg legte legte ("ge"+lege+"t") VHaben ;

-- To eliminate the morpheme "ge".

  no_geV : Verb -> Verb = \verb -> {
    s = table {
      VPastPart a => Predef.drop 2 (verb.s ! VPastPart a) ;
      v => verb.s ! v
      } ;
    aux = verb.aux
    } ;

-- To change the default auxiliary "haben" to "sein".

  seinV : Verb -> Verb = \verb -> {
    s = verb.s ;
    aux = VSein
    } ;


-- For $Verb$.

  VP : Type = {
      s : Agr => VPForm => {
        fin : Str ;          -- V1 hat  ---s1
        inf : Str            -- V2 gesagt ---s4
        } ;
      a1 : Polarity => Str ; -- A1 nicht ---s3
      n2 : Agr => Str ;      -- N2 dich  ---s5
      a2 : Str ;             -- A2 heute ---s6
      ext : Str              -- S-Ext dass sie kommt ---s7
      } ;

  predV : Verb -> VP = \verb ->
    let
      vfin : Tense -> Agr -> Str = \t,a -> 
        verb.s ! vFin t a ;
      vpart = verb.s ! VPastPart APred ;
      vinf = verb.s ! VInf ;

      vHaben = auxPerfect verb ;
      hat : Tense -> Agr -> Str = \t,a -> 
        vHaben ! vFin t a ;
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
    let
      haben = mkV "haben" "hat" "hab" "hatte" "hätte" "gehabt" VHaben
    in 
    {s = table {
      VPresInd Sg P2 => "hast" ;
      v => haben.s ! v
      } ;
     aux = VHaben 
    } ;

  werden_V : Verb = 
    let
      werden = mkV "werden" "wird" "werd" "wurde" "würde" "geworden" VSein
    in 
    {s = table {
      VPresInd Sg P2 => "wirst" ;
      v => werden.s ! v
      } ;
     aux = VSein
    } ;

  sein_V : Verb = 
    let
      sein = mkV "sein" "ist" "sei" "war" "wäre" "gewesen" VSein
    in
    {s = table {
      VPresInd Sg P1 => "bin" ;
      VPresInd Sg P2 => "bist" ;
      VPresInd Pl P2 => "seid" ;
      VPresInd Pl _  => "sind" ;
      VImper Sg    => "sei" ;
      VImper Pl    => "seid" ;
      VPresSubj Sg P1 => "sei" ;
      VPresSubj Sg P2 => (variants {"seiest" ; "seist"}) ;
      VPresSubj Sg P3 => "sei" ;
      VPresSubj Pl P2 => "seien" ;
      VPresSubj Pl _  => "seiet" ;
      VPresPart a => (regA "seiend").s ! Posit ! a ;
      v => sein.s ! v 
      } ;
     aux = VSein
    } ;

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

-- For $Sentence$.

  Clause : Type = {
    s : Tense => Anteriority => Polarity => Order => Str
    } ;

  mkClause : Str -> Agr -> VP -> Clause = \subj,agr,vp -> {
      s = \\t,a,b,o =>
        let
          verb  = vp.s  ! agr ! VPFinite t a ;
          neg   = vp.a1 ! b ;
          obj   = vp.n2 ! agr ++ vp.a2 ++ vp.ext ;
          compl = neg ++ obj ++ verb.inf ;
        in
        case o of {
          Main => subj ++ verb.fin ++ compl ;
          Inv  => verb.fin ++ subj ++ compl ;
          Sub  => subj ++ compl ++ verb.fin
          }
    } ;



--  VerbForms : Type =
--    Tense => Anteriority => Polarity => Order => Agr => {fin, inf : Str} ; 
--
--  VP : Type = {
--    s  : VerbForms ;
--    s2 : Agr => Str
--    } ;
--
--  predV : Verb -> VP = \verb -> {
--    s = \\t,ant,b,ord,agr => 
--      let
--        inf  = verb.s ! VInf ;
--        fin  = presVerb verb agr ;
--        past = verb.s ! VPast ;
--        part = verb.s ! VPPart ;
--        vf : Str -> Str -> {fin, inf : Str} = \x,y -> 
--          {fin = x ; inf = y} ;
--      in
--      case <t,ant,b,ord> of {
--        <Pres,Simul,Pos,ODir>   => vf fin          [] ;
--        <Pres,Simul,Pos,OQuest> => vf (does agr)   inf ;
--        <Pres,Simul,Neg,_>      => vf (doesnt agr) inf ;
--        <Pres,Anter,Pos,_>      => vf (have agr)   part ;
--        <Pres,Anter,Neg,_>      => vf (havent agr) part ;
--        <Past,Simul,Pos,ODir>   => vf past         [] ;
--        <Past,Simul,Pos,OQuest> => vf "did"        inf ;
--        <Past,Simul,Neg,_>      => vf "didn't"     inf ;
--        <Past,Anter,Pos,_>      => vf "had"        part ;
--        <Past,Anter,Neg,_>      => vf "hadn't"     part ;
--        <Fut, Simul,Pos,_>      => vf "will"       inf ;
--        <Fut, Simul,Neg,_>      => vf "won't"      inf ;
--        <Fut, Anter,Pos,_>      => vf "will"       ("have" ++ part) ;
--        <Fut, Anter,Neg,_>      => vf "won't"      ("have" ++ part) ;
--        <Cond,Simul,Pos,_>      => vf "would"      inf ;
--        <Cond,Simul,Neg,_>      => vf "wouldn't"   inf ;
--        <Cond,Anter,Pos,_>      => vf "would"      ("have" ++ part) ;
--        <Cond,Anter,Neg,_>      => vf "wouldn't"   ("have" ++ part)
--        } ;
--    s2 = \\_ => []
--    } ;
--
--  predAux : Aux -> VP = \verb -> {
--    s = \\t,ant,b,ord,agr => 
--      let 
--        inf  = verb.inf ;
--        fin  = verb.pres ! b ! agr ;
--        past = verb.past ! b ! agr ;
--        part = verb.ppart ;
--        vf : Str -> Str -> {fin, inf : Str} = \x,y -> 
--          {fin = x ; inf = y} ;
--      in
--      case <t,ant,b,ord> of {
--        <Pres,Simul,_,  _>      => vf fin          [] ;
--        <Pres,Anter,Pos,_>      => vf (have agr)   part ;
--        <Pres,Anter,Neg,_>      => vf (havent agr) part ;
--        <Past,Simul,_,  _>      => vf past         [] ;
--        <Past,Anter,Pos,_>      => vf "had"        part ;
--        <Past,Anter,Neg,_>      => vf "hadn't"     part ;
--        <Fut, Simul,Pos,_>      => vf "will"       inf ;
--        <Fut, Simul,Neg,_>      => vf "won't"      inf ;
--        <Fut, Anter,Pos,_>      => vf "will"       ("have" ++ part) ;
--        <Fut, Anter,Neg,_>      => vf "won't"      ("have" ++ part) ;
--        <Cond,Simul,Pos,_>      => vf "would"      inf ;
--        <Cond,Simul,Neg,_>      => vf "wouldn't"   inf ;
--        <Cond,Anter,Pos,_>      => vf "would"      ("have" ++ part) ;
--        <Cond,Anter,Neg,_>      => vf "wouldn't"   ("have" ++ part)
--        } ;
--    s2 = \\_ => []
--    } ;
--
--  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
--    s = vp.s ;
--    s2 = \\a => vp.s2 ! a ++ obj ! a
--    } ;
--
--- This is not functional.
--
--  insertAdV : Str -> VP -> VP = \adv,vp -> {
--    s = vp.s ;
--    s2 = vp.s2
--    } ;
--
--  presVerb : {s : VForm => Str} -> Agr -> Str = \verb -> 
--    agrVerb (verb.s ! VPres) (verb.s ! VInf) ;
--
--  infVP : VP -> Agr -> Str = \vp,a -> 
--    (vp.s ! Fut ! Simul ! Neg ! ODir ! a).inf ++ vp.s2 ! a ;
--
--  agrVerb : Str -> Str -> Agr -> Str = \has,have,agr -> 
--    case agr of {
--      {n = Sg ; p = P3} => has ;
--      _                 => have
--      } ;
--
--  have   = agrVerb "has"     "have" ;
--  havent = agrVerb "hasn't"  "haven't" ;
--  does   = agrVerb "does"    "do" ;
--  doesnt = agrVerb "doesn't" "don't" ;
--
--  Aux = {pres,past : Polarity => Agr => Str ; inf,ppart : Str} ;
--
--  auxBe : Aux = {
--    pres = \\b,a => case <b,a> of {
--      <Pos,{n = Sg ; p = P1}> => "am" ; 
--      <Neg,{n = Sg ; p = P1}> => ["am not"] ; --- am not I
--      _ => agrVerb (posneg b "is")  (posneg b "are") a
--      } ;
--    past = \\b,a => agrVerb (posneg b "was") (posneg b "were") a ;
--    inf  = "be" ;
--    ppart = "been"
--    } ;
--
--  posneg : Polarity -> Str -> Str = \p,s -> case p of {
--    Pos => s ;
--    Neg => s + "n't"
--    } ;
--
--  conjThat : Str = "that" ;
--
--  reflPron : Agr => Str = table {
--    {n = Sg ; p = P1} => "myself" ;
--    {n = Sg ; p = P2} => "yourself" ;
--    {n = Sg ; p = P3} => "itself" ; --
--    {n = Pl ; p = P1} => "ourselves" ;
--    {n = Pl ; p = P2} => "yourselves" ;
--    {n = Pl ; p = P3} => "themselves"
--    } ;
--
-- For $Sentence$.
--
--  Clause : Type = {
--    s : Tense => Anteriority => Polarity => Order => Str
--    } ;
--
--  mkClause : Str -> Agr -> VP -> Clause =
--    \subj,agr,vp -> {
--      s = \\t,a,b,o => 
--        let 
--          verb  = vp.s ! t ! a ! b ! o ! agr ;
--          compl = vp.s2 ! agr
--        in
--        case o of {
--          ODir   => subj ++ verb.fin ++ verb.inf ++ compl ;
--          OQuest => verb.fin ++ subj ++ verb.inf ++ compl
--          }
--    } ;
--
--
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
