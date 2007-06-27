concrete Toy0Eng of Toy0 = {

param
  Number = Sg | Pl ;

lincat
  Spec = {s : Str ; n : Number} ;
  Noun = {s : Number => Str} ;
  NP = {s : Str} ;

lin
  SpecNoun spec noun = {s = spec.s ++ noun.s ! spec.n} ;

  One = {s = "one" ; n = Sg} ;
  Two = {s = "two" ; n = Pl} ;

  Felis = regNoun "cat" ;
  Canis = regNoun "dog" ;

oper
  regNoun : Str -> {s : Number => Str} = \s -> {
    s = table {
      Sg => s ;
      Pl => s + "s"
      }
    } ;
}
