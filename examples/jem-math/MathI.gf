incomplete concrete MathI of Math = open 
  Syntax,
  Mathematical,
  LexMath,
  Prelude in {

lincat 
  Prop = S ;
  Exp = NP ;

lin
  And = mkS and_Conj ;
  Or  = mkS or_Conj ;
  If a = mkS (mkAdv if_Subj a) ;

  Zero = mkNP zero_PN ;
  Successor = funct1 successor_N2 ;

  Sum = funct2 sum_N2 ;
  Product = funct2 product_N2 ;

  Even = pred1 even_A ;
  Odd = pred1 odd_A ;
  Prime = pred1 prime_A ;
  
  Equal = pred2 equal_A2 ;
  Less = predC small_A ;
  Greater = predC great_A  ;
  Divisible = pred2 divisible_A2 ;

oper
  funct1 : N2 -> NP -> NP = \f,x -> mkNP the_Art (mkCN f x) ;
  funct2 : N2 -> NP -> NP -> NP = \f,x,y -> mkNP the_Art (mkCN f (mkNP and_Conj x y)) ;

  pred1 : A -> NP -> S = \f,x -> mkS (mkCl x f) ;
  pred2 : A2 -> NP -> NP -> S = \f,x,y -> mkS (mkCl x f y) ;
  predC : A -> NP -> NP -> S = \f,x,y -> mkS (mkCl x f y) ;

lincat 
  Var = Symb ;
lin
  X = MkSymb (ss "x") ;
  Y = MkSymb (ss "y") ;

  EVar x = mkNP (SymbPN x) ;
  EInt i = mkNP (IntPN i) ;

  ANumberVar x = mkNP a_Art (mkCN (mkCN number_N) (mkNP (SymbPN x))) ;
  TheNumberVar x = mkNP the_Art (mkCN (mkCN number_N) (mkNP (SymbPN x))) ;

}
