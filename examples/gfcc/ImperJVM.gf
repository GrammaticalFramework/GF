concrete ImperJVM of Imper = open ResImper in {

flags lexer=codevars ; unlexer=code ; startcat=Stm ;

  lincat
    Body  = {s,s2 : Str} ; -- code, storage for locals
    Stm = Instr ;

  lin
    Empty = ss [] ;
    Funct args val body rest = ss (
      ".method" ++ rest.$0 ++ paren args.s ++ val.s ++ ";" ++
      ".limit" ++ "locals" ++ body.s2 ++ ";" ++
      ".limit" ++ "stack" ++ "1000" ++ ";" ++
      body.s ++
      ".end" ++ "method" ++ ";" ++
      rest.s 
      ) ;
    BodyNil stm = stm ;
    BodyCons a as body = instrb a.s (
      "alloc" ++ a.s ++ body.$0 ++ body.s2) (body ** {s3 = []});

    Decl  typ cont = instrb typ.s (
      "alloc" ++ typ.s ++ cont.$0
      ) cont ;
    Assign t x exp = instrc (
      exp.s ++ 
      t.s ++ "_store" ++ x.s
      ) ;
    Return t exp   = instr (
      exp.s ++ 
      t.s ++ "_return") ;
    While exp loop = 
      let 
        test = "TEST_" ++ loop.s2 ; 
        end = "END_" ++ loop.s2
      in instrl (
        test ++ ";" ++
        exp.s ++ 
        "ifzero" ++ end ++ ";" ++ 
        loop.s ++
        "goto" ++ test ++ ";" ++ 
        end
        ) ;
    IfElse exp t f = 
      let 
        false = "FALSE_" ++ t.s2 ++ f.s2 ; 
        true  = "TRUE_" ++ t.s2 ++ f.s2
      in instrl (
        exp.s ++ 
        "ifzero" ++ false ++ ";" ++ 
        t.s ++
        "goto" ++ true ++ ";" ++
        false ++ ";" ++
        f.s ++ 
        true
        ) ;
    Block stm      = instrc stm.s ;
    End            = ss [] ** {s2,s3 = []} ;

    EVar  t x  = instr (t.s ++ "_load" ++ x.s) ;
    EInt    n  = instr ("ipush" ++ n.s) ;
    EFloat a b = instr ("fpush" ++ a.s ++ "." ++ b.s) ;
    EAddI      = binop "iadd" ;
    EAddF      = binop "fadd" ;
    ESubI      = binop "isub" ;
    ESubF      = binop "fsub" ;
    EMulI      = binop "imul" ;
    EMulF      = binop "fmul" ;
    ELtI       = binop ("call" ++ "ilt") ;
    ELtF       = binop ("call" ++ "flt") ;
    EApp args val f exps = instr (
      exps.s ++
      "invoke" ++ f.s ++ paren args.s ++ val.s
      ) ;

    TInt   = ss "i" ;
    TFloat = ss "f" ;

    NilTyp = ss [] ;
    ConsTyp = cc2 ;

    NilExp = ss [] ;
    ConsExp _ _ = cc2 ;
}
