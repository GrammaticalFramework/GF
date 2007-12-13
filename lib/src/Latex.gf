resource Latex = open Prelude in {
  oper
    command : Str -> Str = \c -> "\\" + c ;
    fun1 : Str -> Str -> Str = \f,x -> "\\" + f + "{" ++ x ++ "}" ;    
    fun2 : Str -> Str -> Str -> Str = 
      \f,x,y -> "\\" + f + "{" ++ x ++ "}{" ++ y ++ "}" ;
    begin : Str -> Str = \e -> "\\begin{" + e + "}" ;   
    end : Str -> Str = \e -> "\\end{" + e + "}" ;
    inEnv : Str -> Str -> Str = \e,s -> begin e ++ s ++ end e ;
}
    

