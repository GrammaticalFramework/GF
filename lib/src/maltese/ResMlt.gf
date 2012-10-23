-- ResMlt.gf: Language-specific parameter types, morphology, VP formation
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2012
-- Licensed under LGPL

--# -path=.:../abstract:../common:../prelude

resource ResMlt = ParamX - [Tense] ** open Prelude, Predef in {

  flags coding=utf8 ;

  param

    {- General -}

    Gender  = Masc | Fem ;

    GenNum  =
        GSg Gender -- dak, dik
      | GPl ; -- dawk

    Agr =
        AgP1 Number  -- jiena, aħna
      | AgP2 Number  -- inti, intom
      | AgP3Sg Gender  -- huwa, hija
      | AgP3Pl    -- huma
    ;

    NPCase = Nom | Gen ;

    Animacy =
        Animate
      | Inanimate
    ;

    -- Definiteness =
    --     Definite    -- eg IL-KARTA. In this context same as Determinate
    --   | Indefinite  -- eg KARTA
    --   ;


    {- Numerals -}

    CardOrd = NCard | NOrd ;

    DForm =
        Unit    -- 0..10
      | Teen    -- 11-19
      --| TeenIl  -- 11-19
      | Ten    -- 20-99
      | Hund    -- 100..999
      --| Thou    -- 1000+
    ;

    Num_Number =
        Num_Sg
      | Num_Dl
      | Num_Pl
    ;

    Num_Case =
        NumNominative   -- TNEJN, ĦAMSA, TNAX, MIJA
      | NumAdjectival ; -- ŻEWĠ, ĦAMES, TNAX-IL, MITT


    {- Nouns -}

    Noun_Sg_Type =
        Singulative  -- eg ĦUTA
      | Collective  -- eg ĦUT
    ;
    Noun_Pl_Type =
        Determinate  -- eg ĦUTIET
      | Indeterminate  -- eg ĦWIET
    ;
    Noun_Number =
        Singular Noun_Sg_Type    -- eg ĦUTA / ĦUT
      | Dual            -- eg WIDNEJN
      | Plural Noun_Pl_Type    -- eg ĦUTIET / ĦWIET
    ;

    NForm =
        NRegular -- WIĊĊ
      | NPronSuffix Agr ; -- WIĊĊU


    {- Verb -}

    -- Possible verb forms (tense + person)
    VForm =
        VPerf Agr    -- Perfect tense in all pronoun cases
      | VImpf Agr    -- Imperfect tense in all pronoun cases
      | VImp Number  -- Imperative is always P2, Sg & Pl
      -- | VPresPart GenNum  -- Present Particible for Gender/Number
      -- | VPastPart GenNum  -- Past Particible for Gender/Number
      -- | VVerbalNoun      -- Verbal Noun
    ;

    -- Inflection of verbs for pronominal suffixes
    VSuffixForm =
        VSuffixNone  -- eg FTAĦT
      | VSuffixDir Agr  -- eg FTAĦTU
      | VSuffixInd Agr  -- eg FTAĦTLU
      | VSuffixDirInd GenNum Agr  -- eg FTAĦTHULU. D.O. is necessarily 3rd person.
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
--      | Irregular
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
    -- VRomanceEnding =
    --     _ARE -- kanta
    --   | _ERE | _IRE -- vinċa, serva --- we don't need this distinction, just always use IRE
    --   ;
    -- VQuadClass =
    --     BiradicalBase
    --   | RepeatedC3
    --   | RepeatedC1
    --   | AdditionalC4
    --   ;


    {- Adjective -}

    AForm =
        APosit GenNum
      | ACompar
      | ASuperl
    ;

  oper

    {- ===== Type declarations ===== -}

    Noun : Type = {
      s : Noun_Number => NForm => Str ;
      g : Gender ;
      --      anim : Animacy ; -- is the noun animate? e.g. TABIB
      } ;

    ProperNoun : Type = {
      s : Str ;
      g : Gender ;
      } ;

    Verb : Type = {
      s : VForm => VSuffixForm => Polarity => Str ;
      i : VerbInfo ;
      } ;

    VerbInfo : Type = {
      class : VClass ;
      form : VDerivedForm ;
      root : Root ; -- radicals
      patt : Pattern ; -- vowels extracted from mamma
      patt2: Pattern ; -- vowel changes; default to patt (experimental)
      -- in particular, patt2 is used to indicate whether an IE sould be shortened
      -- to an I or an E (same for entire verb)
      imp : Str ; -- Imperative Sg. Gives so much information jaħasra!
      } ;

    Adjective : Type = {
      s : AForm => Str ;
      } ;


    {- ===== Some character classes ===== -}

    Letter : pattern Str = #( "a" | "b" | "ċ" | "d" | "e" | "f" | "ġ" | "g" | "għ" | "h" | "ħ" | "i" | "ie" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "ż" | "z" );
    Consonant : pattern Str = #( "b" | "ċ" | "d" | "f" | "ġ" | "g" | "għ" | "h" | "ħ" | "j" | "k" | "l" | "m" | "n" | "p" | "q" | "r" | "s" | "t" | "v" | "w" | "x" | "ż" | "z" );
    CoronalCons : pattern Str = #( "ċ" | "d" | "n" | "r" | "s" | "t" | "x" | "ż" | "z" ); -- "konsonanti xemxin"
    LiquidCons : pattern Str = #( "l" | "m" | "n" | "r" | "għ" );
    SonorantCons : pattern Str = #( "l" | "m" | "n" | "r" ); -- See {SA pg13}. Currently unused, but see DoublingConsN below
    DoublingConsT : pattern Str = #( "ċ" | "d" | "ġ" | "s" | "x" | "ż" | "z" ); -- require doubling when prefixed with 't', eg DDUM, ĠĠORR, SSIB, TTIR, ŻŻID {GM pg68,2b} {OM pg90}
    DoublingConsN : pattern Str = #( "l" | "m" | "r" ); -- require doubling when prefixed with 'n', eg LLAĦĦAQ, MMUR, RRID {OM pg90}
    WeakCons : pattern Str = #( "j" | "w" );
    Vowel : pattern Str = #( "a" | "e" | "i" | "o" | "u" );
    VowelIE : pattern Str = #( "a" | "e" | "i" | "ie" | "o" | "u" );
    Digraph : pattern Str = #( "ie" );
    SemiVowel : pattern Str = #( "għ" | "j" );

    V = Vowel ;
    C = Consonant ;
    LC = LiquidCons ;

    EorI : Str = "e" | "i" ;
    IorE : Str = "i" | "e" ;

    {- ===== Roots & Patterns ===== -}

    Pattern : Type = {V1, V2 : Str} ;
    Root : Type = {C1, C2, C3, C4 : Str} ;

    -- Make a root object. Accepts following overloads:
    -- mkRoot
    -- mkRoot "k-t-b"
    -- mkRoot "k-t-b-l"
    -- mkRoot "k" "t" "b"
    -- mkRoot "k" "t" "b" "l"
    mkRoot : Root = overload {
      mkRoot : Root =
        { C1=[] ; C2=[] ; C3=[] ; C4=[] } ;
      mkRoot : Str -> Root = \root ->
        case toLower root of {
          c1@#Consonant + "-" + c2@#Consonant + "-" + c3@#Consonant =>
            { C1=c1 ; C2=c2 ; C3=c3 ; C4=[] } ; -- "k-t-b"
          c1@#Consonant + "-" + c2@#Consonant + "-" + c3@#Consonant + "-" + c4@#Consonant =>
            { C1=c1 ; C2=c2 ; C3=c3 ; C4=c4 } ; -- "k-t-b-l"
          _   => { C1=(charAt 0 root) ; C2=(charAt 1 root) ; C3=(charAt 2 root) ; C4=(charAt 3 root) }   -- "ktb" (not recommended)
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
        v1@"ie" + _ + v2@#Vowel + _ => mkPattern v1 v2 ; -- IEQAF
        v1@#Vowel + _ + v2@#Vowel + _ => mkPattern v1 v2 ; -- IKTEB
        _ + v1@"ie" + _ + v2@#Vowel + _ => mkPattern v1 v2 ; -- RIEQED
        _ + v1@"ie" + _ => mkPattern v1 ; -- ŻIED
        _ + v1@#Vowel + _ + v2@#Vowel + _ => mkPattern v1 v2 ; -- ĦARBAT
        _ + v1@#Vowel + _ => mkPattern v1 ; -- ĦOBB
        _ => mkPattern
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


    {- ===== Conversions ===== -}

    numnum2nounnum : Num_Number -> Noun_Number = \n ->
      case n of {
	Num_Sg => Singular Singulative ;
	_ => Plural Determinate
      } ;


    {- ===== Useful helper functions ===== -}

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
    pfx_N : Str -> Str = \s -> case takePfx 1 s of {
      "" => [] ;
      m@#DoublingConsN => m + s ;
      _ => "n" + s
      } ;
    pfx_T : Str -> Str = \s -> case takePfx 1 s of {
      "" => [] ;
      d@#DoublingConsT => d + s ;
      _ => "t" + s
      } ;
    -- This is just here to standardise
    -- pfx_J : Str -> Str = \s -> case takePfx 1 s of {
    --   "" => [] ;
    --   _ => "j" + s
    --   } ;
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

    
    -- Add a definite preposition in front of your token
    addDefinitePreposition : Str -> Str -> Str = \prep,n -> (getDefinitePreposition prep n) ++ n ;
    addDefiniteArticle = addDefinitePreposition "il" ;
    getDefiniteArticle = getDefinitePreposition "il" ;

    -- Correctly inflect definite preposition
    -- A more generic version of getDefiniteArticle
      -- Params:
        -- preposition (eg TAL, MAL, BĦALL)
        -- noun
    -- NOTE trying to call this with a runtime string will cause a world of pain. Design around it.
    getDefinitePreposition : Str -> Str -> Str = \prep,noun ->
      let
        -- Remove either 1 or 2 l's
        prepStem : Str = case prep of {
          _ + "ll" => Predef.tk 2 prep ;
          _ + "l"  => Predef.tk 1 prep ;
          _ => prep -- this should never happen, I don't think
        }
      in
      case noun of {
        ("s"|#LiquidCons) + #Consonant + _   => prep + "-i" ;    -- L-ISKOLA
        ("għ" | #Vowel) + _         => case prep of {    -- L-GĦATBA...
                            ("fil"|"bil")  => (Predef.take 1 prep) + "l-" ;
                            "il"       => "l" + "-" ;
                            _         => prep + "-"
                          };
        K@#CoronalCons + _       => prepStem + K + "-" ;  -- IĊ-ĊISK
        #Consonant + _             => prep + "-" ;      -- IL-QADDIS
        _                   => []          -- ?
      } ;

    artIndef = [] ;

    artDef : Str =
      pre {
        "il-" ;
        "l-" / strs { "a" ; "e" ; "i" ; "o" ; "u" ; "h" ; "għ" } ;
        "iċ-" / strs { "ċ" } ;
        "id-" / strs { "d" } ;
        "in-" / strs { "n" } ;
        "ir-" / strs { "r" } ;
        "is-" / strs { "s" } ;
        "it-" / strs { "t" } ;
        "ix-" / strs { "x" } ;
        "iż-" / strs { "ż" } ;
        "iz-" / strs { "z" }
      } ;

    {- ===== Worst-case functions ===== -}

    -- Noun: Takes all forms and a gender
    -- Params:
      -- Singulative, eg KOXXA
      -- Collective, eg KOXXOX
      -- Double, eg KOXXTEJN
      -- Determinate Plural, eg KOXXIET
      -- Indeterminate Plural
      -- Gender
--     mkNoun : (_,_,_,_,_ : NForm => Str) -> Gender -> Noun = \sing,coll,dual,det,ind,gen -> {
--       s = table {
--         Singular Singulative => sing ;
--         Singular Collective => coll ;
--         Dual => dual ;
--         Plural Determinate => det ;
--         Plural Indeterminate => ind
--       } ;
--       g = gen ;
-- --      anim = Inanimate ;
--     } ;

    -- Make a noun animate
    animateNoun : Noun -> Noun ;
    animateNoun = \n -> n ** {anim = Animate} ;

    -- Build an empty pronominal suffix table
    nullSuffixTable : Str -> (NForm => Str) ;
    nullSuffixTable = \s -> table {
      NRegular => s ;
      NPronSuffix _ => []
      } ;

    -- Build a noun's pronominal suffix table
    mkSuffixTable : (NForm => Str) = overload {

      mkSuffixTable : (_ : Str) -> (NForm => Str) = \wicc ->
        table {
          NRegular => wicc ;
          NPronSuffix (AgP1 Sg) => wicc + "i" ;
          NPronSuffix (AgP2 Sg) => wicc + "ek" ;
          NPronSuffix (AgP3Sg Masc) => wicc + "u" ;
          NPronSuffix (AgP3Sg Fem) => wicc + "ha" ;
          NPronSuffix (AgP1 Pl) => wicc + "na" ;
          NPronSuffix (AgP2 Pl) => wicc + "kom" ;
          NPronSuffix (AgP3Pl) => wicc + "hom"
        } ;

      mkSuffixTable : (_,_,_,_,_,_,_,_ : Str) -> (NForm => Str) = \isem,ismi,ismek,ismu,isimha,isimna,isimkom,isimhom ->
        table {
          NRegular => isem ;
          NPronSuffix (AgP1 Sg) => ismi ;
          NPronSuffix (AgP2 Sg) => ismek ;
          NPronSuffix (AgP3Sg Masc) => ismu ;
          NPronSuffix (AgP3Sg Fem) => isimha ;
          NPronSuffix (AgP1 Pl) => isimna ;
          NPronSuffix (AgP2 Pl) => isimkom ;
          NPronSuffix (AgP3Pl) => isimhom
        } ;

      } ;

    -- mkNoun = overload {

    --   mkNoun : (_,_,_,_,_ : Str) -> Gender -> Noun = \sing,coll,dual,det,ind,gen -> {
    --     s = table {
    --       Singular Singulative => (nullSuffixTable sing) ;
    --       Singular Collective => (nullSuffixTable coll) ;
    --       Dual => (nullSuffixTable dual) ;
    --       Plural Determinate => (nullSuffixTable det) ;
    --       Plural Indeterminate => (nullSuffixTable ind)
    --       } ;
    --     g = gen ;
    --     --      anim = Inanimate ;
    --     } ;

      mkNoun : (_,_,_,_,_ : NForm => Str) -> Gender -> Noun = \sing,coll,dual,det,ind,gen -> {
        s = table {
          Singular Singulative => sing ;
          Singular Collective => coll ;
          Dual => dual ;
          Plural Determinate => det ;
          Plural Indeterminate => ind
          } ;
        g = gen ;
        --      anim = Inanimate ;
        } ;

      -- } ;

    -- Adjective: Takes all forms (except superlative)
    -- Params:
      -- Masculine, eg SABIĦ
      -- Feminine, eg SABIĦA
      -- Plural, eg SBIEĦ
      -- Comparative, eg ISBAĦ
    mkAdjective : (_,_,_,_ : Str) -> Adjective = \masc,fem,plural,compar -> {
      s = table {
        APosit gn => case gn of {
          GSg Masc => masc ;
          GSg Fem => fem ;
          GPl => plural
        } ;
        ACompar => compar ;
        ASuperl => addDefiniteArticle compar
      } ;
    } ;

}

