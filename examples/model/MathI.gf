incomplete concrete MathI of Math = 
  open Grammar, Combinators, Predication, Lex in {

  flags startcat = Prop ;

  lincat 
    Prop = S ;
    Elem = NP ;

  lin 
    And x y = coord and_Conj x y ;
    Even x = PosCl (pred even_A x) ;
    Odd x = PosCl (pred odd_A x) ;
    Zero = UsePN zero_PN ;

}
