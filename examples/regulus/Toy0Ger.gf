concrete Toy0Ger of Toy0 = {

param
  Number = Sg | Pl ;
  Gender = Masc | Fem | Neutr ;

lincat
  Spec = {s : Gender => Str ; n : Number} ;
  Noun = {s : Number => Str ; g : Gender} ;
  MAIN,NP = {s : Str} ;

lin
  Main np = np ;
  SpecNoun spec noun = {s = spec.s ! noun.g ++ noun.s ! spec.n} ;

  One = {s = table {Fem => "eine" ; _ => "ein"} ; n = Sg} ;
  Two = {s = \\_ => "zwei" ; n = Pl} ;

  Felis = mkNoun "Katze" "Katzen" Fem ;
  Canis = mkNoun "Hund" "Hünde" Masc ;

oper
  mkNoun : Str -> Str -> Gender -> {s : Number => Str ; g : Gender} = \s,p,g -> {
    s = table {
      Sg => s ;
      Pl => p
      } ;
    g = g
    } ;
}
