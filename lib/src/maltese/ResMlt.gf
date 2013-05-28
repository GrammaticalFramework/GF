-- ResMlt.gf: Language-specific parameter types, morphology, VP formation
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Angelo Zammit 2012
-- Licensed under LGPL

--# -path=.:../abstract:../common:../prelude

resource ResMlt = ParamX ** open Prelude, Predef, Maybe in {

  flags coding=utf8 ;

  {- General -------------------------------------------------------------- -}

  param

    Gender = Masc | Fem ;

    GenNum  =
        GSg Gender -- DAK, DIK
      | GPl        -- DAWK
      ;

    Definiteness =
        Definite    -- eg BIL-
      | Indefinite  -- eg BI
      ;

  oper
    bool2definiteness : Bool -> Definiteness = \b ->
      if_then_else Definiteness b Definite Indefinite ;

    -- Agreement system corrected based on comments by [AZ]
    Agr : Type = { n : Number ; p : Person ; g : Gender } ;

    -- Make Agr from raw ingredients
    mkAgr : Number -> Person -> Gender -> Agr = \n,p,g -> {n = n ; p = p ; g = g} ;

    -- Convert to Agr from other typek
    toAgr = overload {
      toAgr : GenNum -> Agr = \gn -> case gn of {
        GSg g => {n = Sg ; p = P3 ; g = g} ;
        GPl   => {n = Pl ; p = P3 ; g = Masc}
        } ;
      toAgr : VAgr -> Agr = \vagr ->
        case vagr of {
          AgP1 num   => mkAgr num P1 Masc ;
          AgP2 num   => mkAgr num P2 Masc ;
          AgP3Sg gen => mkAgr Pl  P3 gen ;
          AgP3Pl     => mkAgr Pl  P3 Masc
        } ;
      } ;

    -- Make Agr from raw ingredients
    mkGenNum = overload {
      mkGenNum : Gender -> Number -> GenNum = \g,n ->
        case n of {
          Sg => GSg g ;
          Pl => GPl
        } ;
      mkGenNum : Number -> Gender -> GenNum = \n,g ->
        case n of {
          Sg => GSg g ;
          Pl => GPl
        } ;
      mkGenNum : Noun_Number -> Gender -> GenNum = \n,g ->
        case nounnum2num n of {
          Sg => GSg g ;
          Pl => GPl
        } ;
      } ;

    -- Convert to GenNum from another type
    toGenNum : Agr -> GenNum = \a ->
      case a.n of {
        Sg => GSg a.g ;
        Pl => GPl
      } ;

    -- Convert to VAgr from another type
    toVAgr = overload {
      toVAgr : Agr -> VAgr = \agr ->
        case <agr.p,agr.n> of {
          <P1,num> => AgP1 num;
          <P2,num> => AgP2 num;
          <P3,Sg>  => AgP3Sg agr.g;
          <P3,Pl>  => AgP3Pl
        } ;
      toVAgr : GenNum -> VAgr = \gn ->
        case gn of {
          GSg g => AgP3Sg g;
          GPl   => AgP3Pl
        } ;
      } ;

    agrP3 : Number -> Gender -> Agr = \n,g -> mkAgr n P3 g;

    conjAgr : Agr -> Agr -> Agr = \a,b -> {
      n = (conjNumber a.n b.n) ;
      p = (conjPerson a.p b.p) ;
      g = a.g ;
      } ;

    -- ConjNumber, ConjPerson are defined in ParamX
    conjGender : Gender -> Gender -> Gender = \a,b -> b ;

  param
    -- Agreement for verbs
    VAgr =
        AgP1 Number   -- JIENA, AĦNA
      | AgP2 Number   -- INTI, INTOM
      | AgP3Sg Gender -- HUWA, HIJA
      | AgP3Pl        -- HUMA
      ;

  param
    NPCase =
        NPNom
      | NPAcc     -- I have a feeling we'll this need eventually
      | NPCPrep   -- [AZ]
      ;

  oper
    npNom = NPNom ;
    npAcc = NPAcc ;

  {- Clause --------------------------------------------------------------- -}

  oper
    Clause : Type = {
      s : Tense => Anteriority => Polarity => Order => Str
      } ;
    QClause : Type = {
      s : Tense => Anteriority => Polarity => QForm => Str
      } ;
    RClause : Type = {
      s : Tense => Anteriority => Polarity => Agr => Str
      } ;

    -- Clause
    mkClause : Str -> Agr -> VerbPhrase -> Clause = \subj,agr,vp -> {
      s = \\t,a,p,o =>
        let
          -- verb  = vp.s ! t ! a ! p ! o ! agr ;
          -- vform = case <t,agr> of {
          --   _ => VPres
          --   } ;
          vpform : VPForm = VPIndicat t (toVAgr agr) ;
          verb   : Str    = joinVP vp vpform a p ;
          compl  : Str    = vp.s2 ! agr ;
        in
        case o of {
          -- ODir => subj ++ verb.aux ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf ++ vp.p ++ compl ;
          -- OQuest => verb.aux ++ subj ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf ++ vp.p ++ compl

          -- ABSOLUTELY NOT CORRECT: in progress
          ODir => subj ++ verb ++ compl ;
          OQuest => subj ++ verb ++ compl
        }
      } ;

    mkQuestion : {s : Str} -> Clause -> QClause = \wh,cl -> {
      s = \\t,a,p =>
        let
          cls = cl.s ! t ! a ! p ;
          why = wh.s
        in table {
          QDir   => why ++ cls ! OQuest ;
          QIndir => why ++ cls ! ODir
        }
      } ;

  {- Numeral -------------------------------------------------------------- -}

  param
    CardOrd = NCard | NOrd ;

    -- Order of magnitude
    DForm =
        Unit  -- 0..10
      | Teen  -- 11..19
      | Ten   -- 20..99
      | Hund  -- 100..999
      | Thou  -- 1000+
      ;

    -- Indicate how a corresponding object should be treated
    --- Overlap between Num Sg and Num1, but leaving as is for now
    NumForm =
        NumX Number -- Sg | Pl
      | Num0        -- 0 (l-edba SIEGĦA)
      | Num1        -- 1, 101... (SIEGĦA, mija u SIEGĦA)
      | Num2        -- 2 (SAGĦTEJN)
      | Num3_10     -- 3..10, 102, 103... (tlett SIEGĦAT, għaxar SIEGĦAT, mija u żewġ SIEGĦAT, mija u tlett SIEGĦAT)
      | Num11_19    -- 11..19, 111... (ħdax-il SIEGĦA, mija u dsatax-il SIEGĦA)
      | Num20_99    -- 20..99, 120... (għoxrin SIEGĦA, disa' u disgħajn SIEGĦA)
      ;

    NumCase =
        NumNom  -- "Type B" in {MDG, 133}, e.g. TNEJN, ĦAMSA, TNAX, MIJA
      | NumAdj  -- "Type A" in {MDG, 133}, e.g. ŻEWĠ, ĦAMES, TNAX-IL, MITT
      ;

  oper

    num2nounnum : Number -> Noun_Number = \n ->
      case n of {
        Sg  => Singulative ;
        Pl  => Plural
      } ;

    nounnum2num : Noun_Number -> Number = \n ->
      case n of {
        Singulative => Sg ;
        Collective  => Sg ;
        Dual        => Pl ;
        Plural      => Pl
      } ;

    numform2nounnum : NumForm -> Noun_Number = \n ->
      case n of {
        NumX Sg  => Singulative ;
        NumX Pl  => Plural ;
        Num0     => Singulative ;
        Num1     => Singulative ;
        Num2     => Dual ;
        Num3_10  => Collective ;
        Num11_19 => Singulative ;
        Num20_99 => Plural
      } ;

    numform2num : NumForm -> Number = \n ->
      case n of {
        NumX num => num ;
        Num0     => Sg ;
        Num1     => Sg ;
        _        => Pl
      } ;

  {- Determiners etc. ----------------------------------------------------- -}

  oper
    -- [AZ]
    Determiner : Type = {
      s : Gender => Str ;
      n : NumForm ;
      clitic : Str ;
      hasNum : Bool ; -- has a numeral
      isPron : Bool ; -- is a pronoun
      isDefn : Bool ; -- is definite
      } ;
    -- Determiner = {
    --   s : NPCase => Gender => NumCase => Str ;
    --   s2 : NPCase => Gender => Str ; -- tieghi (possessive pronoun)
    --   -- size : Num_Size ; -- One (agreement feature for noun)
    --   isNum : Bool ; -- True (a numeral is present)
    --   isDemo : Bool ; -- True (is a demostrative)
    --   isDefn : Bool ;-- True (is definite)
    --   } ;

    -- [AZ]
    Quantifier : Type = {
      s      : GenNum => Str ;
      clitic : Str ;
      isPron : Bool ;
      isDemo : Bool ; -- Demonstrative (this/that/those/these)
      isDefn : Bool ; -- is definite
      } ;
    -- Quantifier = {
    --   s : NPCase => Gender => NumForm => Str ;
    --   s2 : NPCase => Gender => NumForm => Str ;
    --   isDemo : Bool ; -- Demonstrative (this/that/those/these)
    --   isDefn : Bool ;
    --   } ;

  {- Noun ----------------------------------------------------------------- -}

  oper
    Noun : Type = {
      s : Noun_Number => Str ;
      g : Gender ;
      hasColl : Bool ; -- has a collective form? e.g. BAQAR
      hasDual : Bool ; -- has a dual form? e.g. SAGĦTEJN
      takesPron : Bool ; -- takes enclitic pronon? e.g. MISSIERI
      } ;

    ProperNoun : Type = {
      s : Str ;
      a : Agr ; -- ignore a.p (always P3)
      } ;

    NounPhrase : Type = {
      s : NPCase => Str ;
      a : Agr ;
      isPron : Bool ;
      isDefn : Bool ;
      } ;

  param
    Noun_Number =
        Singulative -- ĦUTA
      | Collective  -- ĦUT
      | Dual        -- WIDNEJN
      | Plural      -- ĦUTIET
      ;

  oper
    -- Noun: Takes all forms and a gender
    -- Params:
    -- Singulative, eg KOXXA
    -- Collective, eg KOXXOX
    -- Double, eg KOXXTEJN
    -- Determinate Plural, eg KOXXIET
    -- Indeterminate Plural
    -- Gender
    mkNoun : (_,_,_,_,_ : Str) -> Gender -> Noun = \sing,coll,dual,det,ind,gen -> {
      s = table {
        Singulative => sing ;
        Collective  => coll ;
        Dual        => dual ;
        Plural      => if_then_Str (isNil det) ind det
        -- Plural   => variants {det ; ind}
        } ;
      g = gen ;
      takesPron = False ;
      hasDual = notB (isNil dual) ;
      hasColl = notB (isNil coll) ;
      } ;

    -- Noun phrase
    mkNP : Str -> Number -> Person -> Gender -> NounPhrase = \s,n,p,g -> {
      s = \\npcase => s ;
      a = mkAgr n p g ;
      isPron = False ;
      isDefn = False ;
      };

    regNP : Str -> NounPhrase = \kulhadd ->
      mkNP kulhadd Sg P3 Masc ; -- kulħadd kuntent

    -- Join a preposition and NP to a string
    prepNP : Preposition -> NounPhrase -> Str ;
    prepNP prep np = case np.isPron of {
      True  => prep.enclitic ! np.a ; -- magħha
      False => case <np.isDefn, prep.takesDet> of {
        <True,True>  => prep.s ! Definite ++ np.s ! NPCPrep ; -- fit-triq
        <True,False> => prep.s ! Definite ++ np.s ! NPNom ;   -- fuq it-triq
        <False,_>    => prep.s ! Indefinite ++ np.s ! NPNom   -- fi triq
        }
      } ;

    Compl : Type = Preposition ** {isPresent : Bool} ;
    -- Compl : Type = {
    --   s : Str ;
    --   -- c : NPForm ;
    --   -- isPre : Bool
    --   } ;

    noCompl : Compl = {
      s = \\_ => [] ;
      enclitic = \\_ => [] ;
      takesDet = False ;
      joinsVerb = False ;
      isPresent = False ;
      } ;

    Preposition = {
      s : Definiteness => Str ;
      enclitic : Agr => Str ; -- when suffixed by pronouns; magħ-ha
      takesDet : Bool ; -- True: fil- / False: fuq il-
      joinsVerb : Bool ; -- True for for_Prep (I.O. suffix)
      } ;

  {- Pronoun -------------------------------------------------------------- -}

  oper
    Pronoun = {
      s : PronForm => Str ; -- cases like omm-i / hi-ja are handled elsewhere
      a : Agr ;
      } ;

  param
    PronForm =
        Personal -- JIENA
      | Possessive -- TIEGĦI
      | Suffixed PronCase
      ;

    PronCase =
        Acc -- Accusative: rajtu
      | Dat -- Dative: rajtlu
      | Gen -- Genitive: qalbu
      ;

  oper
    -- Interrogative pronoun
    mkIP : Str -> Number -> {s : Str ; n : Number} = \who,n ->
      {
        s = who ;
        n = n
      } ;

  {- Verb ----------------------------------------------------------------- -}

  oper
    Variants3 : Type = {s1, s2, s3 : Str} ;

    -- Shortcut functions for accessing stems
    stem1 : Variants3 -> Str = \stems -> stems.s1 ;
    stem2 : Variants3 -> Str = \stems -> stems.s2 ;
    stem3 : Variants3 -> Str = \stems -> stems.s3 ;

    mkVariants3 : Variants3 = overload {
      mkVariants3 : (s1 : Str) -> Variants3 = \a -> { s1 = a ; s2 = a ; s3 = a } ;
      mkVariants3 : (s1, s2, s3 : Str) -> Variants3 = \a,b,c -> { s1 = a ; s2 = b ; s3 = c } ;
      } ;

    mkMaybeVariants3 : Str -> Maybe Variants3 = \s -> Just Variants3 (mkVariants3 s) ;

    NullVariants3 : Maybe Variants3 = Nothing Variants3 { s1 = [] ; s2 = [] ; s3 = [] } ;

    -- Produce stem variants as needed (only call on compile-time strings!)
    -- Refer to doc/stems.org
    stemVariantsPerf : Str -> Variants3 = \s ->
      let
        ftahna  : Str = s ;
        ftahnie : Str = case s of {
          ftahn + "a" => ftahn + "ie" ;
          fet + h@#Cns + "et" => fet + h + "it" ;
          _ => s
          } ;
        ftahni  : Str = case s of {
          ftahn + "a" => ftahn + "i" ;
          _ => ftahnie
          } ;
      in
      { s1 = ftahna ; s2 = ftahnie ; s3 = ftahni } ;
    stemVariantsImpf : Str -> Variants3 = \s ->
      let
        ftahna  : Str = s ;
        ftahnie : Str = case s of {
          nift + "aħ" => nift + "ħ" ;
          _ => s
          } ;
      in
      { s1 = ftahna ; s2 = ftahnie ; s3 = ftahna } ;

    -- Convert old verb form table into one with stem variants
    stemVariantsTbl : (VForm => Str) -> (VForm => Variants3) = \tbl ->
      \\vf => case vf of {
        VPerf _ => stemVariantsPerf (tbl ! vf) ;
        VImpf _ => stemVariantsImpf (tbl ! vf) ;
        _  => mkVariants3 (tbl ! vf)
      } ;

    Verb : Type = {
      s : VForm => Variants3 ; --- need to store different "stems" already at verb level (ġera/ġerie/ġeri)
      i : VerbInfo ;
      } ;

    VerbInfo : Type = {
      class : VClass ;
      form  : VDerivedForm ;
      root  : Root ; -- radicals
      patt  : Pattern ; -- vowels extracted from mamma
      patt2 : Pattern ; -- vowel changes; default to patt (experimental)
      -- in particular, patt2 is used to indicate whether an IE sould be shortened
      -- to an I or an E (same for entire verb)
      imp   : Str ; -- Imperative Sg. Gives so much information jaħasra!
      } ;

  param
    -- Possible verb forms (tense + person)
    VForm =
        VPerf VAgr    -- Perfect tense in all pronoun cases
      | VImpf VAgr    -- Imperfect tense in all pronoun cases
      | VImp Number   -- Imperative is always P2, Sg & Pl
      | VActivePart GenNum  -- Present/active particible, e.g. RIEQED
      | VPassivePart GenNum  -- Passive/past particible, e.g. MAĦBUB
      -- | VVerbalNoun      -- Verbal Noun
    ;

    VDerivedForm =
        FormI
      | FormII
      | FormIII
      | FormIV
      | FormV
      | FormVI
      | FormVII
      | FormVIII
      | FormIX
      | FormX
      | FormUnknown
      ;

    -- Verb classification
    VClass =
        Strong VStrongClass
      | Weak VWeakClass
      | Quad VQuadClass
      | Loan
      | Irregular
      ;
    VStrongClass =
        Regular
      | LiquidMedial
      | Geminated
      ;
    VWeakClass =
        Assimilative
      | Hollow
      | Lacking
      | Defective
      ;
    VQuadClass =
        QStrong
      | QWeak
      ;

    Order =
        ODir    -- ĠANNI JIEKOL ĦUT
      | OQuest  -- JIEKOL ĦUT ĠANNI [?]
      ;


  {- Verb Phrase ---------------------------------------------------------- -}

  oper

    joinVariants3 : Variants3 -> Polarity -> Str = \stems,pol ->
      case <pol> of {
        <Pos> => stem1 stems ;
        <Neg> => stem2 stems ++ BIND ++ "x"
      } ;

    joinVP : VerbPhrase -> VPForm -> Anteriority -> Polarity -> Str = \vp,form,ant,pol ->
      let
        stems = (vp.s ! form ! ant ! pol).main ;
        aux   = (vp.s ! form ! ant ! pol).aux ;
        x : Str = "x" ;
      in
        case takesAux form ant of {

          -- aux is already negated for us
          True => aux ++ case <exists Variants3 vp.dir, exists Variants3 vp.ind> of {

            -- konna ftaħna / ma konniex ftaħna
            <False,False> => stems.s1 ;

            -- konna ftaħnie-ha / ma konniex ftaħni-ha
            <True ,False> => stems.s2 ++ BIND ++ (fromJust Variants3 vp.dir).s1 ;

            -- konna ftaħnie-lha / ma konniex ftaħni-lha
            <False,True > => stems.s2 ++ BIND ++ (fromJust Variants3 vp.ind).s1 ;

            -- konna ftaħni-hie-lha / ma konniex ftaħni-hi-lha
            <True, True > => stems.s3 ++ BIND ++ (fromJust Variants3 vp.dir).s2 ++ BIND ++ (fromJust Variants3 vp.ind).s1

            } ;

          -- No aux part to handle
          False => aux ++ case <exists Variants3 vp.dir, exists Variants3 vp.ind, pol> of {

            -- ftaħna / ftaħnie-x
            <False,False,Pos> => stems.s1 ;
            <False,False,Neg> => stems.s2 ++ BIND ++ x ;

            -- ftaħnie-ha / ftaħni-hie-x
            <True ,False,Pos> => stems.s2 ++ BIND ++ (fromJust Variants3 vp.dir).s1 ;
            <True ,False,Neg> => stems.s3 ++ BIND ++ (fromJust Variants3 vp.dir).s2 ++ BIND ++ x ;

            -- ftaħnie-lha / ftaħni-lhie-x
            <False,True ,Pos> => stems.s2 ++ BIND ++ (fromJust Variants3 vp.ind).s1 ;
            <False,True ,Neg> => stems.s3 ++ BIND ++ (fromJust Variants3 vp.ind).s2 ++ BIND ++ x ;

            -- ftaħni-hie-lha / ftaħni-hi-lhie-x
            <True, True ,Pos> => stems.s3 ++ BIND ++ (fromJust Variants3 vp.dir).s2 ++ BIND ++ (fromJust Variants3 vp.ind).s1 ;
            <True, True ,Neg> => stems.s3 ++ BIND ++ (fromJust Variants3 vp.dir).s3 ++ BIND ++ (fromJust Variants3 vp.ind).s2 ++ BIND ++ x

            }
      } ;

    -- Does a tense + ant take an auxiliary verb?
    -- This affects where (if) the negation is applied
    -- This is a workaround to avoid having a bool param in VerbParts
    -- Must match with the logic in predV
    takesAux : VPForm -> Anteriority -> Bool = \vpf,ant ->
      case <vpf,ant> of {
        <VPIndicat Pres _, Simul> => False ;
        <VPIndicat Past _, Simul> => False ;
        <VPIndicat Fut  _, Simul> => True ;
        <VPIndicat Cond _, Simul> => True ;
        <VPIndicat Pres _, Anter> => False ;
        <VPIndicat Past _, Anter> => True ;
        <VPIndicat Fut  _, Anter> => True ;
        <VPIndicat Cond _, Anter> => True ;
        <VPImperat _, _> => False
      } ;

    VerbParts : Type = {
      aux : Str ;        -- when present, negation is applied here
      main : Variants3 ; -- enclitics always applied here
      } ;

    mkVerbParts = overload {
      mkVerbParts : Variants3 -> VerbParts = \vs -> { aux = [] ; main = vs } ;
      mkVerbParts : Str -> VerbParts = \m -> { aux = [] ; main = mkVariants3 m } ;
      mkVerbParts : Str -> Variants3 -> VerbParts = \a,vs -> { aux = a ; main = vs } ;
      mkVerbParts : Str -> Str -> VerbParts = \a,m -> { aux = a ; main = mkVariants3 m } ;
      } ;

    -- [AZ]
    VerbPhrase : Type = {
      s : VPForm => Anteriority => Polarity => VerbParts ;
      s2 : Agr => Str ; -- complement
      dir : Maybe Variants3 ; -- direct object clitic
      ind : Maybe Variants3 ; -- indirect object clitic
      } ;

    SlashVerbPhrase : Type = VerbPhrase ** {c2 : Compl} ;

  param
    -- [AZ]
    VPForm =
        VPIndicat Tense VAgr
      | VPImperat Number
      ;

  oper

    insertObj : (Agr => Str) -> VerbPhrase -> VerbPhrase = \obj,vp -> {
      s = vp.s ;
      s2 = \\agr => vp.s2 ! agr ++ obj ! agr ;
      dir = vp.dir ;
      ind = vp.ind ;
      } ;

    insertObjPre : (Agr => Str) -> VerbPhrase -> VerbPhrase = \obj,vp -> {
      s = vp.s ;
      s2 = \\agr => obj ! agr ++ vp.s2 ! agr ;
      dir = vp.dir ;
      ind = vp.ind ;
      } ;

    insertObjc : (Agr => Str) -> SlashVerbPhrase -> SlashVerbPhrase = \obj,vp ->
      insertObj obj vp ** {c2 = vp.c2} ;

    insertIndObj : Str -> VerbPhrase -> VerbPhrase = \ind,vp -> {
      s = vp.s ;
      s2 = vp.s2 ;
      dir = vp.dir ;
      ind = mkMaybeVariants3 ind ;
      };

    insertAdV : Str -> VerbPhrase -> VerbPhrase = \adv,vp -> {
      s = vp.s ;
      s2 = \\agr => vp.s2 ! agr ++ adv ;
      dir = vp.dir ;
      ind = vp.ind ;
      } ;

    predVc : (Verb ** {c2 : Compl}) -> SlashVerbPhrase = \verb ->
      predV verb ** {c2 = verb.c2} ;

    copula_kien : {s : VForm => Polarity => Str} = {
      s = \\vform,pol => case <vform,pol> of {
        <VPerf (AgP1 Sg), Pos>     => "kont" ;
        <VPerf (AgP2 Sg), Pos>     => "kont" ;
        <VPerf (AgP3Sg Masc), Pos> => "kien" ;
        <VPerf (AgP3Sg Fem), Pos>  => "kienet" ;
        <VPerf (AgP1 Pl), Pos>     => "konna" ;
        <VPerf (AgP2 Pl), Pos>     => "kontu" ;
        <VPerf (AgP3Pl), Pos>      => "kienu" ;
        <VImpf (AgP1 Sg), Pos>     => "nkun" ;
        <VImpf (AgP2 Sg), Pos>     => "tkun" ;
        <VImpf (AgP3Sg Masc), Pos> => "jkun" ;
        <VImpf (AgP3Sg Fem), Pos>  => "tkun" ;
        <VImpf (AgP1 Pl), Pos>     => "nkunu" ;
        <VImpf (AgP2 Pl), Pos>     => "tkunu" ;
        <VImpf (AgP3Pl), Pos>      => "jkunu" ;
        <VImp (Pl), Pos>           => "kun" ;
        <VImp (Sg), Pos>           => "kunu" ;

        <VPerf (AgP1 Sg), Neg>     => "kontx" ;
        <VPerf (AgP2 Sg), Neg>     => "kontx" ;
        <VPerf (AgP3Sg Masc), Neg> => "kienx" ;
        <VPerf (AgP3Sg Fem), Neg>  => "kinitx" ;
        <VPerf (AgP1 Pl), Neg>     => "konniex" ;
        <VPerf (AgP2 Pl), Neg>     => "kontux" ;
        <VPerf (AgP3Pl), Neg>      => "kienux" ;
        <VImpf (AgP1 Sg), Neg>     => "nkunx" ;
        <VImpf (AgP2 Sg), Neg>     => "tkunx" ;
        <VImpf (AgP3Sg Masc), Neg> => "jkunx" ;
        <VImpf (AgP3Sg Fem), Neg>  => "tkunx" ;
        <VImpf (AgP1 Pl), Neg>     => "nkunux" ;
        <VImpf (AgP2 Pl), Neg>     => "tkunux" ;
        <VImpf (AgP3Pl), Neg>      => "jkunux" ;
        <VImp (Pl), Neg>           => "kunx" ;
        <VImp (Sg), Neg>           => "kunux" ;
        <VActivePart gn, _>      => "" ;
        <VPassivePart gn, _>     => ""
        }
      } ;

    -- Adapted from [AZ]
    CopulaVP : VerbPhrase = {
      s = \\vpf,ant,pol =>
        --- We are ignoring the anteriority
        case <vpf, pol> of {
          --- Here we are bypassing VerbParts by putting negatives in the stem
          <VPIndicat Past vagr, Pos> => mkVerbParts (copula_kien.s ! VPerf vagr ! Pos) [] ; -- kien
          <VPIndicat Pres vagr, Pos> => mkVerbParts (copula_kien.s ! VImpf vagr ! Pos) [] ; -- jkun
          <VPIndicat Fut  vagr, Pos> => mkVerbParts ("se" ++ copula_kien.s ! VImpf vagr ! Pos) [] ; -- se jkun
          <VPIndicat Cond vagr, Pos> => mkVerbParts ("kieku" ++ copula_kien.s ! VPerf vagr ! Pos) [] ; -- kieku kien
          <VPImperat num, Pos>       => mkVerbParts (copula_kien.s ! VImp num ! Pos) [] ; -- kun
          <VPIndicat Past vagr, Neg> => mkVerbParts (copula_kien.s ! VPerf vagr ! Neg) [] ; -- ma kienx
          <VPIndicat Pres vagr, Neg> => mkVerbParts (copula_kien.s ! VImpf vagr ! Neg) [] ; -- ma jkunx
          <VPIndicat Fut  vagr, Neg> => mkVerbParts (mhux ! vagr ++ "se" ++ copula_kien.s ! VImpf vagr ! Pos) [] ; -- mhux se jkun
          <VPIndicat Cond vagr, Neg> => mkVerbParts ("kieku" ++ "ma" ++ copula_kien.s ! VPerf vagr ! Neg) [] ; -- kieku ma kienx
          <VPImperat num, Neg>       => mkVerbParts (copula_kien.s ! VImp num ! Neg) [] -- kunx
        } ;
      s2 = \\agr => [] ;
      dir = NullVariants3 ;
      ind = NullVariants3 ;
      } ;

    -- [AZ]
    predV : Verb -> VerbPhrase = \verb -> {
      s = \\vpf,ant,pol =>
        let
          ma = makePreVowel "ma" "m'" ;
          b1 : Variants3 -> VerbParts = \vs -> mkVerbParts vs ;
          b2 : Str -> Variants3 -> VerbParts = \s,vs -> mkVerbParts s vs ;
        in
        case vpf of {
          VPIndicat tense vagr =>
            let
              -- kien  = joinVP CopulaVP (VPIndicat Past vagr) Simul Pos ;
              -- kienx = joinVP CopulaVP (VPIndicat Past vagr) Simul Neg ;
              kien  = copula_kien.s ! (VPerf vagr) ! Pos ;
              kienx = copula_kien.s ! (VPerf vagr) ! Neg ;
              nkun  = copula_kien.s ! (VImpf vagr) ! Pos ;
            in
            case <tense,ant,pol> of {
              <Pres,Simul,Pos> => b1 (verb.s ! VImpf vagr) ; -- norqod
              <Pres,Simul,Neg> => b2 ma (verb.s ! VImpf vagr) ; -- ma norqodx

              <Past,Simul,Pos> => b1 (verb.s ! VPerf vagr) ; -- rqadt
              <Past,Simul,Neg> => b2 ma (verb.s ! VPerf vagr) ; -- ma rqadtx

              <Fut, Simul,Pos> => b2 "se" (verb.s ! VImpf vagr) ; -- se norqod
              <Fut, Simul,Neg> => b2 (mhux ! vagr ++ "se") (verb.s ! VImpf vagr) ; -- m'iniex se norqod

              <Cond, _   ,Pos> => b2 kien (verb.s ! VImpf vagr) ; -- kont norqod
              <Cond, _   ,Neg> => b2 (ma ++ kienx) (verb.s ! VImpf vagr) ; -- ma kontx norqod

              -- Same as Past Simul
              <Pres,Anter,Pos> => b1 (verb.s ! VPerf vagr) ; -- rqadt
              <Pres,Anter,Neg> => b2 ma (verb.s ! VPerf vagr) ; -- ma rqadtx

              <Past,Anter,Pos> => b2 kien (verb.s ! VPerf vagr) ; -- kont rqadt
              <Past,Anter,Neg> => b2 (ma ++ kienx) (verb.s ! VPerf vagr) ; -- ma kontx rqadt

              <Fut, Anter,Pos> => b2 ("se" ++ nkun) (verb.s ! VPerf vagr) ; -- se nkun rqadt
              <Fut, Anter,Neg> => b2 (mhux ! vagr ++ "se" ++ nkun) (verb.s ! VPerf vagr) -- m'iniex se nkun rqadt
            } ;
          VPImperat num => b1 (verb.s ! VImp num) -- torqodx
        };
      s2 = \\agr => [] ;
      dir = NullVariants3 ;
      ind = NullVariants3 ;
      -- a1 = [] ;
      -- n2 = \\_ => [] ;
      -- a2 = [] ;
      } ;

    -- There is no infinitive in Maltese; use perfective
    infVP : VerbPhrase -> Anteriority -> Polarity -> Agr -> Str = \vp,ant,pol,agr ->
      let
        vpform : VPForm = VPIndicat Past (toVAgr agr) ;
      in
        joinVP vp vpform ant pol ++ vp.s2 ! agr ;

    Aux = {
      s : Tense => Polarity => Str ;
      } ;
    auxHemm : Aux = {
      s = \\t,p => case <t,p> of {
        <Pres,Pos> => "hemm" ;
        <Pres,Neg> => "m'hemmx" ;
        <Past,Pos> => "kien hemm" ;
        <Past,Neg> => "ma kienx hemm" ;
        <Fut,Pos>  => "ħa jkun hemm" ;
        <Fut,Neg>  => "mhux ħa jkun hemm" ;
        <Cond,Pos> => "jekk hemm" ;
        <Cond,Neg> => "jekk hemmx"
        }
      } ;

    reflPron : VAgr => Str = table {
      AgP1 Sg      => "lili nnifsi" ;
      AgP2 Sg      => "lilek innifsek" ;
      AgP3Sg Masc  => "lilu nnifsu" ;
      AgP3Sg Fem   => "lila nnifisha" ;
      AgP1 Pl      => "lilna nfusna" ;
      AgP2 Pl      => "lilkom infuskom" ;
      AgP3Pl       => "lilhom infushom"
      } ;

    mhux : VAgr => Str = table {
      AgP1 Sg      => "m'iniex" ;
      AgP2 Sg      => "m'intix" ;
      AgP3Sg Masc  => "m'hux" ;
      AgP3Sg Fem   => "m'hix" ;
      AgP1 Pl      => "m'aħniex" ;
      AgP2 Pl      => "m'intomx" ;
      AgP3Pl       => "m'humiex"
      } ;

    conjLi : Str = "li" ;
    conjThat = conjLi ;

  {- Adjecive ------------------------------------------------------------ -}

  oper
    Adjective : Type = {
      s : AForm => Str ;
      hasComp : Bool ;
      } ;

  param
    AForm =
        APosit GenNum  -- Positive, e.g. SABIĦ
      | ACompar        -- Comparative, e.g. ISBAĦ
      | ASuperl        -- Superlative, e.g. L-ISBAĦ
      ;

  oper
    -- adjective: Takes all forms (except superlative)
    -- Params:
      -- Masculine, eg SABIĦ
      -- Feminine, eg SABIĦA
      -- Plural, eg SBIEĦ
      -- Comparative, eg ISBAĦ
    mkAdjective : (_,_,_,_ : Str) -> Adjective = \masc,fem,plural,compar -> {
      s = table {
        APosit gn => case gn of {
          GSg Masc => masc ;
          GSg Fem  => fem ;
          GPl      => plural
        } ;
        ACompar => compar ;
        ASuperl => artDef ++ compar
      } ;
      hasComp = notB (isNil compar) ;
    } ;

  {- Other ---------------------------------------------------------------- -}

  oper

    {- ~~~ Some character classes ~~~ -}

    Letter        : pattern Str = #( "a" | "b" | "ċ" | "d" | "e" | "f" | "ġ" | "g" | "għ" | "h" | "ħ" | "i" | "ie" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "ż" | "z" );
    Consonant     : pattern Str = #( "b" | "ċ" | "d" | "f" | "ġ" | "g" | "għ" | "h" | "ħ" | "j" | "k" | "l" | "m" | "n" | "p" | "q" | "r" | "s" | "t" | "v" | "w" | "x" | "ż" | "z" );
    CoronalCons   : pattern Str = #( "ċ" | "d" | "n" | "r" | "s" | "t" | "x" | "ż" | "z" ); -- "konsonanti xemxin"
    LiquidCons    : pattern Str = #( "l" | "m" | "n" | "r" | "għ" );
    SonorantCons  : pattern Str = #( "l" | "m" | "n" | "r" ); -- See {SA pg13}. Currently unused, but see DoublingConsN below
    DoublingConsT : pattern Str = #( "ċ" | "d" | "ġ" | "s" | "x" | "ż" | "z" ); -- require doubling when prefixed with 't', eg DDUM, ĠĠORR, SSIB, TTIR, ŻŻID {GM pg68,2b} {OM pg90}
    DoublingConsN : pattern Str = #( "l" | "m" | "r" ); -- require doubling when prefixed with 'n', eg LLAĦĦAQ, MMUR, RRID {OM pg90}
    StrongCons    : pattern Str = #( "b" | "ċ" | "d" | "f" | "ġ" | "g" | "għ" | "h" | "ħ" | "k" | "l" | "m" | "n" | "p" | "q" | "r" | "s" | "t" | "v" | "x" | "ż" | "z" );
    WeakCons      : pattern Str = #( "j" | "w" );
    Vowel         : pattern Str = #( "a" | "e" | "i" | "o" | "u" );
    VowelIE       : pattern Str = #( "a" | "e" | "i" | "ie" | "o" | "u" );
    Digraph       : pattern Str = #( "ie" );
    SemiVowel     : pattern Str = #( "għ" | "j" );

    Vwl = Vowel ;
    Cns = Consonant ;
    LCns = LiquidCons ;

    EorI : Str = "e" | "i" ;
    IorE : Str = "i" | "e" ;

    {- ~~~ Roots & Patterns ~~~ -}

    Pattern : Type = {V1, V2 : Str} ;
    Root : Type = {C1, C2, C3, C4 : Str} ;

    -- Make a root object. Accepts following overloads:
    -- mkoot (empty root)
    -- mkRoot "k-t-b" / mkRoot "k-t-b-l"
    -- mkRoot "k" "t" "b"
    -- mkRoot "k" "t" "b" "l"
    mkRoot : Root = overload {
      mkRoot : Root =
        { C1=[] ; C2=[] ; C3=[] ; C4=[] } ;
      mkRoot : Str -> Root = \s ->
        case toLower s of {
          c1 + "-" + c2 + "-" + c3 + "-" + c4 => { C1=c1 ; C2=c2 ; C3=c3 ; C4=c4 } ; -- "k-t-b-l"
          c1 + "-" + c2 + "-" + c3 => { C1=c1 ; C2=c2 ; C3=c3 ; C4=[] } ; -- "k-t-b"
          _ => Predef.error("Cannot make root from:"++s)
        } ;
      mkRoot : Str -> Str -> Str -> Root = \c1,c2,c3 ->
        { C1=toLower c1 ; C2=toLower c2 ; C3=toLower c3 ; C4=[] } ;
      mkRoot : Str -> Str -> Str -> Str -> Root = \c1,c2,c3,c4 ->
        { C1=toLower c1 ; C2=toLower c2 ; C3=toLower c3 ; C4=toLower c4 } ;
      } ;

    mkPattern : Pattern = overload {
      mkPattern : Pattern =
        { V1=[] ; V2=[] } ;
      mkPattern : Str -> Pattern = \v1 ->
        { V1=toLower v1 ; V2=[] } ;
      mkPattern : Str -> Str -> Pattern = \v1,v2 ->
        { V1=toLower v1 ; V2=case v2 of {"" => [] ; _ => toLower v2}} ;
      } ;

    -- Extract first two vowels from a token (designed for semitic verb forms)
    --- potentially slow
    extractPattern : Str -> Pattern = \s ->
      case s of {
        v1@"ie" + _ + v2@#Vowel + _       => mkPattern v1 v2 ; -- IEQAF
        v1@#Vowel + _ + v2@#Vowel + _     => mkPattern v1 v2 ; -- IKTEB
        _ + v1@"ie" + _ + v2@#Vowel + _   => mkPattern v1 v2 ; -- RIEQED
        _ + v1@"ie" + _                   => mkPattern v1 ;    -- ŻIED
        _ + v1@#Vowel + _ + v2@#Vowel + _ => mkPattern v1 v2 ; -- ĦARBAT
        _ + v1@#Vowel + _                 => mkPattern v1 ;    -- ĦOBB
        _                                 => mkPattern
      } ;

    -- Create a VerbInfo record, optionally omitting various fields
    mkVerbInfo : VerbInfo = overload {
      mkVerbInfo : VClass -> VDerivedForm -> VerbInfo = \c,f ->
        { class=c ; form=f ; root=mkRoot ; patt=mkPattern ; patt2=mkPattern ; imp=[] } ;
      mkVerbInfo : VClass -> VDerivedForm -> Str -> VerbInfo = \c,f,i ->
        { class=c ; form=f ; root=mkRoot ; patt=mkPattern ; patt2=mkPattern ; imp=i } ;
      mkVerbInfo : VClass -> VDerivedForm -> Root -> Pattern -> VerbInfo = \c,f,r,p ->
        { class=c ; form=f ; root=r ; patt=p ; patt2=p ; imp=[] } ;
      mkVerbInfo : VClass -> VDerivedForm -> Root -> Pattern -> Str -> VerbInfo = \c,f,r,p,i ->
        { class=c ; form=f ; root=r ; patt=p ; patt2=p ; imp=i } ;
      mkVerbInfo : VClass -> VDerivedForm -> Root -> Pattern -> Pattern -> Str -> VerbInfo = \c,f,r,p,p2,i ->
        { class=c ; form=f ; root=r ; patt=p ; patt2=p2 ; imp=i } ;
      } ;

    -- Change certain fields of a VerbInfo record
    updateVerbInfo : VerbInfo = overload {

      -- Root
      updateVerbInfo : VerbInfo -> Root -> VerbInfo = \i,r ->
        { class=i.class ; form=i.form ; root=r ; patt=i.patt ; patt2=i.patt2 ; imp=i.imp } ;

      -- DerivedForm
      updateVerbInfo : VerbInfo -> VDerivedForm -> VerbInfo = \i,f ->
        { class=i.class ; form=f ; root=i.root ; patt=i.patt ; patt2=i.patt2 ; imp=i.imp } ;

      -- DerivedForm, Imperative
      updateVerbInfo : VerbInfo -> VDerivedForm -> Str -> VerbInfo = \i,f,imp ->
        { class=i.class ; form=f ; root=i.root ; patt=i.patt ; patt2=i.patt2 ; imp=imp } ;

      } ;

    {- ~~~ Useful helper functions ~~~ -}

    -- New names for the drop/take operations
    takePfx = Predef.take ;
    dropPfx = Predef.drop ;
    takeSfx = Predef.dp ;
    dropSfx = Predef.tk ;

    -- Get the character at the specific index (0-based).
    -- Negative indices behave as 0 (first character). Out of range indexes return the empty string.
    charAt : Int -> Str -> Str ;
    charAt i s = takePfx 1 (dropPfx i s) ;

    -- Delete character at the specific index (0-based).
    -- Out of range indices are just ignored.
    delCharAt : Int -> Str -> Str ;
    delCharAt i s = (takePfx i s) + (dropPfx (plus i 1) s) ;

    -- -- Replace first substring
    -- replace : Str -> Str -> Str -> Str ;
    -- replace needle haystack replacement =
    --   case haystack of {
    --     x + needle + y => x + replacement + y ;
    --     _ => haystack
    --   } ;

    -- Prefix with a 'n'/'t' or double initial consonant, as necessary. See {OM pg 90}
    pfx_N : Str -> Str = \s -> case s of {
      "" => [] ;
      m@#DoublingConsN + _ => m + s ;
      _ => "n" + s
      } ;
    pfx_T : Str -> Str = \s -> case s of {
      "" => [] ;
      d@#DoublingConsT + _ => d + s ;
      _ => "t" + s
      } ;
    pfx_J : Str -> Str = \s -> pfx "j" s ;

    -- Generically prefix a string (avoiding empty strings)
    pfx : Str -> Str -> Str = \p,s -> case <p,s> of {
      <_, ""> => [] ;
      <"", str> => str ;
      <px, str> => px + str
      } ;

    -- Add suffix, avoiding triple letters {GO pg96-7}
    --- add more cases?
    --- potentially slow
    sfx : Str -> Str -> Str = \a,b ->
      case <a,takePfx 1 b> of {
        <"",_> => [] ;
        <ke+"nn","n"> => ke+"n"+b ;
        <ha+"kk","k"> => ha+"k"+b ;
        <ho+"ll","l"> => ho+"l"+b ;
        <si+"tt","t"> => si+"t"+b ;
        <be+"xx","x"> => be+"x"+b ;
        _ => a + b
      } ;

    -- Replace any IE in the word with an I or E    --- potentially slow
    ie2i : Str -> Str = ie2_ "i" ;
    ie2e : Str -> Str = ie2_ "e" ;
    ie2_ : Str -> Str -> Str = \iore,serviet ->
      case serviet of {
        x + "ie" => x + iore ;
        x + "ie" + y => x + iore + y ;
        x => x
      } ;

    -- Is a word mono-syllabic?
    --- potentially slow
    isMonoSyl : Str -> Bool = \s ->
      case s of {
        #Consonant + ("ie" | #Vowel) => True ; -- ra
        #Consonant + #Consonant + ("ie" | #Vowel) => True ; -- bla

        ("ie" | #Vowel) + #Consonant => True ; -- af
        ("ie" | #Vowel) + #Consonant + #Consonant => True ; -- elf

        #Consonant + ("ie" | #Vowel) + #Consonant => True ; -- miet
        #Consonant + ("ie" | #Vowel) + #Consonant + #Consonant => True ; -- mort
        #Consonant + #Consonant + ("ie" | #Vowel) + #Consonant => True ; -- ħliet
        #Consonant + #Consonant + ("ie" | #Vowel) + #Consonant + #Consonant => True ; -- ħriġt
        _ => False
      } ;

    artIndef : Str = "" ;

    artDef : Str =
      makePreFull
        "il-" -- il-ktieb
        "i"   -- it-triq
        "l-"  -- l-ajruplan
      ;

    -- Make a pre string which only varies for vowels
    makePreVowel : Str -> Str -> Str = \cons,vowel ->
      let
        vowel' : Str = case vowel of {
          _ + "'" => vowel ++ BIND ;
          _ => vowel
          } ;
      in
      pre {
        -- Consonant
        cons ;
        -- Vowel
        vowel' / strs { "a" ; "e" ; "i" ; "o" ; "u" ; "h" ; "għ" }
      } ;

    -- Make a pre string which varies coronal consonants and vowels
    makePreFull : Str -> Str -> Str -> Str = \cons,corcons,vowel ->
      let
        mal = cons ++ BIND ;
        m' = vowel ++ BIND ;
        ma = corcons ;
      in
      pre {
        -- Regular consonant
        mal ;
        -- Vowel
        m' / strs { "a" ; "e" ; "i" ; "o" ; "u" ; "h" ; "għ" } ;
        -- Coronal consonants
        ma+"ċ-" ++ BIND / strs { "ċ" } ;
        ma+"d-" ++ BIND / strs { "d" } ;
        ma+"n-" ++ BIND / strs { "n" } ;
        ma+"r-" ++ BIND / strs { "r" } ;
        ma+"s-" ++ BIND / strs { "s" } ;
        ma+"t-" ++ BIND / strs { "t" } ;
        ma+"x-" ++ BIND / strs { "x" } ;
        ma+"ż-" ++ BIND / strs { "ż" } ;
        ma+"z-" ++ BIND / strs { "z" }
      } ;

}
