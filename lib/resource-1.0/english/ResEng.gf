--# -path=.:../abstract:../common:../../prelude

--1 English auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.

resource ResEng = ParamX ** open Prelude in {

  flags optimize=all ;


-- Some parameters, such as $Number$, are inherited from $ParamX$.

--2 For $Noun$

-- This is the worst-case $Case$ needed for pronouns.

  param
    Case = Nom | Acc | Gen ;

-- Agreement of $NP$ is a record. We'll add $Gender$ later.

  oper
    Agr = {n : Number ; p : Person} ;

  param 
    Gender = Neutr | Masc | Fem ;

--2 For $Verb$

-- Only these five forms are needed for open-lexicon verbs.

  param
    VForm = 
       VInf
     | VPres
     | VPPart
     | VPresPart
     | VPast      --# notpresent
     ;

-- Auxiliary verbs have special negative forms.

    VVForm = 
       VVF VForm
     | VVPresNeg
     | VVPastNeg  --# notpresent
     ;

-- The order of sentence is needed already in $VP$.

    Order = ODir | OQuest ;


--2 For $Adjective$

    AForm = AAdj Degree | AAdv ;

--2 For $Relative$
 
    RAgr = RNoAg | RAg {n : Number ; p : Person} ;
    RCase = RPrep | RC Case ;

--2 For $Numeral$

    CardOrd = NCard | NOrd ;
    DForm = unit | teen | ten  ;

--2 Transformations between parameter types

  oper
    agrP3 : Number -> Agr = \n -> 
      {n = n ; p = P3} ;

    conjAgr : Agr -> Agr -> Agr = \a,b -> {
      n = conjNumber a.n b.n ;
      p = conjPerson a.p b.p
      } ;

-- For $Lex$.

-- For each lexical category, here are the worst-case constructors.

    mkNoun : (_,_,_,_ : Str) -> {s : Number => Case => Str} = 
      \man,mans,men,mens -> {
      s = table {
        Sg => table {
          Gen => mans ;
          _ => man
          } ;
        Pl => table {
          Gen => mens ;
          _ => men
          }
        }
      } ;

    mkAdjective : (_,_,_,_ : Str) -> {s : AForm => Str} = 
      \good,better,best,well -> {
      s = table {
        AAdj Posit  => good ;
        AAdj Compar => better ;
        AAdj Superl => best ;
        AAdv        => well
        }
      } ;

    mkVerb : (_,_,_,_,_ : Str) -> Verb = 
      \go,goes,went,gone,going -> {
      s = table {
        VInf   => go ;
        VPres  => goes ;
        VPast  => went ; --# notpresent
        VPPart => gone ;
        VPresPart => going
        } ;
      isRefl = False
      } ;

    mkIP : (i,me,my : Str) -> Number -> {s : Case => Str ; n : Number} =
     \i,me,my,n -> let who = mkNP i me my n P3 in {s = who.s ; n = n} ;

    mkNP : (i,me,my : Str) -> Number -> Person -> {s : Case => Str ; a : Agr} =
     \i,me,my,n,p -> {
     s = table {
       Nom => i ;
       Acc => me ;
       Gen => my
       } ;
     a = {
       n = n ;
       p = p
       }
     } ;

-- These functions cover many cases; full coverage inflectional patterns are
-- in $MorphoEng$.

    regN : Str -> {s : Number => Case => Str} = \car ->
      mkNoun car (car + "'s") (car + "s") (car + "s'") ;

    regA : Str -> {s : AForm => Str} = \warm ->
      mkAdjective warm (warm + "er") (warm + "est") (warm + "ly") ;

    regV : Str -> Verb = \walk ->
      mkVerb walk (walk + "s") (walk + "ed") (walk + "ed") (walk + "ing") ;

    regNP : Str -> Number -> {s : Case => Str ; a : Agr} = \that,n ->
      mkNP that that (that + "'s") n P3 ;

-- We have just a heuristic definition of the indefinite article.
-- There are lots of exceptions: consonantic "e" ("euphemism"), consonantic
-- "o" ("one-sided"), vocalic "u" ("umbrella").

    artIndef = pre {
      "a" ; 
      "an" / strs {"a" ; "e" ; "i" ; "o" ; "A" ; "E" ; "I" ; "O" }
      } ;

    artDef = "the" ;

-- For $Verb$.

  Verb : Type = {
    s : VForm => Str ;
    isRefl : Bool
    } ;

  VerbForms : Type =
    Tense => Anteriority => Polarity => Order => Agr => {fin, inf : Str} ; 

  VP : Type = {
    s   : VerbForms ;
    prp : Str ; -- present participle 
    inf : Str ; -- infinitive
    ad  : Str ;
    s2  : Agr => Str
    } ;


--- The order gets wrong with AdV, but works around a parser
--- generation bug.

  predV : Verb -> VP = \verb -> {
    s = \\t,ant,b,ord,agr => 
      let
        inf  = verb.s ! VInf ;
        fin  = presVerb verb agr ;
        part = verb.s ! VPPart ;
        vf : Str -> Str -> {fin, inf : Str} = \x,y -> 
          {fin = x ; inf = y} ;
      in
      case <t,ant,b,ord> of {
        <Pres,Simul,Pos,ODir>   => vf            fin [] ; --- should be opp
        <Pres,Simul,Pos,OQuest> => vf (does agr)   inf ;
        <Pres,Anter,Pos,_>      => vf (have agr)   part ; --# notpresent
        <Pres,Anter,Neg,_>      => vf (havent agr) part ; --# notpresent
        <Past,Simul,Pos,ODir>   => vf (verb.s ! VPast) [] ; --# notpresent --- should be opp
        <Past,Simul,Pos,OQuest> => vf "did"        inf ; --# notpresent
        <Past,Simul,Neg,_>      => vf "didn't"     inf ; --# notpresent
        <Past,Anter,Pos,_>      => vf "had"        part ; --# notpresent
        <Past,Anter,Neg,_>      => vf "hadn't"     part ; --# notpresent
        <Fut, Simul,Pos,_>      => vf "will"       inf ; --# notpresent
        <Fut, Simul,Neg,_>      => vf "won't"      inf ; --# notpresent
        <Fut, Anter,Pos,_>      => vf "will"       ("have" ++ part) ; --# notpresent
        <Fut, Anter,Neg,_>      => vf "won't"      ("have" ++ part) ; --# notpresent
        <Cond,Simul,Pos,_>      => vf "would"      inf ; --# notpresent
        <Cond,Simul,Neg,_>      => vf "wouldn't"   inf ; --# notpresent
        <Cond,Anter,Pos,_>      => vf "would"      ("have" ++ part) ; --# notpresent
        <Cond,Anter,Neg,_>      => vf "wouldn't"   ("have" ++ part) ; --# notpresent
        <Pres,Simul,Neg,_>      => vf (doesnt agr) inf
        } ;
    prp  = verb.s ! VPresPart ;
    inf  = verb.s ! VInf ;
    ad = [] ;
    s2 = \\a => if_then_Str verb.isRefl (reflPron ! a) []
    } ;

  predAux : Aux -> VP = \verb -> {
    s = \\t,ant,b,ord,agr => 
      let 
        inf  = verb.inf ;
        fin  = verb.pres ! b ! agr ;
        part = verb.ppart ;
        vf : Str -> Str -> {fin, inf : Str} = \x,y -> 
          {fin = x ; inf = y} ;
      in
      case <t,ant,b,ord> of {
        <Pres,Anter,Pos,_>      => vf (have agr)   part ;  --# notpresent
        <Pres,Anter,Neg,_>      => vf (havent agr) part ; --# notpresent
        <Past,Simul,_,  _>      => vf (verb.past ! b ! agr) [] ; --# notpresent
        <Past,Anter,Pos,_>      => vf "had"        part ; --# notpresent
        <Past,Anter,Neg,_>      => vf "hadn't"     part ; --# notpresent
        <Fut, Simul,Pos,_>      => vf "will"       inf ; --# notpresent
        <Fut, Simul,Neg,_>      => vf "won't"      inf ; --# notpresent
        <Fut, Anter,Pos,_>      => vf "will"       ("have" ++ part) ; --# notpresent
        <Fut, Anter,Neg,_>      => vf "won't"      ("have" ++ part) ; --# notpresent
        <Cond,Simul,Pos,_>      => vf "would"      inf ; --# notpresent
        <Cond,Simul,Neg,_>      => vf "wouldn't"   inf ; --# notpresent
        <Cond,Anter,Pos,_>      => vf "would"      ("have" ++ part) ; --# notpresent
        <Cond,Anter,Neg,_>      => vf "wouldn't"   ("have" ++ part) ; --# notpresent
        <Pres,Simul,_,  _>      => vf fin          [] 
        } ;
    prp = verb.prpart ;
    inf = verb.inf ;
    ad = [] ;
    s2 = \\_ => []
    } ;

  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    prp = vp.prp ;
    inf = vp.inf ;
    ad = vp.ad ;
    s2 = \\a => vp.s2 ! a ++ obj ! a
    } ;

--- The adverb should be before the finite verb.

  insertAdV : Str -> VP -> VP = \adv,vp -> {
    s = vp.s ;
    prp = vp.prp ;
    inf = vp.inf ;
    ad = vp.ad ++ adv ;
    s2 = \\a => vp.s2 ! a
    } ;

-- 

  predVV : {s : VVForm => Str ; isAux : Bool} -> VP = \verb ->
    let verbs = verb.s
    in
    case verb.isAux of {
      True => predAux {
        pres = table {
          Pos => \\_ => verbs ! VVF VPres ;
          Neg => \\_ => verbs ! VVPresNeg
          } ;
        past = table {                       --# notpresent
          Pos => \\_ => verbs ! VVF VPast ;  --# notpresent
          Neg => \\_ => verbs ! VVPastNeg    --# notpresent
          } ;    --# notpresent
        inf = verbs ! VVF VInf ;
        ppart = verbs ! VVF VPPart ;
        prpart = verbs ! VVF VPresPart ;
        } ;
      _    => predV {s = \\vf => verbs ! VVF vf ; isRefl = False}
      } ;

  presVerb : {s : VForm => Str} -> Agr -> Str = \verb -> 
    agrVerb (verb.s ! VPres) (verb.s ! VInf) ;

  infVP : Bool -> VP -> Agr -> Str = \isAux,vp,a ->
    vp.ad ++ if_then_Str isAux [] "to" ++ 
    vp.inf ++ vp.s2 ! a ;

  agrVerb : Str -> Str -> Agr -> Str = \has,have,agr -> 
    case agr of {
      {n = Sg ; p = P3} => has ;
      _                 => have
      } ;

  have   = agrVerb "has"     "have" ;
  havent = agrVerb "hasn't"  "haven't" ;
  does   = agrVerb "does"    "do" ;
  doesnt = agrVerb "doesn't" "don't" ;

  Aux = {
    pres : Polarity => Agr => Str ; 
    past : Polarity => Agr => Str ;  --# notpresent
    inf,ppart,prpart : Str
    } ;

  auxBe : Aux = {
    pres = \\b,a => case <b,a> of {
      <Pos,{n = Sg ; p = P1}> => "am" ; 
      <Neg,{n = Sg ; p = P1}> => ["am not"] ; --- am not I
      _ => agrVerb (posneg b "is")  (posneg b "are") a
      } ;
    past = \\b,a => case a of {                  --# notpresent
      {n = Sg ; p = P1|P3} => (posneg b "was") ; --# notpresent
      _                    => (posneg b "were") --# notpresent
      } ; --# notpresent
    inf  = "be" ;
    ppart = "been" ;
    prpart = "being"
    } ;

  posneg : Polarity -> Str -> Str = \p,s -> case p of {
    Pos => s ;
    Neg => s + "n't"
    } ;

  conjThat : Str = "that" ;

  reflPron : Agr => Str = table {
    {n = Sg ; p = P1} => "myself" ;
    {n = Sg ; p = P2} => "yourself" ;
    {n = Sg ; p = P3} => "itself" ; ----
    {n = Pl ; p = P1} => "ourselves" ;
    {n = Pl ; p = P2} => "yourselves" ;
    {n = Pl ; p = P3} => "themselves"
    } ;

-- For $Sentence$.

  Clause : Type = {
    s : Tense => Anteriority => Polarity => Order => Str
    } ;

  mkClause : Str -> Agr -> VP -> Clause =
    \subj,agr,vp -> {
      s = \\t,a,b,o => 
        let 
          verb  = vp.s ! t ! a ! b ! o ! agr ;
          compl = vp.s2 ! agr
        in
        case o of {
          ODir   => subj ++ verb.fin ++ vp.ad ++ verb.inf ++ compl ;
          OQuest => verb.fin ++ subj ++ vp.ad ++ verb.inf ++ compl
          }
    } ;


-- For $Numeral$.

  mkNum : Str -> Str -> Str -> Str -> {s : DForm => CardOrd => Str} = 
    \two, twelve, twenty, second ->
    {s = table {
       unit => table {NCard => two ; NOrd => second} ; 
       teen => \\c => mkCard c twelve ; 
       ten  => \\c => mkCard c twenty
       }
    } ;

  regNum : Str -> {s : DForm => CardOrd => Str} = 
    \six -> mkNum six (six + "teen") (six + "ty") (regOrd six) ;

  regCardOrd : Str -> {s : CardOrd => Str} = \ten ->
    {s = table {NCard => ten ; NOrd => regOrd ten}} ;

  mkCard : CardOrd -> Str -> Str = \c,ten -> 
    (regCardOrd ten).s ! c ; 

  regOrd : Str -> Str = \ten -> 
    case last ten of {
      "y" => init ten + "ieth" ;
      _   => ten + "th"
      } ;

  mkQuestion : 
      {s : Str} -> Clause -> 
      {s : Tense => Anteriority => Polarity => QForm => Str} = \wh,cl ->
      {
      s = \\t,a,p => 
            let 
              cls = cl.s ! t ! a ! p ;
              why = wh.s
            in table {
              QDir   => why ++ cls ! OQuest ;
              QIndir => why ++ cls ! ODir
              }
      } ;

}
