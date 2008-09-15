concrete MathEng of Math = {

lincat 
  Prop, Exp = Str ;

lin
  And a b = a ++ "and" ++ b ;
  Or a b = a ++ "or" ++ b ;
  If a b = "if" ++ a ++ "then" ++ b ;

  Zero = "zero" ;

  X = "x" ;
  Y = "y" ;

  Successor x = "the successor of" ++ x ;

  Sum x y = "the sum of" ++ x ++ "and" ++ y ;
  Product x y = "the product of" ++ x ++ "and" ++ y ;

  Even x = x ++ "is even" ;
  Odd x = x ++ "is odd" ;
  Prime x = x ++ "is prime" ;
  
  Equal x y = x ++ "is equal to" ++ y ;
  Less x y = x ++ "is less than" ++ y ; 
  Greater x y = x ++ "is greater than" ++ y ; 
  Divisible x y = x ++ "is divisible by" ++ y ; 

lincat 
  Var = Str ;
lin
  X = "x" ;
  Y = "y" ;

  EVar x = x ;
  EInt i = i.s ;

  ANumberVar x = "a number" ++ x ;
  TheNumberVar x = "the number" ++ x ;

}
