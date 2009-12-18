abstract Symbols = {

cat 
  Exp ; 

fun 
--  EInt : Int -> Expp ; --- clashes with EVar...
  EVar : String -> Exp ;
  EIn, EPlus, ETimes, EEq, EGt, ELt : Exp -> Exp -> Exp ;
}
