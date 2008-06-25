--# -path=.:prelude

resource MorphoEng = open Prelude in {

  -- the lexicon construction API

    oper
      mkN : overload {
        mkN : (bus : Str) -> Noun ;
        mkN : (man,men : Str) -> Noun ;
      } ;

      mkA : (warm : Str) -> Adjective ;

      mkV : overload {
        mkV : (kiss : Str) -> Verb ;
        mkV : (do,does : Str) -> Verb ;
      } ;

      mkV2 : overload {
        mkV2 : (love : Verb) -> Verb2 ;
        mkV2 : (talk : Verb) -> (about : Str) -> Verb2 ;
      } ;

  -- grammar-internal definitions

    param
      Number = Sg | Pl ;

    oper
      Noun, Verb : Type = {s : Number => Str} ;
      Adjective : Type = {s : Str} ;
      Verb2 : Type = Verb ** {c : Str} ;

      mkN = overload {
        mkN : (bus : Str) -> Noun = \s -> mkNoun s (add_s s) ;
        mkN : (man,men : Str) -> Noun = mkNoun ;
      } ;

      mkA : (warm : Str) -> Adjective = ss ;

      mkV = overload {
        mkV : (kiss : Str) -> Verb = \s -> mkVerb s (add_s s) ;
        mkV : (do,does : Str) -> Verb = mkVerb ;
      } ;

      mkV2 = overload {
        mkV2 : (love : Verb) -> Verb2 = \love -> love ** {c = []} ;
        mkV2 : (talk : Verb) -> (about : Str) -> Verb2 = 
          \talk,about -> talk ** {c = about} ;
      } ;

      add_s : Str -> Str = \w -> case w of {
        _ + "oo"                           => w + "s" ;   -- bamboo
        _ + ("s" | "z" | "x" | "sh" | "o") => w + "es" ;  -- bus, hero
        _ + ("a" | "o" | "u" | "e") + "y"  => w + "s" ;   -- boy
        x + "y"                            => x + "ies" ; -- fly
        _                                  => w + "s"     -- car
      } ;

      mkNoun : Str -> Str -> Noun = \x,y -> {
        s = table {
          Sg => x ;
          Pl => y
          }
        } ;

      mkVerb : Str -> Str -> Verb = \x,y -> mkNoun y x ;
  }
