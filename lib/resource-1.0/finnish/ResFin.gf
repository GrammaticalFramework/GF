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
          | NPossNom Number | NPossGen Number --- number needed for syntax of AdjCN
          | NPossTransl Number | NPossIllat Number ;

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
  npform2case : Number -> NPForm -> Case = \n,f -> case <f,n> of {
    <NPCase c,_> => c ;
    <NPAcc,Sg>   => Gen ;-- appCompl does the job
    <NPAcc,Pl>   => Nom
    } ;

  n2nform : NForm -> NForm = \nf -> case nf of {
    NPossNom n => NCase n Nom ; ----
    NPossGen n  => NCase n Gen ;
    NPossTransl n => NCase n Transl ;
    NPossIllat n => NCase n Illat ;
    _ => nf
    } ;


--2 For $Verb$

-- A special form is needed for the negated plural imperative.

param
  VForm = 
     Inf InfForm
   | Presn Number Person
   | Impf Number Person  --# notpresent
   | Condit Number Person  --# notpresent
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

    CardOrd = NCard NForm | NOrd NForm ;

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
        <_,    Neg, NPAcc,_,_>      => NPCase Part ; -- en näe taloa/sinua
        <_,    Pos, NPAcc,True,_>   => NPAcc ;       -- näen/täytyy sinut
        <True, Pos, NPAcc,False,Sg> => NPCase Gen ;  -- näen talon
        <False,Pos, NPAcc,_,_>      => NPCase Nom ;  -- täytyy talo/sinut; näen talot
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
     VIFin  Tense  
   | VIInf  InfForm
   | VIPass 
   | VIImper 
   ;  

oper
  VP = {
    s   : VIForm => Anteriority => Polarity => Agr => {fin, inf : Str} ; 
    s2  : Bool => Polarity => Agr => Str ; -- talo/talon/taloa
    ext : Str ;
    sc  : NPForm
    } ;
    
  predV : (Verb ** {sc : NPForm}) -> VP = \verb -> {
    s = \\vi,ant,b,agr => 
      let

        verbs = verb.s ;
        part  : Str = case vi of {
          VIPass => verbs ! PastPartPass (AN (NCase agr.n Nom)) ; 
          _      => verbs ! PastPartAct (AN (NCase agr.n Nom))
          } ; 

        eiv : Str = case agr of {
          {n = Sg ; p = P1} => "en" ;
          {n = Sg ; p = P2} => "et" ;
          {n = Sg ; p = P3} => "ei" ;
          {n = Pl ; p = P1} => "emme" ;
          {n = Pl ; p = P2} => "ette" ;
          {n = Pl ; p = P3} => "eivät"
          } ;

        einegole : Str * Str * Str = case <vi,agr.n> of {
          <VIFin Pres,_>  => <eiv, verbs ! Imper Sg,     "ole"> ;
          <VIFin Fut,_>  => <eiv, verbs ! Imper Sg,     "ole"> ;   --# notpresent
          <VIFin Cond,        _>  => <eiv, verbs ! Condit Sg P3, "olisi"> ;  --# notpresent
          <VIFin Past,        Sg> => <eiv, part,                 "ollut"> ;  --# notpresent
          <VIFin Past,        Pl> => <eiv, part,                 "olleet"> ;  --# notpresent
          <VIImper,           Sg> => <"älä", verbs ! Imper Sg,   "ole"> ;
          <VIImper,           Pl> => <"älkää", verbs ! ImpNegPl, "olko"> ;
          <VIPass,            _>  => <"ei", verbs ! Pass False,  "ole"> ;
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
          <Anter,Pos> => vf (olla ! p)  part ;    --# notpresent
          <Anter,Neg> => vf ei          (ole ++ part) ;   --# notpresent
          <Simul,Neg> => vf ei          neg
          }
      in
      case vi of {
        VIFin Past => mkvf (Impf agr.n agr.p) ;     --# notpresent
        VIFin Cond => mkvf (Condit agr.n agr.p) ;  --# notpresent
        VIFin Fut  => mkvf (Presn agr.n agr.p) ;  --# notpresent
        VIFin Pres => mkvf (Presn agr.n agr.p) ;
        VIImper    => mkvf (Imper agr.n) ;
        VIPass     => mkvf (Pass True) ;
        VIInf i    => mkvf (Inf i)
        } ;

    s2 = \\_,_,_ => [] ;
    ext = [] ;
    sc = verb.sc 
    } ;


  insertObj : (Bool => Polarity => Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    s2 = \\fin,b,a => vp.s2 ! fin ! b ! a ++ obj ! fin ! b ! a ;
    ext = vp.ext ;
    sc = vp.sc
    } ;

  insertExtrapos : Str -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    s2 = vp.s2 ;
    ext = vp.ext ++ obj ;
    sc = vp.sc
    } ;

-- For $Sentence$.

  Clause : Type = {
    s : Tense => Anteriority => Polarity => SType => Str
    } ;

  mkClause : (Polarity -> Str) -> Agr -> VP -> Clause =
    \sub,agr,vp -> {
      s = \\t,a,b,o => 
        let 
          subj = sub b ;
          agrfin = case vp.sc of {
                    NPCase Nom => <agr,True> ;
                    _ => <agrP3 Sg,False>      -- minun täytyy, minulla on
                    } ;
          verb  = vp.s ! VIFin t ! a ! b ! agrfin.p1 ;
          compl = vp.s2 ! agrfin.p2 ! b ! agr ++ vp.ext
        in
        case o of {
          SDecl  => subj ++ verb.fin ++ verb.inf ++ compl ;
          SQuest => questPart verb.fin ++ subj ++ verb.inf ++ compl
          }
    } ;

-- This is used for subjects of passives: therefore isFin in False.

  subjForm : NP -> NPForm -> Polarity -> Str = \np,sc,b -> 
    appCompl False b {s = [] ; c = sc ; isPre = True} np ;

  questPart : Str -> Str = \on -> on ++ BIND ++ "ko" ; ----

  infVP : NPForm -> Polarity -> Agr -> VP -> Str =
    \sc,pol,agr,vp ->
        let 
          fin = case sc of {     -- subject case
            NPCase Nom => True ; -- minä tahdon nähdä auton
            _ => False           -- minun täytyy nähdä auto
            } ;
          verb  = vp.s ! VIInf Inf1 ! Simul ! Pos ! agr ; -- no "ei"
          compl = vp.s2 ! fin ! pol ! agr ++ vp.ext     -- but compl. case propagated
        in
        verb.fin ++ verb.inf ++ compl ;

-- The definitions below were moved here from $MorphoFin$ so that we the
-- auxiliary of predication can be defined.

  verbOlla : Verb = 
    let olla = mkVerb 
      "olla" "on" "olen" "ovat" "olkaa" "ollaan" 
      "oli" "olin" "olisi" "ollut" "oltu" "ollun" ;
    in {s = table {
      Inf Inf3Iness => "olemassa" ;
      Inf Inf3Elat  => "olemasta" ;
      Inf Inf3Illat => "olemaan" ;
      Inf Inf3Adess => "olemalla" ;
      Inf Inf3Abess => "olematta" ;
      v => olla.s ! v
      }
    } ;
 

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
      tulema = Predef.tk 3 tulevat + "m" + a ;
----      tulema = tuje + "m" + a ;
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
      Impf Sg P1 => tuji + "n" ;   --# notpresent
      Impf Sg P2 => tuji + "t" ;  --# notpresent
      Impf Sg P3 => tuli ;  --# notpresent
      Impf Pl P1 => tuji + "mme" ;  --# notpresent
      Impf Pl P2 => tuji + "tte" ;  --# notpresent
      Impf Pl P3 => tuli + vat ;  --# notpresent
      Condit Sg P1 => tulisi + "n" ;  --# notpresent
      Condit Sg P2 => tulisi + "t" ;  --# notpresent
      Condit Sg P3 => tulisi ;  --# notpresent
      Condit Pl P1 => tulisi + "mme" ;  --# notpresent
      Condit Pl P2 => tulisi + "tte" ;  --# notpresent
      Condit Pl P3 => tulisi + vat ;  --# notpresent
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

      NPossNom _     => vete ;
      NPossGen Sg    => vete ;
      NPossGen Pl    => Predef.tk 1 vesien ;
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

-- Reflexive pronoun. 
--- Possessive could be shared with the more general $NounFin.DetCN$.

oper
  reflPron : Agr -> NP = \agr -> 
    let 
      itse = (nhn (sKukko "itse" "itsen" "itsejä")).s ;
      nsa  = possSuffix agr
    in {
      s = table {
        NPCase (Nom | Gen) | NPAcc => itse ! NPossNom Sg + nsa ;
        NPCase Transl      => itse ! NPossTransl Sg + nsa ;
        NPCase Illat       => itse ! NPossIllat Sg + nsa ;
        NPCase c           => itse ! NCase Sg c + nsa
        } ;
      a = agr ;
      isPron = False -- no special acc form
      } ;

  possSuffix : Agr -> Str = \agr -> 
    table Agr ["ni" ; "si" ; "nsa" ; "mme" ; "nne" ; "nsa"] ! agr ;

oper
  rp2np : Number -> {s : Number => NPForm => Str ; a : RAgr} -> NP = \n,rp -> {
    s = rp.s ! n ;
    a = agrP3 Sg ;  -- does not matter (--- at least in Slash)
    isPron = False  -- has no special accusative
    } ;

-- To export

    N : Type =  {s : NForm => Str} ;
    N2 = {s : NForm => Str} ** {c2 : Compl} ;
    N3 = {s : NForm => Str} ** {c2,c3 : Compl} ;
    PN = {s : Case  => Str} ;

    A  = {s : Degree => AForm => Str} ;
    A2 = {s : Degree => AForm => Str ; c2 : Compl} ;

    V, VS, VQ = Verb1 ; -- = {s : VForm => Str ; sc : Case} ;
    V2, VA = Verb1 ** {c2 : Compl} ;
    V2A = Verb1 ** {c2, c3 : Compl} ;
    VV = Verb1 ; ---- infinitive form
    V3 = Verb1 ** {c2, c3 : Compl} ;

    Verb1 = {s : VForm => Str ; sc : NPForm} ;  

    Prep = Compl ;
    Adv = {s : Str} ;

}
