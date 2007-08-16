--# -path=.:prelude

resource MorphoEng = open Prelude in {

    param
      Number = Sg | Pl ;

    oper
      Noun, Verb : Type = {s : Number => Str} ;

      NP = {s : Str ; n : Number} ;
      VP = {s : Bool => Bool => Number => Str * Str} ; -- decl, pol

      mkNoun : Str -> Str -> Noun = \x,y -> {
        s = table {
          Sg => x ;
          Pl => y
          }
        } ;

      regNoun : Str -> Noun = \s -> case last s of {
        "s" | "z" => mkNoun s (s + "es") ;
        "y"       => mkNoun s (init s + "ies") ;
        _         => mkNoun s (s + "s")
        } ;

      mkVerb : Str -> Str -> Verb = \x,y -> mkNoun y x ;

      regVerb : Str -> Verb = \s -> case last s of {
        "s" | "z" => mkVerb s (s + "es") ;
        "y"       => mkVerb s (init s + "ies") ;
        "o"       => mkVerb s (s + "es") ;
        _         => mkVerb s (s + "s")
        } ;

  }
