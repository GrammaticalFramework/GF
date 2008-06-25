concrete Toy0Fre of Toy0 = {

param
  Number = Sg | Pl ;
  Gender = Masc | Fem ;

lincat
  Spec = {s : Gender => Str ; n : Number} ;
  Noun = {s : Number => Str ; g : Gender} ;
  NP = {s : Str} ;

lin
  SpecNoun spec noun = {s = spec.s ! noun.g ++ noun.s ! spec.n} ;

  One = {s = table {Fem => "une" ; _ => "un"} ; n = Sg} ;
  Two = {s = \\_ => "deux" ; n = Pl} ;

  Felis = mkNoun "chat" Masc ;
  Canis = mkNoun "chien" Masc ;

oper
  mkNoun : Str -> Gender -> {s : Number => Str ; g : Gender} = \s,g -> {
    s = table {
      Sg => s ;
      Pl => s + "s"
      } ;
    g = g
    } ;
}
