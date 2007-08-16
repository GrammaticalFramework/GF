--# -path=.:prelude

  -- This is a simple Italian resource morphology for the GF tutorial.

  resource MorphoIta = open Prelude in {

  -- the lexicographer's API

    oper
      masculine, feminine : Gender ;

  

    param
      Number = Sg | Pl ;
      Gender = Masc | Fem ;

    oper
      Noun      : Type = {s : Number => Str ; g : Gender} ; 
      Adjective : Type = {s : Gender => Number => Str} ;

  -- we will only use present indicative third person verb forms

      Verb      : Type = {s : Number => Str} ;

  -- two-place verbs have a preposition

      Verb2     : Type = Verb ** {c : Str} ;

  -- this function takes the gender and both singular and plural forms

      mkNoun : Gender -> Str -> Str -> Noun = \g,vino,vini -> {
        s = table {
          Sg => vino ;
          Pl => vini
          } ;
        g = g
        } ;

  -- this function takes the singular form

     regNoun : Str -> Noun = \vino -> 
       case vino of {
         vin + c@("c" | "g") + "a" 
           => mkNoun Fem  vino (vin + c + "he") ; -- banche
         vin + "a"               
           => mkNoun Fem  vino (vin + "e") ;      -- pizza
         vin + c@("c" | "g") + "o"
           => mkNoun Masc vino (vin + c + "hi") ; -- boschi 
         vin + ("o" | "e") 
           => mkNoun Masc vino (vin + "i") ;      -- vino, pane
         _ => mkNoun Masc vino vino               -- tram
         } ;

  -- to make nouns such as "carne", "università" feminine

     femNoun : Noun -> Noun = \mano -> {
       s = mano.s ;
       g = Fem
       } ;

  -- this takes both genders and numbers

     mkAdjective : (x1,_,_,x4 : Str) -> Adjective = \nero,nera,neri,nere -> {
       s = table {
         Masc => (mkNoun Masc nero neri).s ;
         Fem  => (mkNoun Fem  nera nere).s
         } 
       } ;

  -- this takes the masculine singular form

     regAdjective : Str -> Adjective = \nero ->
       let ner = init nero in
       case last nero of {
         "o" => mkAdjective (ner + "o") (ner + "a") (ner + "i") (ner + "e") ;
         "e" => mkAdjective (ner + "e") (ner + "e") (ner + "i") (ner + "i") ;
         _   => mkAdjective nero nero nero nero
         } ;

  -- this function takes the singular and plural forms

      mkVerb : Str -> Str -> Verb = \ama,amano -> {
        s = table {
          Sg => ama ;
          Pl => amano
          }
        } ;

  -- this function takes the infinitive form

      regVerb : Str -> Verb = \amare -> 
        let am = Predef.tk 3 amare in
        case Predef.dp 3 amare of {
          "ere" => mkVerb (am + "e")    (am + "ono") ;    -- premere
          "ire" => mkVerb (am + "isce") (am + "iscono") ; -- finire
          _     => mkVerb (am + "a")    (am + "ano")      -- amare
        } ;

  }
