-- MorphoMlt.gf: scary morphology operations which need their own elbow space
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Angelo Zammit 2012
-- Licensed under LGPL

resource MorphoMlt = ResMlt ** open Prelude in {

  flags
    optimize=noexpand ;
    coding=utf8 ;


  {- Determiners ---------------------------------------------------------- -}

  oper
    mkDeterminer : Number -> Str -> Determiner = \n,s -> {
        s = \\gen => s ;
        n = NumX n ; -- Number -> NumForm
        clitic = [] ;
        hasNum = False ;
        isPron = False ;
        isDefn = False ;
      } ;

  {- Pronoun -------------------------------------------------------------- -}

  oper
    mkPron : (_,_ : Str) -> Number -> Person -> Gender -> Pronoun =
      \hi, _ha, num, pers, gen ->
      let
        tagh : Str = case <pers,num,gen> of {
          <P1,Sg,_>    => "tiegħ" ;
          <P2,Sg,_>    => "tiegħ" ;
          <P3,Sg,Masc> => "tiegħ" ;
          _            => "tagħ"
          } ;
      in {
        s = table {
          Personal   => hi ;         -- hi
          Possessive => tagh + _ha ; -- tagħha
          Suffixed   => _ha          -- qalbha
          } ;
        a = mkAgr num pers gen ;
      } ;

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

  {- Adjective ------------------------------------------------------------ -}

    -- Infer femininine form of adjective from masculine
    inferAdjFem : Str -> Str ;
    inferAdjFem masc = case masc of {
      _ + "ef" => (dropSfx 2 masc) + "fa" ; -- NIEXEF
      _ + "u" => (init masc) + "a" ; -- BRAVU
      _ + "i" => masc + "ja" ; -- MIMLI
      _ => masc + "a" -- VOJT
      } ;

    -- Infer plural form of adjective from feminine
    inferAdjPlural : Str -> Str ;
    inferAdjPlural fem = case fem of {
      _ + ("f"|"j"|"ġ") + "a" => (init fem) + "in" ; -- NIEXFA, MIMLIJA, MAĦMUĠA
      _ => (init fem) + "i" -- BRAVA
      } ;

  {- Verb ----------------------------------------------------------------- -}

  oper

    -- Conugate imperfect tense from imperative by adding initial letters
    -- Ninu, Toninu, Jaħasra, Toninu; Ninu, Toninu, Jaħasra
    conjGenericImpf : Str -> Str -> (VAgr => Str) = \imp_sg,imp_pl ->
      table {
        AgP1 Sg    => pfx_N imp_sg ;  -- Jiena NIŻLOQ
        AgP2 Sg    => pfx_T imp_sg ;  -- Inti TIŻLOQ
        AgP3Sg Masc=> pfx_J imp_sg ;  -- Huwa JIŻLOQ
        AgP3Sg Fem => pfx_T imp_sg ;  -- Hija TIŻLOQ
        AgP1 Pl    => pfx_N imp_pl ;  -- Aħna NIŻOLQU
        AgP2 Pl    => pfx_T imp_pl ;  -- Intom TIŻOLQU
        AgP3Pl     => pfx_J imp_pl    -- Huma JIŻOLQU
      } ;

    -- IE/I vowel changes
    -- so far only used in derived verbs
    vowelChangesIE : Root -> Vowels -> Vowels = \root,vowels ->
      case <root, vowels> of { -- see {GO pg93}
        <{C2="għ"},{V1="ie";V2="e"}> => mkVowels "e" "i" ; -- QIEGĦED > QEGĦIDKOM
        <_,{V1="ie";V2="e"}> => mkVowels "i" "i" ; -- WIEĠEB > WIĠIBKOM
        <_,{V1="ie";V2=""}> => mkVowels "i" ; -- STRIEĦ > STRIĦAJT
        _ => vowels
      } ;

    {- ~~~ Strong Verb ~~~ -}

    -- Conjugate entire verb in PERFECT tense
    -- Params: Root, Vowels
    conjStrongPerf : Root -> Vowels -> (VAgr => Str) = \root,p ->
      let
        ktib = root.C1 + root.C2 + (case p.V2 of {"e" => "i" ; _ => p.V2 }) + root.C3 ;
        kitb = root.C1 + p.V1 + root.C2 + root.C3 ;
      in
        table {
          AgP1 Sg    => ktib + "t" ;  -- Jiena KTIBT
          AgP2 Sg    => ktib + "t" ;  -- Inti KTIBT
          AgP3Sg Masc=> root.C1 + p.V1 + root.C2 + p.V2 + root.C3 ;  -- Huwa KITEB
          AgP3Sg Fem => kitb + (case p.V2 of {"o" => "o" ; _ => "e"}) + "t" ;  -- Hija KITBET
          AgP1 Pl    => ktib + "na" ;  -- Aħna KTIBNA
          AgP2 Pl    => ktib + "tu" ;  -- Intom KTIBTU
          AgP3Pl     => kitb + "u"  -- Huma KITBU
        } ;

    -- Conjugate entire verb in IMPERFECT tense, given the IMPERATIVE
    -- Params: Imperative Singular (eg IKTEB), Imperative Plural (eg IKTBU)
    conjStrongImpf = conjGenericImpf ;

    -- Conjugate entire verb in IMPERATIVE tense, infers vowel sequence
    -- Params: Root, Vowels
    conjStrongImp : Root -> Vowels -> (Number => Str) = \root,vseq ->
      let
        vwls = vowelChangesStrong vseq ;
      in
        table {
          Sg => (vwls!Sg).V1 + root.C1 + root.C2 + (vwls!Sg).V2 + root.C3 ;  -- Inti:  IKTEB
          Pl => (vwls!Pl).V1 + root.C1 + root.C2 + root.C3 + "u"  -- Intom: IKTBU
        } ;

    -- Vowel changes for imperative
    vowelChangesStrong : Vowels -> (Number => Vowels) = \vseq ->
      table {
        Sg => case <vseq.V1,vseq.V2> of {
          <"a","a"> => mkVowels "o" "o" ; -- RABAT > ORBOT (but: ILGĦAB, AĦBAT)
          <"a","e"> => mkVowels "a" "e" ; -- GĦAMEL > AGĦMEL
          <"e","e"> => mkVowels "i" "e" ; -- FEHEM > IFHEM
          <"e","a"> => mkVowels "i" "a" ; -- FETAĦ > IFTAĦ (but: ONFOĦ)
          <"i","e"> => mkVowels "i" "e" ; -- KITEB > IKTEB
          <"o","o"> => mkVowels "o" "o"   -- GĦOĠOB > OGĦĠOB
        };
        Pl => case <vseq.V1,vseq.V2> of {
          <"a","a"> => mkVowels "o" ; -- RABAT > ORBTU
          <"a","e"> => mkVowels "a" ; -- GĦAMEL > AGĦMLU
          <"e","e"> => mkVowels "i" ; -- FEHEM > IFHMU
          <"e","a"> => mkVowels "i" ; -- FETAĦ > IFTĦU
          <"i","e"> => mkVowels "i" ; -- KITEB > IKTBU
          <"o","o"> => mkVowels "o"   -- GĦOĠOB > OGĦĠBU
        }
      } ;

    {- ~~~ Liquid-Medial Verb ~~~ -}

    -- Conjugate entire verb in PERFECT tense
    -- Params: Root, Vowels
    conjLiquidMedialPerf : Root -> Vowels -> (VAgr => Str) = \root,vseq ->
      let
        zlaq : Str = case root.C1 of {
          "għ" => root.C1 + vseq.V1 + root.C2 + (case vseq.V2 of {"e" => "i" ; _ => vseq.V2 }) + root.C3 ; -- GĦAMIL-
          _ => root.C1 + root.C2 + (case vseq.V2 of {"e" => "i" ; _ => vseq.V2 }) + root.C3 -- ŻLAQ-
          } ;
        zelq = root.C1 + vseq.V1 + root.C2 + root.C3 ;
      in
        table {
          AgP1 Sg    => zlaq + "t" ;  -- Jiena ŻLAQT
          AgP2 Sg    => zlaq + "t" ;  -- Inti ŻLAQT
          AgP3Sg Masc=> root.C1 + vseq.V1 + root.C2 + vseq.V2 + root.C3 ;  -- Huwa ŻELAQ
          AgP3Sg Fem => zelq + (case vseq.V2 of {"o" => "o" ; _ => "e"}) + "t" ;  -- Hija ŻELQET
          AgP1 Pl    => zlaq + "na" ;  -- Aħna ŻLAQNA
          AgP2 Pl    => zlaq + "tu" ;  -- Intom ŻLAQTU
          AgP3Pl     => zelq + "u"  -- Huma ŻELQU
        } ;

    -- Conjugate entire verb in IMPERFECT tense, given the IMPERATIVE
    -- Params: Imperative Singular (eg IŻLOQ), Imperative Plural (eg IŻOLQU)
    conjLiquidMedialImpf = conjGenericImpf ;

    -- Conjugate entire verb in IMPERATIVE tense, infers vowel sequence
    -- Params: Root, Vowels
    conjLiquidMedialImp : Root -> Vowels -> (Number => Str) = \root,vseq ->
      let
        vwls = vowelChangesLiquidMedial vseq ;
      in
        table {
          Sg => (vwls!Sg).V1 + root.C1 + root.C2 + (vwls!Sg).V2 + root.C3 ;  -- Inti: IŻLOQ
          Pl => (vwls!Pl).V1 + root.C1 + (vwls!Pl).V2 + root.C2 + root.C3 + "u"  -- Intom: IŻOLQU
        } ;

    -- Vowel changes for imperative
    vowelChangesLiquidMedial : Vowels -> (Number => Vowels) = \vseq ->
      table {
        Sg => case <vseq.V1,vseq.V2> of {
          <"a","a"> => mkVowels "i" "o" ; -- TALAB > ITLOB but ĦARAQ > AĦRAQ
          <"a","e"> => mkVowels "o" "o" ; -- ĦAREĠ > OĦROĠ
          <"e","e"> => mkVowels "e" "e" ; -- ĦELES > EĦLES
          <"e","a"> => mkVowels "i" "o" ; -- ŻELAQ > IŻLOQ
          <"i","e"> => mkVowels "i" "e" ; -- DILEK > IDLEK
          <"o","o"> => mkVowels "i" "o"   -- XOROB > IXROB
        };
        Pl => case <vseq.V1,vseq.V2> of {
          <"a","a"> => mkVowels "i" "o" ; -- TALAB > ITOLBU
          <"a","e"> => mkVowels "o" "o" ; -- ĦAREĠ > OĦORĠU
          <"e","e"> => mkVowels "e" "i" ; -- ĦELES > EĦILSU
          <"e","a"> => mkVowels "i" "o" ; -- ŻELAQ > IŻOLQU
          <"i","e"> => mkVowels "i" "i" ; -- DILEK > IDILKU
          <"o","o"> => mkVowels "i" "o"   -- XOROB > IXORBU
        }
      } ;

    {- ~~~ Geminated Verb ~~~ -}

    -- Conjugate entire verb in PERFECT tense
    -- Params: Root, Vowels
    conjGeminatedPerf : Root -> Vowels -> (VAgr => Str) = \root,vseq ->
      let
        habb = root.C1 + vseq.V1 + root.C2 + root.C3 ;
      in
        table {
          AgP1 Sg    => habb + "ejt" ;  -- Jiena ĦABBEJT
          AgP2 Sg    => habb + "ejt" ;  -- Inti ĦABBEJT
          AgP3Sg Masc=> habb ;  -- Huwa ĦABB
          AgP3Sg Fem => habb + "et" ;  -- Hija ĦABBET
          AgP1 Pl    => habb + "ejna" ;  -- Aħna ĦABBEJNA
          AgP2 Pl    => habb + "ejtu" ;  -- Intom ĦABBEJTU
          AgP3Pl     => habb + "ew"  -- Huma ĦABBU/ĦABBEW
        } ;

    -- Conjugate entire verb in IMPERFECT tense, given the IMPERATIVE
    -- Params: Imperative Singular (eg IKTEB), Imperative Plural (eg IKTBU)
    conjGeminatedImpf = conjGenericImpf ;

    -- Conjugate entire verb in IMPERATIVE tense, infers vowel sequence
    -- Params: Root, Vowels
    conjGeminatedImp : Root -> Vowels -> (Number => Str) = \root,vseq ->
      let
        vwls = vowelChangesGeminated vseq ;
        stem_sg = root.C1 + (vwls!Sg).V1 + root.C2 + root.C3 ;
      in
        table {
          Sg => stem_sg ;  -- Inti: ĦOBB
          Pl => stem_sg + "u"  -- Intom: ĦOBBU
        } ;

    -- Vowel changes for imperative
    vowelChangesGeminated : Vowels -> (Number => Vowels) = \vseq ->
      \\n => case vseq.V1 of {
        "e" => mkVowels "e" ; -- BEXX > BEXX (?)
        _ => mkVowels "o" -- ĦABB > ĦOBB
      } ;


    {- ~~~ Assimilative Verb ~~~ -}

    -- Conjugate entire verb in PERFECT tense
    -- Params: Root, Vowels
    conjAssimilativePerf : Root -> Vowels -> (VAgr => Str) = \root,vseq ->
      let
        wasal = case root.C3 of {
          "għ" => root.C1 + vseq.V1 + root.C2 + vseq.V2 + "j" ;
          _    => root.C1 + vseq.V1 + root.C2 + vseq.V2 + root.C3
          } ;
        wasl  = root.C1 + vseq.V1 + root.C2 + root.C3 ;
      in
        table {
          AgP1 Sg    => wasal + "t" ;  -- Jiena WASALT
          AgP2 Sg    => wasal + "t" ;  -- Inti WASALT
          AgP3Sg Masc=> case root.C3 of {
            "għ" => root.C1 + vseq.V1 + root.C2 + vseq.V2 + "'" ;  -- Huwa WAQA'
            _    => wasal  -- Huwa WASAL
            } ;
          AgP3Sg Fem => wasl + "et" ;  -- Hija WASLET
          AgP1 Pl    => wasal + "na" ;  -- Aħna WASALNA
          AgP2 Pl    => wasal + "tu" ;  -- Intom WASALTU
          AgP3Pl     => wasl + "u"  -- Huma WASLU
        } ;

    -- Conjugate entire verb in IMPERFECT tense, given the IMPERATIVE
    -- Params: Imperative Singular (eg ASAL), Imperative Plural (eg ASLU)
    conjAssimilativeImpf = conjGenericImpf ;

    -- Conjugate entire verb in IMPERATIVE tense, infers vowel sequence
    -- Params: Root, Vowels
    conjAssimilativeImp : Root -> Vowels -> (Number => Str) = \root,vseq ->
      table {
        Sg => vseq.V1 + root.C2 + vseq.V2 + case root.C3 of { "għ" => "'" ; _ => root.C3 } ;  -- Inti: ASAL
        Pl => vseq.V1 + root.C2 + root.C3 + "u"  -- Intom: ASLU
      } ;

    {- ~~~ Hollow Verb ~~~ -}

    -- Conjugate entire verb in PERFECT tense
    -- Params: Root, Vowels
    -- Refer: http://blog.johnjcamilleri.com/2012/07/vowel-patterns-maltese-hollow-verb/
    conjHollowPerf : Root -> Vowels -> (VAgr => Str) = \root,vseq ->
      let
        sar = root.C1 + vseq.V1 + root.C3 ;
        sir = case <vseq.V1,root.C2> of {
          <"a","w"> => root.C1 + "o" + root.C3 ; -- DAM, FAR, SAQ (most common case)
          _ => root.C1 + "i" + root.C3
          }
      in
      table {
        AgP1 Sg    => sir + "t" ;  -- Jiena SIRT
        AgP2 Sg    => sir + "t" ;  -- Inti SIRT
        AgP3Sg Masc=> sar ;  -- Huwa SAR
        AgP3Sg Fem => sar + "et" ;  -- Hija SARET
        AgP1 Pl    => sir + "na" ;  -- Aħna SIRNA
        AgP2 Pl    => sir + "tu" ;  -- Intom SIRTU
        AgP3Pl     => sar + "u"  -- Huma SARU
      } ;

    -- Conjugate entire verb in IMPERFECT tense, given the IMPERATIVE
    -- Params: Imperative Singular (eg DUM), Imperative Plural (eg DUMU)
    conjHollowImpf : Str -> Str -> (VAgr => Str) = \imp_sg,imp_pl ->
      table {
          AgP1 Sg    => pfx_N imp_sg ;  -- Jiena NDUM / MMUR
          AgP2 Sg    => pfx_T imp_sg ;  -- Inti DDUM / TMUR
          AgP3Sg Masc=> pfx_J imp_sg ;  -- Huwa JDUM / JMUR
          AgP3Sg Fem => pfx_T imp_sg ;  -- Hija DDUM / TMUR
          AgP1 Pl    => pfx_N imp_pl ;  -- Aħna NDUMU / MMORRU
          AgP2 Pl    => pfx_T imp_pl ;  -- Intom DDUMU / TMORRU
          AgP3Pl     => pfx_J imp_pl    -- Huma JDUMU / JMORRU
      } ;

    -- Conjugate entire verb in IMPERATIVE tense, infers vowel sequence
    -- Params: Root, Vowels
    -- Refer: http://blog.johnjcamilleri.com/2012/07/vowel-patterns-maltese-hollow-verb/
    conjHollowImp : Root -> Vowels -> (Number => Str) = \root,vseq ->
      let
        sir = case <vseq.V1,root.C2> of {
          <"a","w"> => root.C1 + "u" + root.C3 ; -- DAM, FAR, SAQ (most common case)
          <"a","j"> => root.C1 + "i" + root.C3 ; -- ĠAB, SAB, TAR
          <"ie","j"> => root.C1 + "i" + root.C3 ; -- FIEQ, RIED, ŻIED
          <"ie","w"> => root.C1 + "u" + root.C3 ; -- MIET
          <"e","j"> => root.C1 + "i" + root.C3 ; -- GĦEB
          _ => Predef.error("Unhandled case in hollow verb:"++root.C1+vseq.V1+root.C2+vseq.V2+root.C3)
          }
      in
      table {
        Sg => sir ;  -- Inti: SIR
        Pl => sir + "u"  -- Intom: SIRU
      } ;

    {- ~~~ Lacking Verb ~~~ -}

    -- Conjugate entire verb in PERFECT tense
    -- Params: Root, Vowels
    conjLackingPerf : Root -> Vowels -> (VAgr => Str) = \root,vseq ->
      let
        mxej = root.C1 + root.C2 + vseq.V1 + root.C3
      in
        table {
          --- i tal-leħen needs to be added here!
          AgP1 Sg    => mxej + "t" ;  -- Jiena IMXEJT
          AgP2 Sg    => mxej + "t" ;  -- Inti IMXEJT
          AgP3Sg Masc=> root.C1 + vseq.V1 + root.C2 + vseq.V2 ;  -- Huwa MEXA
          AgP3Sg Fem => case vseq.V1 of {
            "a" => root.C1 + root.C2 + "at" ;  -- Hija QRAT
            _ => root.C1 + root.C2 + "iet"  -- Hija MXIET
            } ;
          AgP1 Pl    => mxej + "na" ;  -- Aħna IMXEJNA
          AgP2 Pl    => mxej + "tu" ;  -- Intom IMXEJTU
          AgP3Pl     => case vseq.V1 of {
            "a" => root.C1 + root.C2 + "aw" ;  -- Huma QRAW
            _ => root.C1 + root.C2 + "ew"  -- Huma IMXEW
            }
        } ;

    -- Conjugate entire verb in IMPERFECT tense, given the IMPERATIVE
    -- Params: Imperative Singular (eg IMXI), Imperative Plural (eg IMXU)
    conjLackingImpf = conjGenericImpf ;

    -- Conjugate entire verb in IMPERATIVE tense, infers vowel sequence
    -- Params: Root, Vowels
    conjLackingImp : Root -> Vowels -> (Number => Str) = \root,vseq ->
      table {
        Sg => "i" + root.C1 + root.C2 + "i" ;  -- Inti: IMXI
        Pl => "i" + root.C1 + root.C2 + "u"  -- Intom: IMXU
      } ;

    {- ~~~ Defective Verb ~~~ -}

    -- Conjugate entire verb in PERFECT tense
    -- Params: Root, Vowels
    conjDefectivePerf : Root -> Vowels -> ( VAgr => Str ) = \root,vseq ->
      let
        qlaj = root.C1 + root.C2 + (case vseq.V2 of {"e" => "i" ; _ => vseq.V2 }) + "j" ;
        qalgh = root.C1 + vseq.V1 + root.C2 + root.C3 ;
      in
        table {
          AgP1 Sg    => qlaj + "t" ;  -- Jiena QLAJT
          AgP2 Sg    => qlaj + "t" ;  -- Inti QLAJT
          AgP3Sg Masc=> root.C1 + vseq.V1 + root.C2 + vseq.V2 + "'" ;  -- Huwa QALA'
          AgP3Sg Fem => qalgh + (case vseq.V2 of {"o" => "o" ; _ => "e"}) + "t" ;  -- Hija QALGĦET
          AgP1 Pl    => qlaj + "na" ;  -- Aħna QLAJNA
          AgP2 Pl    => qlaj + "tu" ;  -- Intom QLAJTU
          AgP3Pl     => qalgh + "u"  -- Huma QALGĦU
        } ;

    -- Conjugate entire verb in IMPERFECT tense, given the IMPERATIVE
    -- Params: Imperative Singular (eg IKTEB), Imperative Plural (eg IKTBU)
    conjDefectiveImpf = conjGenericImpf ;

    -- Conjugate entire verb in IMPERATIVE tense, infers vowel sequence
    -- Params: Root, Vowels
    conjDefectiveImp : Root -> Vowels -> ( Number => Str ) = \root,vseq ->
      let
        v1 = case vseq.V1 of { "e" => "i" ; _ => vseq.V1 } ;
        v_pl : Str = case root.C2 of { #LiquidCons => "i" ; _ => "" } ; -- some verbs require "i" insertion in middle (eg AQILGĦU)
      in
        table {
          Sg => v1 + root.C1 + root.C2 + vseq.V2 + "'" ;  -- Inti:  AQLA' / IBŻA'
          Pl => v1 + root.C1 + v_pl + root.C2 + root.C3 + "u"  -- Intom: AQILGĦU / IBŻGĦU
        } ;

    {- ~~~ Quadriliteral Verb (Strong) ~~~ -}

    -- Conjugate entire verb in PERFECT tense
    -- Params: Root, Vowels
    conjQuadPerf : Root -> Vowels -> (VAgr => Str) = \root,vseq ->
      let
        dendil = root.C1 + vseq.V1 + root.C2 + root.C3 + (case vseq.V2 of {"e" => "i" ; _ => vseq.V2 }) + root.C4 ;
        dendl = root.C1 + vseq.V1 + root.C2 + root.C3 + root.C4 ;
      in
      table {
        AgP1 Sg    => dendil + "t" ;  -- Jiena DENDILT
        AgP2 Sg    => dendil + "t" ;  -- Inti DENDILT
        AgP3Sg Masc=> root.C1 + vseq.V1 + root.C2 + root.C3 + vseq.V2 + root.C4 ;  -- Huwa DENDIL
        AgP3Sg Fem => dendl + (case vseq.V2 of {"o" => "o" ; _ => "e"}) + "t" ;  -- Hija DENDLET
        AgP1 Pl    => dendil + "na" ;  -- Aħna DENDILNA
        AgP2 Pl    => dendil + "tu" ;  -- Intom DENDILTU
        AgP3Pl     => dendl + "u"  -- Huma DENDLU
      } ;

    -- Conjugate entire verb in IMPERFECT tense, given the IMPERATIVE
    -- Params: Imperative Singular (eg DENDEL), Imperative Plural (eg DENDLU)
    conjQuadImpf : Str -> Str -> (VAgr => Str) = \imp_sg,imp_pl ->
      table {
        AgP1 Sg    => pfx_N imp_sg ;  -- Jiena NDENDEL
        AgP2 Sg    => pfx_T imp_sg ;  -- Inti DDENDEL
        AgP3Sg Masc=> pfx_J imp_sg ;  -- Huwa JDENDEL
        AgP3Sg Fem => pfx_T imp_sg ;  -- Hija DDENDEL
        AgP1 Pl    => pfx_N imp_pl ;  -- Aħna NDENDLU
        AgP2 Pl    => pfx_T imp_pl ;  -- Intom DDENDLU
        AgP3Pl     => pfx_J imp_pl    -- Huma JDENDLU
      } ;

    -- Conjugate entire verb in IMPERATIVE tense, infers vowel sequence
    -- Params: Root, Vowels
    conjQuadImp : Root -> Vowels -> (Number => Str) = \root,vseq ->
      table {
        Sg => root.C1 + vseq.V1 + root.C2 + root.C3 + vseq.V2 + root.C4 ;  -- Inti:  DENDEL
        Pl => root.C1 + vseq.V1 + root.C2 + root.C3 + root.C4 + "u"  -- Intom: DENDLU
      } ;

    {- ~~~ Quadriliteral Verb (Weak Final) ~~~ -}

    -- Conjugate entire verb in PERFECT tense
    -- Params: Stem
    conjQuadWeakPerf : Root -> Vowels -> Str -> (VAgr => Str) = \root,vseq,imp_sg ->
      case takeSfx 1 imp_sg of {
        "a" => -- KANTA
          let
            kanta = imp_sg ;
          in
          table {
            AgP1 Sg    => kanta + "jt" ;  -- Jiena KANTAJT
            AgP2 Sg    => kanta + "jt" ;  -- Inti KANTAJT
            AgP3Sg Masc=> kanta ;  -- Huwa KANTA
            AgP3Sg Fem => kanta + "t" ; -- Hija KANTAT
            AgP1 Pl    => kanta + "jna" ;  -- Aħna KANTAJNA
            AgP2 Pl    => kanta + "jtu" ;  -- Intom KANTAJTU
            AgP3Pl     => kanta + "w"  -- Huma KANTAW
          } ;
        _ => -- SERVI
          let
            serve = root.C1 + vseq.V1 + root.C2 + root.C3 + "e" ;
          in
          table {
            AgP1 Sg    => serve + "jt" ;  -- Jiena SERVEJT
            AgP2 Sg    => serve + "jt" ;  -- Inti SERVEJT
            AgP3Sg Masc=> root.C1 + vseq.V1 + root.C2 + root.C3 + vseq.V2 ;  -- Huwa SERVA
            AgP3Sg Fem => root.C1 + vseq.V1 + root.C2 + root.C3 + "iet" ; -- Hija SERVIET
            AgP1 Pl    => serve + "jna" ;  -- Aħna SERVEJNA
            AgP2 Pl    => serve + "jtu" ;  -- Intom SERVEJTU
            AgP3Pl     => serve + "w"  -- Huma SERVEW
          }
      } ;

    -- Conjugate entire verb in IMPERFECT tense, given the IMPERATIVE
    -- Params: Imperative Singular (eg SERVI), Imperative Plural (eg SERVU)
    conjQuadWeakImpf : Str -> Str -> (VAgr => Str) = \imp_sg,imp_pl ->
      table {
        AgP1 Sg    => pfx_N imp_sg ;  -- Jiena NSERVI
        AgP2 Sg    => pfx_T imp_sg ;  -- Inti SSERVI
        AgP3Sg Masc=> pfx_J imp_sg ;  -- Huwa JSERVI
        AgP3Sg Fem => pfx_T imp_sg ;  -- Hija SSERVI
        AgP1 Pl    => pfx_N imp_pl ;  -- Aħna NSERVU
        AgP2 Pl    => pfx_T imp_pl ;  -- Intom SSERVU
        AgP3Pl     => pfx_J imp_pl    -- Huma JSERVU
      } ;

    -- Conjugate entire verb in IMPERATIVE tense, infers vowel sequence
    -- Params: Root, Vowels
    conjQuadWeakImp : Root -> Vowels -> (Number => Str) = \root,vseq ->
      table {
        --- this is known to fail for KANTA, but that seems like a less common case
        Sg => root.C1 + vseq.V1 + root.C2 + root.C3 + "i" ;  -- Inti: SERVI
        Pl => root.C1 + vseq.V1 + root.C2 + root.C3 + "u"  -- Intom: SERVU
      } ;


    {- ~~~ Non-semitic verbs ~~~ -}

    -- Conjugate entire verb in PERFECTIVE tense
    -- Params: mamma
    conjLoanPerf : Str -> (VAgr => Str) = \mamma ->
      case mamma of {
        _ + "ixxa" =>
          let
            issugger = dropSfx 4 mamma ;
          in
          table {
          AgP1 Sg    => issugger + "ejt" ;  -- Jiena ISSUĠĠEREJT
          AgP2 Sg    => issugger + "ejt" ;  -- Inti ISSUĠĠEREJT
          AgP3Sg Masc=> mamma ; -- Huwa ISSUĠĠERIXXA
          AgP3Sg Fem => issugger + "iet" ;  -- Hija ISSUĠĠERIET
          AgP1 Pl    => issugger + "ejna" ;  -- Aħna ISSUĠĠEREJNA
          AgP2 Pl    => issugger + "ejtu" ;  -- Intom ISSUĠĠEREJTU
          AgP3Pl     => issugger + "ew"  -- Huma ISSUĠĠEREW
          } ;
        _ =>
          let
            ipparkja = mamma ;
          in
          table {
          AgP1 Sg    => ipparkja + "jt" ;  -- Jiena IPPARKJAJT
          AgP2 Sg    => ipparkja + "jt" ;  -- Inti IPPARKJAJT
          AgP3Sg Masc=> ipparkja ; -- Huwa IPPARKJA
          AgP3Sg Fem => ipparkja + "t" ;  -- Hija IPPARKJAT
          AgP1 Pl    => ipparkja + "jna" ;  -- Aħna IPPARKJAJNA
          AgP2 Pl    => ipparkja + "jtu" ;  -- Intom IPPARKJAJTU
          AgP3Pl     => ipparkja + "w"  -- Huma IPPARKJAW
          }
      } ;

    -- Conjugate entire verb in IMPERFECT, given the IMPERATIVE
    -- Params: Imperative Singular (eg IPPARKJA), Imperative Plural (eg IPPARKJAW)
    conjLoanImpf : Str -> Str -> (VAgr => Str) = \imp_sg,imp_pl ->
      let
        euphonicVowel : Str = case takePfx 1 imp_sg of {
          #Consonant => "i" ; -- STABILIXXA > NISTABILIXXA
          _ => []
          } ;
      in
      table {
        AgP1 Sg    => "n" + euphonicVowel + imp_sg ;  -- Jiena NIPPARKJA
        AgP2 Sg    => "t" + euphonicVowel + imp_sg ;  -- Inti TIPPARKJA
        AgP3Sg Masc=> "j" + euphonicVowel + imp_sg ;  -- Huwa JIPPARKJA
        AgP3Sg Fem => "t" + euphonicVowel + imp_sg ;  -- Hija TIPPARKJA
        AgP1 Pl    => "n" + euphonicVowel + imp_pl ;  -- Aħna NIPPARKJAW
        AgP2 Pl    => "t" + euphonicVowel + imp_pl ;  -- Intom TIPPARKJAW
        AgP3Pl     => "j" + euphonicVowel + imp_pl    -- Huma JIPPARKJAW
      } ;

    -- Conjugate entire verb in IMPERATIVE tense
    -- Params: Root, Vowels
    conjLoanImp : Str -> (Number => Str) = \mamma ->
      table {
        Sg => case mamma of {
          _ + "ixxa" => (dropSfx 1 mamma) + "i" ; -- STABILIXXA > STABILIXXI
          _ => mamma -- IPPARKJA > IPPARKJA
          } ;
        Pl => case mamma of {
          _ + "ixxa" => (dropSfx 1 mamma) + "u" ; -- STABILIXXA > STABILIXXU
          _ => mamma + "w" -- IPPARKJA > IPPARKJAW
          }
      } ;

    {- ~~~ Form II verbs ~~~ -}

    conjFormII : VerbInfo -> (VForm => Str) = \i ->
      let
        mamma : Str = case i.class of {
          Weak Defective => i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C2 + i.vseq.V2 + "'" ; -- QATTA'
          Weak Lacking => i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C2 + i.vseq.V2 ; -- NEĦĦA
          _ => i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C2 + i.vseq.V2 + i.root.C3 -- WAQQAF
          } ;
        nehhi : Str = case i.class of {
          Weak Lacking => i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C2 + "i" ; -- NEĦĦI
          _ => mamma -- WAQQAF
          } ;
        bexxix : Str = case <i.class,i.vseq.V1,i.vseq.V2> of {
          <Weak Defective,_,_> => i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C2 + i.vseq.V2 + "j" ; -- QATTAJ
          <_,"e","a"> => i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C2 + "e" + i.root.C3 ; -- NEĦĦEJ
          <_,_,"e"> => i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C2 + "i" + i.root.C3 ;
          _ => nehhi -- no change
          } ;
        waqqf : Str = case i.class of {
          Weak Hollow => i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C3 ; -- QAJM
          Weak Lacking => i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C2 ; -- NEĦĦ
          _ => sfx (i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C2) i.root.C3
          } ;
        waqqfu : Str = waqqf + "u" ;
        perf : VAgr => Str = table {
          AgP1 Sg => bexxix + "t" ;
          AgP2 Sg => bexxix + "t" ;
          AgP3Sg Masc => mamma ;
          AgP3Sg Fem => case <i.vseq.V1, i.vseq.V2> of {
            <"e","a"> => waqqf + "iet" ; -- NEĦĦIET
            _ => waqqf + "et"
            } ;
          AgP1 Pl => bexxix + "na" ;
          AgP2 Pl => bexxix + "tu" ;
          AgP3Pl => case <i.vseq.V1, i.vseq.V2> of {
            <"e","a"> => waqqf + "ew" ; -- NEĦĦEW
            _ => waqqf + "u"
            }
          } ;
        impf : VAgr => Str = table {
          AgP1 Sg => pfx_N nehhi ;
          AgP2 Sg => pfx_T nehhi ;
          AgP3Sg Masc => pfx_J nehhi ;
          AgP3Sg Fem => pfx_T nehhi ;
          AgP1 Pl => pfx_N waqqfu ;
          AgP2 Pl => pfx_T waqqfu ;
          AgP3Pl => pfx_J waqqfu
          } ;
        imp : Number => Str = table {
          Sg => nehhi ;
          Pl => waqqfu
          } ;
      in table {
        VPerf agr => perf ! agr ;
        VImpf agr => impf ! agr ;
        VImp num  => imp ! num ;
        VPresPart _ => NONEXIST ;
        VPastPart _ => NONEXIST
      } ;

    conjFormII_quad : VerbInfo -> (VForm => Str) = \i ->
      let
        vowels = extractVowels i.imp ;
        mamma : Str = case i.class of {
          Quad QWeak => pfx_T i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C3 + i.vseq.V2 ; -- SSERVA
          _ => pfx_T i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C3 + i.vseq.V2 + i.root.C4 -- T-ĦARBAT
          } ;
        tharb : Str = case i.class of {
          _ => pfx_T i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C3
          } ;
        tharbt : Str = case i.class of {
          Quad QWeak => pfx_T i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C3 ; -- SSERV
          _ => pfx_T i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C3 + i.root.C4
          } ;
        perf : VAgr => Str =
          let
            tharbat : Str = case <i.class,vowels.V2> of {
              <Quad QWeak,"i"> => pfx_T i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C3 + "e" + i.root.C4 ; -- SSERVEJ
              <Quad QWeak,"a"> => pfx_T i.root.C1 + i.vseq.V1 + i.root.C2 + i.root.C3 + "a" + i.root.C4 ; -- TKANTAJ
              _ => mamma
              } ;
            tharbtu : Str = case <i.class, vowels.V2> of {
              <Quad QWeak,"i"> => tharb + "ew" ; -- SSERVEW
              <Quad QWeak,"a"> => tharb + "aw" ; -- TKANTAW
              _ => tharbt + "u"
              } ;
          in
          table {
            AgP1 Sg => tharbat + "t" ;
            AgP2 Sg => tharbat + "t" ;
            AgP3Sg Masc => mamma ;
            AgP3Sg Fem => case <i.class,vowels.V2> of {
              <Quad QWeak,"i"> => tharb + "iet" ; -- SSERVIET
              <Quad QWeak,"a"> => tharb + "at" ; -- TKANTAT
              _ => tharbt + "et"
              } ;
            AgP1 Pl => tharbat + "na" ;
            AgP2 Pl => tharbat + "tu" ;
            AgP3Pl => tharbtu
            -- AgP3Pl => case <i.class, vowels.V2> of {
            --   <Quad QWeak,"i"> => tharb + "ew" ; -- SSERVEW
            --   <Quad QWeak,"a"> => tharb + "aw" ; -- TKANTAW
            --   _ => tharbt + "u"
            --   }
          } ;
        impf : VAgr => Str =
          let
            tharbat : Str = case <i.class,vowels.V2> of {
              <Quad QWeak,"i"> => tharb + "i" ; -- SSERVI
              -- <Quad QWeak,"a"> => tharb + "at" ; -- TKANTA
              _ => mamma
              } ;
            tharbtu : Str = case <i.class, vowels.V2> of {
              -- <Quad QWeak,"i"> => tharb + "ew" ; -- SSERVEW
              <Quad QWeak,"a"> => tharb + "aw" ; -- TKANTAW
              _ => tharbt + "u"
              } ;
          in
          table {
            AgP1 Sg => "ni" + tharbat ;
            AgP2 Sg => "ti" + tharbat ;
            AgP3Sg Masc => "ji" + tharbat ;
            AgP3Sg Fem => "ti" + tharbat ;
            AgP1 Pl => "ni" + tharbtu ;
            AgP2 Pl => "ti" + tharbtu ;
            AgP3Pl => "ji" + tharbtu
          } ;
        imp : Number => Str =
          let
            tharbtu : Str = case <i.class, vowels.V2> of {
              -- <Quad QWeak,"i"> => tharb + "ew" ; -- SSERVEW
              <Quad QWeak,"a"> => tharb + "aw" ; -- TKANTAW
              _ => tharbt + "u"
              } ;
          in
          table {
            Sg => i.imp ;
            Pl => tharbtu
          } ;
      in table {
        VPerf agr => perf ! agr ;
        VImpf agr => impf ! agr ;
        VImp num  => imp ! num ;
        VPresPart _ => NONEXIST ;
        VPastPart _ => NONEXIST
      } ;

    {- ~~~ Form III verbs ~~~ -}

    conjFormIII : VerbInfo -> (VForm => Str) = \i ->
      let
        wiegeb : Str = i.root.C1 + i.vseq.V1 + i.root.C2 + i.vseq.V2 + i.root.C3 ;
        wegib : Str = case <i.vseq.V1,i.vseq.V2> of {
          <"ie","e"> => i.root.C1 + "e" + i.root.C2 + "i" + i.root.C3 ;
          <v1,"e"> => i.root.C1 + v1 + i.root.C2 + "i" + i.root.C3 ;
          _ => wiegeb -- no change
          } ;
        wiegb : Str = sfx (i.root.C1 + i.vseq.V1 + i.root.C2) i.root.C3 ;
        wiegbu : Str = wiegb + "u" ;
        perf : VAgr => Str = table {
          AgP1 Sg => wegib + "t" ;
          AgP2 Sg => wegib + "t" ;
          AgP3Sg Masc => wiegeb ;
          AgP3Sg Fem => wiegb + "et" ;
          AgP1 Pl => wegib + "na" ;
          AgP2 Pl => wegib + "tu" ;
          AgP3Pl => wiegbu
          } ;
        impf : VAgr => Str = table {
          AgP1 Sg => pfx_N wiegeb ;
          AgP2 Sg => pfx_T wiegeb ;
          AgP3Sg Masc => pfx_J wiegeb ;
          AgP3Sg Fem => pfx_T wiegeb ;
          AgP1 Pl => pfx_N wiegbu ;
          AgP2 Pl => pfx_T wiegbu ;
          AgP3Pl => pfx_J wiegbu
          } ;
        imp : Number => Str = table {
          Sg => wiegeb ;
          Pl => wiegbu
          } ;
      in table {
        VPerf agr => perf ! agr ;
        VImpf agr => impf ! agr ;
        VImp num  => imp ! num ;
        VPresPart _ => NONEXIST ;
        VPastPart _ => NONEXIST
      } ;

    {- ~~~ Form VII and VIII verbs ~~~ -}

    -- C1 contains the entire initial consonant cluster, e.g. NTR in NTRIFES
    conjFormVII : VerbInfo -> Str -> (VForm => Str) = \i,C1 ->
      let
        nhasel : Str = case i.class of {
          Weak Hollow => C1 + i.vseq.V1 + i.root.C3 ;
          Weak Lacking => C1 + i.vseq.V1 + i.root.C2 + i.vseq.V2 ;
          Weak Defective => C1 + i.vseq.V1 + i.root.C2 + i.vseq.V2 + "'" ;
          _ => C1 + i.vseq.V1 + i.root.C2 + i.vseq.V2 + i.root.C3
          } ;
        v1 : Str = case i.vseq.V1 of { "ie" => "e" ; v => v } ;
        v2 : Str = case i.vseq.V2 of { "e" => "i" ; v => v } ;
        -- nhsil : Str = case <i.class,i.root.C1> of {
        --   <Strong Regular,_> => C1 + i.root.C2 + v2 + i.root.C3 ;
        --   <Strong LiquidMedial,_> => C1 + v1 + i.root.C2 + v2 + i.root.C3 ;
        --   <Weak Hollow,_> => C1 + v1 + i.root.C3 ;
        --   <Weak Lacking,_> => C1 + i.root.C2 + v1 + i.root.C3 ;
        --   _ => C1 + v1 + i.root.C2 + v2 + i.root.C3
        --   } ;
        nhsil : Str = case i.class of {
          Strong Regular => C1 + i.root.C2 + v2 + i.root.C3 ;
          Strong LiquidMedial => C1 + v1 + i.root.C2 + v2 + i.root.C3 ;
          Strong Geminated => C1 + v1 + i.root.C2 + i.root.C3 + "ej" ; -- MTEDDEJ-
          Weak Hollow => C1 + v1 + i.root.C3 ;
          Weak Lacking => C1 + i.root.C2 + v1 + i.root.C3 ;
          Weak Defective => C1 + i.root.C2 + v1 + "j" ;
          _ => C1 + v1 + i.root.C2 + v2 + i.root.C3
          } ;
        nhasl : Str = case i.class of {
          Weak Hollow => C1 + i.vseq.V1 + i.root.C3 ;
          Weak Lacking => C1 + i.root.C2 ;
          _ => sfx (C1 + i.vseq.V1 + i.root.C2) i.root.C3
          } ;
        nhaslu : Str = case i.class of {
          Weak Lacking => nhasl + "ew" ;
          _ => nhasl + "u"
          } ;
        perf : VAgr => Str = table {
          AgP1 Sg => nhsil + "t" ;
          AgP2 Sg => nhsil + "t" ;
          AgP3Sg Masc => nhasel ;
          AgP3Sg Fem => case i.class of {
            Weak Lacking => nhasl + "iet" ;
            _ => nhasl + "et"
            } ;
          AgP1 Pl => nhsil + "na" ;
          AgP2 Pl => nhsil + "tu" ;
          AgP3Pl => nhaslu
          } ;
        impf : VAgr => Str = table {
          AgP1 Sg => "ni" + nhasel ;
          AgP2 Sg => "ti" + nhasel ;
          AgP3Sg Masc => "ji" + nhasel ;
          AgP3Sg Fem => "ti" + nhasel ;
          AgP1 Pl => "ni" + nhaslu ;
          AgP2 Pl => "ti" + nhaslu ;
          AgP3Pl => "ji" + nhaslu
          } ;
        imp : Number => Str = table {
          Sg => nhasel ;
          Pl => nhaslu
          } ;
      in table {
        VPerf agr => perf ! agr ;
        VImpf agr => impf ! agr ;
        VImp num  => imp ! num ;
        VPresPart _ => NONEXIST ;
        VPastPart _ => NONEXIST
      } ;

    {- ~~~ Form IX verbs ~~~ -}

    conjFormIX : VerbInfo -> (VForm => Str) = \i ->
      let
        sfar = i.imp ;
        sfaru = sfar + "u" ;
        perf : VAgr => Str = table {
          AgP1 Sg => sfar + "t" ;
          AgP2 Sg => sfar + "t" ;
          AgP3Sg Masc => sfar ;
          AgP3Sg Fem => sfar + "et" ;
          AgP1 Pl => sfar + "na" ;
          AgP2 Pl => sfar + "tu" ;
          AgP3Pl => sfaru
          } ;
        impf : VAgr => Str = table {
          AgP1 Sg => "ni" + sfar ;
          AgP2 Sg => "ti" + sfar ;
          AgP3Sg Masc => "ji" + sfar ;
          AgP3Sg Fem => "ti" + sfar ;
          AgP1 Pl => "ni" + sfaru ;
          AgP2 Pl => "ti" + sfaru ;
          AgP3Pl => "ji" + sfaru
          } ;
        imp : Number => Str = table {
          Sg => sfar ;
          Pl => sfaru
          } ;
      in table {
        VPerf agr => perf ! agr ;
        VImpf agr => impf ! agr ;
        VImp num  => imp ! num ;
        VPresPart _ => NONEXIST ;
        VPastPart _ => NONEXIST
      } ;

    {- ~~~ Form X verbs ~~~ -}

    conjFormX : VerbInfo -> (VForm => Str) = \i ->
      let
        mamma : Str = i.imp ; --- is it naughty to pass the mamma as imp?
        perf : VAgr => Str = case mamma of {
          -- STAĦBA
          stahb + v@#Vowel =>
            let
              stahba : Str = mamma ;
            in
            table {
            AgP1 Sg => stahb + "ejt" ;
            AgP2 Sg => stahb + "ejt" ;
            AgP3Sg Masc => mamma ;
            AgP3Sg Fem => stahb + "et" ;
            AgP1 Pl => stahb + "ejna" ;
            AgP2 Pl => stahb + "ejtu" ;
            AgP3Pl => stahb + "ew"
            } ;
          -- STKENN
          _ + #Consonant + #Consonant =>
            let
              stkenn : Str = mamma ;
            in
            table {
            AgP1 Sg => stkenn + "ejt" ;
            AgP2 Sg => stkenn + "ejt" ;
            AgP3Sg Masc => stkenn ;
            AgP3Sg Fem => stkenn + "et" ;
            AgP1 Pl => stkenn + "ejna" ;
            AgP2 Pl => stkenn + "ejtu" ;
            AgP3Pl => stkenn + "ew"
            } ;
          -- STRIEĦ
          _ + "ie" + #Consonant =>
            let
              strieh : Str = mamma ;
              strih : Str = ie2i strieh ;
              strihaj : Str = strih + "aj"
            in
            table {
            AgP1 Sg => strihaj + "t" ;
            AgP2 Sg => strihaj + "t" ;
            AgP3Sg Masc => mamma ;
            AgP3Sg Fem => strieh + "et" ;
            AgP1 Pl => strihaj + "na" ;
            AgP2 Pl => strihaj + "tu" ;
            AgP3Pl => strieh + "u"
            } ;
          -- STĦARREĠ
          _ =>
            let
              stharrig : Str = case mamma of {
                stharr + "e" + g@#Consonant => stharr+"i"+g ;
                stenbah => stenbah
                } ;
              stharrg : Str = case mamma of {
                _ + "għ" + #Vowel + #Consonant => mamma ;
                stharr + #Vowel + g@#Consonant => stharr+g ;
                x => x --- unknown case
                } ;
            in
            table {
            AgP1 Sg => stharrig + "t" ;
            AgP2 Sg => stharrig + "t" ;
            AgP3Sg Masc => mamma ;
            AgP3Sg Fem => stharrg + "et" ;
            AgP1 Pl => stharrig + "na" ;
            AgP2 Pl => stharrig + "tu" ;
            AgP3Pl => stharrg + "u"
            }
          } ;
        impf : VAgr => Str = table {
          AgP1 Sg => "ni" + mamma ;
          AgP2 Sg => "ti" + mamma ;
          AgP3Sg Masc => "ji" + mamma ;
          AgP3Sg Fem => "ti" + mamma ;
          AgP1 Pl => "ni" + (perf!AgP3Pl) ;
          AgP2 Pl => "ti" + (perf!AgP3Pl) ;
          AgP3Pl => "ji" + (perf!AgP3Pl)
          } ;
        imp : Number => Str = table {
          Sg => (perf!AgP3Sg Masc) ;
          Pl => (perf!AgP3Pl)
          } ;
      in table {
        VPerf agr => perf ! agr ;
        VImpf agr => impf ! agr ;
        VImp num  => imp ! num ;
        VPresPart _ => NONEXIST ;
        VPastPart _ => NONEXIST
      } ;

}
