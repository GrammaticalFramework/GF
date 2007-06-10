abstract Toy0 = {

-- grammar from Chapter 2 of the Regulus book

flags startcat=MAIN ;

cat 
  MAIN ; NP ; Noun ; Spec ;

fun
  Main : NP -> MAIN ;
  SpecNoun : Spec -> Noun -> NP ;

  One, Two : Spec ;
  Felis, Canis : Noun ;

}

