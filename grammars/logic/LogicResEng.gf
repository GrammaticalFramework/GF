resource LogicResEng = {

param Num = sg | pl  ;

oper 
  
  ss  : Str -> {s : Str} = \s -> {s = s} ;

  nomReg : Str -> Num => Str = \s -> table {sg => s ; pl => s + "s"} ;

  indef : Str = pre {"a" ; "an" / strs {"a" ; "e" ; "i" ; "o"}} ;

  LinElem : Type = {s : Str} ;
  LinProp : Type = {s : Str} ;

  adj1 : Str -> LinElem -> LinProp = 
    \adj,x -> ss (x.s ++ "is" ++ adj) ;
  adj2 : Str -> LinElem -> LinElem -> LinProp = 
    \adj,x,y -> ss (x.s ++ "is" ++ adj ++ y.s) ;

  fun1 : Str -> LinElem -> LinElem = 
    \f,x -> ss ("the" ++ f ++ "of" ++ x.s) ;
  fun2 : Str -> LinElem -> LinElem -> LinElem = 
    \f,x,y -> ss ("the" ++ f ++ "of" ++ x.s ++ "and" ++ y.s) ;


} ;
