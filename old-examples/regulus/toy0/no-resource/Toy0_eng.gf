-- grammar from Chapter 2 of the Regulus book

flags startcat=MAIN ;

cat 
  MAIN ; NP ; Noun ; Spec ;

fun
  Main : NP -> MAIN ;
  SpecNoun : Spec -> Noun -> NP ;

  One, Two : Spec ;
  Felis, Canis : Noun ;

param
  Number = Sg | Pl ;

lincat
  Spec = {s : Str ; n : Number} ;
  Noun = {s : Number => Str} ;
  MAIN,NP = {s : Str} ;

lin
  Main np = np ;
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
