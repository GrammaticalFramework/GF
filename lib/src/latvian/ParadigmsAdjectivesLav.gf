-- Latvian adjective paradigms - by Normunds Grūzītis; copied off mini-grammar as of 2011-07-12

resource ParadigmsAdjectivesLav = open 
  (Predef=Predef), 
  Prelude, 
  ResLav,
  CatLav
  in {

flags
  coding = utf8;
  
oper
	Adj      : Type = {s : Degree => Definite => Gender => Number => Case => Str} ;
	
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
      Posit  => \\_,_,_,_ => lemma ;
      Compar => \\_,_,_,_ => lemma ;
      Superl  => table {Indef => \\_,_,_ => NON_EXISTENT ; Def => \\_,_,_ => lemma}
    }
  } ;

  -- Qualitative adjective: -s, -š
  mkAdjective_Qual : Str -> Adj = \lemma -> {
    s = table {
      Posit  => table {Indef => mkAdjective_Pos lemma Indef ; Def => mkAdjective_Pos lemma Def} ;
      Compar => table {Indef => mkAdjective_Comp lemma Indef ; Def => mkAdjective_Comp lemma Def} ;
      Superl  => table {Indef => \\_,_,_ => NON_EXISTENT ; Def => mkAdjective_Sup lemma}
    }
  } ;

  -- Relative adjective: -ais (Def only); -s, -š (Indef and Def)
  mkAdjective_Rel : Str -> Adj = \lemma -> {
    s = table {
      Posit  => case lemma of {
        s + "ais" => table {Indef => \\_,_,_ => NON_EXISTENT ; Def => mkAdjective_Pos lemma Def} ;
        _         => table {Indef => mkAdjective_Pos lemma Indef ; Def => mkAdjective_Pos lemma Def}
      } ;
      Compar => table {Indef => \\_,_,_ => NON_EXISTENT ; Def => \\_,_,_ => NON_EXISTENT} ;
      Superl  => table {Indef => \\_,_,_ => NON_EXISTENT ; Def => \\_,_,_ => NON_EXISTENT}
    }
  };

  -- Positive degree: -s, -š (Indef and Def); -ais (Def only)
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
            Loc => stem + "ā"
          } ;
          Pl => table {
            Nom => stem + "i" ;
            Gen => stem + "us" ;
            Dat => stem + "iem" ;
            Acc => stem + "us" ;
            Loc => stem + "os"
          }
        } ;
        Fem => table {
          Sg => table {
            Nom => stem + "a" ;
            Gen => stem + "as" ;
            Dat => stem + "ai" ;
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
        }
      } ;
      Def => table {
        Masc => table {
          Sg => table {
            Nom => stem + "ais" ;
            Gen => stem + "ā" ;
            Dat => case stem of {s + "ēj" => stem + "am" ; _ => stem + "ajam"} ;
            Acc => stem + "o" ;
            Loc => case stem of {s + "ēj" => stem + "ā" ; _ => stem + "ajā"}
          } ;
          Pl => table {
            Nom => stem + "ie" ;
            Gen => stem + "o" ;
            Dat => case stem of {s + "ēj" => stem + "iem" ; _ => stem + "ajiem"} ;
            Acc => stem + "os" ;
            Loc => case stem of {s + "ēj" => stem + "os" ; _ => stem + "ajos"}
          }
        } ;
        Fem => table {
          Sg => table {
            Nom => stem + "ā" ;
            Gen => stem + "ās" ;
            Dat => case stem of {s + "ēj" => stem + "ai" ; _ => stem + "ajai"} ;
            Acc => stem + "o" ;
            Loc => case stem of {s + "ēj" => stem + "ā" ; _ => stem + "ajā"}
          } ;
          Pl => table {
            Nom => stem + "ās" ;
            Gen => stem + "o" ;
            Dat => case stem of {s + "ēj" => stem + "ām" ; _ => stem + "ajām"} ;
            Acc => stem + "ās" ;
            Loc => case stem of {s + "ēj" => stem + "ās" ; _ => stem + "ajās"}
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
            Loc => stem + "ākā"
          } ;
          Pl => table {
            Nom => stem + "āki" ;
            Gen => stem + "āku" ;
            Dat => stem + "ākiem" ;
            Acc => stem + "ākus" ;
            Loc => stem + "ākos"
          }
        } ;
        Fem => table {
          Sg => table {
            Nom => stem + "āka" ;
            Gen => stem + "ākas" ;
            Dat => stem + "ākai" ;
            Acc => stem + "āku" ;
            Loc => stem + "ākā"
          } ;
          Pl => table {
            Nom => stem + "ākas" ;
            Gen => stem + "āku" ;
            Dat => stem + "ākām" ;
            Acc => stem + "ākas" ;
            Loc => stem + "ākās"
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
            Loc => stem + "ākajā"
          } ;
          Pl => table {
            Nom => stem + "ākie" ;
            Gen => stem + "āko" ;
            Dat => stem + "ākajiem" ;
            Acc => stem + "ākos" ;
            Loc => stem + "ākajos"
          }
        } ;
        Fem => table {
          Sg => table {
            Nom => stem + "ākā" ;
            Gen => stem + "ākās" ;
            Dat => stem + "ākajai" ;
            Acc => stem + "āko" ;
            Loc => stem + "ākajā"
          } ;
          Pl => table {
            Nom => stem + "ākās" ;
            Gen => stem + "āko" ;
            Dat => stem + "ākajām" ;
            Acc => stem + "ākās" ;
            Loc => stem + "ākajās"
          }
        }
      }
    } ;

  -- Superlative degree: Qual only, Def only
  mkAdjective_Sup : Str -> Gender => Number => Case => Str = \lemma ->
    \\g,n,c => "vis" + (mkAdjective_Comp lemma Def) ! g ! n ! c ;  
} ;
