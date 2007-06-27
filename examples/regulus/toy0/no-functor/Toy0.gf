-- toy0 grammar from Chapter 2 of the Regulus book
abstract Toy0 = {

  flags startcat=NP ;

  cat 
    NP ; 
    Noun ; 
    Spec ;

  fun  
    SpecNoun      : Spec -> Noun -> NP ;
    One, Two      : Spec ;
    Felis, Canis  : Noun ;
}
