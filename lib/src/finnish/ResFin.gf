--# -path=.:../abstract:../common:../../prelude

--1 Finnish auxiliary operations.

-- This module contains operations that are needed to make the
-- resource syntax work. To define everything that is needed to
-- implement $Test$, it moreover contains regular lexical
-- patterns needed for $Lex$.

resource ResFin = ParamX ** open Prelude in {

  flags optimize=all ;
    coding=utf8 ;


--2 Parameters for $Noun$

-- This is the $Case$ as needed for both nouns and $NP$s.

  param
    Case = Nom | Gen | Part | Transl | Ess 
         | Iness | Elat | Illat | Adess | Ablat | Allat 
         | Abess ;  -- Comit, Instruct in NForm 

    NForm = NCase Number Case 
          | NComit | NInstruct  -- no number dist
          | NPossNom Number | NPossGen Number --- number needed for syntax of AdjCN
          | NPossTransl Number | NPossIllat Number 
          | NCompound ;  -- special compound form, e.g. "nais"

--- These cases are possible for subjects.

    SubjCase = SCNom | SCGen | SCPart | SCIness | SCElat | SCAdess | SCAblat ; 

oper
  appSubjCase : SubjCase -> ResFin.NP -> Str = \sc,np -> np.s ! subjcase2npform sc ;

  subjcase2npform : SubjCase -> NPForm = \sc -> case sc of {
    SCNom  => NPCase Nom ;
    SCGen  => NPCase Gen ;
    SCPart => NPCase Part ;
    SCIness => NPCase Iness ;
    SCElat => NPCase Elat ;
    SCAdess => NPCase Adess ;
    SCAblat => NPCase Ablat
    } ;

  npform2subjcase : NPForm -> SubjCase = \sc -> case sc of {
    NPCase Gen => SCGen ;
    NPCase Part => SCPart ;
    NPCase Iness => SCIness ;
    NPCase Elat => SCElat ;
    NPCase Adess => SCAdess ;
    NPCase Ablat => SCAblat ;
    _ => SCNom
    } ;

-- Agreement of $NP$ has number*person and the polite second ("te olette valmis").

param
    Agr = Ag Number Person | AgPol ;
    
    
-- Vowel harmony, used for CNs in determining the correct possessive suffix.

    Harmony = Back | Front ;
    
    
  oper
    complNumAgr : Agr -> Number = \a -> case a of {
      Ag n _ => n ;
      AgPol  => Sg
      } ;
    verbAgr : Agr -> {n : Number ; p : Person} = \a -> case a of {
      Ag n p => {n = n  ; p = p} ;
      AgPol  => {n = Pl ; p = P2}
      } ;

  oper
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
  NPForm = NPCase Case | NPAcc | NPSep ;  -- NPSep is NP used alone, e.g. in an Utt and as complement to copula. Equals NPCase Nom except for pro-drop

oper
  npform2case : Number -> NPForm -> Case = \n,f ->

--  type signature: workaround for gfc bug 9/11/2007
    case <<f,n> : NPForm * Number> of {
      <NPCase c,_> => c ;
      <NPAcc,Sg>   => Gen ; -- appCompl does the job
      <NPAcc,Pl>   => Nom ;
      <NPSep,_>    => Nom
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
   | Potent Number Person  --# notpresent
   | PotentNeg  --# notpresent
   | Imper Number
   | ImperP3 Number
   | ImperP1Pl
   | ImpNegPl
   | PassPresn  Bool 
   | PassImpf   Bool --# notpresent
   | PassCondit Bool --# notpresent
   | PassPotent Bool --# notpresent 
   | PassImper  Bool 
   | PastPartAct  AForm
   | PastPartPass AForm
   | PresPartAct  AForm
   | PresPartPass AForm
   | AgentPart    AForm
   ;

  InfForm =
     Inf1          -- puhua
   | Inf1Long      -- puhuakseni
   | Inf2Iness     -- puhuessa
   | Inf2Instr     -- puhuen
   | Inf2InessPass -- puhuttaessa
   | Inf3Iness     -- puhumassa
   | Inf3Elat      -- puhumasta
   | Inf3Illat     -- puhumaan
   | Inf3Adess     -- puhumalla
   | Inf3Abess     -- puhumatta
   | Inf3Instr     -- puhuman
   | Inf3InstrPass -- puhuttaman
   | Inf4Nom       -- puhuminen
   | Inf4Part      -- puhumista
   | Inf5          -- puhumaisillani
   | InfPresPart   -- puhuvan
   | InfPresPartAgr -- puhuva(mme)
   ;

-- These forms appear in complements to VV and V2V.

  VVType = VVInf | VVIness | VVIllat | VVPresPart ;

oper
  vvtype2infform : VVType -> InfForm = \vt -> case vt of {
    VVInf => Inf1 ;
    VVIness => Inf3Iness ;
    VVIllat => Inf3Illat ;
    VVPresPart => InfPresPart
    } ;
  infform2vvtype : InfForm -> VVType = \vt -> case vt of {
    Inf3Iness => VVIness ;
    Inf3Illat => VVIllat ;
    InfPresPart => VVPresPart ;
    _ => VVInf
    } ;

param
  SType = SDecl | SQuest ;

--2 For $Relative$
 
    RAgr = RNoAg | RAg Agr ;

--2 For $Numeral$

    CardOrd = NCard NForm | NOrd NForm ;

--2 Transformations between parameter types

  oper
    agrP3 : Number -> Agr = \n -> 
      Ag n P3 ;

    conjAgr : Agr -> Agr -> Agr = \a,b -> case <a,b> of {
      <Ag n p, Ag m q> => Ag (conjNumber n m) (conjPerson p q) ;
      <Ag n p, AgPol>  => Ag Pl (conjPerson p P2) ;
      <AgPol,  Ag n p> => Ag Pl (conjPerson p P2) ;
      _ => b 
      } ;

---

  Compl : Type = {
    s : Str * Str * (Agr => Str) ;
    c : NPForm ; 
    } ;

  appCompl : Bool -> Polarity -> Compl -> ResFin.NP -> Str = \isFin,b,co,np ->
    let
      c = case co.c of {
        NPAcc => case b of {
          Neg => NPCase Part ; -- en näe taloa/sinua
          Pos => case isFin of {
               True => NPAcc ; -- näen/täytyy nähdä sinut
               _ => case np.isPron of {
                  False => NPCase Nom ;  -- täytyy nähdä talo
                  _ => NPAcc
                  }
               }
          } ;
        _        => co.c
        } ;
      nps = np.s ! c ;
      cos1 = co.s.p1 ;
      cos2 = case c of {
           NPCase Gen => case np.isPron of {
               True  => co.s.p3 ! np.a ;
               False => co.s.p2
              } ;
           _ => co.s.p2
           } ;
    in
    cos1 ++ nps ++ cos2 ;

-- For $Verb$.

  Verb : Type = {
    s : VForm => Str
    } ;

param
  VIForm =
     VIFin  Tense  
   | VIInf  InfForm
   | VIPass Tense
   | VIImper 
   ;  

oper
  

-- For $Sentence$.

  Clause : Type = {
    s : Tense => Anteriority => Polarity => SType => Str
    } ;

  ClausePlus : Type = {
    s : Tense => Anteriority => Polarity => {subj,fin,inf,compl,adv,ext : Str ; h : Harmony}
    } ;

  insertKinClausePlus : Predef.Ints 1 -> ClausePlus -> ClausePlus = \p,cl -> { 
    s = \\t,a,b =>
      let 
         c = cl.s ! t ! a ! b   
      in
      case p of {
         0 => {subj = c.subj ++ kin b Back ; fin = c.fin ; inf = c.inf ;  -- Jussikin nukkuu
               compl = c.compl ; adv = c.adv ; ext = c.ext ; h = c.h} ;
         1 => {subj = c.subj ; fin = c.fin ++ kin b c.h ; inf = c.inf ;  -- Jussi nukkuukin
               compl = c.compl ; adv = c.adv ; ext = c.ext ; h = c.h}
         }
    } ;

  insertObjClausePlus : Predef.Ints 1 -> Bool -> (Polarity => Str) -> ClausePlus -> ClausePlus = 
   \p,ifKin,obj,cl -> { 
    s = \\t,a,b =>
      let 
         c = cl.s ! t ! a ! b ;
         co = obj ! b ++ if_then_Str ifKin (kin b Back) [] ;
      in case p of {
         0 => {subj = c.subj ; fin = c.fin ; inf = c.inf ; 
               compl = co ; adv = c.compl ++ c.adv ; ext = c.ext ; h = c.h} ; -- Jussi juo maitoakin
         1 => {subj = c.subj ; fin = c.fin ; inf = c.inf ; 
               compl = c.compl ; adv = co ; ext = c.adv ++ c.ext ; h = c.h}   -- Jussi nukkuu nytkin
         }
     } ;

  kin : Polarity -> Harmony -> Str  = 
    \p,b -> case p of {Pos => (mkPart "kin" "kin").s ! b ; Neg => (mkPart "kaan" "kään").s ! b} ;

  mkPart : Str -> Str -> {s : Harmony => Str} = \ko,koe ->
    {s = table {Back => glueTok ko ; Front => glueTok koe}} ;

  glueTok : Str -> Str = \s -> "&+" ++ s ;

-- for pos/neg variation other than just negation word, e.g. case in "on ongelma"/"ei ole ongelmaa"
   posNegClause : Clause -> Clause -> Clause = \pos,neg -> {
     s = \\t,a,b,o => case b of {
         Pos  => pos.s ! t ! a ! b ! o ;
         _    => neg.s ! t ! a ! b ! o
         }
     } ;
-- This is used for subjects of passives: therefore isFin in False.

  subjForm : NP -> SubjCase -> Polarity -> Str = \np,sc,b -> 
    appCompl False b {s = <[],[],\\_ => []> ; c = subjcase2npform sc} np ;

  questPart : Harmony -> Str = \b -> case b of {Back => "ko" ; _ => "kö"} ;

-- The definitions below were moved here from $MorphoFin$ so that the
-- auxiliary of predication can be defined.

  verbOlla : Verb = 
    let
      ollut = (noun2adj (nhn (sRae "ollut" "olleena"))).s ;
      oltu = (noun2adj (nhn (sKukko "oltu" "ollun" "oltuja"))).s  ;
      oleva = (noun2adj (nhn (sKukko "oleva" "olevan" "olevia"))).s  ;
      oltava = (noun2adj (nhn (sKukko "oltava" "oltavan" "oltavia"))).s  ;
      olema = (noun2adj (nhn (sKukko "olema" "oleman" "olemia"))).s  ;
    in
    {s = table {
      Inf Inf1 => "olla" ;
      Inf Inf1Long => "ollakse" ;
      Inf Inf2Iness => "ollessa" ;
      Inf Inf2Instr => "ollen" ;
      Inf Inf2InessPass => "oltaessa" ;
      Inf Inf3Iness => "olemassa" ;
      Inf Inf3Elat  => "olemasta" ;
      Inf Inf3Illat => "olemaan" ;
      Inf Inf3Adess => "olemalla" ;
      Inf Inf3Abess => "olematta" ;
      Inf Inf3Instr => "oleman" ;
      Inf Inf3InstrPass => "oltaman" ;
      Inf Inf4Nom => "oleminen" ;
      Inf Inf4Part => "olemista" ;
      Inf Inf5 => "olemaisilla" ;
      Inf InfPresPart => "olevan" ;
      Inf InfPresPartAgr => "oleva" ;
      Presn Sg P1 => "olen" ;
      Presn Sg P2 => "olet" ;
      Presn Sg P3 => "on" ;
      Presn Pl P1 => "olemme" ;
      Presn Pl P2 => "olette" ;
      Presn Pl P3 => "ovat" ;
      Impf Sg P1 => "olin" ;   --# notpresent
      Impf Sg P2 => "olit" ;  --# notpresent
      Impf Sg P3 => "oli" ;  --# notpresent
      Impf Pl P1 => "olimme" ;  --# notpresent
      Impf Pl P2 => "olitte" ;  --# notpresent
      Impf Pl P3 => "olivat" ;  --# notpresent
      Condit Sg P1 => "olisin" ;  --# notpresent
      Condit Sg P2 => "olisit" ;  --# notpresent
      Condit Sg P3 => "olisi" ;  --# notpresent
      Condit Pl P1 => "olisimme" ;  --# notpresent
      Condit Pl P2 => "olisitte" ;  --# notpresent
      Condit Pl P3 => "olisivat" ;  --# notpresent
      Potent Sg P1 => "lienen" ;  --# notpresent
      Potent Sg P2 => "lienet" ;  --# notpresent
      Potent Sg P3 => "lienee" ;  --# notpresent
      Potent Pl P1 => "lienemme" ;  --# notpresent
      Potent Pl P2 => "lienette" ;  --# notpresent
      Potent Pl P3 => "lienevät" ;  --# notpresent
      PotentNeg    => "liene" ;  --# notpresent
      Imper Sg   => "ole" ;
      Imper Pl   => "olkaa" ;
      ImperP3 Sg => "olkoon" ;
      ImperP3 Pl => "olkoot" ;
      ImperP1Pl  => "olkaamme" ;
      ImpNegPl   => "olko" ;
      PassPresn True  => "ollaan" ;
      PassPresn False => "olla" ;
      PassImpf  True  => "oltiin" ;  --# notpresent
      PassImpf  False => "oltu" ;  --# notpresent
      PassCondit  True  => "oltaisiin" ;  --# notpresent
      PassCondit  False => "oltaisi" ;  --# notpresent
      PassPotent  True  => "oltaneen" ;  --# notpresent
      PassPotent  False => "oltane" ;  --# notpresent
      PassImper True  => "oltakoon" ;
      PassImper False => "oltako" ;
      PastPartAct n => ollut ! n ;
      PastPartPass n => oltu ! n ;
      PresPartAct n => oleva ! n ;
      PresPartPass n => oltava ! n ;
      AgentPart n => olema ! n
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

  CommonNoun = {s : NForm => Str ; h : Harmony } ; --IL 11/2012, vowharmony

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
     vesiin = nh.vesiin ;
     harmony : Harmony = case a of 
       {"a" => Back ; _   => Front  } 
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
      NPossIllat Pl  => Predef.tk 1 vesiin ;
      NCompound      => vesi
      } ;
      h = harmony 
    } ;
-- Surprisingly, making the test for the partitive, this not only covers
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
      nsa  = possSuffixFront agr
    in {
      s = table {
        NPCase Nom | NPSep => itse ! NPossNom Sg ;
        NPCase Gen | NPAcc => itse ! NPossNom Sg + nsa ;
        NPCase Transl      => itse ! NPossTransl Sg + nsa ;
        NPCase Illat       => itse ! NPossIllat Sg + nsa ;
        NPCase c           => itse ! NCase Sg c + nsa
        } ;
      a = agr ;
      isPron = False -- no special acc form
      } ;

  possSuffixGen : Harmony -> Agr -> Str = \h,agr -> case h of {
    Front => BIND ++ possSuffixFront agr ; 
    Back  => BIND ++ possSuffix agr
    } ;

  possSuffixFront : Agr -> Str = \agr -> 
    table Agr ["ni" ; "si" ; "nsä" ; "mme" ; "nne" ; "nsä" ; "nne"] ! agr ;
  possSuffix : Agr -> Str = \agr -> 
    table Agr ["ni" ; "si" ; "nsa" ; "mme" ; "nne" ; "nsa" ; "nne"] ! agr ;

oper
  rp2np : Number -> {s : Number => NPForm => Str ; a : RAgr} -> NP = \n,rp -> {
    s = rp.s ! n ;
    a = agrP3 Sg ;  -- does not matter (--- at least in Slash)
    isPron = False  -- has no special accusative
    } ;

  etta_Conj : Str = "että" ;

    heavyDet : PDet -> PDet ** {sp : Case => Str} = \d -> d ** {sp = d.s1} ;
    PDet : Type = {
      s1 : Case => Str ;
      s2 : Harmony => Str ;
      n : Number ;
      isNum : Bool ;
      isPoss : Bool ;
      isDef : Bool ;
      isNeg : Bool
      } ;

    heavyQuant : PQuant -> PQuant ** {sp : Number => Case => Str} = \d -> 
      d ** {sp = d.s1} ; 
    PQuant : Type = {
      s1 : Number => Case => Str ;
      s2 : Harmony => Str ; 
      isPoss : Bool ;
      isDef : Bool ;
      isNeg : Bool
      } ;  

}
