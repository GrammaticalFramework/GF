--# -path=.:../prelude

concrete ImperJVM of Imper = open Prelude, Precedence, ResImper in {

flags lexer=codevars ; unlexer=code ; startcat=Stm ;
  lincat
    Stm = SS ;
    Typ = SS ;
    Exp = SS ;
    Var = SS ;

  lin
    Decl  typ cont = ss [] ; ----
    Assign t x exp = statement (exp.s ++ t.s ++ "_store" ++ x.s) ;
    Return t exp   = statement (exp.s ++ t.s ++ "_return") ;
    While exp loop = statement ("TEST:" ++ exp.s ++ "ifzero_goto" ++
    "END" ++ ";" ++ loop.s ++ "END") ;
    Block stm      = stm ;
    Next stm cont  = ss (stm.s ++ cont.s) ;      

    EVar  t x  = statement (t.s ++ "_load" ++ x.s) ;
    EInt    n  = statement ("i_push" ++ n.s) ;
    EFloat a b = statement ("f_push" ++ a.s ++ "." ++ b.s) ;
    EAddI  x y = statement (x.s ++ y.s ++ "iadd") ;
    EAddF  x y = statement (x.s ++ y.s ++ "fadd") ;

    TInt       = ss "i" ;
    TFloat     = ss "f" ;

}
