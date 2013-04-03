-- ResMlt.gf: Language-specific parameter types, morphology, VP formation
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Angelo Zammit 2012
-- Licensed under LGPL

--# -path=.:../abstract:../common:../prelude

resource ResMlt = ParamX ** open Prelude, Predef in {

  flags coding=utf8 ;

  {- General -------------------------------------------------------------- -}

  param

    Gender = Masc | Fem ;

    GenNum  =
        GSg Gender -- dak, dik
      | GPl -- dawk
      ;

    Definiteness =
        Definite    -- eg BIL-
      | Indefinite  -- eg BI
      ;

  oper
    -- Agreement system corrected based on comments by [AZ]
    Agr : Type = { g : Gender ; n : Number ; p : Person } ;

    mkAgr : Gender -> Number -> Person -> Agr = \g,n,p -> {g = g ; n = n ; p = p} ;

    toVAgr : Agr -> VAgr = \agr ->
      case <agr.p,agr.n> of {
        <P1,num> => AgP1 num;
        <P2,num> => AgP2 num;
        <P3,Sg>  => AgP3Sg agr.g;
        <P3,Pl>  => AgP3Pl
      } ;
    
    toAgr : VAgr -> Agr = \vagr ->
      case vagr of {
        AgP1 num   => mkAgr Masc num P1 ; --- sorry ladies
        AgP2 num   => mkAgr Masc num P2 ;
        AgP3Sg gen => mkAgr gen Pl P3 ;
        AgP3Pl     => mkAgr Masc Pl P3
      } ;

  param
    -- Agreement for verbs
    VAgr =
        AgP1 Number   -- jiena, aħna
      | AgP2 Number   -- inti, intom
      | AgP3Sg Gender -- huwa, hija
      | AgP3Pl        -- huma
      ;

  param
    NPCase = Nom | CPrep ; -- [AZ]

  {- Numeral -------------------------------------------------------------- -}

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

  {- Nouns ---------------------------------------------------------------- -}

  oper
    Noun : Type = {
      s : Noun_Number => Str ;
      g : Gender ;
      hasColl : Bool ; -- has a collective form? e.g. BAQAR
      hasDual : Bool ; -- has a dual form? e.g. SAGĦTEJN
      takesPron : Bool ; -- takes enclitic pronon? e.g. MISSIERI
      --      anim : Animacy ; -- is the noun animate? e.g. TABIB
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

  {- Pronoun -------------------------------------------------------------- -}

  oper
    Pronoun = {
      -- s : PronForm => {c1, c2: Str} ;
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

  {- Verb ----------------------------------------------------------------- -}

  oper
    Verb : Type = {
      s : VForm => Str ;
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
      -- | VPresPart GenNum  -- Present Particible for Gender/Number
      -- | VPastPart GenNum  -- Past Particible for Gender/Number
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

  oper

    VerbParts : Type = { stem, dir, ind, pol : Str } ;
    mkVParts = overload {
      mkVParts : Str -> Str -> VerbParts = \a,d -> {stem=a; dir=[]; ind=[]; pol=d} ;
      mkVParts : Str -> Str -> Str -> Str -> VerbParts = \a,b,c,d -> {stem=a; dir=b; ind=c; pol=d} ;
      } ;
    joinVParts : VerbParts -> Str = \vb -> vb.stem ++ vb.dir ++ vb.ind ++ vb.ind ;
    
    -- [AZ]
    VP : Type = {
      s : VPForm => Anteriority => Polarity => VerbParts ; -- verb
      s2 : Agr => Str ; -- complement
      -- a1 : Str ;
      -- a2 : Str ;
      } ;

  param
    -- [AZ]
    VPForm =
        VPIndicat Tense VAgr
      | VPImperat Number
      ;

  oper

    -- [AZ]
    insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
      s = vp.s ;
      s2 = obj ;
      -- a1 = vp.a1 ;
      -- a2 = vp.a2 ;
      } ;

    copula_kien = {
      s : (VForm => Str) = table {
        VPerf (AgP1 Sg)     => "kont" ;
        VPerf (AgP2 Sg)     => "kont" ;
        VPerf (AgP3Sg Masc) => "kien" ;
        VPerf (AgP3Sg Fem)  => "kienet" ;
        VPerf (AgP1 Pl)     => "konna" ;
        VPerf (AgP2 Pl)     => "kontu" ;
        VPerf (AgP3Pl)      => "kienu" ;
        VImpf (AgP1 Sg)     => "nkun" ;
        VImpf (AgP2 Sg)     => "tkun" ;
        VImpf (AgP3Sg Masc) => "jkun" ;
        VImpf (AgP3Sg Fem)  => "tkun" ;
        VImpf (AgP1 Pl)     => "nkunu" ;
        VImpf (AgP2 Pl)     => "tkunu" ;
        VImpf (AgP3Pl)      => "jkunu" ;
        VImp (Pl)           => "kun" ;
        VImp (Sg)           => "kunu"
        } ;
      i : VerbInfo = mkVerbInfo (Irregular) (FormI) (mkRoot "k-w-n") (mkPattern "ie") ;
      } ;

    -- Adapted from [AZ]
    CopulaVP : VP = {
      s = \\vpf,ant,pol =>
        case <vpf> of {
          <VPIndicat Past vagr> => polarise (copula_kien.s ! VPerf vagr) pol ;
          <VPIndicat Pres vagr> => polarise (copula_kien.s ! VImpf vagr) pol ;
          <VPImperat num> => polarise (copula_kien.s ! VImp num) pol ;
          _ => Predef.error "tense not implemented"
        } ;
      s2 = \\agr => [] ;
      } where {
        polarise : Str -> Polarity -> VerbParts = \s,pol ->
          mkVParts s (case pol of { Neg => BIND ++ "x" ; _ => [] }) ;
      } ;

    -- [AZ]
    predV : Verb -> VP = \verb -> {
      s = \\vpf,ant,pol =>
        let
          ma = "ma" ;
          mhux = "mhux" ;
          b1 : Str -> VerbParts = \s -> mkVParts s [] ;
          b2 : Str -> VerbParts = \s -> mkVParts s (BIND ++ "x") ;
        in
        case vpf of {
          VPIndicat tense vagr =>
            let
              kien = joinVParts (CopulaVP.s ! VPIndicat Past vagr ! Simul ! pol) ;
            in
            case <tense,ant,pol> of {
              <Pres,Simul,Pos> => b1 (verb.s ! VImpf vagr) ; -- norqod
              <Pres,Anter,Pos> => b1 (kien ++ verb.s ! VImpf vagr) ; -- kont norqod
              <Past,Simul,Pos> => b1 (verb.s ! VPerf vagr) ; -- rqadt
              <Past,Anter,Pos> => b1 (kien ++ verb.s ! VPerf vagr) ; -- kont rqadt
              <Fut, Simul,Pos> => b1 ("se" ++ verb.s ! VImpf vagr) ; -- se norqod
              <Fut, Anter,Pos> => b1 (kien ++ "se" ++ verb.s ! VImpf vagr) ; -- kont se norqod

              <Pres,Simul,Neg> => b2 (ma ++ verb.s ! VImpf vagr) ; -- ma norqodx
              <Pres,Anter,Neg> => b1 (ma ++ kien ++ verb.s ! VImpf vagr) ; -- ma kontx norqod
              <Past,Simul,Neg> => b2 (ma ++ verb.s ! VPerf vagr) ; -- ma rqadtx
              <Past,Anter,Neg> => b1 (ma ++ kien ++ verb.s ! VPerf vagr) ; -- ma kontx rqadt
              <Fut, Simul,Neg> => b1 (mhux ++ "se" ++ verb.s ! VImpf vagr) ; -- mhux se norqod
              <Fut, Anter,Neg> => b1 (ma ++ kien ++ "se" ++ verb.s ! VImpf vagr) ; -- ma kontx se norqod

              <Cond,_,Pos> => b1 (kien ++ verb.s ! VImpf vagr) ; -- kont norqod
              <Cond,_,Neg> => b1 (ma ++ kien ++ verb.s ! VImpf vagr) -- ma kontx norqod
            } ;
          VPImperat num => b2 (verb.s ! VImp num) -- torqodx
        };
      s2 = \\agr => [] ;
      -- a1 = [] ;
      -- n2 = \\_ => [] ;
      -- a2 = [] ;
      } ;

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


    {- ~~~ Conversions ~~~ -}

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

    {- ~~~ Useful helper functions ~~~ -}

    -- Non-existant form
    noexist : Str = "NOEXIST" ;

    -- New names for the drop/take operations
    --- dependent on defn of ResMlt.noexist
    takePfx : Int -> Str -> Str = \n,s -> case s of { "NOEXIST" => noexist ; _ => Predef.take n s } ;
    dropPfx : Int -> Str -> Str = \n,s -> case s of { "NOEXIST" => noexist ; _ => Predef.drop n s } ;
    takeSfx : Int -> Str -> Str = \n,s -> case s of { "NOEXIST" => noexist ; _ => Predef.dp n s } ;
    dropSfx : Int -> Str -> Str = \n,s -> case s of { "NOEXIST" => noexist ; _ => Predef.tk n s } ;
    -- takePfx = Predef.take ;
    -- dropPfx = Predef.drop ;
    -- takeSfx = Predef.dp ;
    -- dropSfx = Predef.tk ;

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
      "NOEXIST" => noexist ; --- dependent on defn of ResMlt.noexist
      m@#DoublingConsN + _ => m + s ;
      _ => "n" + s
      } ;
    pfx_T : Str -> Str = \s -> case s of {
      "" => [] ;
      "NOEXIST" => noexist ; --- dependent on defn of ResMlt.noexist
      d@#DoublingConsT + _ => d + s ;
      _ => "t" + s
      } ;
    pfx_J : Str -> Str = \s -> pfx "j" s ;

    -- Generically prefix a string (avoiding empty strings)
    pfx : Str -> Str -> Str = \p,s -> case <p,s> of {
      <_, ""> => [] ;
      <"", str> => str ;
      <_, "NOEXIST"> => noexist ; --- dependent on defn of ResMlt.noexist
      <"NOEXIST", str> => str ; --- dependent on defn of ResMlt.noexist
      <px, str> => px + str
      } ;
  
    -- Add suffix, avoiding triple letters {GO pg96-7}
    --- add more cases?
    --- potentially slow
    sfx : Str -> Str -> Str = \a,b ->
      case <a,takePfx 1 b> of {
        <"",_> => [] ;
        <"NOEXIST",_> => noexist ; --- dependent on defn of ResMlt.noexist
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

    {- ~~~ Worst-case functions ~~~ -}

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
      -- anim = Inanimate ;
      } ;

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

}

