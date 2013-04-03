-- ParadigmsMlt.gf: morphological paradigms
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Angelo Zammit 2012
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

    {- Parameters --------------------------------------------------------- -}

    -- Abstraction over gender names
    Gender : Type ;
    masculine : Gender ; --%
    feminine : Gender ; --%

    Gender = ResMlt.Gender ;
    masculine = Masc ;
    feminine = Fem ;

    singular : Number = Sg ;
    plural : Number = Pl ;

    form1 = FormI ;
    form2 = FormII ;
    form3 = FormIII ;
    form4 = FormIV ;
    form5 = FormV ;
    form6 = FormVI ;
    form7 = FormVII ;
    form8 = FormVIII ;
    form9 = FormIX ;
    form10 = FormX ;

    strong       = Strong Regular ;
    liquidMedial = Strong LiquidMedial ;
    geminated    = Strong Geminated ;
    assimilative = Weak Assimilative ;
    hollow       = Weak Hollow ;
    lacking      = Weak Lacking ;
    quad         = Quad QStrong ;
    quadWeak     = Quad QWeak ;
    loan         = Loan ;
    irregular    = Irregular ;

    {- Noun --------------------------------------------------------------- -}

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
    mk5N = \sing,coll,dual,det,ind,gen -> lin N (
      mkNoun sing coll dual det ind gen
      ) ;

    -- Proper noun
    mkPN : Str -> Gender -> Number -> ProperNoun = \name,g,n -> {
      s = name ;
      a = mkAgr g n P3 ;
      } ;

    mkN2 = overload {
      mkN2 : N -> Prep -> N2 = prepN2 ;
      mkN2 : N -> Str -> N2 = \n,s -> prepN2 n (mkPrep s);
--      mkN2 : Str -> Str -> N2 = \n,s -> prepN2 (regN n) (mkPrep s);
      mkN2 : N -> N2         = \n -> prepN2 n (mkPrep "ta'") ;
--      mkN2 : Str -> N2       = \s -> prepN2 (regN s) (mkPrep "ta'")
    } ;

    prepN2 : N -> Prep -> N2 ;
    prepN2 = \n,p -> lin N2 (n ** {c2 = p.s}) ;

    -- Mark a noun as taking possessive enclitic pronouns
    possN : N -> N ;
    -- possN = \n -> n ** { takesPron = True } ;
    possN = \n -> lin N {
      s = n.s ;
      g = n.g ;
      hasColl = n.hasColl ;
      hasDual = n.hasDual ;
      takesPron = True ;
      } ;

    {- Preposition -------------------------------------------------------- -}

    mkPrep = overload {
      -- Same in all cases, e.g. FUQ
      mkPrep : Str -> Prep = \fuq -> lin Prep {
        s = \\defn => fuq ;
        takesDet = False
        } ;

      -- Forms:
      --   GĦAL ktieb / triq / ajruplan
      --   GĦALL-ktieb / ajruplan
      --   GĦAT-triq
      mkPrep : Str -> Str -> Str -> Prep = \ghal,ghall,ghat -> lin Prep {
        s = table {
          Indefinite => ghal ;
          Definite   => makePreFull ghall (dropSfx 2 ghat) ghall
          } ;
        takesDet = True
        } ;

      -- All forms:
      --   BI ktieb/triq
      --   B'ajruplan
      --   BIL-ktieb
      --   BIT-triq
      --   BL-ajruplan
      mkPrep : Str -> Str -> Str -> Str -> Str -> Prep = \bi,b',bil,bit,bl -> lin Prep {
        s = table {
          Indefinite => makePreVowel bi b' ;
          Definite   => makePreFull  bil (dropSfx 2 bit) bl
          } ;
        takesDet = True
        } ;
      } ;

    noPrep : Prep ;  -- no preposition
    noPrep = mkPrep [] ;

    {- Verb --------------------------------------------------------------- -}

    -- Re-export ResMlt.mkRoot
    mkRoot : Root = overload {
      mkRoot : Root = ResMlt.mkRoot ;
      mkRoot : Str -> Root = \s0 -> ResMlt.mkRoot s0 ;
      mkRoot : Str -> Str -> Str -> Root = \s0,s1,s2 -> ResMlt.mkRoot s0 s1 s2 ;
      mkRoot : Str -> Str -> Str -> Str -> Root = \s0,s1,s2,s3 -> ResMlt.mkRoot s0 s1 s2 s3 ;
      } ;

    -- Re-export ResMlt.mkPattern
    mkPattern : Pattern = overload {
      mkPattern : Pattern = ResMlt.mkPattern ;
      mkPattern : Str -> Pattern = \s0 -> ResMlt.mkPattern s0 ;
      mkPattern : Str -> Str -> Pattern = \s0,s1 -> ResMlt.mkPattern s0 s1 ;
      } ;

    -- Return the class for a given root
    classifyRoot : Root -> VClass = \r ->
      case <r.C1,r.C2,r.C3,r.C4> of {
        <#WeakCons, #StrongCons, #StrongCons, ""> => Weak Assimilative ;
        <#StrongCons, #WeakCons, #StrongCons, ""> => Weak Hollow ;
        <#StrongCons, #StrongCons, #WeakCons, ""> => Weak Lacking ;
        <#StrongCons, #WeakCons, #WeakCons, ""> => Weak Lacking ;
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

        -- Irregular
        <"'",_,_,_> => Irregular ;
        <_,"'",_,_> => Irregular ;
        <_,_,"'",_> => Irregular ;
        <_,_,_,"'"> => Irregular ;

        <_,_,_,""> => Predef.error("Cannot classify root:"++r.C1+"-"+r.C2+"-"+r.C3) ;
        <_,_,_,_>  => Predef.error("Cannot classify root:"++r.C1+"-"+r.C2+"-"+r.C3+"-"+r.C4)
      } ;

    -- Smart paradigm for building a verb
    mkV : V = overload {

      -- With no root, automatically treat as loan verb
      -- Params: mamma
      mkV : Str -> V = loanV ;

      -- Take an explicit root, implying it is a root & pattern verb
      -- Params: mamma, root
      mkV : Str -> Root -> V = \mamma,root ->
        let
          class : VClass = classifyRoot root ;
          patt : Pattern = extractPattern mamma ;
        in
        case class of {
          Strong Regular      => strongV root patt ;
          Strong LiquidMedial => liquidMedialV root patt ;
          Strong Geminated    => geminatedV root patt ;
          Weak Assimilative   => assimilativeV root patt ;
          Weak Hollow         => hollowV root patt ;
          Weak Lacking        => lackingV root patt ;
          Weak Defective      => defectiveV root patt ;
          Quad QStrong        => quadV root patt ;
          Quad QWeak          => quadWeakV root patt ;
          Irregular           => Predef.error("Cannot use smart paradigm for irregular verb:"++mamma) ;
          Loan                => loanV mamma --- this should probably be an error
        } ;

      -- Takes takes an Imperative of the word for when it behaves less predictably
      -- Params: mamma, imperative P2Sg, root
      mkV : Str -> Str -> Root -> V = \mamma,imp_sg,root ->
        let
          class : VClass = classifyRoot root ;
          patt : Pattern = extractPattern mamma ;
        in
        case class of {
          Strong Regular      => strongV root patt imp_sg ;
          Strong LiquidMedial => liquidMedialV root patt imp_sg ;
          Strong Geminated    => geminatedV root patt imp_sg ;
          Weak Assimilative   => assimilativeV root patt imp_sg ;
          Weak Hollow         => hollowV root patt imp_sg ;
          Weak Lacking        => lackingV root patt imp_sg ;
          Weak Defective      => defectiveV root patt imp_sg ;
          Quad QStrong        => quadV root patt imp_sg ;
          Quad QWeak          => quadWeakV root patt imp_sg ;
          Irregular           => Predef.error("Cannot use smart paradigm for irregular verb:"++mamma) ;
          Loan                => loanV mamma
        } ;

      -- All forms
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
          s = tbl ;
          i = info ;
        } ;

      } ; --end of mkV overload

    -- Some shortcut function names (haven't decided on naming yet)
    mkV_II = overload {
      mkV_II : Str -> Root -> V = \s,r -> derivedV_II s r ;
      mkV_II : Str -> Str -> Root -> V = \s,i,r -> derivedV_II s i r ;
      } ;
    mkV_III : Str -> Root -> V = \s,r -> derivedV_III s r ;
    mkV_V : Str -> Root -> V = \s,r -> derivedV_V s r ;
    mkV_VI : Str -> Root -> V = \s,r -> derivedV_VI s r ;
    mkV_VII : Str -> Str -> Root -> V = \s,t,r -> derivedV_VII s t r ;
    mkV_VIII : Str -> Root -> V = \s,r -> derivedV_VIII s r ;
    mkV_IX : Str -> Root -> V = \s,r -> derivedV_IX s r ;
    mkV_X : Str -> Root -> V = \s,r -> derivedV_X s r ;
    derivedV_I : Str -> Root -> V = mkV ;

    -- Make a Form II verb. Accepts both Tri & Quad roots, then delegates.
    derivedV_II : V = overload {
      -- e.g.: derivedV_II "waqqaf" (mkRoot "w-q-f")
      derivedV_II : Str -> Root -> V = \mammaII, root ->
        case root.C4 of {
          "" => derivedV_TriII mammaII root ;
          _  => derivedV_QuadII mammaII root
        } ;
      -- e.g.: derivedV_II "waqqaf" "waqqaf" (mkRoot "w-q-f")
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
    -- e.g.: derivedV_III "qiegħed" (mkRoot "q-għ-d")
    derivedV_III : Str -> Root -> V = \mammaIII, root ->
      let
        vowels : Pattern = extractPattern mammaIII ;
        vowels2 : Pattern = vowelChangesIE root vowels ;
        class : VClass = classifyRoot root ;
        info : VerbInfo = mkVerbInfo class FormIII root vowels vowels2 mammaIII ; --- assumption: mamma III is also imperative
      in lin V {
        s = conjFormIII info ;
        i = info ;
      } ;

    -- No point having a paradigm for Form IV
    -- derivedV_IV

    -- Make a Form V verb
    -- e.g.: derivedV_V "twaqqaf" (mkRoot "w-q-f")
    derivedV_V : Str -> Root -> V = \mammaV, root ->
      let
        -- use the Form II conjugation, just prefixing a T
        mammaII : Str = dropPfx 1 mammaV ; -- WAQQAF
        vII : V = derivedV_II mammaII root ;
        info : VerbInfo = mkVerbInfo vII.i.class FormV vII.i.root vII.i.patt mammaV ;
      in lin V {
        s = table {
          VPerf agr => pfx_T (vII.s ! VPerf agr) ;
          VImpf (AgP1 Sg) => pfx "ni" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP1 Sg)))) ;
          VImpf (AgP2 Sg) => pfx "ti" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP2 Sg)))) ;
          VImpf (AgP3Sg Masc) => pfx "ji" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP3Sg Masc)))) ;
          VImpf (AgP3Sg Fem)  => pfx "ti" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP3Sg Fem)))) ;
          VImpf (AgP1 Pl) => pfx "ni" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP1 Pl)))) ;
          VImpf (AgP2 Pl) => pfx "ti" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP2 Pl)))) ;
          VImpf (AgP3Pl) => pfx "ji" (pfx_T (dropPfx 1 (vII.s ! VImpf (AgP3Pl)))) ;
          VImp num => pfx_T (vII.s ! VImp num)
          } ;
        i = info ;
      } ;

    -- Make a Form VI verb
    -- e.g.: derivedV_VI "tqiegħed" (mkRoot "q-għ-d")
    derivedV_VI : Str -> Root -> V = \mammaVI, root ->
      let
        -- use the Form III conjugation, just prefixing a T
        mammaIII : Str = dropPfx 1 mammaVI ; -- QIEGĦED
        vIII : V = derivedV_III mammaIII root ;
        info : VerbInfo = updateVerbInfo vIII.i FormVI mammaVI ;
      in lin V {
        s = table {
          VPerf agr => pfx_T (vIII.s ! VPerf agr) ;
          VImpf (AgP1 Sg) => pfx "ni" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP1 Sg)))) ;
          VImpf (AgP2 Sg) => pfx "ti" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP2 Sg)))) ;
          VImpf (AgP3Sg Masc) => pfx "ji" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP3Sg Masc)))) ;
          VImpf (AgP3Sg Fem)  => pfx "ti" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP3Sg Fem)))) ;
          VImpf (AgP1 Pl) => pfx "ni" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP1 Pl)))) ;
          VImpf (AgP2 Pl) => pfx "ti" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP2 Pl)))) ;
          VImpf (AgP3Pl) => pfx "ji" (pfx_T (dropPfx 1 (vIII.s ! VImpf (AgP3Pl)))) ;
          VImp num => pfx_T (vIII.s ! VImp num)
          } ;
        i = info ;
      } ;

    -- Make a Form VII verb
    -- e.g.: derivedV_VII "xeħet" "nxteħet" (mkRoot "x-ħ-t")
    derivedV_VII : Str -> Str -> Root -> V = \mammaI, mammaVII, root ->
      let
        class : VClass = classifyRoot root ;
        vowels : Pattern = extractPattern mammaI ;
        c1 : Str = case mammaVII of {
          "n" + c@#Cns + "t" + _ => "n"+c+"t" ; -- NXT-EĦET
          "ntgħ" + _ => "ntgħ" ; -- NTGĦ-AĠEN
          "nt" + c@#Cns + _ => "nt"+c ; -- NTR-IFES
          "nt" + #Vowel + _ => "nt" ; -- NT-IŻEN
          "n" + c@#Cns + _ => "n"+c ; -- NĦ-ASEL
          _ => "nt" --- unknown case
          } ;
        info : VerbInfo = mkVerbInfo class FormVII root vowels mammaVII ;
      in lin V {
        s = conjFormVII info c1 ;
        i = info ;
      } ;

    -- Make a Form VIII verb
    -- e.g.: derivedV_VIII "xteħet" (mkRoot "x-ħ-t")
    derivedV_VIII : Str -> Root -> V = \mammaVIII, root ->
      let
        mammaI : Str = delCharAt 1 mammaVIII ;
        class : VClass = classifyRoot root ;
        vowels : Pattern = extractPattern mammaI ;
        info : VerbInfo = mkVerbInfo class FormVIII root vowels mammaVIII ;
        c1 : Str = root.C1+"t";
      in lin V {
        s = conjFormVII info c1 ; -- note we use conjFormVII !
        i = info ;
      } ;

    -- Make a Form IX verb
    -- e.g.: derivedV_IX "sfar"
    derivedV_IX : Str -> Root -> V = \mammaIX, root ->
      case mammaIX of {
        -- c1@#Consonant + c2@#Consonant + v1@("ie"|"a") + c3@#Consonant => 
        _  + v1@("ie"|"a"|"â") + _ => 
          let
            patt : Pattern = mkPattern v1 ;
            class : VClass = classifyRoot root ;
            info : VerbInfo = mkVerbInfo class FormIX root patt mammaIX ;
          in lin V {
            s = conjFormIX info ;
            i = info ;
          } ;
        _ => Predef.error("I don't know how to make a Form IX verb out of" ++ mammaIX)
      } ;

    -- Make a Form X verb
    -- e.g.: derivedV_X "stagħġeb" (mkRoot "għ-ġ-b")
    derivedV_X : Str -> Root -> V = \mammaX, root ->
      let
        class : VClass = classifyRoot root ;
        patt : Pattern = extractPattern mammaX ;
        patt2 : Pattern = vowelChangesIE root patt ;
        info : VerbInfo = mkVerbInfo class FormX root patt patt2 mammaX ;
      in lin V {
        s = conjFormX info ;
        i = info ;
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
        s = tbl ;
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
        s = tbl ;
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
        s = tbl ;
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
        s = tbl ;
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
        s = tbl ;
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
        s = tbl ;
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
        s = tbl ;
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
        s = tbl ;
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
        s = tbl ;
        i = info ;
      } ;

    {- ~~~ Irregular verbs ~~~ -}

    -- Make an irregular verb, giving all forms (see last overload of mkV)
    irregularV = mkV Irregular ;

    {- ~~~ Loan verbs ~~~ -}

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
        s = tbl ;
        i = info ;
      } ;

    {- Verb --------------------------------------------------------------- -}

    mkVS : V -> VS ; -- sentence-compl
    mkVS v = lin VS v ;

    prepV2 : V -> Prep -> V2 ;
    prepV2 v p = lin V2 ( v ** { prep = p } ) ;

    dirV2 : V -> V2 ;
    dirV2 v = prepV2 v noPrep ;

    prepPrepV3 : V -> Prep -> Prep -> V3 ;
    prepPrepV3 v p t = lin V3 (v ** { prep1 = p ; prep2 = t }) ;

    dirV3 : V -> Prep -> V3 ;
    dirV3 v p = prepPrepV3 v noPrep p ;

    dirdirV3 : V -> V3 ;
    dirdirV3 v = dirV3 v noPrep ;

    mkV3 : overload {
      mkV3  : V -> V3 ;                   -- ditransitive, e.g. give,_,_
      mkV3  : V -> Prep -> Prep -> V3 ;   -- two prepositions, e.g. speak, with, about
      mkV3  : V -> Prep -> V3 ;           -- give,_,to --%
      -- mkV3  : V -> Str -> V3 ;            -- give,_,to --%
      -- mkV3  : Str -> Str -> V3 ;          -- give,_,to --%
      -- mkV3  : Str -> V3 ;                 -- give,_,_ --%
      };
    mkV3 = overload {
      mkV3 : V -> V3 = dirdirV3 ;
      mkV3 : V -> Prep -> Prep -> V3 = prepPrepV3 ;
      mkV3 : V -> Prep -> V3 = dirV3 ;
      -- mkV3 : V -> Str -> V3 = \v,s -> dirV3 v (mkPrep s);
      -- mkV3 : Str -> Str -> V3 = \v,s -> dirV3 (regV v) (mkPrep s);
      -- mkV3 : Str -> V3 = \v -> dirdirV3 (regV v) ;
      } ;

    mkV2V : V -> Prep -> Prep -> V2V ;  -- e.g. want (noPrep NP) (to VP)
    mkV2V v p t = lin V2V (v ** { prep1 = p ; prep2 = t }) ;

    {- Conjunction -------------------------------------------------------- -}

    mkConj = overload {
      mkConj : Str -> Conj = \y -> mk2Conj [] y ;
      mkConj : Str -> Str -> Conj = \x,y -> mk2Conj x y ;
      } ;

    mk2Conj : Str -> Str -> Conj = \x,y ->
      lin Conj (sd2 x y) ;

    {- Adjective ---------------------------------------------------------- -}

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

    prepA2 : A -> Prep -> A2 ;
    prepA2 a p = lin A2 (a ** {c2 = p.s}) ;

    mkA2 : overload {
      mkA2 : A -> Prep -> A2 ;
      mkA2 : A -> Str -> A2 ;
      } ;
    mkA2 = overload {
      mkA2 : A -> Prep -> A2   = prepA2 ;
      mkA2 : A -> Str -> A2    = \a,p -> prepA2 a (mkPrep p) ;
      } ;

    AS, A2S, AV : Type = A ;
    A2V : Type = A2 ;

    mkAS : A -> AS ;
    mkAS a = a ;

    {- Adverb ------------------------------------------------------------- -}

    mkAdv : Str -> Adv ; -- post-verbal adverb, e.g. ILLUM
    mkAdV : Str -> AdV ; -- preverbal adverb, e.g. DEJJEM
    
    mkAdA : Str -> AdA ; -- adverb modifying adjective, e.g. PJUTTOST
    mkAdN : Str -> AdN ; -- adverb modifying numeral, e.g. MADWAR
    
    mkAdv x = lin Adv (ss x) ;
    mkAdV x = lin AdV (ss x) ;
    mkAdA x = lin AdA (ss x) ;
    mkAdN x = lin AdN (ss x) ;

    {- Quantifier, Ord ---------------------------------------------------- -}

    mkQuant : (dak, dik, dawk : Str) -> Bool -> Quant = \dak,dik,dawk,isdemo -> lin Quant {
      s = table {
        GSg Masc => dak ;
        GSg Fem  => dik ;
        GPl      => dawk
        } ;
      clitic = [] ;
      isPron = False ;
      isDemo = isdemo ;
      isDefn = False ;
      } ;
        
    mkOrd : Str -> Ord = \x -> lin Ord { s = \\c => x };


}
