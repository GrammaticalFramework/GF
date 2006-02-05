--# -path=.:../abstract:../common:../../prelude

--1 Finnish auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.

resource ResFin = ParamX ** open Prelude in {

  flags optimize=all ;


--2 Parameterd for $Noun$

-- This is the $Case$ as needed for both nouns and $NP$s.

  param
    Case = Nom | Gen | Part | Transl | Ess 
         | Iness | Elat | Illat | Adess | Ablat | Allat 
         | Abess ;  -- Comit, Instruct in NForm 

    NForm = NCase Number Case 
          | NComit | NInstruct  -- no number dist
          | NPossNom | NPossGenPl | NPossTransl Number | NPossIllat Number ;

-- Agreement of $NP$ is a record. We'll add $Gender$ later.

  oper
    Agr = {n : Number ; p : Person} ;

    NP = {s : NPForm => Str ; a : Agr ; isPron : Bool} ;

--
--2 Adjectives
--
-- The major division is between the comparison degrees. A degree fixed,
-- an adjective is like common nouns, except for the adverbial form.

param
  AForm = AN NForm | AAdv ;

oper
  Adjective : Type = {s : Degree => AForm => Str} ;

--2 Noun phrases
--
-- Two forms of *virtual accusative* are needed for nouns in singular, 
-- the nominative and the genitive one ("ostan talon"/"osta talo"). 
-- For nouns in plural, only a nominative accusative exist. Pronouns
-- have a uniform, special accusative form ("minut", etc).

param 
  NPForm = NPCase Case | NPAcc ;

oper
  npform2case : NPForm -> Case = \f -> case f of {
    NPCase c => c ;
    NPAcc    => Gen -- appCompl does the job
    } ;

--2 For $Verb$

-- A special form is needed for the negated plural imperative.

param
  VForm = 
     Inf InfForm
   | Presn Number Person
   | Impf Number Person
   | Condit Number Person
   | Imper Number
   | ImperP3 Number
   | ImperP1Pl
   | ImpNegPl
   | Pass Bool 
   | PastPartAct  AForm
   | PastPartPass AForm
   ;

  InfForm =
     Inf1
   | Inf3Iness  -- 5 forms acc. to Karlsson
   | Inf3Elat
   | Inf3Illat
   | Inf3Adess
   | Inf3Abess
   ;

  SType = SDecl | SQuest ;

--2 For $Relative$
 
    RAgr = RNoAg | RAg {n : Number ; p : Person} ;

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

---

  Compl : Type = {s : Str ; c : NPForm ; isPre : Bool} ;

  appCompl : Bool -> Polarity -> Compl -> NP -> Str = \isFin,b,co,np ->
    let
      c = case <isFin, b, co.c, np.isPron,np.a.n> of {
        <_,    Neg, NPAcc,_,_>    => NPCase Part ; -- en näe taloa/sinua
        <_,    Pos, NPAcc,True,_> => NPAcc ;       -- näen/täytyy sinut
        <True, Pos, NPAcc,False,Sg> => NPCase Gen ;  -- näen talon
        <False,Pos, NPAcc,_,Pl>   => NPCase Nom ;  -- täytyy talo/sinut; näen talot
        <_,_,coc,_,_>               => coc
        } ;
      nps = np.s ! c
    in
    preOrPost co.isPre co.s nps ;

-- For $Verb$.

  Verb : Type = {
    s : VForm => Str
    } ;

param
  VIForm =
     VIFin Tense  
   | VIInf InfForm 
   | VIImper 
   ;  

oper
  VP = {
    s   : VIForm => Anteriority => Polarity => Agr => {fin, inf : Str} ; 
    s2  : Polarity => Agr => Str ; -- itseni/itseäni
    ext : Str ;
    sc  : NPForm
    } ;
    
  predV : (Verb ** {sc : NPForm}) -> VP = \verb -> {
    s = \\vi,ant,b,agr => 
      let

        verbs = verb.s ;
        part : Str = verbs ! PastPartAct (AN (NCase agr.n Nom)) ; 

        eiv : Str = case agr of {
          {n = Sg ; p = P1} => "en" ;
          {n = Sg ; p = P2} => "et" ;
          {n = Sg ; p = P3} => "ei" ;
          {n = Pl ; p = P1} => "emme" ;
          {n = Pl ; p = P2} => "ette" ;
          {n = Pl ; p = P3} => "eivät"
          } ;

        einegole : Str * Str * Str = case <vi,agr.n> of {
          <VIFin (Pres | Fut),_>  => <eiv, verbs ! Imper Sg,     "ole"> ;
          <VIFin Cond,        _>  => <eiv, verbs ! Condit Sg P3, "olisi"> ;
          <VIFin Past,        Sg> => <eiv, part,                 "ollut"> ;
          <VIFin Past,        Pl> => <eiv, part,                 "olleet"> ;
          <VIImper,           Sg> => <"älä", verbs ! Imper Sg,   "ole"> ;
          <VIImper,           Pl> => <"älkää", verbs ! ImpNegPl, "olko"> ;
          <VIInf i,           _>  => <"ei", verbs ! Inf i, "olla"> ----
          } ;

        ei  : Str = einegole.p1 ;
        neg : Str = einegole.p2 ;
        ole : Str = einegole.p3 ;

        olla : VForm => Str = verbOlla.s ;

        vf : Str -> Str -> {fin, inf : Str} = \x,y -> 
          {fin = x ; inf = y} ;
        mkvf : VForm -> {fin, inf : Str} = \p -> case <ant,b> of {
          <Simul,Pos> => vf (verbs ! p) [] ;
          <Simul,Neg> => vf ei          neg ;
          <Anter,Pos> => vf (olla ! p)  part ;
          <Anter,Neg> => vf ei          (ole ++ part)
          }
      in
      case vi of {
        VIFin Past => mkvf (Impf agr.n agr.p) ; 
        VIFin Cond => mkvf (Condit agr.n agr.p) ;
        _    => mkvf (Presn agr.n agr.p)  
        } ;

    s2 = \\_,_ => [] ;
    ext = [] ;
    sc = verb.sc 
    } ;


  insertObj : (Polarity => Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    s2 = \\b,a => vp.s2 ! b ! a ++ obj ! b ! a ;
    ext = vp.ext ;
    sc = vp.sc
    } ;

{-
--- This is not functional.

  insertAdV : Str -> VP -> VP = \adv,vp -> {
    s = vp.s ;
    s2 = vp.s2
    } ;

  presVerb : {s : VForm => Str} -> Agr -> Str = \verb -> 
    agrVerb (verb.s ! VPres) (verb.s ! VInf) ;

  infVP : VP -> Agr -> Str = \vp,a -> 
    (vp.s ! Fut ! Simul ! Neg ! ODir ! a).inf ++ vp.s2 ! a ;

  agrVerb : Str -> Str -> Agr -> Str = \has,have,agr -> 
    case agr of {
      {n = Sg ; p = P3} => has ;
      _                 => have
      } ;

  have   = agrVerb "has"     "have" ;
  havent = agrVerb "hasn't"  "haven't" ;
  does   = agrVerb "does"    "do" ;
  doesnt = agrVerb "doesn't" "don't" ;

  Aux = {pres,past : Polarity => Agr => Str ; inf,ppart : Str} ;

  auxBe : Aux = {
    pres = \\b,a => case <b,a> of {
      <Pos,{n = Sg ; p = P1}> => "am" ; 
      <Neg,{n = Sg ; p = P1}> => ["am not"] ; --- am not I
      _ => agrVerb (posneg b "is")  (posneg b "are") a
      } ;
    past = \\b,a => case a of {
      {n = Sg ; p = P1|P3} => (posneg b "was") ;
      _                    => (posneg b "were")
      } ;
    inf  = "be" ;
    ppart = "been"
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
-}
-- For $Sentence$.

  Clause : Type = {
    s : Tense => Anteriority => Polarity => SType => Str
    } ;

  mkClause : Str -> Agr -> VP -> Clause =
    \subj,agr,vp -> {
      s = \\t,a,b,o => 
        let 
          verb  = vp.s ! VIFin t ! a ! b ! agr ;
          compl = vp.s2 ! b ! agr ++ vp.ext
        in
        case o of {
          SDecl  => subj ++ verb.fin ++ verb.inf ++ compl ;
          SQuest => questPart verb.fin ++ subj ++ verb.inf ++ compl
          }
    } ;

  questPart : Str -> Str = \on -> on ++ BIND ++ "ko" ; ----



{-
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
-}

-- The definitions below were moved here from $MorphoFin$ so that we the
-- auxiliary of predication can be defined.

  verbOlla : Verb = 
    mkVerb 
      "olla" "on" "olen" "ovat" "olkaa" "ollaan" 
      "oli" "olin" "olisi" "ollut" "oltu" "ollun" ;

--3 Verbs
--
-- The present, past, conditional. and infinitive stems, acc. to Koskenniemi.
-- Unfortunately not enough (without complicated processes).
-- We moreover give grade alternation forms as arguments, since it does not
-- happen automatically.
--- A problem remains with the verb "seistä", where the infinitive
--- stem has vowel harmony "ä" but the others "a", thus "seisoivat" but "seiskää".


  mkVerb : (_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Verb = 
    \tulla,tulee,tulen,tulevat,tulkaa,tullaan,tuli,tulin,tulisi,tullut,tultu,tullun -> 
    v2v (mkVerbH 
     tulla tulee tulen tulevat tulkaa tullaan tuli tulin tulisi tullut tultu tullun
      ) ;

  v2v : VerbH -> Verb = \vh -> 
    let
      tulla = vh.tulla ; 
      tulee = vh.tulee ; 
      tulen = vh.tulen ; 
      tulevat = vh.tulevat ;
      tulkaa = vh.tulkaa ; 
      tullaan = vh.tullaan ; 
      tuli = vh.tuli ; 
      tulin = vh.tulin ;
      tulisi = vh.tulisi ;
      tullut = vh.tullut ;
      tultu = vh.tultu ;
      tultu = vh.tultu ;
      tullun = vh.tullun ;
      tuje = init tulen ;
      tuji = init tulin ;
      a = Predef.dp 1 tulkaa ;
      tulko = Predef.tk 2 tulkaa + (ifTok Str a "a" "o" "ö") ;
      o = last tulko ;
      tulleena = Predef.tk 2 tullut + ("een" + a) ;
      tulleen = (noun2adj (nhn (sRae tullut tulleena))).s ;
      tullun = (noun2adj (nhn (sKukko tultu tullun (tultu + ("j"+a))))).s  ;
      tulema = tuje + "m" + a ;
      vat = "v" + a + "t"
    in
    {s = table {
      Inf Inf1 => tulla ;
      Presn Sg P1 => tuje + "n" ;
      Presn Sg P2 => tuje + "t" ;
      Presn Sg P3 => tulee ;
      Presn Pl P1 => tuje + "mme" ;
      Presn Pl P2 => tuje + "tte" ;
      Presn Pl P3 => tulevat ;
      Impf Sg P1 => tuji + "n" ;
      Impf Sg P2 => tuji + "t" ;
      Impf Sg P3 => tuli ;
      Impf Pl P1 => tuji + "mme" ;
      Impf Pl P2 => tuji + "tte" ;
      Impf Pl P3 => tuli + vat ;
      Condit Sg P1 => tulisi + "n" ;
      Condit Sg P2 => tulisi + "t" ;
      Condit Sg P3 => tulisi ;
      Condit Pl P1 => tulisi + "mme" ;
      Condit Pl P2 => tulisi + "tte" ;
      Condit Pl P3 => tulisi + vat ;
      Imper Sg   => tuje ;
      Imper Pl   => tulkaa ;
      ImperP3 Sg => tulko + o + "n" ;
      ImperP3 Pl => tulko + o + "t" ;
      ImperP1Pl  => tulkaa + "mme" ;
      ImpNegPl   => tulko ;
      Pass True  => tullaan ;
      Pass False => Predef.tk 2 tullaan ;
      PastPartAct n => tulleen ! n ;
      PastPartPass n => tullun ! n ;
      Inf Inf3Iness => tulema + "ss" + a ;
      Inf Inf3Elat  => tulema + "st" + a ;
      Inf Inf3Illat => tulema +  a   + "n" ;
      Inf Inf3Adess => tulema + "ll" + a ;
      Inf Inf3Abess => tulema + "tt" + a 
      }
    } ;

  VerbH : Type = {
    tulla,tulee,tulen,tulevat,tulkaa,tullaan,tuli,tulin,tulisi,tullut,tultu,tullun
      : Str
    } ;

  mkVerbH : (_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> VerbH = 
    \tulla,tulee,tulen,tulevat,tulkaa,tullaan,tuli,tulin,tulisi,tullut,tultu,tullun -> 
    {tulla = tulla ; 
     tulee = tulee ; 
     tulen = tulen ; 
     tulevat = tulevat ;
     tulkaa = tulkaa ; 
     tullaan = tullaan ; 
     tuli = tuli ; 
     tulin = tulin ;
     tulisi = tulisi ;
     tullut = tullut ;
     tultu = tultu ;
     tullun = tullun
     } ; 

  noun2adj : CommonNoun -> Adj = noun2adjComp True ;

  noun2adjComp : Bool -> CommonNoun -> Adj = \isPos,tuore ->
    let 
      tuoreesti  = Predef.tk 1 (tuore.s ! NCase Sg Gen) + "sti" ; 
      tuoreemmin = Predef.tk 2 (tuore.s ! NCase Sg Gen) + "in"
    in {s = table {
         AN f => tuore.s ! f ;
         AAdv => if_then_Str isPos tuoreesti tuoreemmin
         }
       } ;

  CommonNoun = {s : NForm => Str} ;

-- To form an adjective, it is usually enough to give a noun declension: the
-- adverbial form is regular.

  Adj : Type = {s : AForm => Str} ;

  NounH : Type = {
    a,vesi,vede,vete,vetta,veteen,vetii,vesii,vesien,vesia,vesiin : Str
    } ;

-- worst-case macro

  mkSubst : Str -> (_,_,_,_,_,_,_,_,_,_ : Str) -> NounH = 
    \a,vesi,vede,vete,vetta,veteen,vetii,vesii,vesien,vesia,vesiin -> 
    {a = a ;
     vesi = vesi ;
     vede = vede ;
     vete = vete ;
     vetta = vetta ;
     veteen = veteen ;
     vetii = vetii ;
     vesii = vesii ;
     vesien = vesien ;
     vesia = vesia ;
     vesiin = vesiin
    } ;

  nhn : NounH -> CommonNoun = \nh ->
    let
     a = nh.a ;
     vesi = nh.vesi ;
     vede = nh.vede ;
     vete = nh.vete ;
     vetta = nh.vetta ;
     veteen = nh.veteen ;
     vetii = nh.vetii ;
     vesii = nh.vesii ;
     vesien = nh.vesien ;
     vesia = nh.vesia ;
     vesiin = nh.vesiin
    in
    {s = table {
      NCase Sg Nom    => vesi ;
      NCase Sg Gen    => vede + "n" ;
      NCase Sg Part   => vetta ;
      NCase Sg Transl => vede + "ksi" ;
      NCase Sg Ess    => vete + ("n" + a) ;
      NCase Sg Iness  => vede + ("ss" + a) ;
      NCase Sg Elat   => vede + ("st" + a) ;
      NCase Sg Illat  => veteen ;
      NCase Sg Adess  => vede + ("ll" + a) ;
      NCase Sg Ablat  => vede + ("lt" + a) ;
      NCase Sg Allat  => vede + "lle" ;
      NCase Sg Abess  => vede + ("tt" + a) ;

      NCase Pl Nom    => vede + "t" ;
      NCase Pl Gen    => vesien ;
      NCase Pl Part   => vesia ;
      NCase Pl Transl => vesii + "ksi" ;
      NCase Pl Ess    => vetii + ("n" + a) ;
      NCase Pl Iness  => vesii + ("ss" + a) ;
      NCase Pl Elat   => vesii + ("st" + a) ;
      NCase Pl Illat  => vesiin ;
      NCase Pl Adess  => vesii + ("ll" + a) ;
      NCase Pl Ablat  => vesii + ("lt" + a) ;
      NCase Pl Allat  => vesii + "lle" ;
      NCase Pl Abess  => vesii + ("tt" + a) ;

      NComit    => vetii + "ne" ;
      NInstruct => vesii + "n" ;

      NPossNom       => vete ;
      NPossGenPl     => Predef.tk 1 vesien ;
      NPossTransl Sg => vede + "kse" ;
      NPossTransl Pl => vesii + "kse" ;
      NPossIllat Sg  => Predef.tk 1 veteen ;
      NPossIllat Pl  => Predef.tk 1 vesiin
      }
    } ;
-- Surpraisingly, making the test for the partitive, this not only covers
-- "rae", "perhe", "savuke", but also "rengas", "lyhyt" (except $Sg Illat$), etc.

  sRae : (_,_ : Str) -> NounH = \rae,rakeena ->
    let {
      a      = Predef.dp 1 rakeena ;
      rakee  = Predef.tk 2 rakeena ;
      rakei  = Predef.tk 1 rakee + "i" ;
      raet   = rae + (ifTok Str (Predef.dp 1 rae) "e" "t" [])
    } 
    in
    mkSubst a 
            rae
            rakee 
            rakee
            (raet + ("t" + a)) 
            (rakee + "seen")
            rakei
            rakei
            (rakei + "den") 
            (rakei + ("t" + a))
            (rakei + "siin") ;
-- Nouns with partitive "a"/"ä" ; 
-- to account for grade and vowel alternation, three forms are usually enough
-- Examples: "talo", "kukko", "huippu", "koira", "kukka", "syylä",...

  sKukko : (_,_,_ : Str) -> NounH = \kukko,kukon,kukkoja ->
    let {
      o      = Predef.dp 1 kukko ;
      a      = Predef.dp 1 kukkoja ;
      kukkoj = Predef.tk 1 kukkoja ;
      i      = Predef.dp 1 kukkoj ;
      ifi    = ifTok Str i "i" ;
      kukkoi = ifi kukkoj (Predef.tk 1 kukkoj) ;
      e      = Predef.dp 1 kukkoi ;
      kukoi  = Predef.tk 2 kukon + Predef.dp 1 kukkoi
    } 
    in
    mkSubst a 
            kukko 
            (Predef.tk 1 kukon) 
            kukko
            (kukko + a) 
            (kukko + o + "n")
            (kukkoi + ifi "" "i") 
            (kukoi + ifi "" "i") 
            (ifTok Str e "e" (Predef.tk 1 kukkoi + "ien") (kukkoi + ifi "en" "jen"))
            kukkoja
            (kukkoi + ifi "in" "ihin") ;

}
