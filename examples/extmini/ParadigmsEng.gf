resource ParadigmsEng = GrammarEng [N,A,V] ** 
  open ResEng, GrammarEng, Prelude in {

oper
  mkN = overload {
    mkN : (dog : Str) -> N 
      = \n -> lin N (regNoun n) ;
    mkN : (man, men : Str) -> N 
      = \s,p -> lin N (mkNoun s p) ;
    } ;

  mkPN : (john : Str) -> PN
     = \s -> lin PN (ss s) ;  

  mkA = overload {
    mkA : (small : Str) -> A 
      = \a -> lin A (mkAdj a) ;
    } ;

  mkV = overload {
    mkV : (walk : Str) -> V 
      = \v -> lin V (regVerb v) ;
    mkV : (go,goes,went,gone : Str) -> V 
      = \p1,p2,p3,p4 -> lin V (mkVerb p1 p2 p3 p4) ;
    } ;

  mkV2 = overload {
    mkV2 : Str -> V2
      = \s -> lin V2 (regVerb s ** {c = []}) ;
    mkV2 : V -> V2
      = \v -> lin V2 (v ** {c = []}) ;
    mkV2 : V -> Str -> V2
      = \v,p -> lin V2 (v ** {c = p}) ;
    } ;

}
