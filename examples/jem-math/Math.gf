abstract Math = {

flags startcat = Prop ;

cat 
  Prop ; Exp ;

fun
  And, Or, If : Prop -> Prop -> Prop ;

  Zero : Exp ;

  Successor : Exp -> Exp ;

  Sum, Product : Exp -> Exp -> Exp ;

  Even, Odd, Prime : Exp -> Prop ;
  
  Equal, Less, Greater, Divisible : Exp -> Exp -> Prop ;

cat 
  Var ;

fun
  X, Y : Var ;

  EVar : Var -> Exp ;

  EInt : Int -> Exp ;

  ANumberVar : Var -> Exp ;
  TheNumberVar : Var -> Exp ;

}
