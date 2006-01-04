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
-- are always the same except for the dative.

  Noun : Type = {s : Number => Case => Str ; g : Gender} ;

  mkNoun  : (x1,_,_,_,_,x6 : Str) -> Gender -> Noun = 
    \mann, mannen, manne, mannes, maenner, maennern, g -> {
     s = table {
       Sg => caselist mann mannen manne mannes ;
       Pl => caselist maenner maenner maennern maenner
       } ; 
     g = g
    } ;

-- But we never need all the six forms at the same time. Often
-- we need just two or four forms.

  mkNoun4 : (x1,_,_,x4 : Str) -> Gender -> Noun = \wein,weines,weine,weinen ->
    mkNoun wein wein wein weines weine weinen ;

  mkNoun2 : (x1,x2 : Str) -> Gender -> Noun = \frau,frauen ->
    mkNoun4 frau frau frauen frauen ;

-- Adjectives need four forms: two for the positive and one for the other degrees.

  Adjective : Type = {s : Degree => AForm => Str} ;

  mkAdjective : (x1,_,_,x4 : Str) -> Adjective = \gut,gute,besser,best -> 
    {s = table {
       Posit  => adjForms gut gute ; 
       Compar => adjForms besser besser ; 
       Superl => adjForms best best
       }
    } ;

  regAdjective : Str -> Adjective = \blau ->
    mkAdjective blau blau (blau + "er") (blau + "est") ;

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

  Verb : Type = {s : VForm => Str} ;

  mkVerb : (x1,_,_,_,_,x6 : Str) -> Verb = \geben,gibt,gib,gab,gaebe,gegeben -> 
    let
      ifSibilant : Str -> Str -> Str -> Str = \u,b1,b2 -> 
        case u of {
          "s" => b1 ;
          "x" => b1 ;
          "z" => b1 ;
          "ß" => b1 ;
          _   => b2 
          } ; 
      en = Predef.dp 2 geben ;
      geb = case Predef.tk 1 en of {
        "e" => Predef.tk 2 geben ;
         _  => Predef.tk 1 geben
         } ;
      gebt = geb + (adde geb) + "t" ;
      gebte = ifTok Tok (Predef.dp 1 gab) "e" gab (gab + "e") ;
      gibst = ifSibilant (Predef.dp 1 gib) (gib + "t") (gib + "st") ;
      gegebener = (regAdjective gegeben).s ;
    in {s = table {
       VInf       => geben ;
       VInd Sg P1 => geb + "e" ;
       VInd Sg P2 => gibst ;
       VInd Sg P3 => gibt ;
       VInd Pl P2 => gebt ;
       VInd Pl _  => geben ; -- the famous law
       VImp Sg    => gib + (impe gib) ;
       VImp Pl    => gebt ;
       VSubj Sg P1 => geb + "e" ;
       VSubj Sg P2 => geb + "est" ;
       VSubj Sg P3 => geb + "e" ;
       VSubj Pl P2 => geb + "et" ;
       VSubj Pl _  => geben ;
       VPresPart a => (regAdjective (geben + "d")).s ! a ;

       VImpfInd Sg P1 => gab ;
       VImpfInd Sg P2 => gab + (adde gab) + "st" ;
       VImpfInd Sg P3 => gab ;
       VImpfInd Pl P2 => gab + (adde gab) + "t" ;
       VImpfInd Pl _  => gebte + "n" ;

       VImpfSubj Sg P1 => gaebe ;
       VImpfSubj Sg P2 => gaebe + "st" ;
       VImpfSubj Sg P3 => gaebe ;
       VImpfSubj Pl P2 => gaebe + "t" ;
       VImpfSubj Pl _  => gaebe + "n" ;

       VPart a    => gegebener ! a
       }
     } ;
 
-- Weak verbs:
  regVerb : Str -> Verb = \legen ->
    let 
       leg = Predef.tk 2 legen ;
       legte = leg + "te" ;
    in
       mkVerb legen (leg+(adde leg)+"t") leg legte legte ("ge"+leg+"t") ;


  adde : Str -> Str = \stem ->
   let
     eVowelorLiquid : Str -> Str = \u -> 
      case u of {
        "l" | "r" | "a" | "o" | "u" | "e" | "i" | "ü" | "ä" | "ö" => "e" ;
        _   => [] 
        } ;   

     eConsonantmn : Str -> Str -> Str = \nl,l -> 
      case l of {
        "m" | "n" => eVowelorLiquid nl ;
        _ => []
        } ;
 
     nl = init (Predef.dp 2 stem) ;
     l  = last stem ;
     e  = case l of {
           "d" | t => "e" ;
           _ => eConsonantmn nl l
           } ;
   in 
     e ;


--    mkVerb : (_,_,_,_,_ : Str) -> {s : VForm => Str} = 
--      \go,goes,went,gone,going -> {
--      s = table {
--        VInf   => go ;
--        VPres  => goes ;
--        VPast  => went ;
--        VPPart => gone ;
--        VPresPart => going
--        }
--      } ;
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
--
--    regN : Str -> {s : Number => Case => Str} = \car ->
--      mkNoun car (car + "'s") (car + "s") (car + "s'") ;
--
--    regA : Str -> {s : AForm => Str} = \warm ->
--      mkAdjective warm (warm + "er") (warm + "est") (warm + "ly") ;
--
--    regV : Str -> {s : VForm => Str} = \walk ->
--      mkVerb walk (walk + "s") (walk + "ed") (walk + "ed") (walk + "ing") ;
--
--    regNP : Str -> Number -> {s : Case => Str ; a : Agr} = \that,n ->
--      mkNP that that (that + "'s") n P3 ;
--
-- We have just a heuristic definition of the indefinite article.
-- There are lots of exceptions: consonantic "e" ("euphemism"), consonantic
-- "o" ("one-sided"), vocalic "u" ("umbrella").
--
--    artIndef = pre {
--      "a" ; 
--      "an" / strs {"a" ; "e" ; "i" ; "o" ; "A" ; "E" ; "I" ; "O" }
--      } ;
--
--    artDef = "the" ;
--
-- For $Verb$.
--
--  Verb : Type = {
--    s : VForm => Str
--    } ;
--
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
