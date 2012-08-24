resource ParadigmsCmn = GrammarCmn [N,A,V] ** 
  open ResCmn, GrammarCmn, Prelude in {
flags coding=utf8;
oper
  mkN : (man : Str) -> Str -> N 
      = \n,c -> lin N (regNoun n c) ;  
      
  mkPN : (john : Str) -> Number -> PN
     = \s,n -> lin PN (PropN s n) ;       

  mkA : (small : Str) -> Bool -> A 
      = \a,b -> lin A (mkAdj a b) ;
      
  mkV = overload {      
    mkV : (walk : Str) -> V 
      = \walk -> lin V (regVerb walk) ;
    mkV : (arrive : Str) -> Str -> Str -> Str -> Str -> V
      = \arrive,pp,ds,dp,ep -> lin V (mkVerb arrive pp ds dp ep) ;
      } ;      

}
