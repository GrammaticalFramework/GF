concrete LogicSymb of Logic = open Formal, Prelude in {

lincat
  Prop, Ind = TermPrec ;
lin
  And = infixl 2 "\\&" ;
  Or  = infixl 2 "\\vee" ;
  If  = infixr 1 "\\sup" ;
  Not = prefix 3 "\\sim" ;
  All P = prefix 3 (parenth ("\\forall" ++ P.$0)) P ;
  Exist P = prefix 3 (parenth ("\\exists" ++ P.$0)) P ;
  Past = prefix 3 "P" ;
}
