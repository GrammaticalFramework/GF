-- Latvian noun paradigms - by Normunds Grūzītis; copied off mini-grammar as of 2011-07-12

resource ParadigmsNounsLav = open 
  (Predef=Predef), 
  Prelude, 
  ResLav,
  CatLav
  in {

flags
  coding = utf8;
  
oper
  Noun     : Type = {s : Number => Case => Str ; g : Gender} ;

  masculine : Gender = Masc ;
  feminine  : Gender = Fem ;  
  
-- NOUNS

  -- No parameters - default assumptions (gender, declension, palatalization)
  mkNoun : Str -> Noun = \lemma ->
    mkNounByPal lemma True ;

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
    let decl : NounDecl = case lemma of {
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
      s + #vowel                 => D0
    }
    in mkNounByGendDeclPal lemma gend decl pal ;

  -- Specified declension; default gender and palatalization
  mkNounByDecl : Str -> NounDecl -> Noun = \lemma,decl ->
    mkNounByDeclPal lemma decl True ;

  -- Specified declension and palatalization; default gender
  mkNounByDeclPal : Str -> NounDecl -> Bool -> Noun = \lemma,decl,pal ->
    case decl of {
      D0|D1|D2|D3 => mkNounByGendDeclPal lemma Masc decl pal ;
      D4|D5|D6|DR => mkNounByGendDeclPal lemma Fem  decl pal
    } ;

  -- Specified gender and declension; default palatalization
  mkNounByGendDecl : Str -> Gender -> NounDecl -> Noun = \lemma,gend,decl ->
    mkNounByGendDeclPal lemma gend decl True ;

  -- Specified gender, declension and palatalization - no defaults
  mkNounByGendDeclPal : Str -> Gender -> NounDecl -> Bool -> Noun = \lemma,gend,decl,pal ->
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
    g = gend
  } ;

  -- Expected endings of a D1 lemma:
  --   Sg: -s, -š
  --   Pl: -i
  mkNoun_D1 : Str -> Noun = \lemma ->
    let stem : Str = cutStem lemma
    in {
      s = table {
        Sg => table {
          Nom => lemma ;			-- FIXME: if Pl lemma (-i) => -s or -š?! (default rule, explicit parameter)
          Gen => stem + "a" ;
          Dat => stem + "am" ;
          Acc => stem + "u" ;
          Loc => stem + "ā"
        } ;
        Pl => table {
          Nom => stem + "i" ;
          Gen => stem + "u" ;
          Dat => stem + "iem" ;
          Acc => stem + "us" ;
          Loc => stem + "os"
        }
      } ;
      g = Masc
    } ;

  -- Expected endings of a D2 lemma:
  --   Sg: -is, -s
  --   Pl: -i
  -- Note: ending -s is expected only in the case of few predefined exceptions
  mkNoun_D2 : Str -> Bool -> Noun = \lemma,pal ->
    let stem : Str = cutStem lemma
    in {
      s = table {
        Sg => table {
          Nom => lemma ;			-- FIXME: if Pl lemma (-i) => -is or -s?! (exceptions only - default rules only?)
          Gen => case lemma of {#exception_D2_1 + "s" => lemma ; _ => palatalize stem pal + "a"} ;
          Dat => stem + "im" ;
          Acc => stem + "i" ;
          Loc => stem + "ī"
        } ;
        Pl => table {
          Nom => palatalize stem pal + "i" ;
          Gen => palatalize stem pal + "u" ;
          Dat => palatalize stem pal + "iem" ;
          Acc => palatalize stem pal + "us" ;
          Loc => palatalize stem pal + "os"
        }
      } ;
      g = Masc
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
          Loc => stem + "ū"
        } ;
        Pl => table {
          Nom => stem + "i" ;
          Gen => stem + "u" ;
          Dat => stem + "iem" ;
          Acc => stem + "us" ;
          Loc => stem + "os"
        }
      } ;
      g = Masc
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
          Loc => stem + "ā"
        } ;
        Pl => table {
          Nom => stem + "as" ;
          Gen => stem + "u" ;
          Dat => stem + "ām" ;
          Acc => stem + "as" ;
          Loc => stem + "ās"
        }
      } ;
      g = gend
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
          Loc => stem + "ē"
        } ;
        Pl => table {
          Nom => stem + "es" ;
          Gen => palatalize stem pal + "u" ;
          Dat => stem + "ēm" ;
          Acc => stem + "es" ;
          Loc => stem + "ēs"
        }
      } ;
      g = gend
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
            Loc => stem + "ī"
          }
        } ;
        Pl => table {
          Nom => stem + "is" ;
          Gen => palatalize stem pal + "u" ;
          Dat => stem + "īm" ;
          Acc => stem + "is" ;
          Loc => stem + "īs"
        }
      } ;
      g = gend
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
          Loc => NON_EXISTENT
        } ;
        Pl => table {
          Nom => stem + "šanās" ;
          Gen => stem + "šanos" ;
          Dat => NON_EXISTENT ;
          Acc => stem + "šanās" ;
          Loc => NON_EXISTENT
        }
      } ;
      g = Fem
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
