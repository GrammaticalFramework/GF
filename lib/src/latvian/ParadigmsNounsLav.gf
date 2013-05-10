--# -path=.:abstract:common:prelude

resource ParadigmsNounsLav = open ResLav, CatLav, Prelude, Predef in {

flags coding = utf8 ;

oper

  masculine : Gender = Masc ;
  feminine  : Gender = Fem ;

  -- No parameters - default assumptions (gender, declension, palatalization)
  mkNoun : Str -> Noun = \lemma ->
    mkNounByPal lemma True ;

  mkProperNoun : Str -> Number -> ProperNoun = \lemma,num ->
    let n = mkNoun lemma in {
      s = \\c => n.s ! num ! c  ;
      gend = n.gend ;
      num = num
    } ;

{-
  mkCardinalNumeral : Str -> CardinalNumeral = \lemma ->
    let
		stem : Str = cutStem lemma;
		masc = mkNoun_D1 lemma;
		fem = mkNoun_D4 lemma + "a" Fem
	in {
		s = table {
			Masc => table {

			} ;
			Fem => table {
			} ;
		}
	}
-}

  -- Specified palatalization; default gender and declension
  mkNounByPal : Str -> Bool -> Noun = \lemma,pal ->
    case lemma of {
      #exception_D4 + ("a"|"as")      => mkNounByGendPal lemma Masc pal ;
      #exception_D6 + "is"            => mkNounByGendPal lemma Masc pal ;
      s + ("a"|"as"|"e"|"es"|"šanās") => mkNounByGendPal lemma Fem  pal ;
      _                               => mkNounByGendPal lemma Masc pal
    } ;

  -- Specified gender; default declension and palatalization
  mkNounByGend : Str -> Gender -> Noun = \lemma,gend ->
    mkNounByGendPal lemma gend True ;

  -- Specified gender and palatalization; default declension
  mkNounByGendPal : Str -> Gender -> Bool -> Noun = \lemma,gend,pal ->
    let decl : Declension = case lemma of {
      #exception_D2_1 + "s"      => D2 ;
      #exception_D2_1_pal + "i"  => D2 ;
      #exception_D2_2 + "s"      => D2 ;
      #exception_D2_2_pal + "i"  => D2 ;
      #exception_D6 + "is"       => D6 ;
      s + "šanās"                => DR ;
      s + ("š"|"i")              => D1 ;
      s + "is"                   => case gend of {Masc => D2 ; Fem  => D6} ;
      s + "us"                   => D3 ;
      s + "as"                   => D4 ;
      s + "es"                   => D5 ;
      s + "s"                    => case gend of {Masc => D1 ; Fem  => D6} ;
      s + "a"                    => D4 ;
      s + "e"                    => D5 ;
      s + #vowel                 => D0 ;
      _                          => D0
    }
    in mkNounByGendDeclPal lemma gend decl pal ;

  -- Specified declension; default gender and palatalization
  mkNounByDecl : Str -> Declension -> Noun = \lemma,decl ->
    mkNounByDeclPal lemma decl True ;

  -- Specified declension and palatalization; default gender
  mkNounByDeclPal : Str -> Declension -> Bool -> Noun = \lemma,decl,pal ->
    case decl of {
      D0|D1|D2|D3 => mkNounByGendDeclPal lemma Masc decl pal ;
      D4|D5|D6|DR => mkNounByGendDeclPal lemma Fem  decl pal
    } ;

  -- Specified gender and declension; default palatalization
  mkNounByGendDecl : Str -> Gender -> Declension -> Noun = \lemma,gend,decl ->
    mkNounByGendDeclPal lemma gend decl True ;

  -- Specified gender, declension and palatalization - no defaults
  mkNounByGendDeclPal : Str -> Gender -> Declension -> Bool -> Noun = \lemma,gend,decl,pal ->
    case decl of {
      D0 => mkNoun_D0 lemma gend     ;
      D1 => mkNoun_D1 lemma          ;
      D2 => mkNoun_D2 lemma pal      ;
      D3 => mkNoun_D3 lemma          ;
      D4 => mkNoun_D4 lemma gend     ;
      D5 => mkNoun_D5 lemma gend pal ;
      D6 => mkNoun_D6 lemma gend pal ;
      DR => mkNoun_DR lemma
    } ;

  -- Indeclinable noun
  -- Expected endings: #vowel
  mkNoun_D0 : Str -> Gender -> Noun = \lemma,gend -> {
    s = \\_,_ => lemma ;
    gend = gend
  } ;

  -- Expected endings of a D1 lemma:
  --   Sg: -s, -š
  --   Pl: -i
  --       should be provided only in the case of plural mass nouns
  --       produces an incorrect Sg.Nom form if plural lemma is given
  --       the incorrect Sg.Nom forms should be filtered out by a domain lexicon
  mkNoun_D1 : Str -> Noun = \lemma ->
    let stem : Str = cutStem lemma
    in {
      s = table {
        Sg => table {
          Nom => lemma ;
          Gen => stem + "a" ;
          Dat => stem + "am" ;
          Acc => stem + "u" ;
          Loc => stem + "ā" ;
          Voc => stem
        } ;
        Pl => table {
          Nom => stem + "i" ;
          Gen => stem + "u" ;
          Dat => stem + "iem" ;
          Acc => stem + "us" ;
          Loc => stem + "os" ;
          Voc => stem + "i"
        }
      } ;
      gend = Masc
    } ;

  -- Expected endings of a D2 lemma:
  --   Sg: -is, -s
  --       -s is expected only in the case of few predefined exceptions
  --   Pl: -i
  --       should be provided only in the case of plural mass nouns
  --       produces an incorrect Sg.Nom form if plural lemma is given
  --       the incorrect Sg.Nom forms should be filtered out by a domain lexicon
  mkNoun_D2 : Str -> Bool -> Noun = \lemma,pal ->
    let stem : Str = cutStem lemma
    in {
      s = table {
        Sg => table {
          Nom => lemma ;
          Gen => case lemma of {#exception_D2_1 + "s" => lemma ; _ => palatalize stem pal + "a"} ;
          Dat => stem + "im" ;
          Acc => stem + "i" ;
          Loc => stem + "ī" ;
		  Voc => stem + "i"
        } ;
        Pl => table {
          Nom => palatalize stem pal + "i" ;
          Gen => palatalize stem pal + "u" ;
          Dat => palatalize stem pal + "iem" ;
          Acc => palatalize stem pal + "us" ;
          Loc => palatalize stem pal + "os" ;
		  Voc => palatalize stem pal + "i"
        }
      } ;
      gend = Masc
    } ;

  -- Expected endings of a D3 lemma:
  --   Sg: -us
  --   Pl: -i
  mkNoun_D3 : Str -> Noun = \lemma ->
    let stem : Str = cutStem lemma
    in {
      s = table {
        Sg => table {
          Nom => stem + "us" ;
          Gen => stem + "us" ;
          Dat => stem + "um" ;
          Acc => stem + "u" ;
          Loc => stem + "ū" ;
          Voc => stem + "u"
        } ;
        Pl => table {
          Nom => stem + "i" ;
          Gen => stem + "u" ;
          Dat => stem + "iem" ;
          Acc => stem + "us" ;
          Loc => stem + "os" ;
          Voc => stem + "i"
        }
      } ;
      gend = Masc
    } ;

  -- Expected endings of a D4 lemma:
  --   Sg: -a (incl. -šana)
  --   Pl: -as (incl. -šanas)
  mkNoun_D4 : Str -> Gender -> Noun = \lemma,gend ->
    let stem : Str = cutStem lemma
    in {
      s = table {
        Sg => table {
          Nom => stem + "a" ;
          Gen => stem + "as" ;
          Dat => case gend of {Fem => stem + "ai" ; Masc => stem + "am"} ;
          Acc => stem + "u" ;
          Loc => stem + "ā" ;
          Voc => stem + "a"
        } ;
        Pl => table {
          Nom => stem + "as" ;
          Gen => stem + "u" ;
          Dat => stem + "ām" ;
          Acc => stem + "as" ;
          Loc => stem + "ās" ;
          Voc => stem + "as"
        }
      } ;
      gend = gend
    } ;

  -- Expected endings of a D5 lemma:
  --   Sg: -e
  --   Pl: -es
  mkNoun_D5 : Str -> Gender -> Bool -> Noun = \lemma,gend,pal ->
    let stem : Str = cutStem lemma
    in {
      s = table {
        Sg => table {
          Nom => stem + "e" ;
          Gen => stem + "es" ;
          Dat => case gend of {Fem => stem + "ei" ; Masc => stem + "em"} ;
          Acc => stem + "i" ;
          Loc => stem + "ē" ;
          Voc => stem + "e"
        } ;
        Pl => table {
          Nom => stem + "es" ;
          Gen => palatalize stem pal + "u" ;
          Dat => stem + "ēm" ;
          Acc => stem + "es" ;
          Loc => stem + "ēs" ;
          Voc => stem + "es"
        }
      } ;
      gend = gend
    } ;

  -- Expected endings of a D6 lemma:
  --   Sg: -s
  --   Pl: -is
  mkNoun_D6 : Str -> Gender -> Bool -> Noun = \lemma,gend,pal ->
    let stem : Str = cutStem lemma
    in {
      s = table {
        Sg => case stem of {
          #exception_D6 => \\_ => NON_EXISTENT ;
          _ => table {
            Nom => stem + "s" ;
            Gen => stem + "s" ;
            Dat => case gend of {Fem => stem + "ij" ; Masc => stem + "im"} ;
            Acc => stem + "i" ;
            Loc => stem + "ī" ;
            Voc => stem + "s"
          }
        } ;
        Pl => table {
          Nom => stem + "is" ;
          Gen => palatalize stem pal + "u" ;
          Dat => stem + "īm" ;
          Acc => stem + "is" ;
          Loc => stem + "īs" ;
          Voc => stem + "is"
        }
      } ;
      gend = gend
    } ;

  -- Reflexive noun
  -- Expected endings: -šanās
  mkNoun_DR : Str -> Noun = \lemma ->
    let stem : Str = cutStem lemma
    in {
      s = table {
        Sg => table {
          Nom => stem + "šanās" ;
          Gen => stem + "šanās" ;
          Dat => NON_EXISTENT ;
          Acc => stem + "šanos" ;
          Loc => NON_EXISTENT ;
          Voc => stem + "šanās"
        } ;
        Pl => table {
          Nom => stem + "šanās" ;
          Gen => stem + "šanos" ;
          Dat => NON_EXISTENT ;
          Acc => stem + "šanās" ;
          Loc => NON_EXISTENT ;
          Voc => stem + "šanās"
        }
      } ;
      gend = Fem
    } ;

  -- Exceptions

  exception_D2_1     : pattern Str = #(_ + "akmen"|"asmen"|"mēnes"|"ruden"|"sāl"|"ūden"|"ziben") ;
  exception_D2_1_pal : pattern Str = #(_ + "akmeņ"|"asmeņ"|"mēneš"|"rudeņ"|"sāļ"|"ūdeņ"|"zibeņ") ;
  exception_D2_2     : pattern Str = #(_ + "sun") ;
  exception_D2_2_pal : pattern Str = #(_ + "suņ") ;
  exception_D4       : pattern Str = #(_ + "puik") ;
  exception_D6       : pattern Str = #(_ + "ļaud") ;



  -- Auxiliaries

  cutStem : Str -> Str = \lemma ->
    case lemma of {
      s + ("is"|"us"|"as"|"es") => s ;
      s + "šanās" => s ;
      _ => Predef.tk 1 lemma
    } ;

  palatalize : Str -> Bool -> Str = \stem,pal ->
    case pal of {
      True => case stem of {
        s + "st" => case stem of {
          s + (#vowel|#sonantCons) + "st" => stem ;
          _ => doPalatalize stem
        } ;
        _ => doPalatalize stem
      } ;
      False => stem
    } ;

  doPalatalize : Str -> Str = \stem ->
    case stem of {
      s + c@(#doubleCons) => s + changeDoubleCons c ;
      s + c@(#simpleCons) => s + changeSimpleCons c ;
      s + c@(#labialCons) => s + c + "j" ;
      _                   => stem
    } ;

  changeSimpleCons : Str -> Str = \cons ->
    case cons of {
      "c" => "č" ;
      "d" => "ž" ;
      "l" => "ļ" ;
      "n" => "ņ" ;
      "s" => "š" ;
      "t" => "š" ;
      "z" => "ž"
    } ;

  changeDoubleCons : Str -> Str = \cons ->
    case cons of {
      "ll" => "ļļ" ;
      "ln" => "ļņ" ;
      "nn" => "ņņ" ;
      "sl" => "šļ" ;
      "sn" => "šņ" ;
      "st" => "š"  ;
      "zl" => "žļ" ;
      "zn" => "žņ"
    } ;

} ;
