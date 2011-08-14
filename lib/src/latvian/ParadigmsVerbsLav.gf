-- Latvian verb paradigms - by Pēteris Paikens & Normunds Grūzītis, copied off mini-grammar as of 2011-07-12

resource ParadigmsVerbsLav = open 
  (Predef=Predef), 
  Prelude, 
  ResLav,
  CatLav
  in {

flags
  coding = utf8;
  
oper
  Verb     : Type = {s : Polarity => VerbForm => Str} ;
  Verb_TMP : Type = {s : VerbForm => Str} ;

-- VERBS

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
      s + ("ties") => mkVerb_C1_R lemma lemma2 lemma3
    } ;

  mkRegVerb : Str -> VerbConj -> Verb_TMP = \lemma,conj ->
    case conj of {
      C2 => mkVerb_C2 lemma ;
      C3 => mkVerb_C3 lemma
    } ;

  mkReflVerb : Str -> VerbConj -> Verb_TMP = \lemma,conj ->
    case conj of {
      C2 => mkVerb_C2_R lemma ;
      C3 => mkVerb_C3_R lemma
    } ;

  filter_Neg : Verb_TMP -> Verb_TMP = \full -> {
    s = table {
      Debitive => NON_EXISTENT ;
      DebitiveRelative => NON_EXISTENT ;
      x => full.s ! x
    }
  } ;

  -- First conjugation
  -- Ref. to Lexicon.xml (revision 719): 15. paradigma
  mkVerb_C1 : Str -> Str -> Str -> Verb_TMP = \lemma,lemma2,lemma3 ->
    let
      stem  : Str = Predef.tk 1 lemma  ;
      stem2 : Str = Predef.tk 1 lemma2 ;
      stem3 : Str = Predef.tk 1 lemma3
    in {
      s = table {
        Infinitive => stem + "t" ;

        Indicative P1 Sg Pres => stem2 + "u" ;
        Indicative P1 Sg Fut  => pal_C1_1 stem3 stem + "šu" ;
        Indicative P1 Sg Past    => stem3 + "u" ;
        Indicative P1 Pl Pres => stem2 + "am" ;
        Indicative P1 Pl Fut  => pal_C1_1 stem3 stem + "sim" ;
        Indicative P1 Pl Past    => stem3 + "ām" ;

        Indicative P2 Sg Pres => pal_C1_2 stem3 stem2 ;
        Indicative P2 Sg Fut  => pal_C1_1 stem3 stem + "si" ;
        Indicative P2 Sg Past    => stem3 + "i" ;
        Indicative P2 Pl Pres => stem2 + "at" ;
        Indicative P2 Pl Fut  => pal_C1_1 stem3 stem + ("siet"|"sit") ;
        Indicative P2 Pl Past    => stem3 + "āt" ;

        Indicative P3 _ Pres => stem2 ;
        Indicative P3 _ Fut  => pal_C1_1 stem3 stem + "s" ;
        Indicative P3 _ Past    => stem3 + "a" ;

		Indicative _ _ Cond  => stem + "tu";		

        Relative Pres => stem2 + "ot" ;
        Relative Fut  => pal_C1_1 stem3 stem + "šot" ;
        Relative Past    => NON_EXISTENT ;
        Relative Cond    => NON_EXISTENT ;

        Debitive => "jā" + stem2 ;
        DebitiveRelative => "jā" + stem2 + "ot" ;

        Participle Masc Sg Nom => pal_C1_4 stem3 + "is" ;
        Participle Masc Sg Gen => pal_C1_3 stem3 + "uša" ;
        Participle Masc Sg Dat => pal_C1_3 stem3 + "ušam" ;
        Participle Masc Sg Acc => pal_C1_3 stem3 + "ušu" ;
        Participle Masc Sg Loc => pal_C1_3 stem3 + "ušā" ;
        Participle Masc Pl Nom => pal_C1_3 stem3 + "uši" ;
        Participle Masc Pl Gen => pal_C1_3 stem3 + "ušu" ;
        Participle Masc Pl Dat => pal_C1_3 stem3 + "ušiem" ;
        Participle Masc Pl Acc => pal_C1_3 stem3 + "ušus" ;
        Participle Masc Pl Loc => pal_C1_3 stem3 + "ušos" ;

        Participle Fem Sg Nom => pal_C1_3 stem3 + "usi" ;
        Participle Fem Sg Gen => pal_C1_3 stem3 + "ušas" ;
        Participle Fem Sg Dat => pal_C1_3 stem3 + "ušai" ;
        Participle Fem Sg Acc => pal_C1_3 stem3 + "ušu" ;
        Participle Fem Sg Loc => pal_C1_3 stem3 + "ušā" ;
        Participle Fem Pl Nom => pal_C1_3 stem3 + "ušas" ;
        Participle Fem Pl Gen => pal_C1_3 stem3 + "ušu" ;
        Participle Fem Pl Dat => pal_C1_3 stem3 + "ušām" ;
        Participle Fem Pl Acc => pal_C1_3 stem3 + "ušas" ;
        Participle Fem Pl Loc => pal_C1_3 stem3 + "ušās"
      }
    } ;

  -- Second conjugation
  -- Ref. to Lexicon.xml (revision 719): 16. paradigma
  mkVerb_C2 : Str -> Verb_TMP = \lemma ->
    let stem : Str = Predef.tk 1 lemma
    in {
      s = table {
        Infinitive => stem + "t" ;

        Indicative P1 Sg Pres => stem + "ju" ;
        Indicative P1 Sg Fut  => stem + "šu" ;
        Indicative P1 Sg Past    => stem + "ju" ;
        Indicative P1 Pl Pres => stem + "jam" ;
        Indicative P1 Pl Fut  => stem + "sim" ;
        Indicative P1 Pl Past    => stem + "jām" ;

        Indicative P2 Sg Pres => stem ;
        Indicative P2 Sg Fut  => stem + "si" ;
        Indicative P2 Sg Past    => stem + "ji" ;
        Indicative P2 Pl Pres => stem + "jat" ;
        Indicative P2 Pl Fut  => stem + ("siet"|"sit") ;
        Indicative P2 Pl Past    => stem + "jāt" ;

        Indicative P3 _ Pres => stem ;
        Indicative P3 _ Fut  => stem + "s" ;
        Indicative P3 _ Past    => stem + "ja" ;

		Indicative _ _ Cond  => stem + "tu";		

        Relative Pres => stem + "jot" ;
        Relative Fut  => stem + "šot" ;
        Relative Past    => NON_EXISTENT ;
        Relative Cond    => NON_EXISTENT ;

        Debitive => "jā" + stem ;
        DebitiveRelative => "jā" + stem + "jot" ;

        Participle Masc Sg Nom => stem + "jis" ;
        Participle Masc Sg Gen => stem + "juša" ;
        Participle Masc Sg Dat => stem + "jušam" ;
        Participle Masc Sg Acc => stem + "jušu" ;
        Participle Masc Sg Loc => stem + "jušā" ;
        Participle Masc Pl Nom => stem + "juši" ;
        Participle Masc Pl Gen => stem + "jušu" ;
        Participle Masc Pl Dat => stem + "jušiem" ;
        Participle Masc Pl Acc => stem + "jušus" ;
        Participle Masc Pl Loc => stem + "jušos" ;

        Participle Fem Sg Nom => stem + "jusi" ;
        Participle Fem Sg Gen => stem + "jušas" ;
        Participle Fem Sg Dat => stem + "jušai" ;
        Participle Fem Sg Acc => stem + "jušu" ;
        Participle Fem Sg Loc => stem + "jušā" ;
        Participle Fem Pl Nom => stem + "jušas" ;
        Participle Fem Pl Gen => stem + "jušu" ;
        Participle Fem Pl Dat => stem + "jušām" ;
        Participle Fem Pl Acc => stem + "jušas" ;
        Participle Fem Pl Loc => stem + "jušās"
      }
    } ;

  -- Third conjugation
  -- Ref. to Lexicon.xml (revision 719): 17. paradigma
  mkVerb_C3 : Str -> Verb_TMP = \lemma ->
    let stem : Str = Predef.tk 1 lemma
    in {
      s = table {
        Infinitive => stem + "t" ;

        Indicative P1 Sg Pres => pal_C3_1 stem + "u" ;
        Indicative P1 Sg Fut  => stem + "šu" ;
        Indicative P1 Sg Past    => stem + "ju" ;
        Indicative P1 Pl Pres => pal_C3_1 stem + pal_C3_2 stem "am" ;
        Indicative P1 Pl Fut  => stem + "sim" ;
        Indicative P1 Pl Past    => stem + "jām" ;

        Indicative P2 Sg Pres => pal_C3_1 stem + "i" ;
        Indicative P2 Sg Fut  => stem + "si" ;
        Indicative P2 Sg Past    => stem + "ji" ;
        Indicative P2 Pl Pres => pal_C3_1 stem + pal_C3_2 stem "at" ;
        Indicative P2 Pl Fut  => stem + ("siet"|"sit") ;
        Indicative P2 Pl Past    => stem + "jāt" ;

        Indicative P3 _ Pres => pal_C3_5 stem ;
        Indicative P3 _ Fut  => stem + "s" ;
        Indicative P3 _ Past    => stem + "ja" ;

		Indicative _ _ Cond  => stem + "tu";		

        Relative Pres => pal_C3_1 stem + "ot" ;
        Relative Fut  => stem + "šot" ;
        Relative Past    => NON_EXISTENT ;
        Relative Cond    => NON_EXISTENT ;

        Debitive => pal_C3_3 stem ;
        DebitiveRelative => pal_C3_3 stem + "ot" ;

        Participle Masc Sg Nom => stem + "jis" ;
        Participle Masc Sg Gen => stem + "juša" ;
        Participle Masc Sg Dat => stem + "jušam" ;
        Participle Masc Sg Acc => stem + "jušu" ;
        Participle Masc Sg Loc => stem + "jušā" ;
        Participle Masc Pl Nom => stem + "juši" ;
        Participle Masc Pl Gen => stem + "jušu" ;
        Participle Masc Pl Dat => stem + "jušiem" ;
        Participle Masc Pl Acc => stem + "jušus" ;
        Participle Masc Pl Loc => stem + "jušos" ;

        Participle Fem Sg Nom => stem + "jusi" ;
        Participle Fem Sg Gen => stem + "jušas" ;
        Participle Fem Sg Dat => stem + "jušai" ;
        Participle Fem Sg Acc => stem + "jušu" ;
        Participle Fem Sg Loc => stem + "jušā" ;
        Participle Fem Pl Nom => stem + "jušas" ;
        Participle Fem Pl Gen => stem + "jušu" ;
        Participle Fem Pl Dat => stem + "jušām" ;
        Participle Fem Pl Acc => stem + "jušas" ;
        Participle Fem Pl Loc => stem + "jušās"
      }
    } ;

  -- First conjugation: reflexive verbs
  -- Ref. to Lexicon.xml (revision 719): 18. paradigma
  mkVerb_C1_R : Str -> Str -> Str -> Verb_TMP = \lemma,lemma2,lemma3 ->
    let
      stem  : Str = Predef.tk 4 lemma  ;
      stem2 : Str = Predef.tk 2 lemma2 ;
      stem3 : Str = Predef.tk 2 lemma3
    in {
      s = table {
        Infinitive => stem + "ties" ;

        Indicative P1 Sg Pres => stem2 + "os" ;
        Indicative P1 Sg Fut  => pal_C1_1 stem3 stem + "šos" ;
        Indicative P1 Sg Past    => stem3 + "os" ;
        Indicative P1 Pl Pres => stem2 + "amies" ;
        Indicative P1 Pl Fut  => pal_C1_1 stem3 stem + "simies" ;
        Indicative P1 Pl Past    => stem3 + "āmies" ;

        Indicative P2 Sg Pres => pal_C1_2 stem3 stem2 + "ies" ;
        Indicative P2 Sg Fut  => pal_C1_1 stem3 stem + "sies" ;
        Indicative P2 Sg Past    => stem3 + "ies" ;
        Indicative P2 Pl Pres => stem2 + "aties" ;
        Indicative P2 Pl Fut  => pal_C1_1 stem3 stem + ("sieties"|"sities") ;
        Indicative P2 Pl Past    => stem3 + "āties" ;

        Indicative P3 _ Pres => stem2 + "as" ;
        Indicative P3 _ Fut  => pal_C1_1 stem3 stem + "sies" ;
        Indicative P3 _ Past    => stem3 + "ās" ;

		Indicative _ _ Cond  => stem + "tos";		

        Relative Pres => stem2 + "oties" ;
        Relative Fut  => pal_C1_1 stem3 stem + "šoties" ;
        Relative Past    => NON_EXISTENT ;
        Relative Cond    => NON_EXISTENT ;

        Debitive => "jā" + stem2 + "as" ;
        DebitiveRelative => "jā" + stem2 + "oties" ;

        Participle Masc Sg Nom => pal_C1_4 stem3 + "ies" ;
        Participle Masc Sg Gen => NON_EXISTENT ;
        Participle Masc Sg Dat => NON_EXISTENT ;
        Participle Masc Sg Acc => pal_C1_3 stem3 + "ušos" ;
        Participle Masc Sg Loc => NON_EXISTENT ;
        Participle Masc Pl Nom => pal_C1_3 stem3 + "ušies" ;
        Participle Masc Pl Gen => pal_C1_3 stem3 + "ušos" ;
        Participle Masc Pl Dat => NON_EXISTENT ;
        Participle Masc Pl Acc => pal_C1_3 stem3 + "ušos" ;
        Participle Masc Pl Loc => NON_EXISTENT ;

        Participle Fem Sg Nom => pal_C1_3 stem3 + "usies" ;
        Participle Fem Sg Gen => pal_C1_3 stem3 + "ušās" ;
        Participle Fem Sg Dat => NON_EXISTENT ;
        Participle Fem Sg Acc => pal_C1_3 stem3 + "ušos" ;
        Participle Fem Sg Loc => NON_EXISTENT ;
        Participle Fem Pl Nom => pal_C1_3 stem3 + "ušās" ;
        Participle Fem Pl Gen => pal_C1_3 stem3 + "ušos" ;
        Participle Fem Pl Dat => NON_EXISTENT ;
        Participle Fem Pl Acc => pal_C1_3 stem3 + "ušos" ;
        Participle Fem Pl Loc => NON_EXISTENT
      }
    } ;

  -- Second conjugation: reflexive verbs
  -- Ref. to Lexicon.xml (revision 719): 19. paradigma
  mkVerb_C2_R : Str -> Verb_TMP = \lemma ->
    let stem : Str = Predef.tk 4 lemma
    in {
      s = table {
        Infinitive => stem + "ties" ;

        Indicative P1 Sg Pres => stem + "jos" ;
        Indicative P1 Sg Fut  => stem + "šos" ;
        Indicative P1 Sg Past    => stem + "jos" ;
        Indicative P1 Pl Pres => stem + "jamies" ;
        Indicative P1 Pl Fut  => stem + "simies" ;
        Indicative P1 Pl Past    => stem + "jāmies" ;

        Indicative P2 Sg Pres => stem + "jies" ;
        Indicative P2 Sg Fut  => stem + "sies" ;
        Indicative P2 Sg Past    => stem + "jies" ;
        Indicative P2 Pl Pres => stem + "jaties" ;
        Indicative P2 Pl Fut  => stem + ("sieties"|"sities") ;
        Indicative P2 Pl Past    => stem + "jāties" ;

        Indicative P3 _ Pres => stem + "jas" ;
        Indicative P3 _ Fut  => stem + "sies" ;
        Indicative P3 _ Past    => stem + "jās" ;

		Indicative _ _ Cond  => stem + "tos";		

        Relative Pres => stem + "joties" ;
        Relative Fut  => stem + "šoties" ;
        Relative Past    => NON_EXISTENT ;
        Relative Cond    => NON_EXISTENT ;

        Debitive => "jā" + stem + "jas" ;
        DebitiveRelative => "jā" + stem + "joties" ;

        Participle Masc Sg Nom => stem + "jies" ;
        Participle Masc Sg Gen => NON_EXISTENT ;
        Participle Masc Sg Dat => NON_EXISTENT ;
        Participle Masc Sg Acc => stem + "jušos" ;
        Participle Masc Sg Loc => NON_EXISTENT ;
        Participle Masc Pl Nom => stem + "jušies" ;
        Participle Masc Pl Gen => stem + "jušos" ;
        Participle Masc Pl Dat => NON_EXISTENT ;
        Participle Masc Pl Acc => stem + "jušos" ;
        Participle Masc Pl Loc => NON_EXISTENT ;

        Participle Fem Sg Nom => stem + "jusies" ;
        Participle Fem Sg Gen => stem + "jušās" ;
        Participle Fem Sg Dat => NON_EXISTENT ;
        Participle Fem Sg Acc => stem + "jušos" ;
        Participle Fem Sg Loc => NON_EXISTENT ;
        Participle Fem Pl Nom => stem + "jušās" ;
        Participle Fem Pl Gen => stem + "jušos" ;
        Participle Fem Pl Dat => NON_EXISTENT ;
        Participle Fem Pl Acc => stem + "jušās" ;
        Participle Fem Pl Loc => NON_EXISTENT
      }
    } ;

  -- Third conjugation: reflexive verbs
  -- Ref. to Lexicon.xml (revision 719): 20. paradigma
  mkVerb_C3_R : Str -> Verb_TMP = \lemma ->
    let stem : Str = Predef.tk 4 lemma
    in {
      s = table {
        Infinitive => stem + "ties" ;

        Indicative P1 Sg Pres => pal_C3_1 stem + "os" ;
        Indicative P1 Sg Fut  => stem + "šos" ;
        Indicative P1 Sg Past    => stem + "jos" ;
        Indicative P1 Pl Pres => pal_C3_4 stem + "mies" ;
        Indicative P1 Pl Fut  => stem + "simies" ;
        Indicative P1 Pl Past    => stem + "jāmies" ;

        Indicative P2 Sg Pres => pal_C3_1 stem + "ies" ;
        Indicative P2 Sg Fut  => stem + "sies" ;
        Indicative P2 Sg Past    => stem + "jies" ;
        Indicative P2 Pl Pres => pal_C3_4 stem + "ties" ;
        Indicative P2 Pl Fut  => stem + ("sieties"|"sities") ;
        Indicative P2 Pl Past    => stem + "jāties" ;

        Indicative P3 _ Pres => pal_C3_4 stem + "s" ;
        Indicative P3 _ Fut  => stem + "sies" ;
        Indicative P3 _ Past    => stem + "jās" ;

		Indicative _ _ Cond  => stem + "tos";		

        Relative Pres => pal_C3_1 stem + "oties" ;
        Relative Fut  => stem + "šoties" ;
        Relative Past    => NON_EXISTENT ;
        Relative Cond    => NON_EXISTENT ;

        Debitive => pal_C3_6 stem + "s" ;
        DebitiveRelative => pal_C3_6 stem + "oties" ;

        Participle Masc Sg Nom => stem + "jies" ;
        Participle Masc Sg Gen => NON_EXISTENT ;
        Participle Masc Sg Dat => NON_EXISTENT ;
        Participle Masc Sg Acc => stem + "jušos" ;
        Participle Masc Sg Loc => NON_EXISTENT ;
        Participle Masc Pl Nom => stem + "jušies" ;
        Participle Masc Pl Gen => stem + "jušos" ;
        Participle Masc Pl Dat => NON_EXISTENT ;
        Participle Masc Pl Acc => stem + "jušos" ;
        Participle Masc Pl Loc => NON_EXISTENT ;

        Participle Fem Sg Nom => stem + "jusies" ;
        Participle Fem Sg Gen => stem + "jušās" ;
        Participle Fem Sg Dat => NON_EXISTENT ;
        Participle Fem Sg Acc => stem + "jušos" ;
        Participle Fem Sg Loc => NON_EXISTENT ;
        Participle Fem Pl Nom => stem + "jušās" ;
        Participle Fem Pl Gen => stem + "jušos" ;
        Participle Fem Pl Dat => NON_EXISTENT ;
        Participle Fem Pl Acc => stem + "jušās" ;
        Participle Fem Pl Loc => NON_EXISTENT
      }
    } ;

  mkVerb_Irreg : Str -> Verb = \lemma ->
    case lemma of {
      "būt" => mkVerb_toBe
    } ;

  mkVerb_toBe : Verb = {
    s = table {
      Pos => table {
        Indicative P1 Sg Pres => "esmu" ;
        Indicative P2 Sg Pres => "esi" ;
        Indicative P3 _  Pres => "ir" ;
        Debitive => "jābūt" ;
        x => (mkVerb_C1 "būt" "esu" "biju").s ! x			-- the incorrect form 'esu' will be overriden
      } ;
      Neg => table {
        Indicative P1 Sg Pres => "neesmu" ;
        Indicative P2 Sg Pres => "neesi" ;
        Indicative P3 _  Pres => "nav" ;
        Debitive => NON_EXISTENT;
        DebitiveRelative => NON_EXISTENT;
        x => (mkVerb_C1 "nebūt" "neesu" "nebiju").s ! x		-- the incorrect form 'neesu' will be overriden
      }
    }
  } ;

  -- Auxiliaries (palatalization rules)

  -- Ref. to the Java implementation: mija6
  pal_C1_1 : Str -> Str -> Str = \stem3,stem ->
    case stem of {
      s + "s" => case stem3 of {
        _ + "d" => s + "dī" ;
        _ + "t" => s + "tī" ;
        _ + "s" => s + "sī" ;
        _ => stem
      } ;
      _ => stem
    } ;

  -- Ref. to the Java implementation: mija7
  pal_C1_2 : Str -> Str -> Str = \stem3,stem ->
    case stem of {
      s + "š" => case stem3 of {
        _ + "s" => s + "s" ;
        _ => stem
      } ;
      s + "ž"  => s + "d" ;
      s + "ļ"  => s + "l" ;
      s + "mj" => s + "m" ;
      s + "bj" => s + "b" ;
      s + "pj" => s + "p" ;
      s + "k"  => s + "c" ;
      s + "g"  => s + "dz" ;
      _ => stem
    } ;

  -- Ref. to the Java implementation: mija11
  pal_C1_3 : Str -> Str = \stem ->
    case stem of {
      s + "c"  => s + "k" ;
      s + "dz" => s + "g" ;
      _ => stem
    } ;

  -- Ref. to the Java implementation: mija14
  pal_C1_4 : Str -> Str = \stem ->
    case stem of {
      s + "k" => s + "c" ;
      _ => stem
    } ;

  -- Ref. to the Java implementation: mija2
  pal_C3_1 : Str -> Str = \stem ->
    case stem of {
      s + "cī" => s + "k" ;
      _ => Predef.tk 1 stem
    } ;

  -- Ref. to the Java implementation: mija2a
  pal_C3_2 : Str -> Str -> Str = \stem,ending ->
    case stem of {
      _ + "ī"   => "ā" + Predef.dp 1 ending ;
      _ + "inā" => "ā" + Predef.dp 1 ending ;
      _ => ending
    } ;

  -- Ref. to the Java implementation: mija5
  pal_C3_3 : Str -> Str = \stem ->
    "jā" +
    case stem of {
      s + "dā" => s + "d" ;
      s + "ā"  => s + "a" ;
      s + "cī" => s + "ka" ;
      s + "ī"  => s + "a" ;
      _ => Predef.tk 1 stem
    } ;

  -- Ref. to the Java implementation: mija8
  pal_C3_4 : Str -> Str = \stem ->
    case stem of {
      s + "inā" => stem ;
      s + "cī"  => s + "kā" ;		-- e.g. 'sacīt'
      s + "ī"   => s + "ā" ;
      s + "ē"   => s + "a" ;
      _ => stem
    } ;

  -- Ref. to the Java implementation: mija9
  pal_C3_5 : Str -> Str = \stem ->
    case stem of {
      s + "dā" => Predef.tk 1 stem ;
      s + "ā"  => s + "a" ;
      s + "cī" => s + "ka" ;		-- e.g. 'sacīt'
      s + "ī"  => s + "a" ;
      _ => Predef.tk 1 stem
    } ;

  -- Ref. to the Java implementation: mija12
  pal_C3_6 : Str -> Str = \stem ->
    "jā" +
    case stem of {
      s + "cī"  => s + "kā" ;
      s + "ī"   => s + "ā" ;
      s + "inā" => s + "inā" ;
      _ => Predef.tk 1 stem + "a"
    } ;  
	
} ;
