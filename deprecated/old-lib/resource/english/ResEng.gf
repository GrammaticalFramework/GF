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

-- Agreement of $NP$ has 8 values. $Gender$ is needed for "who"/"which" and
-- for "himself"/"herself"/"itself".

  param
    Agr = AgP1 Number | AgP2 Number | AgP3Sg Gender | AgP3Pl ;

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
 
    RAgr = RNoAg | RAg Agr ;
    RCase = RPrep Gender | RC Gender Case ;

--2 For $Numeral$

    CardOrd = NCard | NOrd ;
    DForm = unit | teen | ten  ;

--2 Transformations between parameter types

  oper
    toAgr : Number -> Person -> Gender -> Agr = \n,p,g -> 
      case p of {
        P1 => AgP1 n ;
        P2 => AgP2 n ;
        P3 => case n of {
          Sg => AgP3Sg g ;
          Pl => AgP3Pl
          }
        } ;

    fromAgr : Agr -> {n : Number ; p : Person ; g : Gender} = \a -> case a of {
      AgP1 n => {n = n ; p = P1 ; g = Masc} ;
      AgP2 n => {n = n ; p = P2 ; g = Masc} ;
      AgP3Pl => {n = Pl ; p = P3 ; g = Masc} ;
      AgP3Sg g => {n = Sg ; p = P3 ; g = g}
      } ;

    agrP3 : Number -> Agr = \n -> agrgP3 n Neutr ;

    agrgP3 : Number -> Gender -> Agr = \n,g -> toAgr n P3 g ;

    conjAgr : Agr -> Agr -> Agr = \a0,b0 -> 
      let a = fromAgr a0 ; b = fromAgr b0 
      in
      toAgr
        (conjNumber a.n b.n)
        (conjPerson a.p b.p) a.g ;

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
     \i,me,my,n -> let who = mkNP i me my n P3 Neutr in {
        s = who.s ; 
        n = n
        } ;

    mkNP : (i,me,my : Str) -> Number -> Person -> Gender -> 
     {s : Case => Str ; a : Agr} =
     \i,me,my,n,p,g -> {
     s = table {
       Nom => i ;
       Acc => me ;
       Gen => my
       } ;
     a = toAgr n p g ;
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
      mkNP that that (that + "'s") n P3 Neutr ;

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

  param
  CPolarity = 
     CPos
   | CNeg Bool ;  -- contracted or not

  oper
  contrNeg : Bool -> Polarity -> CPolarity = \b,p -> case p of {
    Pos => CPos ;
    Neg => CNeg b
    } ;

  VerbForms : Type =
    Tense => Anteriority => CPolarity => Order => Agr => 
      {aux, adv, fin, inf : Str} ; -- would, not, sleeps, slept

  VP : Type = {
    s   : VerbForms ;
    prp : Str ;   -- present participle 
    inf : Str ;   -- the infinitive form ; VerbForms would be the logical place
    ad  : Str ;   -- sentence adverb
    s2  : Agr => Str -- complement
    } ;


  SlashVP = VP ** {c2 : Str} ;

  predVc : (Verb ** {c2 : Str}) -> SlashVP = \verb -> 
    predV verb ** {c2 = verb.c2} ;

  predV : Verb -> VP = \verb -> {
    s = \\t,ant,b,ord,agr => 
      let
        inf  = verb.s ! VInf ;
        fin  = presVerb verb agr ;
        part = verb.s ! VPPart ;
      in
      case <t,ant,b,ord> of {
        <Pres,Simul,CPos,ODir>   => vff            fin [] ;
        <Pres,Simul,CPos,OQuest> => vf (does agr)   inf ;
        <Pres,Anter,CPos,_>      => vf (have agr)   part ; --# notpresent
        <Pres,Anter,CNeg c,_>    => vfn c (have agr) (havent agr) part ; --# notpresent
        <Past,Simul,CPos,ODir>   => vff (verb.s ! VPast) [] ; --# notpresent
        <Past,Simul,CPos,OQuest> => vf "did"        inf ; --# notpresent
        <Past,Simul,CNeg c,_>    => vfn c "did" "didn't"     inf ; --# notpresent
        <Past,Anter,CPos,_>      => vf "had"        part ; --# notpresent
        <Past,Anter,CNeg c,_>    => vfn c "had" "hadn't"     part ; --# notpresent
        <Fut, Simul,CPos,_>      => vf "will"       inf ; --# notpresent
        <Fut, Simul,CNeg c,_>    => vfn c "will" "won't"      inf ; --# notpresent
        <Fut, Anter,CPos,_>      => vf "will"       ("have" ++ part) ; --# notpresent
        <Fut, Anter,CNeg c,_>    => vfn c "will" "won't"("have" ++ part) ; --# notpresent
        <Cond,Simul,CPos,_>      => vf "would"      inf ; --# notpresent
        <Cond,Simul,CNeg c,_>    => vfn c "would" "wouldn't"   inf ; --# notpresent
        <Cond,Anter,CPos,_>      => vf "would"      ("have" ++ part) ; --# notpresent
        <Cond,Anter,CNeg c,_> => vfn c "would" "wouldn't" ("have" ++ part) ; --# notpresent
        <Pres,Simul,CNeg c,_>    => vfn c (does agr) (doesnt agr) inf
        } ;
    prp  = verb.s ! VPresPart ;
    inf  = verb.s ! VInf ;
    ad   = [] ;
    s2 = \\a => if_then_Str verb.isRefl (reflPron ! a) []
    } ;

  predAux : Aux -> VP = \verb -> {
    s = \\t,ant,cb,ord,agr => 
      let 
        b = case cb of {
          CPos => Pos ;
          _ => Neg
          } ;
        inf  = verb.inf ;
        fin  = verb.pres ! b ! agr ;
        finp = verb.pres ! Pos ! agr ;
        part = verb.ppart ;
      in
      case <t,ant,cb,ord> of {
        <Pres,Anter,CPos,_>      => vf (have agr)   part ;  --# notpresent
        <Pres,Anter,CNeg c,_>    => vfn c (have agr) (havent agr) part ; --# notpresent
        <Past,Simul,CPos,  _>    => vf (verb.past ! b ! agr) [] ; --# notpresent
        <Past,Simul,CNeg c,  _> => vfn c (verb.past!Pos!agr)(verb.past!Neg!agr) [] ; --# notpresent
        <Past,Anter,CPos,_>      => vf "had"        part ; --# notpresent
        <Past,Anter,CNeg c,_>    => vfn c "had" "hadn't"     part ; --# notpresent
        <Fut, Simul,CPos,_>      => vf "will"       inf ; --# notpresent
        <Fut, Simul,CNeg c,_>    => vfn c "will" "won't"      inf ; --# notpresent
        <Fut, Anter,CPos,_>      => vf "will"       ("have" ++ part) ; --# notpresent
        <Fut, Anter,CNeg c,_>    => vfn c "will" "won't"("have" ++ part) ; --# notpresent
        <Cond,Simul,CPos,_>      => vf "would"      inf ; --# notpresent
        <Cond,Simul,CNeg c,_>    => vfn c "would" "wouldn't"   inf ; --# notpresent
        <Cond,Anter,CPos,_>      => vf "would"      ("have" ++ part) ; --# notpresent
        <Cond,Anter,CNeg c,_> => vfn c "would" "wouldn't" ("have" ++ part) ; --# notpresent
        <Pres,Simul,CPos,  _>    => vf fin          [] ;
        <Pres,Simul,CNeg c,  _>  => vfn c finp fin          [] 
        } ;
    prp = verb.prpart ;
    inf = verb.inf ;
    ad = [] ;
    s2 = \\_ => []
    } ;
        
  vff : Str -> Str -> {aux, adv, fin, inf : Str} = \x,y -> 
    {aux = [] ; adv = [] ; fin = x ; inf = y} ;

  vf : Str -> Str -> {aux, adv, fin, inf : Str} = \x,y -> vfn True x x y ;

  vfn : Bool -> Str -> Str -> Str -> {aux, fin, adv, inf : Str} = 
    \contr,x,y,z -> 
    case contr of {
      True  => {aux = y ; adv = [] ; fin = [] ; inf = z} ;
      False => {aux = x ; adv = "not" ; fin = [] ; inf = z}
      } ;

  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    prp = vp.prp ;
    inf = vp.inf ;
    ad = vp.ad ;
    s2 = \\a => vp.s2 ! a ++ obj ! a
    } ;

  insertObjPre : (Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    prp = vp.prp ;
    inf = vp.inf ;
    ad = vp.ad ;
    s2 = \\a => obj ! a ++ vp.s2 ! a 
    } ;

  insertObjc : (Agr => Str) -> SlashVP -> SlashVP = \obj,vp -> 
    insertObj obj vp ** {c2 = vp.c2} ;

--- The adverb should be before the finite verb.

  insertAdV : Str -> VP -> VP = \ad,vp -> {
    s = vp.s ;
    prp = vp.prp ;
    inf = vp.inf ;
    ad  = vp.ad ++ ad ;
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
    vp.ad ++ 
    case isAux of {True => [] ; False => "to"} ++ 
    vp.inf ++ vp.s2 ! a ;

  agrVerb : Str -> Str -> Agr -> Str = \has,have,agr -> 
    case agr of {
      AgP3Sg _ => has ;
      _        => have
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
      <Pos,AgP1 Sg> => "am" ; 
      <Neg,AgP1 Sg> => ["am not"] ; --- am not I
      _ => agrVerb (posneg b "is")  (posneg b "are") a
      } ;
    past = \\b,a => case a of {          --# notpresent
      AgP1 Sg | AgP3Sg _ => posneg b "was" ; --# notpresent
      _                  => (posneg b "were")  --# notpresent
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
    AgP1 Sg      => "myself" ;
    AgP2 Sg      => "yourself" ;
    AgP3Sg Masc  => "himself" ;
    AgP3Sg Fem   => "herself" ;
    AgP3Sg Neutr => "itself" ;
    AgP1 Pl      => "ourselves" ;
    AgP2 Pl      => "yourselves" ;
    AgP3Pl       => "themselves"
    } ;

-- For $Sentence$.

  Clause : Type = {
    s : Tense => Anteriority => CPolarity => Order => Str
    } ;

  mkClause : Str -> Agr -> VP -> Clause =
    \subj,agr,vp -> {
      s = \\t,a,b,o => 
        let 
          verb  = vp.s ! t ! a ! b ! o ! agr ;
          compl = vp.s2 ! agr
        in
        case o of {
          ODir => subj ++ verb.aux ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf ++ compl ;
          OQuest => verb.aux ++ subj ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf ++ compl
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
      {s : Tense => Anteriority => CPolarity => QForm => Str} = \wh,cl ->
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

-- for VP conjunction

  param
    VPIForm = VPIInf | VPIPPart ;


}
