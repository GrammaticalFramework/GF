--# -path=.:abstract:common:prelude

resource ParadigmsPronounsLav = open ResLav, CatLav, Prelude, Predef in {

flags coding = utf8 ;

oper

  PronGend : Type = { s : Gender => Number => Case => Str } ;

  -- Pronouns (incl. "determiners")

  mkPronoun_I : Gender -> Pronoun = \gend -> {
    s = table {
      Nom => "es" ;
      Gen => "manis" ;
      Dat => "man" ;
      Acc => "mani" ;
      Loc => "manī" ;
      Voc => NON_EXISTENT
    } ;
    agr = AgrP1 Sg gend ;
    poss = table {
      Masc => table {
        Sg => table {
          Nom => "mans" ;
          Gen => "mana" ;
          Dat => "manam" ;
          Acc => "manu" ;
          Loc => "manā" ;
          Voc => "mans"
        } ;
        Pl => table {
          Nom => "mani" ;
          Gen => "manu" ;
          Dat => "maniem" ;
          Acc => "manus" ;
          Loc => "manos" ;
          Voc => "mani"
        }
      } ;
      Fem => table {
        Sg => table {
          Nom => "mana" ;
          Gen => "manas" ;
          Dat => "manai" ;
          Acc => "manu" ;
          Loc => "manā" ;
          Voc => "mana"
        } ;
        Pl => table {
          Nom => "manas" ;
          Gen => "manu" ;
          Dat => "manām" ;
          Acc => "manas" ;
          Loc => "manās" ;
          Voc => "manas"
        }
      }
    } ;
    pol = Pos
  } ;

  mkPronoun_We : Gender -> Pronoun = \gend -> {
    s = table {
      Nom => "mēs" ;
      Gen => "mūsu" ;
      Dat => "mums" ;
      Acc => "mūs" ;
      Loc => "mūsos" ;
      Voc => NON_EXISTENT
    } ;
    agr = AgrP1 Pl gend ;
    poss = \\_,_,_ => "mūsu" ;
    pol = Pos
  } ;

  mkPronoun_You_Sg : Gender -> Pronoun = \gend -> {
    s = table {
      Nom => "tu" ;
      Gen => "tevis" ;
      Dat => "tev" ;
      Acc => "tevi" ;
      Loc => "tevī" ;
      Voc => "tu"
    } ;
    agr = AgrP2 Sg gend ;
    poss = table {
      Masc => table {
        Sg => table {
          Nom => "tavs" ;
          Gen => "tava" ;
          Dat => "tavam" ;
          Acc => "tavu" ;
          Loc => "tavā" ;
          Voc => "tavs"
        };
        Pl => table {
          Nom => "tavi" ;
          Gen => "tavu" ;
          Dat => "taviem" ;
          Acc => "tavus" ;
          Loc => "tavos" ;
          Voc => "tavi"
        }
      } ;
      Fem => table {
        Sg => table {
          Nom => "tava" ;
          Gen => "tavas" ;
          Dat => "tavai" ;
          Acc => "tavu" ;
          Loc => "tavā" ;
          Voc => "tava"
        };
        Pl => table {
          Nom => "tavas" ;
          Gen => "tavu" ;
          Dat => "tavām" ;
          Acc => "tavas" ;
          Loc => "tavās" ;
          Voc => "tavas"
        }
      }
    } ;
    pol = Pos
  } ;

  mkPronoun_You_Pol : Gender -> Pronoun = \gend -> {
    s = table {
      Nom => "Jūs" ;
      Gen => "Jūsu" ;
      Dat => "Jums" ;
      Acc => "Jūs" ;
      Loc => "Jūsos" ;
      Voc => "Jūs"
    } ;
    agr = AgrP2 Pl gend ;  -- FIXME: in the case of a predicate nominal: copula=Pl, complement=Sg
    poss = \\_,_,_ => "Jūsu" ;
    pol = Pos
  } ;

  mkPronoun_You_Pl : Gender -> Pronoun = \gend -> {
    s = table {
      Nom => "jūs" ;
      Gen => "jūsu" ;
      Dat => "jums" ;
      Acc => "jūs" ;
      Loc => "jūsos" ;
      Voc => "jūs"
    } ;
    agr = AgrP2 Pl gend ;
    poss = \\_,_,_ => "jūsu" ;
    pol = Pos
  } ;

  mkPronoun_They : Gender -> Pronoun = \gend -> {
    s = \\c => (mkPronoun_Gend "viņš").s ! gend ! Pl ! c ;
    agr = AgrP3 Pl gend ;
    poss = \\_,_,_ => "viņu" ;
    pol = Pos
  } ;

  mkPronoun_It_Sg : Gender -> Pronoun = \gend -> {
    s = \\c => (mkPronoun_ThisThat That).s ! gend ! Sg ! c ;
    agr = AgrP3 Sg gend ;
    poss = \\_,_,_ => case gend of { Masc => "tā" ; Fem => "tās" } ;
    pol = Pos
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
    mkPronoun_Thing : Str -> Polarity -> Pronoun = \lemma,pol ->
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
      agr = AgrP3 Sg Masc ;
      poss = \\_,_,_ => case stem of { "kaut" => stem ++ "kā" ; _ => stem + "kā" } ;
      pol =  pol
    } ;

    -- Everybody, somebody, nobody
    mkPronoun_Body : Str -> Polarity -> Pronoun = \lemma,pol -> {
      s = \\c => (mkPronoun_Gend lemma).s ! Masc ! Sg ! c ;
      agr = AgrP3 Sg Masc ;
      poss = \\_,_,_ => (mkPronoun_Gend lemma).s ! Masc ! Sg ! Gen ;
      pol = pol
    } ;

} ;
