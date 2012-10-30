--# -path=.:../abstract:../common:../prelude

resource ParadigmsVerbsLav = open
  (Predef=Predef),
  Prelude,
  ResLav,
  CatLav
  in {

flags
  coding = utf8 ;

oper
  Verb_TMP : Type = {s : VerbForm => Str} ;

  -- Second and third conjugations
  mkVerb : Str -> VerbConj -> Verb = \lemma,conj -> {
    s = table {
      Pos => (mkVerb_Pos lemma conj).s ;
      Neg => (filter_Neg (mkVerb_Pos ("ne"+lemma) conj)).s
    }
  } ;

  -- First conjugation
  mkVerbC1 : Str -> Str -> Str -> Verb = \lemma,lemma2,lemma3 -> {
    s = table {
      Pos => (mkVerbC1_Pos lemma lemma2 lemma3).s ;
      Neg => (filter_Neg (mkVerbC1_Pos ("ne"+lemma) ("ne"+lemma2) ("ne"+lemma3))).s
    }
  } ;

  mkVerb_Pos : Str -> VerbConj -> Verb_TMP = \lemma,conj ->
    case lemma of {
      -- TODO: "ir" =>
      s + ("t")    => mkRegVerb lemma conj ;
      s + ("ties") => mkReflVerb lemma conj
    } ;

  mkVerbC1_Pos : Str -> Str -> Str -> Verb_TMP = \lemma,lemma2,lemma3 ->
    case lemma of {
      -- TODO: "ir" =>
      s + ("t") => mkVerb_C1 lemma lemma2 lemma3 ;
      s + ("ties") => mkVerb_C1_Refl lemma lemma2 lemma3
    } ;

  mkRegVerb : Str -> VerbConj -> Verb_TMP = \lemma,conj ->
    case conj of {
      C2 => mkVerb_C2 lemma ;
      C3 => mkVerb_C3 lemma
    } ;

  mkReflVerb : Str -> VerbConj -> Verb_TMP = \lemma,conj ->
    case conj of {
      C2 => mkVerb_C2_Refl lemma ;
      C3 => mkVerb_C3_Refl lemma
    } ;

  filter_Neg : Verb_TMP -> Verb_TMP = \full -> {
    s = table {
      Debitive => NON_EXISTENT ;
      DebitiveRelative => NON_EXISTENT ;
      x => full.s ! x
    }
  } ;

  -- First conjugation
  -- Ref. to lexicon.xml (revision 719): 15th paradigm
  -- lemma1: Infinitive
  -- lemma2: Indicative P1 Sg Pres
  -- lemma3: Indicative P1 Sg Past
  mkVerb_C1 : Str -> Str -> Str -> Verb_TMP = \lemma1,lemma2,lemma3 ->
    let
      stem1 : Str = Predef.tk 1 lemma1 ;
      stem2 : Str = Predef.tk 1 lemma2 ;
      stem3 : Str = Predef.tk 1 lemma3
    in {
      s = table {
        Infinitive => lemma1 ; -- stem1 + "t"

        Indicative P1 Sg Pres => lemma2 ; -- stem2 + "u"
        Indicative P1 Sg Fut  => pal_C1_1 stem3 stem1 + "šu" ;
        Indicative P1 Sg Past => lemma3 ; -- stem3 + "u"
        Indicative P1 Pl Pres => stem2 + "am" ;
        Indicative P1 Pl Fut  => pal_C1_1 stem3 stem1 + "sim" ;
        Indicative P1 Pl Past => stem3 + "ām" ;

        Indicative P2 Sg Pres => pal_C1_4 stem2 ;
        Indicative P2 Sg Fut  => pal_C1_1 stem3 stem1 + "si" ;
        Indicative P2 Sg Past => stem3 + "i" ;
        Indicative P2 Pl Pres => stem2 + "at" ;
      --Indicative P2 Pl Fut  => pal_C1_1 stem3 stem1 + ("siet"|"sit") ;
        Indicative P2 Pl Fut  => pal_C1_1 stem3 stem1 + "siet" ;
        Indicative P2 Pl Past => stem3 + "āt" ;

        Indicative P3 _ Pres => stem2 ;
        Indicative P3 _ Fut  => pal_C1_1 stem3 stem1 + "s" ;
        Indicative P3 _ Past => stem3 + "a" ;

        Indicative _ _ Cond => stem1 + "tu" ;

        Relative Pres => stem2 + "ot" ;
        Relative Fut  => pal_C1_1 stem3 stem1 + "šot" ;
        Relative Past => NON_EXISTENT ;
        Relative Cond => NON_EXISTENT ;

        Debitive => "jā" + stem2 ;

        DebitiveRelative => "jā" + stem2 + "ot" ;

        Imperative Sg => pal_C1_4 stem2 ;
        Imperative Pl => pal_C1_4 stem2 + "iet" ;

        Participle IsUsi g n c => mkParticiple_IsUsi g n c (pal_C1_3 stem3) ;
        Participle TsTa  g n c => mkParticiple_TsTa g n c stem1
      }
    } ;

  -- Second conjugation
  -- Ref. to lexicon.xml (revision 719): 16th paradigm
  -- lemma: Infinitive
  mkVerb_C2 : Str -> Verb_TMP = \lemma ->
    let
      stem : Str = Predef.tk 1 lemma
    in {
      s = table {
        Infinitive => lemma ; -- stem + "t"

        Indicative P1 Sg Pres => stem + "ju" ;
        Indicative P1 Sg Fut  => stem + "šu" ;
        Indicative P1 Sg Past => stem + "ju" ;
        Indicative P1 Pl Pres => stem + "jam" ;
        Indicative P1 Pl Fut  => stem + "sim" ;
        Indicative P1 Pl Past => stem + "jām" ;

        Indicative P2 Sg Pres => stem ;
        Indicative P2 Sg Fut  => stem + "si" ;
        Indicative P2 Sg Past => stem + "ji" ;
        Indicative P2 Pl Pres => stem + "jat" ;
      --Indicative P2 Pl Fut  => stem + ("siet"|"sit") ;
        Indicative P2 Pl Fut  => stem + "siet" ;
        Indicative P2 Pl Past => stem + "jāt" ;

        Indicative P3 _ Pres => stem ;
        Indicative P3 _ Fut  => stem + "s" ;
        Indicative P3 _ Past => stem + "ja" ;

        Indicative _ _ Cond => stem + "tu" ;

        Relative Pres => stem + "jot" ;
        Relative Fut  => stem + "šot" ;
        Relative Past => NON_EXISTENT ;
        Relative Cond => NON_EXISTENT ;

        Debitive => "jā" + stem ;

        DebitiveRelative => "jā" + stem + "jot" ;

        Imperative Sg => stem ;
        Imperative Pl => stem + "jiet" ;

        Participle IsUsi g n c => mkParticiple_IsUsi g n c (stem + "j") ;
        Participle TsTa  g n c => mkParticiple_TsTa g n c stem
      }
    } ;

  -- Third conjugation
  -- Ref. to lexicon.xml (revision 719): 17th paradigm
  -- lemma: Infinitive
  mkVerb_C3 : Str -> Verb_TMP = \lemma ->
    let
      stem : Str = Predef.tk 1 lemma
    in {
      s = table {
        Infinitive => lemma ; -- stem + "t"

        Indicative P1 Sg Pres => pal_C3_1 stem + "u" ;
        Indicative P1 Sg Fut  => stem + "šu" ;
        Indicative P1 Sg Past => stem + "ju" ;
        Indicative P1 Pl Pres => pal_C3_1 stem + pal_C3_2 stem "am" ;
        Indicative P1 Pl Fut  => stem + "sim" ;
        Indicative P1 Pl Past => stem + "jām" ;

        Indicative P2 Sg Pres => pal_C3_1 stem + "i" ;
        Indicative P2 Sg Fut  => stem + "si" ;
        Indicative P2 Sg Past => stem + "ji" ;
        Indicative P2 Pl Pres => pal_C3_1 stem + pal_C3_2 stem "at" ;
      --Indicative P2 Pl Fut  => stem + ("siet"|"sit") ;
        Indicative P2 Pl Fut  => stem + "siet" ;
        Indicative P2 Pl Past => stem + "jāt" ;

        Indicative P3 _ Pres => pal_C3_5 stem ;
        Indicative P3 _ Fut  => stem + "s" ;
        Indicative P3 _ Past => stem + "ja" ;

        Indicative _ _ Cond => stem + "tu" ;

        Relative Pres => pal_C3_1 stem + "ot" ;
        Relative Fut  => stem + "šot" ;
        Relative Past => NON_EXISTENT ;
        Relative Cond => NON_EXISTENT ;

        Debitive => pal_C3_3 stem ;

        DebitiveRelative => pal_C3_3 stem + "ot" ;

        Imperative Sg => pal_C3_1 stem + "i" ;
        Imperative Pl => pal_C3_1 stem + "iet" ;

        Participle IsUsi g n c => mkParticiple_IsUsi g n c (stem + "j") ;
        Participle TsTa  g n c => mkParticiple_TsTa g n c stem
      }
    } ;

  -- First conjugation: reflexive
  -- Ref. to lexicon.xml (revision 719): 18th paradigm
  -- lemma1: Infinitive
  -- lemma2: Indicative P1 Sg Pres
  -- lemma3: Indicative P1 Sg Past
  mkVerb_C1_Refl : Str -> Str -> Str -> Verb_TMP = \lemma1,lemma2,lemma3 ->
    let
      stem1 : Str = Predef.tk 4 lemma1 ;
      stem2 : Str = Predef.tk 2 lemma2 ;
      stem3 : Str = Predef.tk 2 lemma3
    in {
      s = table {
        Infinitive => lemma1 ; -- stem + "ties"

        Indicative P1 Sg Pres => lemma2 ; -- stem2 + "os"
        Indicative P1 Sg Fut  => pal_C1_1 stem3 stem1 + "šos" ;
        Indicative P1 Sg Past => lemma3 ; -- stem3 + "os"
        Indicative P1 Pl Pres => stem2 + "amies" ;
        Indicative P1 Pl Fut  => pal_C1_1 stem3 stem1 + "simies" ;
        Indicative P1 Pl Past => stem3 + "āmies" ;

        Indicative P2 Sg Pres => pal_C1_2 stem3 stem2 + "ies" ;
        Indicative P2 Sg Fut  => pal_C1_1 stem3 stem1 + "sies" ;
        Indicative P2 Sg Past => stem3 + "ies" ;
        Indicative P2 Pl Pres => stem2 + "aties" ;
      --Indicative P2 Pl Fut  => pal_C1_1 stem3 stem1 + ("sieties"|"sities") ;
        Indicative P2 Pl Fut  => pal_C1_1 stem3 stem1 + "sieties" ;
        Indicative P2 Pl Past => stem3 + "āties" ;

        Indicative P3 _ Pres => stem2 + "as" ;
        Indicative P3 _ Fut  => pal_C1_1 stem3 stem1 + "sies" ;
        Indicative P3 _ Past => stem3 + "ās" ;

        Indicative _ _ Cond => stem1 + "tos" ;

        Relative Pres => stem2 + "oties" ;
        Relative Fut  => pal_C1_1 stem3 stem1 + "šoties" ;
        Relative Past => NON_EXISTENT ;
        Relative Cond => NON_EXISTENT ;

        Debitive => "jā" + stem2 + "as" ;

        DebitiveRelative => "jā" + stem2 + "oties" ;

        Imperative Sg => pal_C1_2 stem3 stem2 + "ies" ;
        Imperative Pl => pal_C1_2 stem3 stem2 + "ieties" ;

        Participle IsUsi g n c => mkParticiple_IesUsies g n c (pal_C1_3 stem3) ;
        Participle TsTa  g n c => mkParticiple_TsTa g n c stem1
      }
    } ;

  -- Second conjugation: reflexive
  -- Ref. to lexicon.xml (revision 719): 19th paradigm
  -- lemma: Infinitive
  mkVerb_C2_Refl : Str -> Verb_TMP = \lemma ->
    let
      stem : Str = Predef.tk 4 lemma
    in {
      s = table {
        Infinitive => lemma ; -- stem + "ties"

        Indicative P1 Sg Pres => stem + "jos" ;
        Indicative P1 Sg Fut  => stem + "šos" ;
        Indicative P1 Sg Past => stem + "jos" ;
        Indicative P1 Pl Pres => stem + "jamies" ;
        Indicative P1 Pl Fut  => stem + "simies" ;
        Indicative P1 Pl Past => stem + "jāmies" ;

        Indicative P2 Sg Pres => stem + "jies" ;
        Indicative P2 Sg Fut  => stem + "sies" ;
        Indicative P2 Sg Past => stem + "jies" ;
        Indicative P2 Pl Pres => stem + "jaties" ;
      --Indicative P2 Pl Fut  => stem + ("sieties"|"sities") ;
        Indicative P2 Pl Fut  => stem + "sieties" ;
        Indicative P2 Pl Past => stem + "jāties" ;

        Indicative P3 _ Pres => stem + "jas" ;
        Indicative P3 _ Fut  => stem + "sies" ;
        Indicative P3 _ Past => stem + "jās" ;

        Indicative _ _ Cond => stem + "tos" ;

        Relative Pres => stem + "joties" ;
        Relative Fut  => stem + "šoties" ;
        Relative Past => NON_EXISTENT ;
        Relative Cond => NON_EXISTENT ;

        Debitive => "jā" + stem + "jas" ;

        DebitiveRelative => "jā" + stem + "joties" ;

        Imperative Sg => stem + "jies" ;
        Imperative Pl => stem + "jieties" ;

        Participle IsUsi g n c => mkParticiple_IesUsies g n c (stem + "j") ;
        Participle TsTa  g n c => mkParticiple_TsTa g n c stem
      }
    } ;

  -- Third conjugation: reflexive
  -- Ref. to lexicon.xml (revision 719): 20th paradigm
  -- lemma: Infinitive
  mkVerb_C3_Refl : Str -> Verb_TMP = \lemma ->
    let
      stem : Str = Predef.tk 4 lemma
    in {
      s = table {
        Infinitive => lemma ; -- stem + "ties"

        Indicative P1 Sg Pres => pal_C3_1 stem + "os" ;
        Indicative P1 Sg Fut  => stem + "šos" ;
        Indicative P1 Sg Past => stem + "jos" ;
        Indicative P1 Pl Pres => pal_C3_4 stem + "mies" ;
        Indicative P1 Pl Fut  => stem + "simies" ;
        Indicative P1 Pl Past => stem + "jāmies" ;

        Indicative P2 Sg Pres => pal_C3_1 stem + "ies" ;
        Indicative P2 Sg Fut  => stem + "sies" ;
        Indicative P2 Sg Past => stem + "jies" ;
        Indicative P2 Pl Pres => pal_C3_4 stem + "ties" ;
      --Indicative P2 Pl Fut  => stem + ("sieties"|"sities") ;
        Indicative P2 Pl Fut  => stem + "sieties" ;
        Indicative P2 Pl Past => stem + "jāties" ;

        Indicative P3 _ Pres => pal_C3_4 stem + "s" ;
        Indicative P3 _ Fut  => stem + "sies" ;
        Indicative P3 _ Past => stem + "jās" ;

        Indicative _ _ Cond => stem + "tos" ;

        Relative Pres => pal_C3_1 stem + "oties" ;
        Relative Fut  => stem + "šoties" ;
        Relative Past => NON_EXISTENT ;
        Relative Cond => NON_EXISTENT ;

        Debitive => pal_C3_6 stem + "s" ;

        DebitiveRelative => pal_C3_6 stem + "oties" ;

        Imperative Sg => pal_C3_1 stem + "ies" ;
        Imperative Pl => pal_C3_1 stem + "ieties" ;

        Participle IsUsi g n c => mkParticiple_IesUsies g n c (stem + "j") ;
        Participle TsTa  g n c => mkParticiple_TsTa g n c stem
      }
    } ;

  mkVerb_Irreg : Str -> Verb = \lemma ->
    case lemma of {
      "būt"   => mkVerb_Irreg_Be ;
      "iet"   => mkVerb_Irreg_Go ;
      #prefix + "iet"   => mkVerb_Irreg_Go_Prefix (Predef.tk 3 lemma) ;
      "gulēt" => mkVerb_Irreg_Sleep  -- FIXME: Should be treated as a regular verb (C3: gulēt, sēdēt etc.)
      -- TODO: add "dot"/Give (+prefix, +refl)
      -- TODO: multiple prefixes
      -- TODO: move to IrregLav?
    } ;

  mkVerb_Irreg_Be : Verb = {
    s = table {
      Pos => table {
        Indicative P1 Sg Pres => "esmu" ;
        Indicative P2 Sg Pres => "esi" ;
        Indicative P3 _  Pres => "ir" ;

        Debitive => "jābūt" ;

        x => (mkVerb_C1 "būt" "esu" "biju").s ! x -- the incorrect 'esu' will be overriden
      } ;
      Neg => table {
        Indicative P1 Sg Pres => "neesmu" ;
        Indicative P2 Sg Pres => "neesi" ;
        Indicative P3 _  Pres => "nav" ;

        Debitive => NON_EXISTENT ;

        DebitiveRelative => NON_EXISTENT ;

        x => (mkVerb_C1 "nebūt" "neesu" "nebiju").s ! x -- the incorrect 'neesu' will be overriden
      }
    }
  } ;

  mkVerb_Irreg_Go : Verb = mkVerb_Irreg_Go_Prefix "" ;

  mkVerb_Irreg_Go_Prefix : Str -> Verb = \pref -> {
    s = table {
      Pos => table {
        Indicative P3 _ Pres => pref + "iet" ;
        Debitive => "jā" + pref + "iet" ;
        x => (mkVerb_C1 (pref + "iet") (pref + "eju") (pref + "gāju")).s ! x
      } ;
      Neg => table {
        Indicative P3 _ Pres => "ne" + pref + "iet" ;
        Debitive => NON_EXISTENT ;
        DebitiveRelative => NON_EXISTENT ;
        x => (mkVerb_C1 ("ne" + pref + "iet") ("ne" + pref + "eju") ("ne" + pref + "gāju")).s ! x
      }
    }
  } ;

  mkVerb_Irreg_Sleep : Verb = {
    s = table {
      Pos => table {
        Indicative P2 Sg Pres => (mkVerb_C3 "gulēt").s ! Indicative P2 Sg Pres ;
        Indicative p  n  Pres => (mkVerb_C3 "guļēt").s ! Indicative p n Pres ;

        -- FIXME: Here and there, the incorrect 'guļēt' contains intentional palatalization

        Relative Pres => (mkVerb_C3 "guļēt").s ! Relative Pres ;

        Debitive => (mkVerb_C3 "guļēt").s ! Debitive ;

        DebitiveRelative => (mkVerb_C3 "guļēt").s ! DebitiveRelative ;

        x => (mkVerb_C3 "gulēt").s ! x
      } ;
      Neg => table {
        Indicative P2 Sg Pres => (mkVerb_C3 "negulēt").s ! Indicative P2 Sg Pres ;
        Indicative p  n  Pres => (mkVerb_C3 "neguļēt").s ! Indicative p n Pres ;

        Relative Pres => (mkVerb_C3 "neguļēt").s ! Relative Pres ;

        Debitive => NON_EXISTENT ;

        DebitiveRelative => NON_EXISTENT ;

        x => (mkVerb_C3 "negulēt").s ! x
      }
    }
  } ;

  -- Auxiliaries: palatalization rules

  -- Ref. to the Java implementation: mija6
  -- stem3: Indicative P1 Sg Past
  -- stem1: Infinitive
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
  -- stem3: Indicative P1 Sg Past
  -- stem2: Indicative P1 Sg Pres
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
  -- stem3: Indicative P1 Sg Past
  pal_C1_3 : Str -> Str = \stem3 ->
    case stem3 of {
      s + "c"  => s + "k" ;
      s + "dz" => s + "g" ;
      _        => stem3
    } ;

  -- Ref. to the Java implementation: mija14
  -- stem: Indicative P1 Sg Pres | Indicative P1 Sg Past
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
