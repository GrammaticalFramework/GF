resource ResIta = open Prelude in {
  param
    Number = Sg | Pl ;
    Gender = Masc | Fem ;
  oper
    NounPhrase : Type = 
      {s : Str ; g : Gender ; n : Number} ; 
    Noun : Type = {s : Number => Str ; g : Gender} ;
    Adjective : Type = {s : Gender => Number => Str} ;

    det : Number -> Str -> Str -> Noun -> NounPhrase =
      \n,m,f,cn -> {
        s = table {Masc => m ; Fem => f} ! cn.g ++ 
            cn.s ! n ;
        g = cn.g ;
        n = n
      } ;
    noun : Str -> Str -> Gender -> Noun =
      \vino,vini,g -> {
        s = table {Sg => vino ; Pl => vini} ;
        g = g
      } ;
    adjective : (nero,nera,neri,nere : Str) -> Adjective =
      \nero,nera,neri,nere -> {
        s = table {
          Masc => table {Sg => nero ; Pl => neri} ; 
          Fem => table {Sg => nera ; Pl => nere}
          }
        } ;
    regAdj : Str -> Adjective = \nero ->
      let ner : Str = init nero 
      in 
      adjective nero (ner+"a") (ner+"i") (ner+"e") ;
    copula : Number => Str = 
      table {Sg => "è" ; Pl => "sono"} ;
}
