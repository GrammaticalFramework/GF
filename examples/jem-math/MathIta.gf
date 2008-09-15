concrete MathIta of Math = {

lincat 
  Prop, Exp = Str ;

lin
  And a b = a ++ "e" ++ b ;
  Or a b = a ++ "o" ++ b ;
  If a b = "si" ++ a ++ "allora" ++ b ;

  Zero = "zero" ;

  Successor x = "il successore di" ++ x ;

  Sum x y = "la somma di" ++ x ++ "e" ++ y ;
  Product x y = "il prodotto di" ++ x ++ "e" ++ y ;

  Even x = x ++ "è pari" ;
  Odd x = x ++ "è dispari" ;
  Prime x = x ++ "è primo" ;
  
  Equal x y = x ++ "è uguale a" ++ y ;
  Less x y = x ++ "è inferiore a" ++ y ; 
  Greater x y = x ++ "è superiore a" ++ y ; 
  Divisible x y = x ++ "è divisibile per" ++ y ; 

lincat 
  Var = Str ;
lin
  X = "x" ;
  Y = "y" ;

  EVar x = x ;
  EInt i = i.s ;

  ANumberVar x = "un numero" ++ x ;
  TheNumberVar x = "il numero" ++ x ;


}
