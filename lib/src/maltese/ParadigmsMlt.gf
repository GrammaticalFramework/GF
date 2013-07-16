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

    {- Type declarations only (for synopsis) ------------------------------ -}

    masculine : Gender ;
    feminine  : Gender ;

    singular : Number ;
    plural   : Number ;

    form1  : VDerivedForm ; -- Binyan I: daħal
    form2  : VDerivedForm ; -- Binyan II: daħħal
    form3  : VDerivedForm ; -- Binyan III: wieġeb
    form4  : VDerivedForm ; -- Binyan IV: wera
    form5  : VDerivedForm ; -- Binyan V: ddaħħal
    form6  : VDerivedForm ; -- Binyan VI: twieġeb
    form7  : VDerivedForm ; -- Binyan VII: ndaħal
    form8  : VDerivedForm ; -- Binyan VIII: ftakar
    form9  : VDerivedForm ; -- Binyan IX: sfar
    form10 : VDerivedForm ; -- Binyan X: stieden

    strong       : VClass ; -- Strong tri. verb: kiteb (k-t-b)
    liquidMedial : VClass ; -- Strong liquid-medial tri. verb: ħareġ (ħ-r-ġ)
    geminated    : VClass ; -- Strong geminated tri. verb: ħabb (ħ-b-b)
    assimilative : VClass ; -- Weak-initial tri. verb: wieġeb (w-ġ-b)
    hollow       : VClass ; -- Weak-medial tri. verb: ried (r-j-d)
    lacking      : VClass ; -- Weak-final tri. verb: mexa (m-x-j)
    defective    : VClass ; -- GĦ-final tri. verb: qata' (q-t-għ)
    quad         : VClass ; -- Strong quad. verb: ħarbat (ħ-r-b-t)
    quadWeak     : VClass ; -- Weak-final quad. verb: kanta (k-n-t-j)
    irregular    : VClass ; -- Irregular verb: af ('-'-f)
    loan         : VClass ; -- Loan verb: ipparkja (no root)

    mkN : overload {
      mkN : Str -> N ; -- Noun paradigm 1: Take the singular and infer plural
      mkN : Str -> Gender -> N ; -- Noun paradigm 1: Explicit gender
      mkN : Str -> Str -> N ; -- Noun paradigm 1: Take the singular and explicit plural
      mkN : Str -> Str -> Gender -> N ; -- Noun paradigm 1: Explicit gender
      mkN : Str -> Str -> Str -> N ; -- Noun paradigm 1x: Take singular and both plurals
      mkN : Str -> Str -> Str -> Gender -> N ; -- Noun paradigm 1x: Explicit gender
    } ;

    mkNColl : overload {
      mkNColl : Str -> N ; -- Noun paradigm 2c: Collective form only
      mkNColl : Str -> Str -> N ; -- Noun paradigm 2b: Collective and plural
      mkNColl : Str -> Str -> Str -> N ; -- Noun paradigm 2: Singular, collective and plural
      mkNColl : Str -> Str -> Str -> Str -> N ; -- Noun paradigm 2x: Singular, collective and both plurals
      } ;

    mkNNoPlural : overload {
      mkNNoPlural : Str -> N ; -- Noun paradigm 3: No plural
      mkNNoPlural : Str -> Gender -> N ; -- Noun paradigm 3: Explicit gender
    } ;

    mkNDual : overload {
      mkNDual : Str -> N ; -- Noun paradigm 4: Infer dual, plural and gender from singular
      mkNDual : Str -> Str -> Str -> N ; -- Noun paradigm 4: Singular, dual, plural
      mkNDual : Str -> Str -> Str -> Gender -> N ; -- Noun paradigm 4: Explicit gender
      mkNDual : Str -> Str -> Str -> Str -> N ; -- Noun paradigm 4x: Singular, dual, both plurals
      mkNDual : Str -> Str -> Str -> Str -> Gender -> N ; -- Noun paradigm 4x: Explicit gender
      } ;

    mkPN : Str -> Gender -> Number -> ProperNoun ; -- Proper noun

    mkN2 : overload {
      mkN2 : N -> Prep -> N2 ;
      mkN2 : N -> Str -> N2 ;
      mkN2 : N -> N2 ; -- use "ta'"
    } ;

    mkN3 : Noun -> Prep -> Prep -> N3 ;

    possN : N -> N ; -- Mark a noun as taking possessive enclitic pronouns: missieri, missierek...

    mkRoot : overload {
      mkRoot : Root ; -- Null root
      mkRoot : Str -> Root ; -- From hyphenated string: "k-t-b"
      mkRoot : Str -> Str -> Str -> Root ; -- Tri-consonantal root
      mkRoot : Str -> Str -> Str -> Str -> Root ; -- Quadri-consonantal root
      } ;

    mkVowels : overload {
      mkVowels : Vowels ; -- Null vowel sequence
      mkVowels : Str -> Vowels ; -- Only single vowel
      mkVowels : Str -> Str -> Vowels ; -- Two-vowel sequence
      } ;

    -- Smart paradigm for building a verb
    mkV : overload {
      mkV : Str -> V ; -- With no root, automatically treat as loan verb
      mkV : Str -> Root -> V ; -- Take an explicit root, implying it is a root & pattern verb
      mkV : Str -> Str -> Root -> V ; -- Takes an Imperative of the word for when it behaves less predictably
      mkV : VClass -> VDerivedForm -> Root -> Vowels -> (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> V ; -- All forms: mkV (Strong Regular) (FormI) (mkRoot "k-t-b") (mkVowels "i" "e") "ktibt" "ktibt" "kiteb" "kitbet" "ktibna" "ktibtu" "kitbu" "nikteb" "tikteb" "jikteb" "tikteb" "niktbu" "tiktbu" "jiktbu" "ikteb" "iktbu"
      } ;
    mkV_II : overload {
      mkV_II : Str -> Root -> V ; -- Form II verb: mkV_II "waqqaf" (mkRoot "w-q-f")
      mkV_II : Str -> Str -> Root -> V ; -- Form II verb with explicit imperative form: mkV_II "waqqaf" "waqqaf" (mkRoot "w-q-f")
      } ;
    mkV_III    : Str -> Root -> V ; -- Form III verb: mkV_III "qiegħed" (mkRoot "q-għ-d")
    mkV_V      : Str -> Root -> V ; -- Form V verb: mkV_V "twaqqaf" (mkRoot "w-q-f")
    mkV_VI     : Str -> Root -> V ; -- Form VI verb: mkV_VI "tqiegħed" (mkRoot "q-għ-d")
    mkV_VII    : Str -> Str -> Root -> V ; -- Form VII verb: mkV_VII "xeħet" "nxteħet" (mkRoot "x-ħ-t")
    mkV_VIII   : Str -> Root -> V ; -- Form VIII verb: mkV_VIII "xteħet" (mkRoot "x-ħ-t")
    mkV_IX     : Str -> Root -> V ; -- Form IX verb: mkV_IX "sfar" (mkRoot "s-f-r")
    mkV_X      : Str -> Root -> V ; -- Form X verb: mkV_X "stagħġeb" (mkRoot "għ-ġ-b")

    presPartV : overload {
      presPartV : Str -> V -> V ; -- Add the present participle to a verb: ħiereġ
      presPartV : Str -> Str -> Str -> V -> V ;  -- Add the present participle to a verb: ħiereġ, ħierġa, ħierġin
      } ;
    pastPartV : overload {
      pastPartV : Str -> V -> V ; -- Add the past participle to a verb: miktub
      pastPartV : Str -> Str -> Str -> V -> V ; -- Add the past participle to a verb: miktub, miktuba, miktubin
      } ;

    mkVS : V -> VS ; -- sentence-compl

    mkV3 : overload {
      mkV3  : V -> V3 ;                   -- ditransitive: give,_,_
      mkV3  : V -> Prep -> Prep -> V3 ;   -- two prepositions: speak, with, about
      mkV3  : V -> Prep -> V3 ;           -- one preposition: give,_,to
      };

    mkV2V : V -> Prep -> Prep -> V2V ;  -- want (noPrep NP) (to VP)

    mkConj : overload {
      mkConj : Str -> Conj ; -- Conjunction: wieħed tnejn u tlieta
      mkConj : Str -> Str -> Conj ; -- Conjunction: wieħed , tnejn u tlieta
      } ;

    mkA : overload {
      mkA : Str -> A ; -- Regular adjective with predictable feminine and plural forms: bravu
      mkA : Str -> Str -> A ; -- Infer feminine from masculine; no comparative form: sabiħ, sbieħ
      mkA : Str -> Str -> Str -> A ; -- Explicit feminine form; no comparative form: sabiħ, sabiħa, sbieħ
      mkA : Str -> Str -> Str -> Str -> A ; -- All forms: sabiħ, sabiħa, sbieħ, isbaħ
    } ;

    sameA : Str -> A ; -- Adjective with same forms for masculine, feminine and plural: blu

    mkA2 : overload {
      mkA2 : A -> Prep -> A2 ;
      mkA2 : A -> Str -> A2 ;
      } ;

    mkAS : A -> AS ;

    mkAdv : Str -> Adv ; -- post-verbal adverb: illum
    mkAdV : Str -> AdV ; -- preverbal adverb: dejjem

    mkAdA : Str -> AdA ; -- adverb modifying adjective: pjuttost
    mkAdN : Str -> AdN ; -- adverb modifying numeral: madwar


--.
-- Everything below this is definitions (excluded from synopsis)


    {- Parameters --------------------------------------------------------- -}

    masculine : Gender = Masc ;
    feminine  : Gender = Fem ;

    singular : Number = Sg ;
    plural   : Number = Pl ;

    form1  = FormI ;
    form2  = FormII ;
    form3  = FormIII ;
    form4  = FormIV ;
    form5  = FormV ;
    form6  = FormVI ;
    form7  = FormVII ;
    form8  = FormVIII ;
    form9  = FormIX ;
    form10 = FormX ;

    strong       = Strong Regular ;
    liquidMedial = Strong LiquidMedial ;
    geminated    = Strong Geminated ;
    assimilative = Weak Assimilative ;
    hollow       = Weak Hollow ;
    lacking      = Weak Lacking ;
    defective    = Weak Defective ;
    quad         = Quad QStrong ;
    quadWeak     = Quad QWeak ;
    irregular    = Irregular ;
    loan         = Loan ;

    {- Noun --------------------------------------------------------------- -}

    -- Noun paradigm 1(x): singular and plural(s)
    mkN = overload {

      -- 1: Take the singular and infer plural
      mkN : Str -> N = \sing ->
        let plural = inferNounPlural sing ;
            gender = inferNounGender sing ;
        in  mk5N sing [] [] plural [] gender ;
      mkN : Str -> Gender -> N = \sing,gender ->
        let plural = inferNounPlural sing ;
        in  mk5N sing [] [] plural [] gender ;

      -- 1: Take the singular and plural
      mkN : Str -> Str -> N = \sing,plural ->
        let gender = inferNounGender sing ;
        in  mk5N sing [] [] plural [] gender ;
      mkN : Str -> Str -> Gender -> N = \sing,plural,gender ->
        mk5N sing [] [] plural [] gender ;

      -- 1x: Take both plurals
      mkN : Str -> Str -> Str -> N = \sing,det,ind ->
        let gender = inferNounGender sing ;
        in  mk5N sing [] [] det ind gender ;
      mkN : Str -> Str -> Str -> Gender -> N = \sing,det,ind,gender ->
        mk5N sing [] [] det ind gender ;

    } ;

    -- Noun paradigm 2: with a collective form
    mkNColl = overload {
      -- Note: collective noun is always treated as Masculine

      -- 2c
      mkNColl : Str -> N = \coll ->
        mk5N [] coll [] [] [] Masc ;

      -- 2b
      mkNColl : Str -> Str -> N = \coll,det ->
        mk5N [] coll [] det [] Masc ;
      -- 2bx
      -- mkNColl : Str -> Str -> Str -> N = \coll,det,ind ->
      --   mk5N [] coll [] det ind Masc ;

      -- 2
      mkNColl : Str -> Str -> Str -> N = \sing,coll,det ->
        mk5N sing coll [] det [] Masc ;
      -- 2x
      mkNColl : Str -> Str -> Str -> Str -> N = \sing,coll,det,ind ->
        mk5N sing coll [] det ind Masc ;

      } ;

    -- Noun paradigm 3: only singulative form
    mkNNoPlural : N = overload {
      mkNNoPlural : Str -> N = \sing ->
        let gender = inferNounGender sing ;
        in  mk5N sing [] [] [] [] gender
      ;
      mkNNoPlural : Str -> Gender -> N = \sing,gender ->
        mk5N sing [] [] [] [] gender
      ;
    } ;

    -- Noun paradigm 4: with dual form
    mkNDual = overload {

      -- 4 smart
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

      -- 4
      mkNDual : Str -> Str -> Str -> N = \sing,dual,det ->
        let gender = inferNounGender sing ;
        in  mk5N sing [] dual det [] gender ;
      mkNDual : Str -> Str -> Str -> Gender -> N = \sing,dual,det,gender ->
        mk5N sing [] dual det [] gender ;

      -- 4x
      mkNDual : Str -> Str -> Str -> Str -> N = \sing,dual,det,ind ->
        let gender = inferNounGender sing ;
        in  mk5N sing [] dual det ind gender ;
      mkNDual : Str -> Str -> Str -> Str -> Gender -> N = \sing,dual,det,ind,gender ->
        mk5N sing [] dual det ind gender ;

      } ;

    -- Build a noun using 5 potentially non-present forms and a gender
    -- You can pass empty strings to this oper; they won't be passed along
    mk5N : (_,_,_,_,_ : Str) -> Gender -> N ;
    mk5N = \sing,coll,dual,det,ind,gen -> lin N (
      case <isNil sing,isNil coll,isNil dual,isNil det,isNil ind> of {
        <False,True, True, False,True > => mkNoun sing sing det det det gen False False ; -- 1
        <False,True, True, False,False> => mkNoun sing sing det det ind gen False False ; -- 1x

        <False,False,True, False,True > => mkNoun sing coll det det det gen True False ; -- 2
        <False,False,True, False,False> => mkNoun sing coll det det ind gen True False ; -- 2x
        <True, False,True, False,True > => mkNoun coll coll det det det gen True False ; -- 2b
        <True, False,True, False,False> => mkNoun coll coll det det ind gen True False ; -- 2bx
        <True, False,True, True, True > => mkNoun coll coll coll coll coll gen True False ; -- 2c

        <False,True, True, True, True > => mkNoun sing sing sing sing sing gen False False ; -- 3

        <False,True, False,False,True > => mkNoun sing sing dual det det gen False True ; -- 4
        <False,True, False,False,False> => mkNoun sing sing dual det ind gen False True ; -- 4x

        _ => error "Calling mk5N with some invalid combination"
        }
      ) ;

    -- Proper noun
    mkPN : Str -> Gender -> Number -> ProperNoun = \name,g,n -> {
      s = name ;
      a = mkAgr n P3 g ;
      } ;

    mkN2 = overload {
      mkN2 : N -> Prep -> N2 = prepN2 ;
      mkN2 : N -> Str -> N2 = \n,s -> prepN2 n (mkPrep s);
--      mkN2 : Str -> Str -> N2 = \n,s -> prepN2 (regN n) (mkPrep s);
      mkN2 : N -> N2         = \n -> prepN2 n (mkPrep "ta'") ;
--      mkN2 : Str -> N2       = \s -> prepN2 (regN s) (mkPrep "ta'")
    } ;

    prepN2 : N -> Prep -> N2 ;
    prepN2 = \n,p -> lin N2 (n ** {c2 = hasCompl p}) ;

    mkN3 : Noun -> Prep -> Prep -> N3 ;
    mkN3 = \n,p,q -> lin N3 (n ** {c2 = hasCompl p ; c3 = hasCompl q}) ;

    -- Mark a noun as taking possessive enclitic pronouns
    possN : N -> N = \n -> lin N {
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
        enclitic = prepClitics fuq ;
        takesDet = False ;
        joinsVerb = False ;
        } ;

      -- Same in non-clitic cases, but given all clitic cases e.g. QABEL
      mkPrep : (_,_,_,_,_,_,_,_ : Str) -> Prep = \qabel, qabli, qablek, qablu, qabilha, qabilna, qabilkom, qabilhom -> lin Prep {
        s = \\defn => qabel ;
        enclitic = \\agr => case toVAgr agr of {
          AgP1 Sg     => qabli ;
          AgP2 Sg     => qablek ;
          AgP3Sg Masc => qablu ;
          AgP3Sg Fem  => qabilha ;
          AgP1 Pl     => qabilna ;
          AgP2 Pl     => qabilkom ;
          AgP2Pl      => qabilhom
          } ;
        takesDet = False ;
        joinsVerb = False ;
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
        enclitic = prepClitics ghal ;
        takesDet = True ;
        joinsVerb = False ;
        } ;

      -- All forms, but assumed enclitic forms
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
        enclitic = prepClitics bi ;
        takesDet = True ;
        joinsVerb = False ;
        } ;

      -- All forms:
      --   BI ktieb/triq
      --   B'ajruplan
      --   BIL-ktieb
      --   BIT-triq
      --   BL-ajruplan
      --   BIJA
      --   BIK
      --   BIH
      --   BIHA
      --   BINA
      --   BIKOM
      --   BIHOM
      mkPrep : (_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Bool -> Prep = \bi,b',bil,bit,bl,bija,bik,bih,biha,bina,bikom,bihom,joinsV -> lin Prep {
        s = table {
          Indefinite => makePreVowel bi b' ;
          Definite   => makePreFull  bil (dropSfx 2 bit) bl
          } ;
        enclitic = \\agr => case toVAgr agr of {
          AgP1 Sg     => bija ;
          AgP2 Sg     => bik ;
          AgP3Sg Masc => bih ;
          AgP3Sg Fem  => biha ;
          AgP1 Pl     => bina ;
          AgP2 Pl     => bikom ;
          AgP2Pl      => bihom
          } ;
        takesDet = True ;
        joinsVerb = joinsV ;
        } ;
    } ;

    prepClitics : Str -> (Agr => Str) = \taht -> \\agr =>
      case taht of {

        war+"a" => case toVAgr agr of {
          AgP1 Sg     => war+"ajja" ;
          AgP2 Sg     => war+"ajk" ;
          AgP3Sg Masc => war+"ajh" ;
          AgP3Sg Fem  => war+"ajha" ;
          AgP1 Pl     => war+"ajna" ;
          AgP2 Pl     => war+"ajkom" ;
          AgP2Pl      => war+"ajhom"
          } ;

        f+"i" => case toVAgr agr of {
          AgP1 Sg     => f+"ija" ;
          AgP2 Sg     => f+"ik" ;
          AgP3Sg Masc => f+"ih" ;
          AgP3Sg Fem  => f+"iha" ;
          AgP1 Pl     => f+"ina" ;
          AgP2 Pl     => f+"ikom" ;
          AgP2Pl      => f+"ihom"
          } ;

        t+"a'" => case toVAgr agr of {
          AgP1 Sg     => t+"iegħi" ;
          AgP2 Sg     => t+"iegħek" ;
          AgP3Sg Masc => t+"iegħu" ;
          AgP3Sg Fem  => t+"agħha" ;
          AgP1 Pl     => t+"agħna" ;
          AgP2 Pl     => t+"agħkom" ;
          AgP2Pl      => t+"agħhom"
          } ;

        _ => case toVAgr agr of {
          AgP1 Sg     => taht+"i" ;
          AgP2 Sg     => taht+"ek" ;
          AgP3Sg Masc => taht+"u" ;
          AgP3Sg Fem  => taht + "ha" ;
          AgP1 Pl     => case taht of {bej+"n" => bej+"na"; _ => taht+"na"} ;
          AgP2 Pl     => taht + "kom" ;
          AgP2Pl      => taht + "hom"
          }
      } ;

    {- Verb --------------------------------------------------------------- -}

    -- Re-export ResMlt.mkRoot
    mkRoot : Root = overload {
      mkRoot : Root = ResMlt.mkRoot ;
      mkRoot : Str -> Root = \s0 -> ResMlt.mkRoot s0 ;
      mkRoot : Str -> Str -> Str -> Root = \s0,s1,s2 -> ResMlt.mkRoot s0 s1 s2 ;
      mkRoot : Str -> Str -> Str -> Str -> Root = \s0,s1,s2,s3 -> ResMlt.mkRoot s0 s1 s2 s3 ;
      } ;

    -- Re-export ResMlt.mkVowels
    mkVowels : Vowels = overload {
      mkVowels : Vowels = ResMlt.mkVowels ;
      mkVowels : Str -> Vowels = \s0 -> ResMlt.mkVowels s0 ;
      mkVowels : Str -> Str -> Vowels = \s0,s1 -> ResMlt.mkVowels s0 s1 ;
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
          vseq : Vowels = extractVowels mamma ;
        in
        case class of {
          Strong Regular      => strongV root vseq ;
          Strong LiquidMedial => liquidMedialV root vseq ;
          Strong Geminated    => geminatedV root vseq ;
          Weak Assimilative   => assimilativeV root vseq ;
          Weak Hollow         => hollowV root vseq ;
          Weak Lacking        => lackingV root vseq ;
          Weak Defective      => defectiveV root vseq ;
          Quad QStrong        => quadV root vseq ;
          Quad QWeak          => quadWeakV root vseq ;
          Irregular           => Predef.error("Cannot use smart paradigm for irregular verb:"++mamma) ;
          Loan                => loanV mamma --- this should probably be an error
        } ;

      -- Takes an Imperative of the word for when it behaves less predictably
      -- Params: mamma, imperative P2Sg, root
      mkV : Str -> Str -> Root -> V = \mamma,imp_sg,root ->
        let
          class : VClass = classifyRoot root ;
          vseq : Vowels = extractVowels mamma ;
        in
        case class of {
          Strong Regular      => strongV root vseq imp_sg ;
          Strong LiquidMedial => liquidMedialV root vseq imp_sg ;
          Strong Geminated    => geminatedV root vseq imp_sg ;
          Weak Assimilative   => assimilativeV root vseq imp_sg ;
          Weak Hollow         => hollowV root vseq imp_sg ;
          Weak Lacking        => lackingV root vseq imp_sg ;
          Weak Defective      => defectiveV root vseq imp_sg ;
          Quad QStrong        => quadV root vseq imp_sg ;
          Quad QWeak          => quadWeakV root vseq imp_sg ;
          Irregular           => Predef.error("Cannot use smart paradigm for irregular verb:"++mamma) ;
          Loan                => loanV mamma
        } ;

      -- All forms
      -- mkV (Strong Regular) (FormI) (mkRoot "k-t-b") (mkVowels "i" "e") "ktibt" "ktibt" "kiteb" "kitbet" "ktibna" "ktibtu" "kitbu" "nikteb" "tikteb" "jikteb" "tikteb" "niktbu" "tiktbu" "jiktbu" "ikteb" "iktbu"
      mkV : VClass -> VDerivedForm -> Root -> Vowels -> (_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> V =
        \class, form, root, vseq,
        perfP1Sg, perfP2Sg, perfP3SgMasc, perfP3SgFem, perfP1Pl, perfP2Pl, perfP3Pl,
        impfP1Sg, impfP2Sg, impfP3SgMasc, impfP3SgFem, impfP1Pl, impfP2Pl, impfP3Pl,
        impSg, impPl ->
        let
          tbl : (VForm => Str) = table {
            VPerf (AgP1 Sg)     => perfP1Sg ;
            VPerf (AgP2 Sg)     => perfP2Sg ;
            VPerf (AgP3Sg Masc) => perfP3SgMasc ;
            VPerf (AgP3Sg Fem)  => perfP3SgFem ;
            VPerf (AgP1 Pl)     => perfP1Pl ;
            VPerf (AgP2 Pl)     => perfP2Pl ;
            VPerf (AgP3Pl)      => perfP3Pl ;
            VImpf (AgP1 Sg)     => impfP1Sg ;
            VImpf (AgP2 Sg)     => impfP2Sg ;
            VImpf (AgP3Sg Masc) => impfP3SgMasc ;
            VImpf (AgP3Sg Fem)  => impfP3SgFem ;
            VImpf (AgP1 Pl)     => impfP1Pl ;
            VImpf (AgP2 Pl)     => impfP2Pl ;
            VImpf (AgP3Pl)      => impfP3Pl ;
            VImp (Pl)           => impSg ;
            VImp (Sg)           => impPl ;
            VPresPart _         => NONEXIST ;
            VPastPart _         => NONEXIST
            } ;
          info : VerbInfo = mkVerbInfo class form root vseq impSg ;
        in lin V  {
          s = stemVariantsTbl tbl ;
          i = info ;
          hasPresPart = False ;
          hasPastPart = False ;
        } ;

      } ; --end of mkV overload

    -- Some shortcut function names (haven't decided on naming yet)
    mkV_II = overload {
      mkV_II : Str -> Root -> V = \s,r -> derivedV_II s r ;
      mkV_II : Str -> Str -> Root -> V = \s,i,r -> derivedV_II s i r ;
      } ;
    mkV_III    : Str -> Root -> V = \s,r -> derivedV_III s r ;
    mkV_V      : Str -> Root -> V = \s,r -> derivedV_V s r ;
    mkV_VI     : Str -> Root -> V = \s,r -> derivedV_VI s r ;
    mkV_VII    : Str -> Str -> Root -> V = \s,t,r -> derivedV_VII s t r ;
    mkV_VIII   : Str -> Root -> V = \s,r -> derivedV_VIII s r ;
    mkV_IX     : Str -> Root -> V = \s,r -> derivedV_IX s r ;
    mkV_X      : Str -> Root -> V = \s,r -> derivedV_X s r ;
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
        vseq : Vowels = extractVowels mammaII ;
        imp : Str = case mammaII of {
          nehh + "a" => nehh + "i" ; --- maybe too generic?
          _ => mammaII --- assumption: mamma II is also imperative
          } ;
        newinfo : VerbInfo = mkVerbInfo class FormII root vseq imp ;
      in lin V {
        s = stemVariantsTbl (conjFormII newinfo) ;
        i = newinfo ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    -- Make a Quadri-Consonantal Form II verb
    derivedV_QuadII : V = overload {
      derivedV_QuadII : Str -> Root -> V = \mammaII, root ->
        let
          class : VClass = classifyRoot root ;
          vseq : Vowels = extractVowels mammaII ;
          imp : Str = mammaII ; --- assumption: mamma II is also imperative
          newinfo : VerbInfo = mkVerbInfo class FormII root vseq imp ;
        in lin V {
          s = stemVariantsTbl (conjFormII_quad newinfo) ;
          i = newinfo ;
          hasPresPart = False ;
          hasPastPart = False ;
        } ;
      derivedV_QuadII : Str -> Str -> Root -> V = \mammaII, imp, root ->
        let
          class : VClass = classifyRoot root ;
          vseq : Vowels = extractVowels mammaII ;
          newinfo : VerbInfo = mkVerbInfo class FormII root vseq imp ;
        in lin V {
          s = stemVariantsTbl (conjFormII_quad newinfo) ;
          i = newinfo ;
          hasPresPart = False ;
          hasPastPart = False ;
        } ;
      } ;

    -- Make a Form III verb
    -- e.g.: derivedV_III "qiegħed" (mkRoot "q-għ-d")
    derivedV_III : Str -> Root -> V = \mammaIII, root ->
      let
        vseq : Vowels = extractVowels mammaIII ;
        class : VClass = classifyRoot root ;
        info : VerbInfo = mkVerbInfo class FormIII root vseq mammaIII ; --- assumption: mamma III is also imperative
      in lin V {
        s = stemVariantsTbl (conjFormIII info) ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
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
        info : VerbInfo = mkVerbInfo vII.i.class FormV vII.i.root vII.i.vseq mammaV ;
        get : VForm -> Str = \vf -> (vII.s ! vf).s1 ;
        tbl : VForm => Str = table {
          VPerf agr           => pfx_T (get (VPerf agr)) ;
          VImpf (AgP1 Sg)     => pfx "ni" (pfx_T (dropPfx 1 (get (VImpf (AgP1 Sg))))) ;
          VImpf (AgP2 Sg)     => pfx "ti" (pfx_T (dropPfx 1 (get (VImpf (AgP2 Sg))))) ;
          VImpf (AgP3Sg Masc) => pfx "ji" (pfx_T (dropPfx 1 (get (VImpf (AgP3Sg Masc))))) ;
          VImpf (AgP3Sg Fem)  => pfx "ti" (pfx_T (dropPfx 1 (get (VImpf (AgP3Sg Fem))))) ;
          VImpf (AgP1 Pl)     => pfx "ni" (pfx_T (dropPfx 1 (get (VImpf (AgP1 Pl))))) ;
          VImpf (AgP2 Pl)     => pfx "ti" (pfx_T (dropPfx 1 (get (VImpf (AgP2 Pl))))) ;
          VImpf (AgP3Pl)      => pfx "ji" (pfx_T (dropPfx 1 (get (VImpf (AgP3Pl))))) ;
          VImp num            => pfx_T (get (VImp num)) ;
          VPresPart _         => NONEXIST ;
          VPastPart _         => NONEXIST
          } ;
      in lin V {
        s = stemVariantsTbl (tbl) ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    -- Make a Form VI verb
    -- e.g.: derivedV_VI "tqiegħed" (mkRoot "q-għ-d")
    derivedV_VI : Str -> Root -> V = \mammaVI, root ->
      let
        -- use the Form III conjugation, just prefixing a T
        mammaIII : Str = dropPfx 1 mammaVI ; -- QIEGĦED
        vIII : V = derivedV_III mammaIII root ;
        info : VerbInfo = updateVerbInfo vIII.i FormVI mammaVI ;
        get : VForm -> Str = \vf -> (vIII.s ! vf).s1 ;
        tbl : VForm => Str = table {
          VPerf agr           => pfx_T (get (VPerf agr)) ;
          VImpf (AgP1 Sg)     => pfx "ni" (pfx_T (dropPfx 1 (get (VImpf (AgP1 Sg))))) ;
          VImpf (AgP2 Sg)     => pfx "ti" (pfx_T (dropPfx 1 (get (VImpf (AgP2 Sg))))) ;
          VImpf (AgP3Sg Masc) => pfx "ji" (pfx_T (dropPfx 1 (get (VImpf (AgP3Sg Masc))))) ;
          VImpf (AgP3Sg Fem)  => pfx "ti" (pfx_T (dropPfx 1 (get (VImpf (AgP3Sg Fem))))) ;
          VImpf (AgP1 Pl)     => pfx "ni" (pfx_T (dropPfx 1 (get (VImpf (AgP1 Pl))))) ;
          VImpf (AgP2 Pl)     => pfx "ti" (pfx_T (dropPfx 1 (get (VImpf (AgP2 Pl))))) ;
          VImpf (AgP3Pl)      => pfx "ji" (pfx_T (dropPfx 1 (get (VImpf (AgP3Pl))))) ;
          VImp num            => pfx_T (get (VImp num)) ;
          VPresPart _         => NONEXIST ;
          VPastPart _         => NONEXIST
          } ;
      in lin V {
        s = stemVariantsTbl (tbl) ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    -- Make a Form VII verb
    -- e.g.: derivedV_VII "xeħet" "nxteħet" (mkRoot "x-ħ-t")
    derivedV_VII : Str -> Str -> Root -> V = \mammaI, mammaVII, root ->
      let
        class : VClass = classifyRoot root ;
        vowels : Vowels = extractVowels mammaI ;
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
        s = stemVariantsTbl (conjFormVII info c1) ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    -- Make a Form VIII verb
    -- e.g.: derivedV_VIII "xteħet" (mkRoot "x-ħ-t")
    derivedV_VIII : Str -> Root -> V = \mammaVIII, root ->
      let
        mammaI : Str = delCharAt 1 mammaVIII ;
        class : VClass = classifyRoot root ;
        vowels : Vowels = extractVowels mammaI ;
        info : VerbInfo = mkVerbInfo class FormVIII root vowels mammaVIII ;
        c1 : Str = root.C1+"t";
      in lin V {
        s = stemVariantsTbl (conjFormVII info c1) ; -- note we use conjFormVII !
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    -- Make a Form IX verb
    -- e.g.: derivedV_IX "sfar" (mkRoot "s-f-r")
    derivedV_IX : Str -> Root -> V = \mammaIX, root ->
      case mammaIX of {
        -- c1@#Consonant + c2@#Consonant + v1@("ie"|"a") + c3@#Consonant =>
        _  + v1@("ie"|"a"|"â") + _ =>
          let
            vseq : Vowels = mkVowels v1 ;
            class : VClass = classifyRoot root ;
            info : VerbInfo = mkVerbInfo class FormIX root vseq mammaIX ;
          in lin V {
            s = stemVariantsTbl (conjFormIX info) ;
            i = info ;
            hasPresPart = False ;
            hasPastPart = False ;
          } ;
        _ => Predef.error("I don't know how to make a Form IX verb out of" ++ mammaIX)
      } ;

    -- Make a Form X verb
    -- e.g.: derivedV_X "stagħġeb" (mkRoot "għ-ġ-b")
    derivedV_X : Str -> Root -> V = \mammaX, root ->
      let
        class : VClass = classifyRoot root ;
        vseq : Vowels = extractVowels mammaX ;
        info : VerbInfo = mkVerbInfo class FormX root vseq mammaX ;
      in lin V {
        s = stemVariantsTbl (conjFormX info) ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    {- ~~~ Strong Verb ~~~ -}

    -- Regular strong verb ("sħiħ"), eg KITEB
    strongV : V = overload {

      -- Params: root, vowels
      strongV : Root -> Vowels -> V = \root,vseq ->
        let imp = conjStrongImp root vseq
        in strongVWorst root vseq imp ;

      -- Params: root, vowels, imperative P2Sg
      strongV : Root -> Vowels -> Str -> V =\root,vseq,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => (takePfx 3 imp_sg) + root.C3 + "u" -- IFTAĦ > IFTĦU
            } ;
        in strongVWorst root vseq imp ;

      } ;

    -- Worst case for strong verb
    strongVWorst : Root -> Vowels -> (Number => Str) -> V = \root,vseq,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjStrongPerf root vseq ) ! agr ;
          VImpf agr => ( conjStrongImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n    => imp ! n ;
          VPresPart _ => NONEXIST ;
          VPastPart _ => NONEXIST
          } ;
        info : VerbInfo = mkVerbInfo (Strong Regular) (FormI) root vseq (imp ! Sg) ;
      in lin V {
        s = stemVariantsTbl tbl ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;


    {- ~~~ Liquid-Medial Verb ~~~ -}

    -- Liquid-medial strong verb, eg ŻELAQ
    liquidMedialV : V = overload {

      -- Params: root, vowels
      liquidMedialV : Root -> Vowels -> V = \root,vseq ->
        let imp = conjLiquidMedialImp root vseq
        in liquidMedialVWorst root vseq imp ;

      -- Params: root, vowels, imperative P2Sg
      liquidMedialV : Root -> Vowels -> Str -> V = \root,vseq,imp_sg ->
        let
          vowels = extractVowels imp_sg ;
          imp = table {
            Sg => imp_sg ;
            Pl => case root.C1 of {
              "għ" => vowels.V1 + root.C1 + root.C2 + root.C3 + "u" ; -- AGĦMEL > AGĦMLU
                _ => vowels.V1 + root.C1 + vowels.V2 + root.C2 + root.C3 + "u" -- OĦROĠ > OĦORĠU
              }
            } ;
        in liquidMedialVWorst root vseq imp ;

      } ;

    -- Worst case for liquid medial strong verb
    liquidMedialVWorst : Root -> Vowels -> (Number => Str) -> V = \root,vseq,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjLiquidMedialPerf root vseq ) ! agr ;
          VImpf agr => ( conjLiquidMedialImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n    => imp ! n ;
          VPresPart _ => NONEXIST ;
          VPastPart _ => NONEXIST
          } ;
        info : VerbInfo = mkVerbInfo (Strong LiquidMedial) (FormI) root vseq (imp ! Sg) ;
      in lin V {
        s = stemVariantsTbl tbl ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    {- ~~~ Geminated Verb ~~~ -}

    -- Geminated strong verb ("trux"), eg ĦABB
    geminatedV : V = overload {

      -- Params: root, vowels
      geminatedV : Root -> Vowels -> V = \root,vseq ->
        let imp = conjGeminatedImp root vseq
        in geminatedVWorst root vseq imp ;

      -- Params: root, vowels, imperative P2Sg
      geminatedV : Root -> Vowels -> Str -> V = \root,vseq,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => imp_sg + "u" -- ŻOMM > ŻOMMU
            } ;
        in geminatedVWorst root vseq imp ;

      };

    -- Worst case for reduplicated verb
    geminatedVWorst : Root -> Vowels -> (Number => Str) -> V = \root,vseq,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjGeminatedPerf root vseq ) ! agr ;
          VImpf agr => ( conjGeminatedImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n    => imp ! n ;
          VPresPart _ => NONEXIST ;
          VPastPart _ => NONEXIST
          } ;
        info : VerbInfo = mkVerbInfo (Strong Geminated) (FormI) root vseq (imp ! Sg) ;
      in lin V {
        s = stemVariantsTbl tbl ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    {- ~~~ Assimilative Verb ~~~ -}

    -- Assimilative weak verb, eg WASAL
    assimilativeV : V = overload {

      -- Params: root, vowels
      assimilativeV : Root -> Vowels -> V = \root,vseq ->
        let imp = conjAssimilativeImp root vseq
        in assimilativeVWorst root vseq imp ;

      -- Params: root, vowels, imperative P2Sg
      assimilativeV : Root -> Vowels -> Str -> V =\root,vseq,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => (dropSfx 2 imp_sg) + root.C3 + "u" -- ASAL > ASLU
            } ;
        in assimilativeVWorst root vseq imp ;

      } ;

    -- Worst case for assimilative verb
    assimilativeVWorst : Root -> Vowels -> (Number => Str) -> V = \root,vseq,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjAssimilativePerf root vseq ) ! agr ;
          VImpf agr => ( conjAssimilativeImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n    => imp ! n ;
          VPresPart _ => NONEXIST ;
          VPastPart _ => NONEXIST
          } ;
        info : VerbInfo = mkVerbInfo (Weak Assimilative) (FormI) root vseq (imp ! Sg) ;
      in lin V {
        s = stemVariantsTbl tbl ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    {- ~~~ Hollow Verb ~~~ -}

    -- Hollow weak verb, eg SAR (S-J-R)
    hollowV : V = overload {

      -- Params: root, vowels
      hollowV : Root -> Vowels -> V = \root,vseq ->
        let imp = conjHollowImp root vseq
        in hollowVWorst root vseq imp ;

      -- Params: root, vowels, imperative P2Sg
      hollowV : Root -> Vowels -> Str -> V =\root,vseq,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => imp_sg + "u" -- SIR > SIRU
            } ;
        in hollowVWorst root vseq imp ;

      } ;

    -- Worst case for hollow verb
    hollowVWorst : Root -> Vowels -> (Number => Str) -> V = \root,vseq,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjHollowPerf root vseq ) ! agr ;
          VImpf agr => ( conjHollowImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n    => imp ! n ;
          VPresPart _ => NONEXIST ;
          VPastPart _ => NONEXIST
          } ;
        info : VerbInfo = mkVerbInfo (Weak Hollow) (FormI) root vseq (imp ! Sg) ;
      in lin V {
        s = stemVariantsTbl tbl ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    {- ~~~ Lacking Verb ~~~ -}

    -- Lacking (nieqes) verb, eg MEXA (M-X-J)
    lackingV : V = overload {

      -- Params: root, vowels
      lackingV : Root -> Vowels -> V = \root,vseq ->
        let imp = conjLackingImp root vseq
        in lackingVWorst root vseq imp ;

      -- Params: root, vowels, imperative P2Sg
      lackingV : Root -> Vowels -> Str -> V =\root,vseq,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => case imp_sg of {
              aqr+"a" => aqr+"aw" ; -- AQRA > AQRAW
              imx+"i" => imx+"u" ; -- IMXI > IMXU
              x => (dropSfx 1 x) + "u" --- unknown case
              }
            } ;
        in lackingVWorst root vseq imp ;

      } ;

    -- Worst case for lacking verb
    lackingVWorst : Root -> Vowels -> (Number => Str) -> V = \root,vseq,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjLackingPerf root vseq ) ! agr ;
          VImpf agr => ( conjLackingImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n    => imp ! n ;
          VPresPart _ => NONEXIST ;
          VPastPart _ => NONEXIST
          } ;
        info : VerbInfo = mkVerbInfo (Weak Lacking) (FormI) root vseq (imp ! Sg) ;
      in lin V {
        s = stemVariantsTbl tbl ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    {- ~~~ Defective Verb ~~~ -}

    -- Defective verb, eg QALA' (Q-L-GĦ)
    defectiveV : V = overload {

      -- Params: root, vowels
      defectiveV : Root -> Vowels -> V = \root,vseq ->
        let imp = conjDefectiveImp root vseq
        in defectiveVWorst root vseq imp ;

      -- Params: root, vowels, imperative P2Sg
      defectiveV : Root -> Vowels -> Str -> V =\root,vseq,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => (takePfx 2 imp_sg) + "i" + root.C2 + "għu" -- ISMA' > ISIMGĦU
            } ;
        in defectiveVWorst root vseq imp ;

      } ;

    -- Worst case for defective verb
    defectiveVWorst : Root -> Vowels -> (Number => Str) -> V = \root,vseq,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjDefectivePerf root vseq ) ! agr ;
          VImpf agr => ( conjDefectiveImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n    => imp ! n ;
          VPresPart _ => NONEXIST ;
          VPastPart _ => NONEXIST
          } ;
        info : VerbInfo = mkVerbInfo (Weak Defective) (FormI) root vseq (imp ! Sg) ;
      in lin V {
        s = stemVariantsTbl tbl ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    {- ~~~ Quadriliteral Verb (Strong) ~~~ -}

    -- Make a Quad verb, eg DENDEL (D-L-D-L)
    quadV : V = overload {

      -- Params: root, vowels
      quadV : Root -> Vowels -> V = \root,vseq ->
        let imp = conjQuadImp root vseq
        in quadVWorst root vseq imp ;

      -- Params: root, vowels, imperative P2Sg
      quadV : Root -> Vowels -> Str -> V =\root,vseq,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => (takePfx 4 imp_sg) + root.C4 + "u" -- ĦARBAT > ĦARBTU
            } ;
        in quadVWorst root vseq imp ;

      } ;

    -- Worst case for quad verb
    quadVWorst : Root -> Vowels -> (Number => Str) -> V = \root,vseq,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjQuadPerf root vseq ) ! agr ;
          VImpf agr => ( conjQuadImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n    => imp ! n ;
          VPresPart _ => NONEXIST ;
          VPastPart _ => NONEXIST
          } ;
        info : VerbInfo = mkVerbInfo (Quad QStrong) (FormI) root vseq (imp ! Sg) ;
      in lin V {
        s = stemVariantsTbl tbl ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    {- ~~~ Quadriliteral Verb (Weak Final) ~~~ -}

    -- Make a weak-final Quad verb, eg SERVA (S-R-V-J)
    quadWeakV : V = overload {

      -- Params: root, vowels
      quadWeakV : Root -> Vowels -> V = \root,vseq ->
        let imp = conjQuadWeakImp root vseq
        in quadWeakVWorst root vseq imp ;

      -- Params: root, vowels, imperative P2Sg
      quadWeakV : Root -> Vowels -> Str -> V =\root,vseq,imp_sg ->
        let
          imp = table {
            Sg => imp_sg ;
            Pl => case (takeSfx 1 imp_sg) of {
              "a" => imp_sg + "w" ; -- KANTA > KANTAW
              _ => (dropSfx 1 imp_sg) + "u" -- SERVI > SERVU
              }
            } ;
        in quadWeakVWorst root vseq imp ;

      } ;

    -- Worst case for quadWeak verb
    quadWeakVWorst : Root -> Vowels -> (Number => Str) -> V = \root,vseq,imp ->
      let
        tbl : (VForm => Str) = table {
          VPerf agr => ( conjQuadWeakPerf root vseq (imp ! Sg) ) ! agr ;
          VImpf agr => ( conjQuadWeakImpf (imp ! Sg) (imp ! Pl) ) ! agr ;
          VImp n    => imp ! n ;
          VPresPart _ => NONEXIST ;
          VPastPart _ => NONEXIST
          } ;
        info : VerbInfo = mkVerbInfo (Quad QWeak) (FormI) root vseq (imp ! Sg) ;
      in lin V {
        s = stemVariantsTbl tbl ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
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
          VImp n    => imp ! n ;
          VPresPart _ => NONEXIST ;
          VPastPart _ => NONEXIST
          } ;
        info : VerbInfo = mkVerbInfo (Loan) (FormI) (imp ! Sg) ;
      in lin V {
        s = stemVariantsTbl tbl ;
        i = info ;
        hasPresPart = False ;
        hasPastPart = False ;
      } ;

    {- Verb --------------------------------------------------------------- -}

    -- Add the present participle to a verb
    presPartV = overload {

      presPartV : Str -> V -> V = \hiereg,v ->
        let
          m : Str = hiereg ;
          f : Str = case hiereg of {
            miex+"i"  => miex+"ja" ;
            ge+"j"    => ge+"jja" ;
            sej+"jer" => sej+"ra" ;
            r+"ie"+q@#Cns+e@#Vwl+d@#Cns => r+"ie"+q+d+"a" ;
            _          => hiereg+"a"
            } ;
          p : Str = case hiereg of {
            miex+"i"  => miex+"jin" ;
            ge+"j"    => ge+"jjin" ;
            sej+"jer" => sej+"rin" ;
            r+"ie"+q@#Cns+e@#Vwl+d@#Cns => r+"ie"+q+d+"in" ;
            _          => hiereg+"in"
            } ;
        in lin V {
        s = \\vform => case vform of {
          VPresPart (GSg Masc) => mkVerbStems m ;
          VPresPart (GSg Fem)  => mkVerbStems f ;
          VPresPart (GPl)      => mkVerbStems p ;
          x => v.s ! x
          } ;
        i = v.i ;
        hasPresPart = True ;
        hasPastPart = v.hasPastPart ;
        } ;

      presPartV : Str -> Str -> Str -> V -> V = \hiereg,hierga,hiergin,v -> lin V {
        s = \\vform => case vform of {
          VPresPart (GSg Masc) => mkVerbStems hiereg ;
          VPresPart (GSg Fem)  => mkVerbStems hierga ;
          VPresPart (GPl)      => mkVerbStems hiergin ;
          x => v.s ! x
          } ;
        i = v.i ;
        hasPresPart = True ;
        hasPastPart = v.hasPastPart ;
        } ;

      } ;

    -- Add the past participle to a verb
    pastPartV = overload {

      pastPartV : Str -> V -> V = \miktub,v ->
        let
          m : Str = miktub ;
          f : Str = case miktub of {
            mixtr+"i"  => mixtr+"ija" ;
            mdaww+"ar" => mdaww+"ra" ;
            mwaqq+"a'" => mwaqq+"għa" ;
            _          => miktub+"a"
            } ;
          p : Str = case miktub of {
            mixtr+"i"  => mixtr+"ijin" ;
            mdaww+"ar" => mdaww+"rin" ;
            mwaqq+"a'" => mwaqq+"għin" ;
            ffriz+"at" => ffriz+"ati" ;
            _          => miktub+"in"
            } ;
        in lin V {
        s = \\vform => case vform of {
          VPastPart (GSg Masc) => mkVerbStems m ;
          VPastPart (GSg Fem)  => mkVerbStems f ;
          VPastPart (GPl)      => mkVerbStems p ;
          x => v.s ! x
          } ;
        i = v.i ;
        hasPresPart = v.hasPresPart ;
        hasPastPart = True ;
        } ;

      pastPartV : Str -> Str -> Str -> V -> V = \miktub,miktuba,miktubin,v -> lin V {
        s = \\vform => case vform of {
          VPastPart (GSg Masc) => mkVerbStems miktub ;
          VPastPart (GSg Fem)  => mkVerbStems miktuba ;
          VPastPart (GPl)      => mkVerbStems miktubin ;
          x => v.s ! x
          } ;
        i = v.i ;
        hasPresPart = v.hasPresPart ;
        hasPastPart = True ;
        } ;

      } ;

    hasCompl : Prep -> Compl = \p -> p ** { isPresent = True } ;
    noCompl : Compl = noPrep ** { isPresent = False } where { noPrep : Prep = mkPrep [] };

    mkVS v = lin VS v ;

    prepV2 : V -> Prep -> V2 ;
    prepV2 v p = lin V2 ( v ** { c2 = hasCompl p } ) ;

    dirV2 : V -> V2 ;
    dirV2 v = lin V2 ( v ** { c2 = noCompl } ) ;

    prepPrepV3 : V -> Prep -> Prep -> V3 ;
    prepPrepV3 v p t = lin V3 (v ** { c2 = hasCompl p ; c3 = hasCompl t }) ;

    dirV3 : V -> Prep -> V3 ;
    dirV3      v   t = lin V3 (v ** { c2 = noCompl ; c3 = hasCompl t }) ;

    dirdirV3 : V -> V3 ;
    dirdirV3   v     = lin V3 (v ** { c2 = noCompl ; c3 = noCompl }) ;

    mkV3 = overload {
      mkV3 : V -> V3 = dirdirV3 ;
      mkV3 : V -> Prep -> Prep -> V3 = prepPrepV3 ;
      mkV3 : V -> Prep -> V3 = dirV3 ;
      } ;

    mkV2V v p t = lin V2V (v ** { c2 = hasCompl p ; c3 = hasCompl t }) ;

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

      -- Regular adjective with predictable feminine and plural forms
      -- Params:
        -- Adjective, eg BRAVU
      mkA : Str -> A = \masc ->
        let
          fem = inferAdjFem masc ;
          plural = inferAdjPlural fem
        in
        mk3A masc fem plural ;

      -- Infer feminine from masculine; no comparative form.
      -- Params:
        -- Masculine, eg SABIĦ
        -- Plural, eg SBIEĦ
      mkA : Str -> Str -> A = brokenA ;

      -- Explicit feminine form; no comparative form.
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

    sameA a = mk3A a a a ;

    -- Adjective with predictable feminine but broken plural
    brokenA = overload {

      -- without comparative form
      brokenA : Str -> Str -> A = \masc,plural ->
        let
          fem = inferAdjFem masc
        in
        mk3A masc fem plural ;

      -- with comparative form
      brokenA : Str -> Str -> Str -> A = \masc,plural,compar ->
        let
          fem = inferAdjFem masc
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

    prepA2 : A -> Prep -> A2 ;
    prepA2 a p = lin A2 (a ** {c2 = hasCompl p}) ;

    dirA2 : A -> A2 ;
    -- dirA2 a = prepA2 a noPrep ;
    dirA2 a = lin A2 (a ** {c2 = noCompl}) ;

    mkA2 = overload {
      mkA2 : A -> Prep -> A2 = prepA2 ;
      mkA2 : A -> Str -> A2  = \a,p -> prepA2 a (mkPrep p) ;
      } ;

    AS, A2S, AV : Type = A ;
    A2V : Type = A2 ;

    mkAS a = a ;

    {- Adverb ------------------------------------------------------------- -}

    mkAdv x = lin Adv (ss x) ** {
      joinsVerb = False ;
      a = agrP3 Sg Masc ; -- ignored when joinsVerb = False
      } ;
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
