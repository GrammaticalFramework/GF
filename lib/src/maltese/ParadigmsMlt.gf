-- ParadigmsMlt.gf: morphological paradigms
--
-- Maltese Resource Grammar Library
-- John J. Camilleri, 2012
-- Licensed under LGPL

--# -path=.:../abstract:../../prelude:../common

resource ParadigmsMlt = open
  Predef,
  Prelude,
  MorphoMlt,
  ResMlt,
  CatMlt
  in {

  flags
    optimize=noexpand ;
    coding=utf8 ;

  oper

    {- ===== Parameters ===== -}

    -- Abstraction over gender names
    Gender : Type ;
    masculine : Gender ; --%
    feminine : Gender ; --%

    Gender = ResMlt.Gender ;
    masculine = Masc ;
    feminine = Fem ;

    {- ===== Noun Paradigms ===== -}

    -- Helper function for inferring noun plural from singulative
    -- Nouns with collective & determinate forms should not use this...
    inferNounPlural : Str -> Str = \sing ->
      case sing of {
        _ + "na" => init sing + "iet" ; -- eg WIDNIET
        _ + "i" => sing + "n" ; -- eg BAĦRIN, DĦULIN, RAĦLIN
        _ + ("a"|"u") => init(sing) + "i" ; -- eg ROTI
        _ + "q" => sing + "at" ; -- eg TRIQAT
        _ => sing + "i"
      } ;

    -- Helper function for inferring noun gender from singulative
    -- Refer {MDG pg190}
    inferNounGender : Str -> Gender = \sing ->
      case sing of {
        _ + "aġni" => Fem ;
        _ + "anti" => Fem ;
        _ + "zzjoni" => Fem ;
        _ + "ġenesi" => Fem ;
        _ + "ite" => Fem ;
        _ + "itù" => Fem ;
        _ + "joni" => Fem ;
        _ + "ojde" => Fem ;
        _ + "udni" => Fem ;
        _ + ("a"|"à") => Fem ;
        _ => Masc
      } ;


    -- Smart paradigm for building a noun
    mkN : N = overload {

      -- Take the singular and infer gender & plural.
      -- Assume no special plural forms.
      -- Params:
        -- Singular, eg AJRUPLAN
      mkN : Str -> N = \sing ->
        let
          plural = inferNounPlural sing ;
          gender = inferNounGender sing ;
        in
          mk5N sing [] [] plural [] gender ;

      -- Take an explicit gender.
      -- Assume no special plural forms.
      -- Params:
        -- Singular, eg AJRUPLAN
        -- Gender
      mkN : Str -> Gender -> N = \sing,gender ->
        let
          plural = inferNounPlural sing ;
        in
          mk5N sing [] [] plural [] gender ;

      -- Take the singular, plural. Infer gender.
      -- Assume no special plural forms.
      -- Params:
        -- Singular, eg KTIEB
        -- Plural, eg KOTBA
      mkN : Str -> Str -> N = \sing,plural ->
        let
          gender = inferNounGender sing ;
        in
          mk5N sing [] [] plural [] gender ;

      -- Take the singular, plural and gender.
      -- Assume no special plural forms.
      -- Params:
        -- Singular, eg KTIEB
        -- Plural, eg KOTBA
        -- Gender
      mkN : Str -> Str -> Gender -> N = \sing,plural,gender ->
          mk5N sing [] [] plural [] gender ;


      -- Takes all 5 forms, inferring gender
      -- Params:
        -- Singulative, eg KOXXA
        -- Collective, eg KOXXOX
        -- Double, eg KOXXTEJN
        -- Determinate Plural, eg KOXXIET
        -- Indeterminate Plural
      mkN : Str -> Str -> Str -> Str -> Str -> N = \sing,coll,dual,det,ind ->
        let
          gender = if_then_else (Gender) (isNil sing) (inferNounGender coll) (inferNounGender sing) ;
        in
          mk5N sing coll dual det ind gender ;

    } ; --end of mkN overload

    -- Take the singular and infer gender.
    -- No other plural forms.
    -- Params:
      -- Singular, eg ARTI
    mkNNoPlural : N = overload {

      mkNNoPlural : Str -> N = \sing ->
        let  gender = inferNounGender sing ;
        in  mk5N sing [] [] [] [] gender
      ;

      mkNNoPlural : Str -> Gender -> N = \sing,gender ->
        mk5N sing [] [] [] [] gender
      ;

    } ; --end of mkNNoPlural overload


    -- Take the singular and infer dual, plural & gender
    -- Params:
      -- Singular, eg AJRUPLAN
    mkNDual : Str -> N = \sing ->
      let
        dual : Str = case sing of {
          _ + ("għ"|"'") => sing + "ajn" ;
          _ + ("a") => init(sing) + "ejn" ;
          _ => sing + "ejn"
        } ;
        plural = inferNounPlural sing ;
        gender = inferNounGender sing ;
      in
        mk5N sing [] dual plural [] gender ;


    -- Take the collective, and infer singulative, determinate plural, and gender.
    -- Params:
      -- Collective Plural, eg TUFFIEĦ
    mkNColl : Str -> N = \coll ->
      let
        stem : Str = case coll of {
          -- This can only apply when there are 2 syllables in the word
          _ + #Vowel + #Consonant + #Vowel + K@#Consonant => dropSfx 2 coll + K ; -- eg GĦADAM -> GĦADM-

          _ => coll
        } ;
        sing : Str = case stem of {
          _ => stem + "a"
        } ;
        det : Str = case stem of {
          _ => stem + "iet"
        } ;
        -- gender = inferNounGender sing ;
        gender = Masc ; -- Collective noun is always treated as Masculine
      in
        mk5N sing coll [] det [] gender ;

    -- Build a noun using 5 forms, and a gender
    mk5N : (_,_,_,_,_ : Str) -> Gender -> N ;
    mk5N = \sing,coll,dual,det,ind,gen ->
--      lin N (mkNoun sing coll dual det ind gen) ;
      lin N (mkNoun
               (nullSuffixTable sing)
               (nullSuffixTable coll)
               (nullSuffixTable dual)
               (nullSuffixTable det)
               (nullSuffixTable ind)
               gen) ;

{-
    -- Correctly abbreviate definite prepositions and join with noun
    -- Params:
      -- preposition (eg TAL, MAL, BĦALL)
      -- noun
    abbrevPrepositionDef : Str -> Str -> Str = \prep,noun ->
      let
        -- Remove either 1 or 2 l's
        prepStem : Str = case prep of {
          _ + "ll" => dropSfx 2 prep ;
          _ + "l"  => dropSfx 1 prep ;
          _ => prep -- this should never happen, I don't think
        }
      in
      case noun of {
        ("s"|#LiquidCons) + #Consonant + _ => prep + "-i" + noun ;
        ("għ" | #Vowel) + _ => case prep of {
          ("fil"|"bil") => (takePfx 1 prep) + "l-" + noun ;
          _ => prep + "-" + noun
        };
        K@#CoronalConsonant + _ => prepStem + K + "-" + noun ;
        #Consonant + _ => prep + "-" + noun ;
        _ => []
      } ;
-}
    -- Correctly abbreviate indefinite prepositions and join with noun
    -- Params:
      -- preposition (eg TA', MA', BĦAL)
      -- noun
    abbrevPrepositionIndef : Str -> Str -> Str = \prep,noun ->
      let
        initPrepLetter = takePfx 1 prep ;
        initNounLetter = takePfx 1 noun
      in
      if_then_Str (isNil noun) [] (
      case prep of {

        -- TA', MA', SA
        _ + ("a'"|"a") =>
          case noun of {
            #Vowel + _  => initPrepLetter + "'" + noun ;
            ("għ" | "h") + #Vowel + _ => initPrepLetter + "'" + noun ;
            _ => prep ++ noun
          } ;

        -- FI, BI
        _ + "i" =>
        if_then_Str (pbool2bool (eqStr initPrepLetter initNounLetter))
          (prep ++ noun)
          (case noun of {
            -- initPrepLetter + _ => prep ++ noun ;
            #Vowel + _  => initPrepLetter + "'" + noun ;
            #Consonant + #Vowel + _  => initPrepLetter + "'" + noun ;
            #Consonant + "r" + #Vowel + _ => initPrepLetter + "'" + noun ;
            _ => prep ++ noun
          }) ;

        -- Else leave untouched
        _ => prep ++ noun

      });


    mkN2 = overload {
      mkN2 : N -> Prep -> N2 = prepN2 ;
      mkN2 : N -> Str -> N2 = \n,s -> prepN2 n (mkPrep s);
--      mkN2 : Str -> Str -> N2 = \n,s -> prepN2 (regN n) (mkPrep s);
      mkN2 : N -> N2         = \n -> prepN2 n (mkPrep "ta'") ;
--      mkN2 : Str -> N2       = \s -> prepN2 (regN s) (mkPrep "ta'")
    } ;

    prepN2 : N -> Prep -> N2 ;
    prepN2 = \n,p -> lin N2 (n ** {c2 = p.s}) ;

    mkPrep : Str -> Prep ; -- e.g. "in front of"
    noPrep : Prep ;  -- no preposition

    mkPrep p = lin Prep (ss p) ;
    noPrep = mkPrep [] ;


    {- ===== Verb paradigms ===== -}
{-
    -- Takes a verb as a string determined derived form
    -- Params: "Mamma" (Perf Per3 Sg Masc) as string (eg KITEB or ĦAREĠ)
    classifyDerivedVerb : Str -> Root -> Pattern -> VDerivedForm = \mamma,root,patt ->
      case mamma of {

        -- Form I
        --- form III verbs with long A's will get incorrectly classified as I, e.g. ĦÂRES : impossible to detect!
        c1@#Consonant + v1@#Vowel + c2@#Consonant + v2@#Vowel + c3@#Consonant => FormI ; -- FETAĦ

        -- Form II
        -- c2 and c3 are equal
        c1@#Consonant + v1@#Vowel + c2@#Consonant + c3@#Consonant + v2@#Vowel + c4@#Consonant => -- FETTAĦ
          if_then_else VDerivedForm (pbool2bool (eqStr c2 c3)) FormII FormUnknown ;

        -- Form III
        -- v1 is long --- anything with v1==a would have already been caught above
        c1@#Consonant + v1@("a"|"ie") + c2@#Consonant + v2@#Vowel + c3@#Consonant =>
          case <v1, patt.V1> of {
--            <"a","a"> => FormI ; -- no vowel change; ĦAREĠ
--            <"a",_> => FormIII ; -- ĦARES > ĦÂRES --- impossible to detect!
            <"ie","ie"> => FormI ; -- no vowel change; MIET
            _ => FormIII -- QAGĦAD > QIEGĦED
            } ;

        -- Form IV
        "wera" => FormIV ;
        "għama" => FormIV ;
        "għana" => FormIV ;

        -- Form V
        -- c0 is T, OR c0 and c1 are equal
        -- c2 and c3 are equal
        "t" + c1@#Consonant + v1@#Vowel + c2@#Consonant + c3@#Consonant + v2@#Vowel + c4@#Consonant => -- TWAQQAF
          if_then_else VDerivedForm (pbool2bool (eqStr c2 c3)) FormV FormUnknown ;
        c0@#DoublingConsT + c1@#DoublingConsT + v1@#Vowel + c2@#Consonant + c3@#Consonant + v2@#Vowel + c4@#Consonant => -- SARRAF
          if_then_else
          VDerivedForm
          (andB (pbool2bool (eqStr c0 c1)) (pbool2bool (eqStr c2 c3)))
          FormV FormUnknown ;

        -- Form VI
        -- c0 is T, OR c0 and c1 are equal
        -- v1 is long
        "t" + c1@#Consonant + v1@("a"|"ie") + c2@#Consonant + v2@#Vowel + c3@#Consonant => FormVI ; -- TQIEGĦED
        c0@#DoublingConsT + c1@#DoublingConsT + v1@("a"|"ie") + c2@#Consonant + v2@#Vowel + c3@#Consonant => -- ĠĠIELED
          if_then_else VDerivedForm (pbool2bool (eqStr c0 c1)) FormVI FormUnknown ;

        -- Form VII
        -- c0 is N, OR c0 is NT, OR c0 is N-T
        "n" + c1@#Consonant + v1@#Vowel + c2@#Consonant + v2@#Vowel + c3@#Consonant => FormVII ; -- NĦASEL
        "nt" + c1@#Consonant + _ => FormVII ; -- NTQAL
        "nt" + c1@#Vowel + _ => case root.C1 of {
          "n" => FormVIII ; -- NTESA (N-S-J)
          _ => FormVII -- NTIŻEN (W-Ż-N)
          } ;
        "nst" + _ => FormVII ; -- NSTAB
        "nxt" + _ => FormVII ; -- NXTAMM

        -- Form VIII
        -- c2 is T
        c1@#Consonant + "t" + v1@#Vowel + c3@#Consonant + _ =>
          case <c1, root.C1> of {
            <"s", "s"> => FormVIII ; -- STABAT (S-B-T)
            <"s", _> => FormX ; -- STAĦBA (Ħ-B-A)
            _ => FormVIII -- MTEDD, XTEĦET
          } ;

        -- Form IX
        c1@#Consonant + c2@#Consonant + v1@("a"|"ie") + c3@#Consonant => FormIX ; -- SFAR, BLIEH

        -- Form X
        "st" + v1@#Vowel + c2@#Consonant + c2@#Consonant + _ => FormX ; -- STAGĦĠEB, STAQSA

        -- boqq
        _ => FormUnknown
      } ;
-}
    -- Takes a verb as a string and returns the VType and root/pattern.
    -- Used in smart paradigm below and elsewhere.
    -- Params: "Mamma" (Perf Per3 Sg Masc) as string (eg KITEB or ĦAREĠ)
    classifyVerb : Str -> VerbInfo = \mamma ->
      case mamma of {

        -- Defective, BELA'
        c1@#Consonant + v1@#Vowel + c2@#Consonant + v2@#Vowel + c3@( "għ" | "'" ) =>
          mkVerbInfo (Weak Defective) FormI (mkRoot c1 c2 "għ") (mkPattern v1 v2) ;

        -- Lacking, MEXA
        c1@#Consonant + v1@#Vowel + c2@#Consonant + v2@#Vowel =>
          mkVerbInfo (Weak Lacking) FormI (mkRoot c1 c2 "j") (mkPattern v1 v2) ;

        -- Hollow, SAB
        -- --- determining of middle radical is not right, e.g. SAB = S-J-B
        c1@#Consonant + v1@"a"  + c3@#Consonant =>
          mkVerbInfo (Weak Hollow) FormI (mkRoot c1 "w" c3) (mkPattern v1) ;
        c1@#Consonant + v1@"ie" + c3@#Consonant =>
          mkVerbInfo (Weak Hollow) FormI (mkRoot c1 "j" c3) (mkPattern v1) ;

        -- Weak Assimilative, WAQAF
        c1@#WeakCons + v1@#Vowel + c2@#Consonant + v2@#Vowel  + c3@#Consonant =>
          mkVerbInfo (Weak Assimilative) FormI (mkRoot c1 c2 c3) (mkPattern v1 v2) ;

        -- Strong Geminated, ĦABB --- no checking that c2 and c3 are actually equal
        c1@#Consonant + v1@#Vowel + c2@#Consonant + c3@#Consonant =>
          mkVerbInfo (Strong Geminated) FormI (mkRoot c1 c2 c3) (mkPattern v1) ;

        -- Strong LiquidMedial, ŻELAQ
        c1@#Consonant + v1@#Vowel + c2@(#LiquidCons | "għ") + v2@#Vowel + c3@#Consonant =>
          mkVerbInfo (Strong LiquidMedial) FormI (mkRoot c1 c2 c3) (mkPattern v1 v2) ;

        -- Strong Regular, QATEL
        c1@#Consonant + v1@#Vowel + c2@#Consonant + v2@#Vowel + c3@#Consonant =>
          mkVerbInfo (Strong Regular) FormI (mkRoot c1 c2 c3) (mkPattern v1 v2) ;

        -- Strong Quad, QAĊĊAT
        c1@#Consonant + v1@#Vowel + c2@#Consonant + c3@#Consonant + v2@#Vowel + c4@#Consonant =>
          mkVerbInfo (Quad QStrong) FormI (mkRoot c1 c2 c3 c4) (mkPattern v1 v2) ;

        -- Weak-Final Quad, PINĠA
        c1@#Consonant + v1@#Vowel + c2@#Consonant + c3@#Consonant + v2@#Vowel =>
          mkVerbInfo (Quad QWeak) FormI (mkRoot c1 c2 c3 "j") (mkPattern v1 v2) ;

        -- Assume it is a loan verb
        _ => mkVerbInfo Loan FormUnknown
      } ;

    -- Return the class for a given root
    classifyRoot : Root -> VClass = \r ->
      case <r.C1,r.C2,r.C3,r.C4> of {
        <#WeakCons, #Consonant, #Consonant, ""> => Weak Assimilative ;
        <#Consonant, #WeakCons, #Consonant, ""> => Weak Hollow ;
        <#Consonant, #Consonant, #WeakCons, ""> => Weak Lacking ;
        <#Consonant, #Consonant, "għ", ""> => Weak Defective ;
        <#Consonant, c2@#Consonant, c3@#Consonant, ""> =>
          if_then_else VClass (pbool2bool (eqStr c2 c3))
          (Strong Geminated)
          (case c2 of {
            #LiquidCons => Strong LiquidMedial ;
            _ => Strong Regular
          }) ;
        <#Consonant, #Consonant, #Consonant, #WeakCons> => Quad QWeak ;
        <#Consonant, #Consonant, #Consonant, #Consonant> => Quad QStrong ;
        _ => Predef.error("Cannot classify root: "++r.C1++"-"++r.C2++"-"++r.C3++"-"++r.C4) --- this should never happen
      } ;

    -- Just get the non-suffixed forms of a verb, for quick testing
    plainVerbTable : V -> (VForm => Str) = \v ->
      \\tense => v.s ! tense ! VSuffixNone ! Pos ;

    -- Smart paradigm for building a verb
    mkV : V = overload {

      -- Tries to do everything just from the mamma of the verb
      -- Params: mamma
      mkV : Str -> V = \mamma ->
        let
          info = classifyVerb mamma ;
        in
        case info.class of {
          Strong Regular      => strongV info.root info.patt ;
          Strong LiquidMedial => liquidMedialV info.root info.patt ;
          Strong Geminated    => geminatedV info.root info.patt ;
          Weak Assimilative   => assimilativeV info.root info.patt ;
          Weak Hollow         => hollowV info.root info.patt ;
          Weak Lacking        => lackingV info.root info.patt ;
          Weak Defective      => defectiveV info.root info.patt ;
          Quad QStrong        => quadV info.root info.patt ;
          Quad QWeak          => quadWeakV info.root info.patt ;
          Loan                => loanV mamma
        } ;

      -- Takes an explicit root, when it is not obvious from the mamma
      -- Params: mamma, root
      mkV : Str -> Root -> V = \mamma,root ->
        let
          info = classifyVerb mamma ;
        in
        case info.class of {
          Strong Regular      => strongV root info.patt ;
          Strong LiquidMedial => liquidMedialV root info.patt ;
          Strong Geminated    => geminatedV root info.patt ;
          Weak Assimilative   => assimilativeV root info.patt ;
          Weak Hollow         => hollowV root info.patt ;
          Weak Lacking        => lackingV root info.patt ;
          Weak Defective      => defectiveV root info.patt ;
          Quad QStrong        => quadV root info.patt ;
          Quad QWeak          => quadWeakV root info.patt ;
          Loan                => loanV mamma
        } ;

      -- Takes takes an Imperative of the word for when it behaves less predictably
      -- Params: mamma, imperative P2Sg
      mkV : Str -> Str -> V = \mamma,imp_sg ->
        let
          info = classifyVerb mamma ;
        in
        case info.class of {
          Strong Regular      => strongV info.root info.patt imp_sg ;
          Strong LiquidMedial => liquidMedialV info.root info.patt imp_sg ;
          Strong Geminated    => geminatedV info.root info.patt imp_sg ;
          Weak Assimilative   => assimilativeV info.root info.patt imp_sg ;
          Weak Hollow         => hollowV info.root info.patt imp_sg ;
          Weak Lacking        => lackingV info.root info.patt imp_sg ;
          Weak Defective      => defectiveV info.root info.patt imp_sg ;
          Quad QStrong        => quadV info.root info.patt imp_sg ;
          Quad QWeak          => quadWeakV info.root info.patt imp_sg ;
          Loan                => loanV mamma
        } ;

      -- Params: mamma, root, imperative P2Sg
      -- mkV : Str -> Root -> Str -> V = \mamma,root,imp_sg ->
      --   let
      --     info = classifyVerb mamma ;
      --   in
      --   case info.class of {
      --     Strong Regular      => strongV root info.patt imp_sg ;
      --     Strong LiquidMedial => liquidMedialV root info.patt imp_sg ;
      --     Strong Geminated    => geminatedV root info.patt imp_sg ;
      --     Weak Assimilative   => assimilativeV root info.patt imp_sg ;
      --     Weak Hollow         => hollowV root info.patt imp_sg ;
      --     Weak Lacking        => lackingV root info.patt imp_sg ;
      --     Weak Defective      => defectiveV root info.patt imp_sg ;
      --     Quad QStrong        => quadV root info.patt imp_sg ;
      --     Quad QWeak          => quadWeakV root info.patt imp_sg ;
      --     Loan                => loanV mamma
      --   } ;

      -- All forms! :S
      -- mkV (Strong Regular) (FormI) (mkRoot "k-t-b") (mkPattern "i" "e") "ktibt" "ktibt" "kiteb" "kitbet" "ktibna" "ktibtu" "kitbu" "nikteb" "tikteb" "jikteb" "tikteb" "niktbu" "tiktbu" "jiktbu" "ikteb" "iktbu"
      mkV : VClass -> VDerivedForm -> Root -> Pattern -> (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> V =
        \class, form, root, patt,
        perfP1Sg, perfP2Sg, perfP3SgMasc, perfP3SgFem, perfP1Pl, perfP2Pl, perfP3Pl,
        impfP1Sg, impfP2Sg, impfP3SgMasc, impfP3SgFem, impfP1Pl, impfP2Pl, impfP3Pl,
        impSg, impPl ->
        let
          tbl : (VForm => Str) = table {
            VPerf (AgP1 Sg) => perfP1Sg ;
            VPerf (AgP2 Sg) => perfP2Sg ;
            VPerf (AgP3Sg Masc) => perfP3SgMasc ;
            VPerf (AgP3Sg Fem) => perfP3SgFem ;
            VPerf (AgP1 Pl) => perfP1Pl ;
            VPerf (AgP2 Pl) => perfP2Pl ;
            VPerf (AgP3Pl) => perfP3Pl ;
            VImpf (AgP1 Sg) => impfP1Sg ;
            VImpf (AgP2 Sg) => impfP2Sg ;
            VImpf (AgP3Sg Masc) => impfP3SgMasc ;
            VImpf (AgP3Sg Fem) => impfP3SgFem ;
            VImpf (AgP1 Pl) => impfP1Pl ;
            VImpf (AgP2 Pl) => impfP2Pl ;
            VImpf (AgP3Pl) => impfP3Pl ;
            VImp (Pl) => impSg ;
            VImp (Sg) => impPl
            } ;
          info : VerbInfo = mkVerbInfo class form root patt impSg ;
        in lin V  {
          s = verbPolarityTable info (verbPronSuffixTable info tbl) ;
          i = info ;
        } ;

      } ; --end of mkV overload

    -- Some shortcut function names (haven't decided on naming yet)
    mkV_II : Str -> V = \s -> derivedV_II s ;
    mkV_III : Str -> V = \s -> derivedV_III s ;
    mkV_V : Str -> V = \s -> derivedV_V s ;
    mkV_VI : Str -> V = \s -> derivedV_VI s ;
    mkV_VII : Str -> Str -> V = \s,t -> derivedV_VII s t ;
    mkV_VIII : Str -> V = \s -> derivedV_VIII s ;
    mkV_IX : Str -> V = \s -> derivedV_IX s ;
    mkV_X : Str -> Str -> V = \s,t -> derivedV_X s t ;
    derivedV_I : Str -> V = mkV ;

    -- Make a Form II verb. Accepts both Tri & Quad roots, then delegates.
    -- e.g.: derivedV_II "waqqaf"
    derivedV_II : V = overload {
      derivedV_II : Str -> V = \mammaII ->
        case mammaII of {
            -- Quad Form II
--            "t" + #Consonant + _ => derivedV_QuadII mammaII root4 ; -- TFIXKEL
--            #DoublingConsT + #DoublingConsT + _ => derivedV_QuadII mammaII root4 ; -- DDARDAR
            #Consonant + #Consonant + _ => derivedV_QuadII mammaII root4 where {
              mammaI4 : Str = dropPfx 1 mammaII ;          
              root4 : Root = (classifyVerb mammaI4).root ;
              } ; -- DDARDAR
            
            -- Tri Form II
            _ => derivedV_TriII mammaII root3 where {
              mammaI3 : Str = delCharAt 3 mammaII ; --- this works because the only verb with a duplicated GĦ is ŻAGĦGĦAR (make smaller)
              root3 : Root = (classifyVerb mammaI3).root ;
              }
        } ;
      derivedV_II : Str -> Root -> V = \mammaII, root ->
        case root.C4 of {
          "" => derivedV_TriII mammaII root ;
          _  => derivedV_QuadII mammaII root
        } ;
      derivedV_II : Str -> Str -> Root -> V = \mammaII, imp, root ->
        case root.C4 of {
          "" => derivedV_TriII mammaII root ;
          _  => derivedV_QuadII mammaII imp root
        } ;
      } ;

    -- Make a Tri-Consonantal Form II verb
    derivedV_TriII : Str -> Root -> V = \mammaII, root ->
      let
        class : VClass = classifyRoot root ;
        patt : Pattern = extractPattern mammaII ;
        imp : Str = case mammaII of {
          nehh + "a" => nehh + "i" ; --- maybe too generic?
          _ => mammaII --- assumption: mamma II is also imperative
          } ;
        newinfo : VerbInfo = mkVerbInfo class FormII root patt imp ;
      in lin V {
        s = conjFormII newinfo ;
        i = newinfo ;
      } ;

    -- Make a Quadri-Consonantal Form II verb
    derivedV_QuadII : V = overload {
      derivedV_QuadII : Str -> Root -> V = \mammaII, root ->
        let
          class : VClass = classifyRoot root ;
          patt : Pattern = extractPattern mammaII ;
          imp : Str = mammaII ; --- assumption: mamma II is also imperative
          newinfo : VerbInfo = mkVerbInfo class FormII root patt imp ;
        in lin V {
          s = conjFormII_quad newinfo ;
          i = newinfo ;
        } ;
      derivedV_QuadII : Str -> Str -> Root -> V = \mammaII, imp, root ->
        let
          class : VClass = classifyRoot root ;
          patt : Pattern = extractPattern mammaII ;
          newinfo : VerbInfo = mkVerbInfo class FormII root patt imp ;
        in lin V {
          s = conjFormII_quad newinfo ;
          i = newinfo ;
        } ;
      } ;

    -- Make a Form III verb
    -- e.g.: derivedV_III "qiegħed"
--    derivedV_III : V = overload {
      derivedV_III : Str -> V = \mammaIII ->
        let
          info : VerbInfo = classifyVerb (ie2i mammaIII) ;
          vowels : Pattern = extractPattern mammaIII ;
          vowels2 : Pattern = case <info.root, vowels> of { -- see {GO pg93}
            <{C2="għ"},{V1="ie";V2="e"}> => mkPattern "e" "i" ; -- QIEGĦED > QEGĦIDKOM
            <_,{V1="ie";V2="e"}> => mkPattern "i" "i" ; -- WIEĠEB > WIĠIBKOM
            _ => vowels
            } ;
          newinfo : VerbInfo = mkVerbInfo info.class FormIII info.root vowels vowels2 mammaIII ; --- assumption: mamma III is also imperative
        in lin V {
          s = conjFormIII newinfo ;
          i = newinfo ;
        } ;
--      } ;

    -- No point having a paradigm for Form IV
    -- derivedV_IV

    -- Make a Form V verb
    -- e.g.: derivedV_V "twaqqaf"
--    derivedV_V : V = overload {
      derivedV_V : Str -> V = \mammaV ->
        let
          -- use the Form II conjugation, just prefixing a T
          mammaII : Str = dropPfx 1 mammaV ; -- WAQQAF
          vII : V = derivedV_II mammaII ;
          newinfo : VerbInfo = mkVerbInfo vII.i.class FormV vII.i.root vII.i.patt mammaV ;
        in lin V {
          s = table {
            VPerf agr => \\suffix,pol => pfx_T (vII.s ! VPerf agr ! suffix ! pol) ;
            VImpf (AgP1 Sg) => \\suffix,pol => pfx "ni" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP1 Sg) ! suffix ! pol))) ;
            VImpf (AgP2 Sg) => \\suffix,pol => pfx "ti" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP2 Sg) ! suffix ! pol))) ;
            VImpf (AgP3Sg Masc) => \\suffix,pol => pfx "ji" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP3Sg Masc) ! suffix ! pol))) ;
            VImpf (AgP3Sg Fem)  => \\suffix,pol => pfx "ti" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP3Sg Fem) ! suffix ! pol))) ;
            VImpf (AgP1 Pl) => \\suffix,pol => pfx "ni" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP1 Pl) ! suffix ! pol))) ;
            VImpf (AgP2 Pl) => \\suffix,pol => pfx "ti" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP2 Pl) ! suffix ! pol))) ;
            VImpf (AgP3Pl) => \\suffix,pol => pfx "ji" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP3Pl) ! suffix ! pol))) ;
            VImp num => \\suffix,pol => pfx_T (vII.s ! VImp num ! suffix ! pol)
            } ;
          i = newinfo ;
        } ;
--      } ;

    -- Make a Form VI verb
    -- e.g.: derivedV_VI "tqiegħed"
--    derivedV_VI : V = overload {
      derivedV_VI : Str -> V = \mammaVI ->
        let
          -- use the Form III conjugation, just prefixing a T
          mammaIII : Str = dropPfx 1 mammaVI ; -- QIEGĦED
          vIII : V = derivedV_III mammaIII ;
          newinfo : VerbInfo = updateVerbInfo vIII.i FormVI mammaVI ;
        in lin V {
          s = table {
            VPerf agr => \\suffix,pol => pfx_T (vIII.s ! VPerf agr ! suffix ! pol) ;
            VImpf (AgP1 Sg) => \\suffix,pol => pfx "ni" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP1 Sg) ! suffix ! pol))) ;
            VImpf (AgP2 Sg) => \\suffix,pol => pfx "ti" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP2 Sg) ! suffix ! pol))) ;
            VImpf (AgP3Sg Masc) => \\suffix,pol => pfx "ji" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP3Sg Masc) ! suffix ! pol))) ;
            VImpf (AgP3Sg Fem)  => \\suffix,pol => pfx "ti" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP3Sg Fem) ! suffix ! pol))) ;
            VImpf (AgP1 Pl) => \\suffix,pol => pfx "ni" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP1 Pl) ! suffix ! pol))) ;
            VImpf (AgP2 Pl) => \\suffix,pol => pfx "ti" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP2 Pl) ! suffix ! pol))) ;
            VImpf (AgP3Pl) => \\suffix,pol => pfx "ji" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP3Pl) ! suffix ! pol))) ;
            VImp num => \\suffix,pol => pfx_T (vIII.s ! VImp num ! suffix ! pol)
            } ;
          i = newinfo ;
        } ;
--      } ;

    -- Make a Form VII verb
    -- e.g.: derivedV_VII "xeħet" "nxteħet"
--    derivedV_VII : V = overload {
      derivedV_VII : Str -> Str -> V = \mammaI,mammaVII ->
        let
          info : VerbInfo = classifyVerb mammaI ;
          c1 : Str = case mammaVII of {
            "n" + c@#C + "t" + _ => "n"+c+"t" ; -- NXT-EĦET
            "ntgħ" + _ => "ntgħ" ; -- NTGĦ-AĠEN
            "nt" + c@#C + _ => "nt"+c ; -- NTR-IFES
            "nt" + #Vowel + _ => "nt" ; -- NT-IŻEN
            "n" + c@#C + _ => "n"+c ; -- NĦ-ASEL
            _ => "nt" --- unknown case
            } ;
          newinfo : VerbInfo = mkVerbInfo info.class FormVII info.root info.patt mammaVII ;
        in lin V {
          s = conjFormVII newinfo c1 ;
          i = newinfo ;
        } ;
--      } ;

    -- Make a Form VIII verb
    -- e.g.: derivedV_VIII "xteħet"
--    derivedV_VIII : V = overload {
      derivedV_VIII : Str -> V = \mammaVIII ->
        let
          mammaI : Str = delCharAt 1 mammaVIII ;
          info : VerbInfo = classifyVerb mammaI ;
          c1 : Str = info.root.C1+"t";
          newinfo : VerbInfo = updateVerbInfo info FormVIII mammaVIII ;
        in lin V {
          s = conjFormVII newinfo c1 ; -- note we use conjFormVIII ! 
          i = newinfo ;
        } ;
--      } ;

    -- Make a Form IX verb
    -- e.g.: derivedV_IX "sfar"
--    derivedV_IX : V = overload {
      derivedV_IX : Str -> V = \mammaIX ->
        case mammaIX of {
          c1@#Consonant + c2@#Consonant + v1@("ie"|"a") + c3@#Consonant => 
            let
              root : Root = mkRoot c1 c2 c3 ;
              patt : Pattern = mkPattern v1 ;
              class : VClass = classifyRoot root ;
              newinfo : VerbInfo = mkVerbInfo class FormIX root patt mammaIX ;
            in lin V {
              s = conjFormIX newinfo ;
              i = newinfo ;
            } ;
          _ => Predef.error("I don't know how to make a Form IX verb out of" ++ mammaIX)
        } ;
--      } ;

    -- Make a Form X verb
    derivedV_X : V = overload {
      -- e.g.: derivedV_X "stagħġeb" (mkRoot "għ-ġ-b")
      derivedV_X : Str -> Root -> V = \mammaX,root ->
        let
          class : VClass = classifyRoot root ;
          patt : Pattern = extractPattern mammaX ;
          newinfo : VerbInfo = mkVerbInfo class FormX root patt mammaX ;
        in lin V {
          s = conjFormX newinfo ;
          i = newinfo ;
        } ;
      -- e.g.: derivedV_X "stagħġeb" "għ-ġ-b"
      derivedV_X : Str -> Str -> V = \mammaX,str_root ->
        let
          root : Root = mkRoot str_root ;
          class : VClass = classifyRoot root ;
          patt : Pattern = extractPattern mammaX ;
          newinfo : VerbInfo = mkVerbInfo class FormX root patt mammaX ;
        in lin V {
          s = conjFormX newinfo ;
          i = newinfo ;
        } ;
      } ;

    {- ~~~ Strong Verb ~~~ -}

    -- Regular strong verb ("sħiħ"), eg KITEB
    strongV : V = overload {

      -- Params: root, pattern
      strongV : Root -> Pattern -> V = \root,patt ->
        let imp = conjStrongImp root patt
        in strongVWorst root patt imp ;

      -- Params: root, pattern, imperative P2Sg
      strongV : Root -> Pattern -> Str -> V =\root,patt,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => (takePfx 3 imp_sg) + root.C3 + "u" -- IFTAĦ > IFTĦU
            } ;
        in strongVWorst root patt imp ;

      } ;

    -- Worst case for strong verb
    strongVWorst : Root -> Pattern -> (Number => Str) -> V = \root,patt,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjStrongPerf root patt ) ! agr ;
          VImpf agr => ( conjStrongImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n =>    imp ! n
          } ;
        info : VerbInfo = mkVerbInfo (Strong Regular) (FormI) root patt (imp ! Sg) ;
      in lin V {
        s = verbPolarityTable info (verbPronSuffixTable info tbl) ;
        i = info ;
      } ;


    {- ~~~ Liquid-Medial Verb ~~~ -}

    -- Liquid-medial strong verb, eg ŻELAQ
    liquidMedialV : V = overload {

      -- Params: root, pattern
      liquidMedialV : Root -> Pattern -> V = \root,patt ->
        let imp = conjLiquidMedialImp root patt
        in liquidMedialVWorst root patt imp ;

      -- Params: root, pattern, imperative P2Sg
      liquidMedialV : Root -> Pattern -> Str -> V = \root,patt,imp_sg ->
        let
          vowels = extractPattern imp_sg ;
          imp = table {
            Sg => imp_sg ;
            Pl => case root.C1 of {
              "għ" => vowels.V1 + root.C1 + root.C2 + root.C3 + "u" ; -- AGĦMEL > AGĦMLU
                _ => vowels.V1 + root.C1 + vowels.V2 + root.C2 + root.C3 + "u" -- OĦROĠ > OĦORĠU
              }
            } ;
        in liquidMedialVWorst root patt imp ;

      } ;

    -- Worst case for liquid medial strong verb
    liquidMedialVWorst : Root -> Pattern -> (Number => Str) -> V = \root,patt,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjLiquidMedialPerf root patt ) ! agr ;
          VImpf agr => ( conjLiquidMedialImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n =>    imp ! n
          } ;
        info : VerbInfo = mkVerbInfo (Strong LiquidMedial) (FormI) root patt (imp ! Sg) ;
      in lin V {
        s = verbPolarityTable info (verbPronSuffixTable info tbl) ;
        i = info ;
      } ;

    {- ~~~ Geminated Verb ~~~ -}

    -- Geminated strong verb ("trux"), eg ĦABB
    geminatedV : V = overload {

      -- Params: root, pattern
      geminatedV : Root -> Pattern -> V = \root,patt ->
        let imp = conjGeminatedImp root patt
        in geminatedVWorst root patt imp ;
        
      -- Params: root, pattern, imperative P2Sg
      geminatedV : Root -> Pattern -> Str -> V = \root,patt,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => imp_sg + "u" -- ŻOMM > ŻOMMU
            } ;
        in geminatedVWorst root patt imp ;

      };

    -- Worst case for reduplicated verb
    geminatedVWorst : Root -> Pattern -> (Number => Str) -> V = \root,patt,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjGeminatedPerf root patt ) ! agr ;
          VImpf agr => ( conjGeminatedImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n =>    imp ! n
          } ;
        info : VerbInfo = mkVerbInfo (Strong Geminated) (FormI) root patt (imp ! Sg) ;
      in lin V {
        s = verbPolarityTable info (verbPronSuffixTable info tbl) ;
        i = info ;
      } ;

    {- ~~~ Assimilative Verb ~~~ -}

    -- Assimilative weak verb, eg WASAL
    assimilativeV : V = overload {

      -- Params: root, pattern
      assimilativeV : Root -> Pattern -> V = \root,patt ->
        let imp = conjAssimilativeImp root patt
        in assimilativeVWorst root patt imp ;

      -- Params: root, pattern, imperative P2Sg
      assimilativeV : Root -> Pattern -> Str -> V =\root,patt,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => (dropSfx 2 imp_sg) + root.C3 + "u" -- ASAL > ASLU
            } ;
        in assimilativeVWorst root patt imp ;

      } ;

    -- Worst case for assimilative verb
    assimilativeVWorst : Root -> Pattern -> (Number => Str) -> V = \root,patt,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjAssimilativePerf root patt ) ! agr ;
          VImpf agr => ( conjAssimilativeImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n =>    imp ! n
          } ;
        patt2 : Pattern = case (imp!Sg) of {
          "ie"+_ => mkPattern "i" patt.V2 ; -- (WAQAF) IEQAF > TIQAFLI
          _ => patt -- (WASAL) ASAL > TASALLI
          } ;
        info : VerbInfo = mkVerbInfo (Weak Assimilative) (FormI) root patt patt2 (imp ! Sg) ;
      in lin V {
        s = verbPolarityTable info (verbPronSuffixTable info tbl) ;
        i = info ;
      } ;

    {- ~~~ Hollow Verb ~~~ -}

    -- Hollow weak verb, eg SAR (S-J-R)
    hollowV : V = overload {

      -- Params: root, pattern
      hollowV : Root -> Pattern -> V = \root,patt ->
        let imp = conjHollowImp root patt
        in hollowVWorst root patt imp ;

      -- Params: root, pattern, imperative P2Sg
      hollowV : Root -> Pattern -> Str -> V =\root,patt,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => imp_sg + "u" -- SIR > SIRU
            } ;
        in hollowVWorst root patt imp ;

      } ;

    -- Worst case for hollow verb
    hollowVWorst : Root -> Pattern -> (Number => Str) -> V = \root,patt,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjHollowPerf root patt ) ! agr ;
          VImpf agr => ( conjHollowImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n =>    imp ! n
          } ;
        patt2 : Pattern = case patt.V1 of {
          "ie" => mkPattern "i" patt.V2 ; -- (ŻIED) ŻID > ŻIDLI
          _ => patt -- (MAR) MUR > MURLI
          } ;
        info : VerbInfo = mkVerbInfo (Weak Hollow) (FormI) root patt patt2 (imp ! Sg) ;
      in lin V {
        s = verbPolarityTable info (verbPronSuffixTable info tbl) ;
        i = info ;
      } ;

    {- ~~~ Lacking Verb ~~~ -}

    -- Lacking (nieqes) verb, eg MEXA (M-X-J)
    lackingV : V = overload {

      -- Params: root, pattern
      lackingV : Root -> Pattern -> V = \root,patt ->
        let imp = conjLackingImp root patt
        in lackingVWorst root patt imp ;

      -- Params: root, pattern, imperative P2Sg
      lackingV : Root -> Pattern -> Str -> V =\root,patt,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => case imp_sg of {
              aqr+"a" => aqr+"aw" ; -- AQRA > AQRAW
              imx+"i" => imx+"u" ; -- IMXI > IMXU
              x => (dropSfx 1 x) + "u" --- unknown case
              }
            } ;
        in lackingVWorst root patt imp ;

      } ;

    -- Worst case for lacking verb
    lackingVWorst : Root -> Pattern -> (Number => Str) -> V = \root,patt,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjLackingPerf root patt ) ! agr ;
          VImpf agr => ( conjLackingImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n =>    imp ! n
          } ;
        info : VerbInfo = mkVerbInfo (Weak Lacking) (FormI) root patt (imp ! Sg) ;
      in lin V {
        s = verbPolarityTable info (verbPronSuffixTable info tbl) ;
        i = info ;
      } ;

    {- ~~~ Defective Verb ~~~ -}

    -- Defective verb, eg QALA' (Q-L-GĦ)
    defectiveV : V = overload {

      -- Params: root, pattern
      defectiveV : Root -> Pattern -> V = \root,patt ->
        let imp = conjDefectiveImp root patt
        in defectiveVWorst root patt imp ;

      -- Params: root, pattern, imperative P2Sg
      defectiveV : Root -> Pattern -> Str -> V =\root,patt,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => (takePfx 2 imp_sg) + "i" + root.C2 + "għu" -- ISMA' > ISIMGĦU
            } ;
        in defectiveVWorst root patt imp ;

      } ;

    -- Worst case for defective verb
    defectiveVWorst : Root -> Pattern -> (Number => Str) -> V = \root,patt,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjDefectivePerf root patt ) ! agr ;
          VImpf agr => ( conjDefectiveImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n =>    imp ! n
          } ;
        info : VerbInfo = mkVerbInfo (Weak Defective) (FormI) root patt (imp ! Sg) ;
      in lin V {
        s = verbPolarityTable info (verbPronSuffixTable info tbl) ;
        i = info ;
      } ;

    {- ~~~ Quadriliteral Verb (Strong) ~~~ -}

    -- Make a Quad verb, eg DENDEL (D-L-D-L)
    quadV : V = overload {

      -- Params: root, pattern
      quadV : Root -> Pattern -> V = \root,patt ->
        let imp = conjQuadImp root patt
        in quadVWorst root patt imp ;

      -- Params: root, pattern, imperative P2Sg
      quadV : Root -> Pattern -> Str -> V =\root,patt,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => (takePfx 4 imp_sg) + root.C4 + "u" -- ĦARBAT > ĦARBTU
            } ;
        in quadVWorst root patt imp ;

      } ;

    -- Worst case for quad verb
    quadVWorst : Root -> Pattern -> (Number => Str) -> V = \root,patt,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjQuadPerf root patt ) ! agr ;
          VImpf agr => ( conjQuadImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n =>    imp ! n
          } ;
        info : VerbInfo = mkVerbInfo (Quad QStrong) (FormI) root patt (imp ! Sg) ;
      in lin V {
        s = verbPolarityTable info (verbPronSuffixTable info tbl) ;
        i = info ;
      } ;

    {- ~~~ Quadriliteral Verb (Weak Final) ~~~ -}

    -- Make a weak-final Quad verb, eg SERVA (S-R-V-J)
    quadWeakV : V = overload {

      -- Params: root, pattern
      quadWeakV : Root -> Pattern -> V = \root,patt ->
        let imp = conjQuadWeakImp root patt
        in quadWeakVWorst root patt imp ;

      -- Params: root, pattern, imperative P2Sg
      quadWeakV : Root -> Pattern -> Str -> V =\root,patt,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => case (takeSfx 1 imp_sg) of {
              "a" => imp_sg + "w" ; -- KANTA > KANTAW
              _ => (dropSfx 1 imp_sg) + "u" -- SERVI > SERVU
              }
            } ;
        in quadWeakVWorst root patt imp ;

      } ;

    -- Worst case for quadWeak verb
    quadWeakVWorst : Root -> Pattern -> (Number => Str) -> V = \root,patt,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjQuadWeakPerf root patt (imp ! Sg) ) ! agr ;
          VImpf agr => ( conjQuadWeakImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n =>    imp ! n
          } ;
        info : VerbInfo = mkVerbInfo (Quad QWeak) (FormI) root patt (imp ! Sg) ;
      in lin V {
        s = verbPolarityTable info (verbPronSuffixTable info tbl) ;
        i = info ;
      } ;

    {- ~~~ Non-semitic verbs ~~~ -}

    -- Make a loan verb, eg IPPARKJA
    -- Params: mamma
    loanV : Str -> V = \mamma ->
      let
        imp = conjLoanImp mamma ;
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjLoanPerf mamma ) ! agr ;
          VImpf agr => ( conjLoanImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n =>    imp ! n
          } ;
        info : VerbInfo = mkVerbInfo (Loan) (FormI) (imp ! Sg) ;
      in lin V {
        s = verbPolarityTable info (verbPronSuffixTable info tbl) ;
        i = info ;
      } ;


    {- ===== Adjective Paradigms ===== -}

    -- Overloaded function for building an adjective
    mkA : A = overload {

      -- Same form for gender and number; no comparative form.
      -- Params:
        -- Adjective, eg BLU
      mkA : Str -> A = sameA ;

      -- Infer feminine from masculine; no comparative form.
      -- Params:
        -- Masculine, eg SABIĦ
        -- Plural, eg SBIEĦ
      mkA : Str -> Str -> A = brokenA ;

      -- Infer feminine from masculine; no comparative form.
      -- Params:
        -- Masculine, eg SABIĦ
        -- Feminine, eg SABIĦA
        -- Plural, eg SBIEĦ
      mkA : Str -> Str -> Str -> A = mk3A ;

      -- Take all forms.
      -- Params:
        -- Masculine, eg SABIĦ
        -- Feminine, eg SABIĦA
        -- Plural, eg SBIEĦ
        -- Comparative, eg ISBAĦ
      mkA : Str -> Str -> Str -> Str -> A = mk4A ;

    } ;

    -- Regular adjective with predictable feminine and plural forms
    regA : Str -> A ;
    regA masc =
      let
        fem = determineAdjFem masc ;
        plural = determineAdjPlural fem
      in
      mk3A masc fem plural ;

    -- Adjective with same forms for masculine, feminine and plural.
    sameA : Str -> A ;
    sameA a = mk3A a a a ;

    -- Adjective with predictable feminine but broken plural
    brokenA = overload {

      -- without comparative form
      brokenA : Str -> Str -> A = \masc,plural ->
        let
          fem = determineAdjFem masc
        in
        mk3A masc fem plural ;

      -- with comparative form
      brokenA : Str -> Str -> Str -> A = \masc,plural,compar ->
        let
          fem = determineAdjFem masc
        in
        mk4A masc fem plural compar ;

      } ;

    -- Build an adjective noun using all 3 forms, when it has no comparative form
    mk3A : (_,_,_ : Str) -> A ;
    mk3A = \masc,fem,plural ->
      lin A (mkAdjective masc fem plural []) ** {hasComp = False} ;

    -- Build an adjective noun using all 4 forms (superlative is trivial)
    mk4A : (_,_,_,_ : Str) -> A ;
    mk4A = \masc,fem,plural,compar ->
      lin A (mkAdjective masc fem plural compar) ** {hasComp = True} ;

    -- Determine femininine form of adjective from masculine
    determineAdjFem : Str -> Str ;
    determineAdjFem masc = case masc of {
      _ + "ef" => (dropSfx 2 masc) + "fa" ; -- NIEXEF
      _ + "u" => (init masc) + "a" ; -- BRAVU
      _ + "i" => masc + "ja" ; -- MIMLI
      _ => masc + "a" -- VOJT
      } ;

    -- Determine plural form of adjective from feminine
    determineAdjPlural : Str -> Str ;
    determineAdjPlural fem = case fem of {
      _ + ("f"|"j"|"ġ") + "a" => (init fem) + "in" ; -- NIEXFA, MIMLIJA, MAĦMUĠA
      _ => (init fem) + "i" -- BRAVA
      } ;

}
