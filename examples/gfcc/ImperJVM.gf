--# -path=.:../prelude

concrete ImperJVM of Imper = open Prelude, Precedence, ResImper in {

flags lexer=codevars ; unlexer=code ; startcat=Stm ;
  lincat
    Stm = Instr ;
    Typ = SS ;
    Exp = SS ;
    Var = SS ;

  lin
    Decl  typ cont = instrc (
      "alloc_" ++ typ.s ++ cont.$0
      ) cont ;
    Assign t x exp = instrc (
      exp.s ++ 
      t.s ++ "_store" ++ x.s
      ) ;
    Return t exp   = instr (
      exp.s ++ 
      t.s ++ "_return") ;
    While exp loop = instrc (
      "TEST:" ++ exp.s ++ 
      "ifzero_goto" ++ "END" ++ ";" ++ 
      loop.s ++ 
      "END"
      ) ;
    Block stm      = instrc stm.s ;
    End            = ss [] ** {s3 = []} ;

    EVar  t x  = instr (t.s ++ "_load" ++ x.s) ;
    EInt    n  = instr ("ipush" ++ n.s) ;
    EFloat a b = instr ("fpush" ++ a.s ++ "." ++ b.s) ;
    EAddI      = binop "iadd" ;
    EAddF      = binop "fadd" ;
    EMulI      = binop "imul" ;
    EMulF      = binop "fmul" ;
    ELtI       = binop ("call" ++ "ilt") ;
    ELtF       = binop ("call" ++ "flt") ;

    TInt       = ss "i" ;
    TFloat     = ss "f" ;

}
