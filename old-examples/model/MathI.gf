incomplete concrete MathI of Math = 
  open Syntax, Lex in {

  flags startcat = Prop ;

  lincat 
    Prop = S ;
    Elem = NP ;

  lin 
    And x y = mkS and_Conj x y ;
    Even x = mkS (mkCl x even_A) ;
    Odd x = mkS (mkCl x odd_A) ;
    Zero = mkNP zero_PN ;

}
