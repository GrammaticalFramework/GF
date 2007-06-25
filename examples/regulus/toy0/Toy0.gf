abstract Toy0 = {

-- grammar from Chapter 2 of the Regulus book

flags startcat=NP ;

cat 
  NP ; Noun ; Spec ;

fun
  SpecNoun : Spec -> Noun -> NP ;

  One, Two : Spec ;
  Felis, Canis : Noun ;

}

