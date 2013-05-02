--# -path=.:../abstract:../common:../prelude

resource ParadigmsPronounsLav = open
  (Predef=Predef),
  Prelude,
  ResLav,
  CatLav
  in {

flags
  coding = utf8 ;

oper
  PronGend : Type = { s : Gender => Number => Case => Str } ;
  Pron : Type = { s : Case => Str ; a : ResLav.Agr ; possessive : Gender => Number => Case => Str } ;

-- PRONOUNS (incl. 'determiners')

  mkPronoun_I : Gender -> Pron = \g -> {
    s = table {
      Nom => "es" ;
      Gen => "manis" ;
      Dat => "man" ;
      Acc => "mani" ;
      Loc => "manī" ;
      ResLav.Voc => NON_EXISTENT
    } ;
    a = AgP1 Sg g ;
    possessive = table {
      Masc => table {
        Sg => table {
          Nom => "mans" ;
          Gen => "mana" ;
          Dat => "manam" ;
          Acc => "manu" ;
          Loc => "manā" ;
          ResLav.Voc => "mans"
        } ;
        Pl => table {
          Nom => "mani" ;
          Gen => "manu" ;
          Dat => "maniem" ;
          Acc => "manus" ;
          Loc => "manos" ;
          ResLav.Voc => "mani"
        }
      } ;
      Fem => table {
        Sg => table {
          Nom => "mana" ;
          Gen => "manas" ;
          Dat => "manai" ;
          Acc => "manu" ;
          Loc => "manā" ;
          ResLav.Voc => "mana"
        } ;
        Pl => table {
          Nom => "manas" ;
          Gen => "manu" ;
          Dat => "manām" ;
          Acc => "manas" ;
          Loc => "manās" ;
          ResLav.Voc => "manas"
        }
      }
    }
  } ;

  mkPronoun_We : Gender -> Pron = \g -> {
    s = table {
      Nom => "mēs" ;
      Gen => "mūsu" ;
      Dat => "mums" ;
      Acc => "mūs" ;
      Loc => "mūsos" ;
      ResLav.Voc => NON_EXISTENT
    } ;
    a = AgP1 Pl g ;
    possessive = \\_,_,_ => "mūsu"
  } ;

  mkPronoun_You_Sg : Gender -> Pron = \g -> {
    s = table {
      Nom => "tu" ;
      Gen => "tevis" ;
      Dat => "tev" ;
      Acc => "tevi" ;
      Loc => "tevī" ;
      ResLav.Voc => "tu"
    } ;
    a = AgP2 Sg g ;
    possessive = table {
      Masc => table {
        Sg => table {
          Nom => "tavs" ;
          Gen => "tava" ;
          Dat => "tavam" ;
          Acc => "tavu" ;
          Loc => "tavā" ;
          ResLav.Voc => "tavs"
        };
        Pl => table {
          Nom => "tavi" ;
          Gen => "tavu" ;
          Dat => "taviem" ;
          Acc => "tavus" ;
          Loc => "tavos" ;
          ResLav.Voc => "tavi"
        }
      } ;
      Fem => table {
        Sg => table {
          Nom => "tava" ;
          Gen => "tavas" ;
          Dat => "tavai" ;
          Acc => "tavu" ;
          Loc => "tavā" ;
          ResLav.Voc => "tava"
        };
        Pl => table {
          Nom => "tavas" ;
          Gen => "tavu" ;
          Dat => "tavām" ;
          Acc => "tavas" ;
          Loc => "tavās" ;
          ResLav.Voc => "tavas"
        }
      }
    }
  } ;

  mkPronoun_You_Pol : Gender -> Pron = \g -> {
    s = table {
      Nom => "Jūs" ;
      Gen => "Jūsu" ;
      Dat => "Jums" ;
      Acc => "Jūs" ;
      Loc => "Jūsos" ;
      ResLav.Voc => "Jūs"
    } ;
    a = AgP2 Pl g ;  -- FIXME: in the case of a predicate nominal: copula=Pl, complement=Sg
    possessive = \\_,_,_ => "Jūsu"
  } ;

  mkPronoun_You_Pl : Gender -> Pron = \g -> {
    s = table {
      Nom => "jūs" ;
      Gen => "jūsu" ;
      Dat => "jums" ;
      Acc => "jūs" ;
      Loc => "jūsos" ;
      ResLav.Voc => "jūs"
    } ;
    a = AgP2 Pl g ;
    possessive = \\_,_,_ => "jūsu"
  } ;

  mkPronoun_They : Gender -> Pron = \g -> {
    s = \\c => (mkPronoun_Gend "viņš").s ! g ! Pl ! c ;
    a = AgP3 Pl g Pos ;
    possessive = \\_,_,_ => "viņu"
  } ;

  mkPronoun_It_Sg : Gender -> Pron = \g -> {
    s = \\c => (mkPronoun_ThisThat That).s ! g ! Sg ! c ;
    a = AgP3 Sg g Pos ;
    possessive = \\_,_,_ => case g of { Masc => "tā" ; Fem => "tās" }
  } ;

  -- Gender=>Number=>Case P3 pronouns
  -- Expected ending of a lemma: -s or -š (Masc=>Sg=>Nom)
  -- Examples:
  --   viņš (he/she)
  --   kāds (a/some)
  --   katrs, ikviens, jebkurš (every/everything/everyone/all)
  --   neviens (no/nothing/noone)
  --   viss (all)
  --   kurš (that-relative)
  mkPronoun_Gend : Str -> PronGend = \lemma ->
    let stem : Str = Predef.tk 1 lemma
    in {
      s = table {
        Masc => table {
          Sg => table {
            Nom => lemma ;
            Gen => stem + "a" ;
            Dat => stem + "am" ;
            Acc => stem + "u" ;
            Loc => stem + "ā" ;
            Voc => NON_EXISTENT
          } ;
          Pl => table {
            Nom => stem + "i" ;
            Gen => stem + "u" ;
            Dat => stem + "iem" ;
            Acc => stem + "us" ;
            Loc => stem + "os" ;
            Voc => NON_EXISTENT
          }
        } ;
        Fem => table {
          Sg => table {
            Nom => stem + "a" ;
            Gen => stem + "as" ;
            Dat => stem + "ai" ;
            Acc => stem + "u" ;
            Loc => stem + "ā" ;
            Voc => NON_EXISTENT
          } ;
          Pl => table {
            Nom => stem + "as" ;
            Gen => stem + "u" ;
            Dat => stem + "ām" ;
            Acc => stem + "as" ;
            Loc => stem + "ās" ;
            Voc => NON_EXISTENT
          }
        }
      } ;
    } ;

  -- A special case (paradigm) of Gender=>Number=>Case P3 pronouns
  -- Returns the full paradigm of 'šis' (this) or 'tas' (that)
  mkPronoun_ThisThat : ThisOrThat -> PronGend = \tot ->
    let
      stem  : Str = case tot of {This => "š" ; That => "t"} ;
      suff1 : Str = case tot of {This => "i" ; That => "a"} ;
      suff2 : Str = case tot of {This => "ī" ; That => "ā"}
    in {
      s = table {
        Masc => table {
          Sg => table {
            Nom => stem + suff1 + "s" ;
            Gen => stem + suff2 ;
            Dat => stem + suff1 + "m" ;
            Acc => stem + "o" ;
            Loc => stem + "ajā" ;
            Voc => NON_EXISTENT
          } ;
          Pl => table {
            Nom => stem + "ie" ;
            Gen => stem + "o" ;
            Dat => stem + "iem" ;
            Acc => stem + "os" ;
            Loc => stem + "ajos" ;
            Voc => NON_EXISTENT
          }
        } ;
        Fem => table {
          Sg => table {
            Nom => stem + suff2 ;
            Gen => stem + suff2 + "s" ;
            Dat => stem + "ai" ;
            Acc => stem + "o" ;
            Loc => stem + "ajā" ;
            Voc => NON_EXISTENT
          } ;
          Pl => table {
            Nom => stem + suff2 + "s" ;
            Gen => stem + "o" ;
            Dat => stem + suff2 + "m" ;
            Acc => stem + suff2 + "s" ;
            Loc => stem + "ajās" ;
            Voc => NON_EXISTENT
          }
        }
      } ;
    } ;

    -- Everything, something, nothing, i.e., all that end with "kas"
    mkPronoun_Thing : Str -> Polarity -> Pron = \lemma,pol ->
    let stem : Str = Predef.tk 3 lemma
    in {
      s = \\c => table {
        Nom => case stem of { "kaut" => stem ++ "kas" ; _ => stem + "kas" } ;
        Gen => case stem of { "kaut" => stem ++ "kā" ; _ => stem + "kā" } ;
        Dat => case stem of { "kaut" => stem ++ "kam" ; _ => stem + "kam" } ;
        Acc => case stem of { "kaut" => stem ++ "ko" ; _ => stem + "ko" } ;
        Loc => case stem of { "kaut" => stem ++ "kur" ; _ => stem + "kur" } ;
        Voc => NON_EXISTENT
      } ! c ;
      a = AgP3 Sg Masc pol ;
      possessive = \\_,_,_ => case stem of { "kaut" => stem ++ "kā" ; _ => stem + "kā" }
    } ;

    -- Everybody, somebody, nobody
    mkPronoun_Body : Str -> Polarity -> Pron = \lemma,pol -> {
      s = \\c => (mkPronoun_Gend lemma).s ! Masc ! Sg ! c ;
      a = AgP3 Sg Masc pol ;
      possessive = \\_,_,_ => (mkPronoun_Gend lemma).s ! Masc ! Sg ! Gen ;
    } ;

} ;
