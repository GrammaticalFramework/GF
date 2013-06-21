--# -path=.:abstract:common:prelude

resource ParadigmsVerbsLav = open ResLav, CatLav, Prelude, Predef in {

flags coding = utf8 ;

oper

  Verb_TMP : Type = {s : VForm => Str} ;

  -- Second and third conjugations
  mkVerb : Str -> Conjugation -> Case -> Verb = \lemma,conj,leftVal -> {
    s = table {
      Pos => (mkVerb_Pos lemma conj).s ;
      Neg => (filter_Neg (mkVerb_Pos ("ne"+lemma) conj)).s
    } ;
    leftVal = leftVal
  } ;

  -- First conjugation
  mkVerbC1 : Str -> Str -> Str -> Case -> Verb = \lemma,lemma2,lemma3,leftVal -> {
    s = table {
      Pos => (mkVerbC1_Pos lemma lemma2 lemma3).s ;
      Neg => (filter_Neg (mkVerbC1_Pos ("ne"+lemma) ("ne"+lemma2) ("ne"+lemma3))).s
    } ;
    leftVal = leftVal
  } ;

  mkVerb_Pos : Str -> Conjugation -> Verb_TMP = \lemma,conj ->
    case lemma of {
      -- TODO: "ir"
      s + ("ties") => mkReflVerb lemma conj ;
      _            => mkRegVerb lemma conj
    } ;

  mkVerbC1_Pos : Str -> Str -> Str -> Verb_TMP = \lemma,lemma2,lemma3 ->
    case lemma of {
      -- TODO: "ir"
      s + ("ties") => mkVerb_C1_Refl lemma lemma2 lemma3 ;
      _            => mkVerb_C1 lemma lemma2 lemma3
    } ;

  mkRegVerb : Str -> Conjugation -> Verb_TMP = \lemma,conj ->
    case conj of {
      C2 => mkVerb_C2 lemma ;
      C3 => mkVerb_C3 lemma
    } ;

  mkReflVerb : Str -> Conjugation -> Verb_TMP = \lemma,conj ->
    case conj of {
      C2 => mkVerb_C2_Refl lemma ;
      C3 => mkVerb_C3_Refl lemma
    } ;

  filter_Neg : Verb_TMP -> Verb_TMP = \full -> {
    s = table {
      VDeb => NON_EXISTENT ;
      VDebRel => NON_EXISTENT ;
      x => full.s ! x
    }
  } ;

  -- First conjugation
  -- Ref. to lexicon.xml (revision 719): 15th paradigm
  -- lemma1: VInf
  -- lemma2: VInd P1 Sg Pres
  -- lemma3: VInd P1 Sg Past
  mkVerb_C1 : Str -> Str -> Str -> Verb_TMP = \lemma1,lemma2,lemma3 ->
    let
      stem1 : Str = Predef.tk 1 lemma1 ;
      stem2 : Str = Predef.tk 1 lemma2 ;
      stem3 : Str = Predef.tk 1 lemma3
    in {
      s = table {
        VInf => lemma1 ;  -- stem1 + "t"

        VInd P1 Sg Pres => lemma2 ;  -- stem2 + "u"
        VInd P1 Sg Fut  => pal_C1_1 stem3 stem1 + "šu" ;
        VInd P1 Sg Past => lemma3 ;  -- stem3 + "u"
        VInd P1 Pl Pres => stem2 + "am" ;
        VInd P1 Pl Fut  => pal_C1_1 stem3 stem1 + "sim" ;
        VInd P1 Pl Past => stem3 + "ām" ;

        VInd P2 Sg Pres => pal_C1_4 stem2 ;
        VInd P2 Sg Fut  => pal_C1_1 stem3 stem1 + "si" ;
        VInd P2 Sg Past => stem3 + "i" ;
        VInd P2 Pl Pres => stem2 + "at" ;
        VInd P2 Pl Fut  => pal_C1_1 stem3 stem1 + "siet" ;  -- ("siet"|"sit")
        VInd P2 Pl Past => stem3 + "āt" ;

        VInd P3 _ Pres => stem2 ;
        VInd P3 _ Fut  => pal_C1_1 stem3 stem1 + "s" ;
        VInd P3 _ Past => stem3 + "a" ;

        VInd _  _ Cond => stem1 + "tu" ;

        VRel Pres => stem2 + "ot" ;
        VRel Fut  => pal_C1_1 stem3 stem1 + "šot" ;
        VRel Past => NON_EXISTENT ;
        VRel Cond => NON_EXISTENT ;

        VDeb    => "jā" + stem2 ;
        VDebRel => "jā" + stem2 + "ot" ;

        VImp Sg => pal_C1_4 stem2 ;
        VImp Pl => pal_C1_4 stem2 + "iet" ;

        VPart Act  g n c => mkParticiple_IsUsi g n c (pal_C1_3 stem3) ;
        VPart Pass g n c => mkParticiple_TsTa g n c stem1
      }
    } ;

  -- Second conjugation
  -- Ref. to lexicon.xml (revision 719): 16th paradigm
  -- lemma: VInf
  mkVerb_C2 : Str -> Verb_TMP = \lemma ->
    let
      stem : Str = Predef.tk 1 lemma
    in {
      s = table {
        VInf => lemma ; -- stem + "t"

        VInd P1 Sg Pres => stem + "ju" ;
        VInd P1 Sg Fut  => stem + "šu" ;
        VInd P1 Sg Past => stem + "ju" ;
        VInd P1 Pl Pres => stem + "jam" ;
        VInd P1 Pl Fut  => stem + "sim" ;
        VInd P1 Pl Past => stem + "jām" ;

        VInd P2 Sg Pres => stem ;
        VInd P2 Sg Fut  => stem + "si" ;
        VInd P2 Sg Past => stem + "ji" ;
        VInd P2 Pl Pres => stem + "jat" ;
        VInd P2 Pl Fut  => stem + "siet" ;  -- ("siet"|"sit")
        VInd P2 Pl Past => stem + "jāt" ;

        VInd P3 _ Pres => stem ;
        VInd P3 _ Fut  => stem + "s" ;
        VInd P3 _ Past => stem + "ja" ;

        VInd _  _ Cond => stem + "tu" ;

        VRel Pres => stem + "jot" ;
        VRel Fut  => stem + "šot" ;
        VRel Past => NON_EXISTENT ;
        VRel Cond => NON_EXISTENT ;

        VDeb    => "jā" + stem ;
        VDebRel => "jā" + stem + "jot" ;

        VImp Sg => stem ;
        VImp Pl => stem + "jiet" ;

        VPart Act  g n c => mkParticiple_IsUsi g n c (stem + "j") ;
        VPart Pass g n c => mkParticiple_TsTa g n c stem
      }
    } ;

  -- Third conjugation
  -- Ref. to lexicon.xml (revision 719): 17th paradigm
  -- lemma: VInf
  mkVerb_C3 : Str -> Verb_TMP = \lemma ->
    let
      stem : Str = Predef.tk 1 lemma
    in {
      s = table {
        VInf => lemma ;  -- stem + "t"

        VInd P1 Sg Pres => pal_C3_1 stem + "u" ;
        VInd P1 Sg Fut  => stem + "šu" ;
        VInd P1 Sg Past => stem + "ju" ;
        VInd P1 Pl Pres => pal_C3_1 stem + pal_C3_2 stem "am" ;
        VInd P1 Pl Fut  => stem + "sim" ;
        VInd P1 Pl Past => stem + "jām" ;

        VInd P2 Sg Pres => pal_C3_1 stem + "i" ;
        VInd P2 Sg Fut  => stem + "si" ;
        VInd P2 Sg Past => stem + "ji" ;
        VInd P2 Pl Pres => pal_C3_1 stem + pal_C3_2 stem "at" ;
        VInd P2 Pl Fut  => stem + "siet" ;  -- ("siet"|"sit")
        VInd P2 Pl Past => stem + "jāt" ;

        VInd P3 _ Pres => pal_C3_5 stem ;
        VInd P3 _ Fut  => stem + "s" ;
        VInd P3 _ Past => stem + "ja" ;

        VInd _  _ Cond => stem + "tu" ;

        VRel Pres => pal_C3_1 stem + "ot" ;
        VRel Fut  => stem + "šot" ;
        VRel Past => NON_EXISTENT ;
        VRel Cond => NON_EXISTENT ;

        VDeb    => pal_C3_3 stem ;
        VDebRel => pal_C3_3 stem + "ot" ;

        VImp Sg => pal_C3_1 stem + "i" ;
        VImp Pl => pal_C3_1 stem + "iet" ;

        VPart Act  g n c => mkParticiple_IsUsi g n c (stem + "j") ;
        VPart Pass g n c => mkParticiple_TsTa g n c stem
      }
    } ;

  -- First conjugation: reflexive
  -- Ref. to lexicon.xml (revision 719): 18th paradigm
  -- lemma1: VInf
  -- lemma2: VInd P1 Sg Pres
  -- lemma3: VInd P1 Sg Past
  mkVerb_C1_Refl : Str -> Str -> Str -> Verb_TMP = \lemma1,lemma2,lemma3 ->
    let
      stem1 : Str = Predef.tk 4 lemma1 ;
      stem2 : Str = Predef.tk 2 lemma2 ;
      stem3 : Str = Predef.tk 2 lemma3
    in {
      s = table {
        VInf => lemma1 ;  -- stem + "ties"

        VInd P1 Sg Pres => lemma2 ;  -- stem2 + "os"
        VInd P1 Sg Fut  => pal_C1_1 stem3 stem1 + "šos" ;
        VInd P1 Sg Past => lemma3 ;  -- stem3 + "os"
        VInd P1 Pl Pres => stem2 + "amies" ;
        VInd P1 Pl Fut  => pal_C1_1 stem3 stem1 + "simies" ;
        VInd P1 Pl Past => stem3 + "āmies" ;

        VInd P2 Sg Pres => pal_C1_2 stem3 stem2 + "ies" ;
        VInd P2 Sg Fut  => pal_C1_1 stem3 stem1 + "sies" ;
        VInd P2 Sg Past => stem3 + "ies" ;
        VInd P2 Pl Pres => stem2 + "aties" ;
        VInd P2 Pl Fut  => pal_C1_1 stem3 stem1 + "sieties" ;  -- ("sieties"|"sities")
        VInd P2 Pl Past => stem3 + "āties" ;

        VInd P3 _ Pres => stem2 + "as" ;
        VInd P3 _ Fut  => pal_C1_1 stem3 stem1 + "sies" ;
        VInd P3 _ Past => stem3 + "ās" ;

        VInd _  _ Cond => stem1 + "tos" ;

        VRel Pres => stem2 + "oties" ;
        VRel Fut  => pal_C1_1 stem3 stem1 + "šoties" ;
        VRel Past => NON_EXISTENT ;
        VRel Cond => NON_EXISTENT ;

        VDeb    => "jā" + stem2 + "as" ;
        VDebRel => "jā" + stem2 + "oties" ;

        VImp Sg => pal_C1_2 stem3 stem2 + "ies" ;
        VImp Pl => pal_C1_2 stem3 stem2 + "ieties" ;

        VPart Act  g n c => mkParticiple_IesUsies g n c (pal_C1_3 stem3) ;
        VPart Pass g n c => mkParticiple_TsTa g n c stem1
      }
    } ;

  -- Second conjugation: reflexive
  -- Ref. to lexicon.xml (revision 719): 19th paradigm
  -- lemma: VInf
  mkVerb_C2_Refl : Str -> Verb_TMP = \lemma ->
    let
      stem : Str = Predef.tk 4 lemma
    in {
      s = table {
        VInf => lemma ;  -- stem + "ties"

        VInd P1 Sg Pres => stem + "jos" ;
        VInd P1 Sg Fut  => stem + "šos" ;
        VInd P1 Sg Past => stem + "jos" ;
        VInd P1 Pl Pres => stem + "jamies" ;
        VInd P1 Pl Fut  => stem + "simies" ;
        VInd P1 Pl Past => stem + "jāmies" ;

        VInd P2 Sg Pres => stem + "jies" ;
        VInd P2 Sg Fut  => stem + "sies" ;
        VInd P2 Sg Past => stem + "jies" ;
        VInd P2 Pl Pres => stem + "jaties" ;
        VInd P2 Pl Fut  => stem + "sieties" ;  -- ("sieties"|"sities")
        VInd P2 Pl Past => stem + "jāties" ;

        VInd P3 _ Pres => stem + "jas" ;
        VInd P3 _ Fut  => stem + "sies" ;
        VInd P3 _ Past => stem + "jās" ;

        VInd _  _ Cond => stem + "tos" ;

        VRel Pres => stem + "joties" ;
        VRel Fut  => stem + "šoties" ;
        VRel Past => NON_EXISTENT ;
        VRel Cond => NON_EXISTENT ;

        VDeb    => "jā" + stem + "jas" ;
        VDebRel => "jā" + stem + "joties" ;

        VImp Sg => stem + "jies" ;
        VImp Pl => stem + "jieties" ;

        VPart Act  g n c => mkParticiple_IesUsies g n c (stem + "j") ;
        VPart Pass g n c => mkParticiple_TsTa g n c stem
      }
    } ;

  -- Third conjugation: reflexive
  -- Ref. to lexicon.xml (revision 719): 20th paradigm
  -- lemma: VInf
  mkVerb_C3_Refl : Str -> Verb_TMP = \lemma ->
    let
      stem : Str = Predef.tk 4 lemma
    in {
      s = table {
        VInf => lemma ;  -- stem + "ties"

        VInd P1 Sg Pres => pal_C3_1 stem + "os" ;
        VInd P1 Sg Fut  => stem + "šos" ;
        VInd P1 Sg Past => stem + "jos" ;
        VInd P1 Pl Pres => pal_C3_4 stem + "mies" ;
        VInd P1 Pl Fut  => stem + "simies" ;
        VInd P1 Pl Past => stem + "jāmies" ;

        VInd P2 Sg Pres => pal_C3_1 stem + "ies" ;
        VInd P2 Sg Fut  => stem + "sies" ;
        VInd P2 Sg Past => stem + "jies" ;
        VInd P2 Pl Pres => pal_C3_4 stem + "ties" ;
        VInd P2 Pl Fut  => stem + "sieties" ;  -- ("sieties"|"sities")
        VInd P2 Pl Past => stem + "jāties" ;

        VInd P3 _ Pres => pal_C3_4 stem + "s" ;
        VInd P3 _ Fut  => stem + "sies" ;
        VInd P3 _ Past => stem + "jās" ;

        VInd _  _ Cond => stem + "tos" ;

        VRel Pres => pal_C3_1 stem + "oties" ;
        VRel Fut  => stem + "šoties" ;
        VRel Past => NON_EXISTENT ;
        VRel Cond => NON_EXISTENT ;

        VDeb    => pal_C3_6 stem + "s" ;
        VDebRel => pal_C3_6 stem + "oties" ;

        VImp Sg => pal_C3_1 stem + "ies" ;
        VImp Pl => pal_C3_1 stem + "ieties" ;

        VPart Act  g n c => mkParticiple_IesUsies g n c (stem + "j") ;
        VPart Pass g n c => mkParticiple_TsTa g n c stem
      }
    } ;

  mkVerb_Irreg : Str -> Case -> Verb = \lemma,leftVal ->
    case lemma of {
      "būt"   => mkVerb_Irreg_Be leftVal ;
      "iet"   => mkVerb_Irreg_Go leftVal ;
      #prefix + "iet"   => mkVerb_Irreg_Go_Prefix (Predef.tk 3 lemma) leftVal ;
      "gulēt" => mkVerb_Irreg_Sleep leftVal
      -- FIXME: "gulēt" should be treated as a regular verb (C3: gulēt, sēdēt etc.)
      -- TODO: add "dot"/Give (+prefix, +refl)
      -- TODO: multiple prefixes
      -- TODO: move to IrregLav?
    } ;

  mkVerb_Irreg_Be : Case -> Verb = \leftVal -> {
    s = table {
      Pos => table {
        VInd P1 Sg Pres => "esmu" ;
        VInd P2 Sg Pres => "esi" ;
        VInd P3 _  Pres => "ir" ;

        VDeb => "jābūt" ;

        x => (mkVerb_C1 "būt" "esu" "biju").s ! x -- the incorrect 'esu' will be overriden
      } ;
      Neg => table {
        VInd P1 Sg Pres => "neesmu" ;
        VInd P2 Sg Pres => "neesi" ;
        VInd P3 _  Pres => "nav" ;

        VDeb    => NON_EXISTENT ;
        VDebRel => NON_EXISTENT ;

        x => (mkVerb_C1 "nebūt" "neesu" "nebiju").s ! x -- the incorrect 'neesu' will be overriden
      }
    } ;
    leftVal = leftVal
  } ;

  mkVerb_Irreg_Go : Case -> Verb = \leftVal -> mkVerb_Irreg_Go_Prefix "" leftVal ;

  mkVerb_Irreg_Go_Prefix : Str -> Case -> Verb = \pref,leftVal -> {
    s = table {
      Pos => table {
        VInd P3 _ Pres => pref + "iet" ;
        VDeb => "jā" + pref + "iet" ;
        x => (mkVerb_C1 (pref + "iet") (pref + "eju") (pref + "gāju")).s ! x
      } ;
      Neg => table {
        VInd P3 _ Pres => "ne" + pref + "iet" ;
        VDeb => NON_EXISTENT ;
        VDebRel => NON_EXISTENT ;
        x => (mkVerb_C1 ("ne" + pref + "iet") ("ne" + pref + "eju") ("ne" + pref + "gāju")).s ! x
      }
    } ;
    leftVal = leftVal
  } ;

  mkVerb_Irreg_Sleep : Case -> Verb = \leftVal -> {
    s = table {
      Pos => table {
        VInd P2 Sg Pres => (mkVerb_C3 "gulēt").s ! VInd P2 Sg Pres ;
        VInd p  n  Pres => (mkVerb_C3 "guļēt").s ! VInd p n Pres ;

        -- FIXME: Here and there, the incorrect 'guļēt' contains intentional palatalization

        VRel Pres => (mkVerb_C3 "guļēt").s ! VRel Pres ;

        VDeb => (mkVerb_C3 "guļēt").s ! VDeb ;

        VDebRel => (mkVerb_C3 "guļēt").s ! VDebRel ;

        x => (mkVerb_C3 "gulēt").s ! x
      } ;
      Neg => table {
        VInd P2 Sg Pres => (mkVerb_C3 "negulēt").s ! VInd P2 Sg Pres ;
        VInd p  n  Pres => (mkVerb_C3 "neguļēt").s ! VInd p n Pres ;

        VRel Pres => (mkVerb_C3 "neguļēt").s ! VRel Pres ;

        VDeb => NON_EXISTENT ;

        VDebRel => NON_EXISTENT ;

        x => (mkVerb_C3 "negulēt").s ! x
      }
    } ;
    leftVal = leftVal
  } ;

  -- Auxiliaries: palatalization rules

  -- Ref. to the Java implementation: mija6
  -- stem3: VInd P1 Sg Past
  -- stem1: VInf
  pal_C1_1 : Str -> Str -> Str = \stem3,stem1 ->
    case stem1 of {
      s + "s" => case stem3 of {
        _ + "d" => s + "dī" ;
        _ + "t" => s + "tī" ;
        _ + "s" => s + "sī" ;
        _       => stem1
      } ;
      s + "z" => s + "zī" ; -- e.g. 'lauzt' => 'lauzīs'
      _       => stem1
    } ;

  -- Ref. to the Java implementation: mija7
  -- stem3: VInd P1 Sg Past
  -- stem2: VInd P1 Sg Pres
  pal_C1_2 : Str -> Str -> Str = \stem3,stem2 ->
    case stem2 of {
      s + "š" => case stem3 of {
        _ + "s" => s + "s" ;
        _       => stem2
      } ;
      s + "t" => case stem2 of {
        _ + "met"  => stem2 ;
        _ + "cērt" => stem2 ;
        _          => s + "ti"
      } ;
    --s + "ž"  => s + "d" ; -- FIXME: 'laužu' => 'lauz' not 'laud'
      s + "ļ"  => s + "l" ;
      s + "mj" => s + "m" ;
      s + "bj" => s + "b" ;
      s + "pj" => s + "p" ;
      s + "k"  => s + "c" ;
      s + "g"  => s + "dz" ;
      _        => stem2
    } ;

  -- Ref. to the Java implementation: mija11
  -- stem3: VInd P1 Sg Past
  pal_C1_3 : Str -> Str = \stem3 ->
    case stem3 of {
      s + "c"  => s + "k" ;
      s + "dz" => s + "g" ;
      _        => stem3
    } ;

  -- Ref. to the Java implementation: mija14
  -- stem: VInd P1 Sg Pres | VInd P1 Sg Past
  pal_C1_4 : Str -> Str = \stem ->
    case stem of {
      s + "k" => s + "c" ;
      s + "t" => s + "ti" ;
      _       => stem
    } ;

  -- Ref. to the Java implementation: mija2
  pal_C3_1 : Str -> Str = \stem ->
    case stem of {
      s + "cī" => s + "k" ;
      _        => Predef.tk 1 stem
    } ;

  -- Ref. to the Java implementation: mija2a
  pal_C3_2 : Str -> Str -> Str = \stem,ending ->
    case stem of {
      _ + "ī"   => "ā" + Predef.dp 1 ending ;
      _ + "inā" => "ā" + Predef.dp 1 ending ;
      _         => ending
    } ;

  -- Ref. to the Java implementation: mija5
  pal_C3_3 : Str -> Str = \stem -> "jā" + pal_C3_5 stem ;

  -- Ref. to the Java implementation: mija8
  pal_C3_4 : Str -> Str = \stem ->
    case stem of {
      s + "inā" => stem ;
      s + "cī"  => s + "kā" ;
      s + "ī"   => s + "ā" ;
      s + "ē"   => s + "a" ;
      _         => stem
    } ;

  -- Ref. to the Java implementation: mija9
  pal_C3_5 : Str -> Str = \stem ->
    case stem of {
      s + "dā"  => Predef.tk 1 stem ;
      s + "ā"   => s + "a" ;
      s + "ācī" => s + "āca" ; -- e.g. 'mācīt' => 'māca'
      s + "īcī" => s + "īca" ; -- e.g. 'mīcīt' => 'mīca'
      s + "cī"  => s + "ka" ; -- e.g. 'sacīt' => 'saka'
      s + "ī"   => s + "a" ;
      _         => Predef.tk 1 stem
    } ;

  -- Ref. to the Java implementation: mija12
  pal_C3_6 : Str -> Str = \stem ->
    "jā" +
    case stem of {
      s + "cī"  => s + "kā" ;
      s + "ī"   => s + "ā" ;
      s + "inā" => s + "inā" ;
      _         => Predef.tk 1 stem + "a"
    } ;


  -- Participles: non-declinable and partially declinable participles, nominative cases of declinable participles
  -- Declinable participles: syntactic function - attribute => category - adjective
  -- TODO: declinable participles => adjectives
  -- TODO: -ot, -am, -ām; -dams/dama, -damies/damās; -ams/ama, -āms/āma
  -- -ošs/oša ir tikai adjektīvi! Divdabji - tikai verbālās formas! (sk. Baibas sarakstu)

  mkParticiple_IsUsi : Gender -> Number -> Case -> Str -> Str = \g,n,c,stem ->
    case g of {
      Masc => case n of {
        Sg => case c of {
          Nom => stem + "is" ;
          Gen => stem + "uša" ;
          Dat => stem + "ušam" ;
          Acc => stem + "ušu" ;
          Loc => stem + "ušā" ;
          Voc => NON_EXISTENT
        } ;
        Pl => case c of {
          Nom => stem + "uši" ;
          Gen => stem + "ušu" ;
          Dat => stem + "ušiem" ;
          Acc => stem + "ušus" ;
          Loc => stem + "ušos" ;
          Voc => NON_EXISTENT
        }
      } ;
      Fem => case n of {
        Sg => case c of {
          Nom => stem + "usi" ;
          Gen => stem + "ušas" ;
          Dat => stem + "ušai" ;
          Acc => stem + "ušu" ;
          Loc => stem + "ušā" ;
          Voc => NON_EXISTENT
        } ;
        Pl => case c of {
          Nom => stem + "ušas" ;
          Gen => stem + "ušu" ;
          Dat => stem + "ušām" ;
          Acc => stem + "ušas" ;
          Loc => stem + "ušās" ;
          Voc => NON_EXISTENT
        }
      }
    } ;

  mkParticiple_TsTa : Gender -> Number -> Case -> Str -> Str = \g,n,c,stem ->
    case g of {
      Masc => case n of {
        Sg => case c of {
          Nom => stem + "ts" ;
          Gen => stem + "ta" ;
          Dat => stem + "tam" ;
          Acc => stem + "tu" ;
          Loc => stem + "tā" ;
          Voc => NON_EXISTENT     -- FIXME: -tais ?
        } ;
        Pl => case c of {
          Nom => stem + "ti" ;
          Gen => stem + "tu" ;
          Dat => stem + "tiem" ;
          Acc => stem + "tus" ;
          Loc => stem + "tos" ;
          Voc => NON_EXISTENT     -- FIXME: -tie ?
        }
      } ;
      Fem => case n of {
        Sg => case c of {
          Nom => stem + "ta" ;
          Gen => stem + "tas" ;
          Dat => stem + "tai" ;
          Acc => stem + "tu" ;
          Loc => stem + "tā" ;
          Voc => NON_EXISTENT     -- FIXME: -tā ?
        } ;
        Pl => case c of {
          Nom => stem + "tas" ;
          Gen => stem + "tu" ;
          Dat => stem + "tām" ;
          Acc => stem + "tas" ;
          Loc => stem + "tās" ;
          Voc => NON_EXISTENT     -- FIXME: -tās ?
        }
      }
    } ;

  mkParticiple_IesUsies : Gender -> Number -> Case -> Str -> Str = \g,n,c,stem ->
    case g of {
      Masc => case n of {
        Sg => case c of {
          Nom => stem + "ies" ;
          Gen => NON_EXISTENT ;
          Dat => NON_EXISTENT ;
          Acc => stem + "ušos" ;
          Loc => NON_EXISTENT ;
          Voc => NON_EXISTENT
        } ;
        Pl => case c of {
          Nom => stem + "ušies" ;
          Gen => stem + "ušos" ;
          Dat => NON_EXISTENT ;
          Acc => stem + "ušos" ;
          Loc => NON_EXISTENT ;
          Voc => NON_EXISTENT
        }
      } ;
      Fem => case n of {
        Sg => case c of {
          Nom => stem + "usies" ;
          Gen => stem + "ušās" ;
          Dat => NON_EXISTENT ;
          Acc => stem + "ušos" ;
          Loc => NON_EXISTENT ;
          Voc => NON_EXISTENT
        } ;
        Pl => case c of {
          Nom => stem + "ušās" ;
          Gen => stem + "ušos" ;
          Dat => NON_EXISTENT ;
          Acc => stem + "ušos" ;
          Loc => NON_EXISTENT ;
          Voc => NON_EXISTENT
        }
      }
    } ;

} ;
