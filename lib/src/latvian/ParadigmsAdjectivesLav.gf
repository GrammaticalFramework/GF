--# -path=.:../abstract:../common:../prelude

resource ParadigmsAdjectivesLav = open
  (Predef=Predef),
  Prelude,
  ResLav,
  CatLav
  in {

flags
  coding = utf8;

oper
	--Adj      : Type = {s : Degree => Definite => Gender => Number => Case => Str} ;
	Adj      : Type = {s : AForm => Str} ;

-- ADJECTIVES

  -- TODO: Parameters and paradigms should be redesigned due to the many NON_EXISTENT forms..?

  -- To keep the code and user interface (parameters) simple, Masc lemmas are expected.

  -- No parameters - default assumptions (type)
  mkAdjective : Str -> Adj = \lemma ->
    case lemma of {
      s + "ais"     => mkAdjective_Rel lemma ;
      s + ("s"|"š") => mkAdjective_Qual lemma ;
      s + #vowel    => mkAdjective_Indecl lemma
    } ;

  -- Specified type - no defaults
  mkAdjectiveByType : Str -> AdjType -> Adj = \lemma,type ->
    case type of {
      AdjQual   => mkAdjective_Qual lemma ;
      AdjRel    => mkAdjective_Rel lemma ;
      AdjIndecl => mkAdjective_Indecl lemma
    } ;

  -- Indeclinable adjective: theoretically, any #vowel ending
  mkAdjective_Indecl : Str -> Adj = \lemma -> {
    s = table{
	  AAdj Superl Indef _ _ _ => NON_EXISTENT;
	  AAdj _ _ _ _ _ => lemma ;
	  AAdv d => mkAdjective_Adverb lemma ! d-- TODO - notestēt šādu keisu
    }
  } ;

  -- Qualitative adjective: -s, -š
  mkAdjective_Qual : Str -> Adj = \lemma -> {
    s = table {
	  AAdj Posit d g n c => mkAdjective_Pos lemma d ! g ! n ! c;
	  AAdj Compar d g n c => mkAdjective_Comp lemma d ! g ! n ! c;
	  AAdj Superl Def g n c => mkAdjective_Sup lemma ! g ! n ! c;
	  AAdj Superl Indef _ _ _ => NON_EXISTENT;
	  AAdv d => mkAdjective_Adverb lemma ! d
    }
  } ;

  -- Relative adjective: -ais (Def only); -s, -š (Indef and Def)
  mkAdjective_Rel : Str -> Adj = \lemma -> {
    s = table {
      AAdj Posit Def g n c => mkAdjective_Pos lemma Def ! g ! n ! c;
	  AAdj Posit Indef g n c => case lemma of {
        s + "ais" => NON_EXISTENT  ;
        _         => mkAdjective_Pos lemma Indef ! g ! n ! c
      } ;
      AAdj _ _ _ _ _ => NON_EXISTENT ;
	  AAdv d => mkAdjective_Adverb lemma ! d
    }
  };

  mkAdjective_Participle : Verb -> Adj = \v -> {
    s = table {
		AAdj Posit Indef g n c => v.s ! Pos !(Participle g n c); --FIXME - iznest polaritāti ārpusē lai ir noliegtie kā atsevišķi īpašībasvārdi
		_ => NON_EXISTENT --FIXME - salikt arī tās divdabja formas
	}
  };

  -- Positive degree: -s, -š (Indef and Def); -ais (Def only)
  -- TODO - atsaukties uz lietvārdu locīšanas tabulām?
  mkAdjective_Pos : Str -> Definite -> Gender => Number => Case => Str = \lemma,defin ->
    let stem : Str = case lemma of {
      s + "ais" => s ;
      _ => Predef.tk 1 lemma
    }
    in case defin of {
      Indef => table {
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
      Def => table {
        Masc => table {
          Sg => table {
            Nom => stem + "ais" ;
            Gen => stem + "ā" ;
            Dat => case stem of {s + "ēj" => stem + "am" ; _ => stem + "ajam"} ;
            Acc => stem + "o" ;
            Loc => case stem of {s + "ēj" => stem + "ā" ; _ => stem + "ajā"} ;
			Voc => stem + "ais"
          } ;
          Pl => table {
            Nom => stem + "ie" ;
            Gen => stem + "o" ;
            Dat => case stem of {s + "ēj" => stem + "iem" ; _ => stem + "ajiem"} ;
            Acc => stem + "os" ;
            Loc => case stem of {s + "ēj" => stem + "os" ; _ => stem + "ajos"} ;
			Voc => stem + "ie"
          }
        } ;
        Fem => table {
          Sg => table {
            Nom => stem + "ā" ;
            Gen => stem + "ās" ;
            Dat => case stem of {s + "ēj" => stem + "ai" ; _ => stem + "ajai"} ;
            Acc => stem + "o" ;
            Loc => case stem of {s + "ēj" => stem + "ā" ; _ => stem + "ajā"} ;
			Voc => stem + "ā"
          } ;
          Pl => table {
            Nom => stem + "ās" ;
            Gen => stem + "o" ;
            Dat => case stem of {s + "ēj" => stem + "ām" ; _ => stem + "ajām"} ;
            Acc => stem + "ās" ;
            Loc => case stem of {s + "ēj" => stem + "ās" ; _ => stem + "ajās"} ;
			Voc => stem + "ās"
          }
        }
      }
    } ;

  -- Comparative degree: Qual only
  mkAdjective_Comp : Str -> Definite -> Gender => Number => Case => Str = \lemma,defin ->
    let stem : Str = Predef.tk 1 lemma
    in case defin of {
      Indef => table {
        Masc => table {
          Sg => table {
            Nom => stem + "āks" ;
            Gen => stem + "āka" ;
            Dat => stem + "ākam" ;
            Acc => stem + "āku" ;
            Loc => stem + "ākā" ;
			Voc => NON_EXISTENT
          } ;
          Pl => table {
            Nom => stem + "āki" ;
            Gen => stem + "āku" ;
            Dat => stem + "ākiem" ;
            Acc => stem + "ākus" ;
            Loc => stem + "ākos" ;
			Voc => NON_EXISTENT
          }
        } ;
        Fem => table {
          Sg => table {
            Nom => stem + "āka" ;
            Gen => stem + "ākas" ;
            Dat => stem + "ākai" ;
            Acc => stem + "āku" ;
            Loc => stem + "ākā" ;
			Voc => NON_EXISTENT
          } ;
          Pl => table {
            Nom => stem + "ākas" ;
            Gen => stem + "āku" ;
            Dat => stem + "ākām" ;
            Acc => stem + "ākas" ;
            Loc => stem + "ākās" ;
			Voc => NON_EXISTENT
          }
        }
      } ;
      Def => table {
        Masc => table {
          Sg => table {
            Nom => stem + "ākais" ;
            Gen => stem + "ākā" ;
            Dat => stem + "ākajam" ;
            Acc => stem + "āko" ;
            Loc => stem + "ākajā" ;
			Voc => stem + "ākais"
          } ;
          Pl => table {
            Nom => stem + "ākie" ;
            Gen => stem + "āko" ;
            Dat => stem + "ākajiem" ;
            Acc => stem + "ākos" ;
            Loc => stem + "ākajos" ;
			Voc => stem + "ākie"
          }
        } ;
        Fem => table {
          Sg => table {
            Nom => stem + "ākā" ;
            Gen => stem + "ākās" ;
            Dat => stem + "ākajai" ;
            Acc => stem + "āko" ;
            Loc => stem + "ākajā" ;
			Voc => stem + "ākā"
          } ;
          Pl => table {
            Nom => stem + "ākās" ;
            Gen => stem + "āko" ;
            Dat => stem + "ākajām" ;
            Acc => stem + "ākās" ;
            Loc => stem + "ākajās" ;
			Voc => stem + "ākās"
          }
        }
      }
    } ;

  -- Superlative degree: Qual only, Def only
  mkAdjective_Sup : Str -> Gender => Number => Case => Str = \lemma ->
    \\g,n,c => "vis" + (mkAdjective_Comp lemma Def) ! g ! n ! c ;

  -- Adverbial form, all 3 degrees
  mkAdjective_Adverb : Str -> Degree => Str = \lemma ->
  let stem : Str = case lemma of {
      s + "ais" => s ;
      _ => Predef.tk 1 lemma
  } in table {
	Posit => stem + "i";
	Compar => stem + "āk";
	Superl => "vis" + stem + "āk"
  };
} ;
