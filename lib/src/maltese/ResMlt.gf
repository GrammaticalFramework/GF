-- ResMlt.gf: Language-specific parameter types, morphology, VP formation
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2012
-- Licensed under LGPL

--# -path=.:../abstract:../common:../prelude

resource ResMlt = ParamX - [Tense] ** open Prelude, Predef in {

  flags coding=utf8 ;

  param

    Gender  = Masc | Fem ;

    NPCase = Nom | Gen ;

    {- Numerals -}

    CardOrd = NCard | NOrd ;

    Num_Number =
        Num_Sg
      | Num_Dl
      | Num_Pl
    ;

  -- oper
  --   Num_Number : Type = { n : Number ; isDual : Bool } ;

  param

    DForm =
        Unit    -- 0..10
      | Teen    -- 11-19
      --| TeenIl  -- 11-19
      | Ten    -- 20-99
      | Hund    -- 100..999
      --| Thou    -- 1000+
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

    {- Other... -}

    GenNum  = GSg Gender | GPl ; -- masc/fem/plural, e.g. adjective inflection

    Animacy =
        Animate
      | Inanimate
    ;

    Definiteness =
        Definite    -- eg IL-KARTA. In this context same as Determinate
      | Indefinite  -- eg KARTA
      ;

--    Person  = P1 | P2 | P3 ;
--    State   = Def | Indef | Const ;
--    Mood    = Ind | Cnj | Jus ;
--    Voice   = Act | Pas ;

--    Order   = Verbal | Nominal ;

    -- Agreement features
    Agr =
        AgP1 Number  -- Jiena, Aħna
      | AgP2 Number  -- Inti, Intom
      | AgP3Sg Gender  -- Huwa, Hija
      | AgP3Pl    -- Huma
    ;

    -- Agr : Type = {g : Gender ; n : Number ; p : Person} ;
    -- Ag : Gender -> Number -> Person -> Agr = \g,n,p -> {g = g ; n = n ; p = p} ;
    -- agrP1 : Number -> Agr = \n -> Ag {} n P1 ;
    -- agrP3 : Gender -> Number -> Agr = \g,n -> Ag g n P3 ;

    -- Possible tenses
    -- Tense =
    --     Perf  -- Perfect tense, eg SERAQ
    --   | Impf -- Imperfect tense, eg JISRAQ
    --   | Imp  -- Imperative, eg ISRAQ
      -- | PresPart  -- Present Particible. Intransitive and 'motion' verbs only, eg NIEŻEL
      -- | PastPart  -- Past Particible. Both verbal & adjectival function, eg MISRUQ
      -- | VerbalNoun  -- Verbal Noun, eg SERQ
    -- ;

    -- Possible verb forms (tense + person)
    VForm =
        VPerf Agr    -- Perfect tense in all pronoun cases
      | VImpf Agr    -- Imperfect tense in all pronoun cases
      | VImp Number  -- Imperative is always P2, Sg & Pl
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
      | FormXI
      | FormX
      ;

    -- Verb classification
    VClass =
        Strong VStrongClass
      | Weak VWeakClass
      | Loan --- temporary
      -- | Romance
      -- | English
      ;

    VStrongClass =
        Regular
      | LiquidMedial
      | Reduplicative
      | Quad
      ;

    VWeakClass =
        Assimilative
      | Hollow
      | WeakFinal
      | Defective
      | QuadWeakFinal
      ;

    -- VQuadClass =
    --     BiradicalBase
    --   | RepeatedC3
    --   | RepeatedC1
    --   | AdditionalC4
    --   ;

    VRomanceClass =
        Integrated
      | NonIntegrated
      ;

    -- Inflection of verbs for pronominal suffixes
    VSuffixForm =
        VNone  -- eg FTAĦT
      | VDir Agr  -- eg FTAĦTU
      | VInd Agr  -- eg FTAĦTLU
      | VDirInd Agr Agr  -- eg FTAĦTHULU
      ;

    -- For Adjectives
    AForm =
--        AF Degree GenNum
        APosit GenNum
      | ACompar
      | ASuperl
    ;

  oper

    -- Roots & Patterns
    Pattern : Type = {V1, V2 : Str} ;
    -- Root3 : Type = {K, T, B : Str} ;
    -- Root4 : Type = Root3 ** {L : Str} ;
    Root : Type = {C1, C2, C3, C4 : Str} ;

    mkRoot : Root = overload {
      mkRoot : Root =
        { C1=[] ; C2=[] ; C3=[] ; C4=[] } ;
      mkRoot : Str -> Root = \root ->
        let root = toLower root in
        case (charAt 1 root) of {
          "-" => { C1=(charAt 0 root) ; C2=(charAt 2 root) ; C3=(charAt 4 root) ; C4=(charAt 6 root) } ; -- "k-t-b"
          _   => { C1=(charAt 0 root) ; C2=(charAt 1 root) ; C3=(charAt 2 root) ; C4=(charAt 3 root) }   -- "ktb"
        } ;
      mkRoot : Str -> Str -> Str -> Root = \c1,c2,c3 ->
        { C1=c1 ; C2=c2 ; C3=c3 ; C4=[] } ;
      mkRoot : Str -> Str -> Str -> Str -> Root = \c1,c2,c3,c4 ->
        { C1=c1 ; C2=c2 ; C3=c3 ; C4=c4 } ;
      } ;
    
    mkPattern : Pattern = overload {
      mkPattern : Pattern =
        { V1=[] ; V2=[] } ;
      mkPattern : Str -> Pattern = \v1 ->
        { V1=v1 ; V2=[] } ;
      mkPattern : Str -> Str -> Pattern = \v1,v2 ->
        { V1=v1 ; V2=v2 } ;
      } ;

    -- Some character classes
    Consonant : pattern Str = #( "b" | "ċ" | "d" | "f" | "ġ" | "g" | "għ" | "ħ" | "h" | "j" | "k" | "l" | "m" | "n" | "p" | "q" | "r" | "s" | "t" | "v" | "w" | "x" | "ż" | "z" );
    CoronalCons : pattern Str = #( "ċ" | "d" | "n" | "r" | "s" | "t" | "x" | "ż" | "z" ); -- "konsonanti xemxin"
    ImpfDoublingCons : pattern Str = #( "d" | "ġ" | "s" | "t" | "ż" ); -- require doubling in imperfect, eg (inti) IDDUM, IĠĠOR, ISSIB, ITTIR, IŻŻID. --- only used in hollow paradigm (?)
    LiquidCons : pattern Str = #( "l" | "m" | "n" | "r" | "għ" );
    WeakCons : pattern Str = #( "j" | "w" );
    Vowel : pattern Str = #( "a" | "e" | "i" | "o" | "u" );
    Digraph : pattern Str = #( "ie" );
    SemiVowel : pattern Str = #( "għ" | "j" );

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
      s : VForm => Str ;
--      s : VForm => VSuffixForm => Str ;
      c : VClass ;
    } ;

    Adjective : Type = {
      s : AForm => Str ;
    } ;

    {- ===== Conversions ===== -}

    numnum2nounnum : Num_Number -> Noun_Number = \n ->
      case n of {
	Num_Sg => Singular Singulative ;
	_ => Plural Determinate
      } ;


    {- ===== Useful helper functions ===== -}

    -- Get the character at the specific index (0-based).
    -- Negative indexes behave as 0 (first character). Out of range indexes return the empty string.
    charAt : Int -> Str -> Str ;
    charAt i s = take 1 (drop i s) ;

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

