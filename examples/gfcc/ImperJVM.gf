--# -path=.:../prelude
concrete ImperJVM of Imper = open ResImper in {

flags lexer=codevars ; unlexer=code ; startcat=Stm ;

  lincat
    Rec = {s,s2,s3 : Str} ; -- code, storage for locals, continuation
    Stm = Instr ;

  lin
    Empty = ss [] ;
    FunctNil val stm cont = ss (
      ".method" ++ "public" ++ "static" ++ cont.$0 ++ paren [] ++ val.s ++ ";" ++
      ".limit" ++ "locals" ++ stm.s2 ++ ";" ++
      ".limit" ++ "stack" ++ "1000" ++ ";" ++
      stm.s ++
      ".end" ++ "method" ++ ";" ++ ";" ++
      cont.s 
      ) ;
    Funct args val rec = ss (
      ".method" ++ "public" ++ "static" ++ rec.$0 ++ paren args.s ++ val.s ++ ";" ++
      ".limit"  ++ "locals" ++ rec.s2 ++ ";" ++
      ".limit"  ++ "stack"  ++ "1000" ++ ";" ++
      rec.s ++
      ".end" ++ "method" ++ ";" ++ ";" ++
      rec.s3 
      ) ;

    RecOne typ stm prg = instrb typ.s (
      ["alloc"] ++ typ.s ++ stm.$0 ++ stm.s2) {s = stm.s ; s2 = stm.s2 ; s3 = prg.s};

    RecCons typ _ body prg = instrb typ.s (
      ["alloc"] ++ typ.s ++ body.$0 ++ body.s2) 
         {s = body.s ; s2 = body.s2 ; s3 = prg.s};

    Decl  typ cont = instrb typ.s (
      ["alloc"] ++ typ.s ++ cont.$0
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
        "label" ++ test ++ ";" ++
        exp.s ++ 
        "ifeq" ++ end ++ ";" ++ 
        loop.s ++
        "goto" ++ test ++ ";" ++ 
        "label" ++ end
        ) ;
    IfElse exp t f = 
      let 
        false = "FALSE_" ++ t.s2 ++ f.s2 ; 
        true  = "TRUE_" ++ t.s2 ++ f.s2
      in instrl (
        exp.s ++ 
        "ifeq" ++ false ++ ";" ++ 
        t.s ++
        "goto" ++ true ++ ";" ++
        "label" ++ false ++ ";" ++
        f.s ++ 
        "label" ++ true
        ) ;
    Block stm      = instrc stm.s ;
    End            = ss [] ** {s2,s3 = []} ;

    EVar  t x  = instr (t.s ++ "_load" ++ x.s) ;
    EInt    n  = instr ("ldc" ++ n.s) ;
    EFloat a b = instr ("ldc" ++ a.s ++ "." ++ b.s) ;
    EAdd       = binopt "add" ;
    ESub       = binopt "sub" ;
    EMul       = binopt "mul" ;
    ELt t      = binop ("invokestatic" ++ t.s ++ "runtime/lt" ++ paren (t.s ++ t.s) ++ "i") ;
    EApp args val f exps = instr (
      exps.s ++
      "invokestatic" ++ f.s ++ paren args.s ++ val.s
      ) ;

    TNum t = t ;
    TInt   = ss "i" ;
    TFloat = ss "f" ;

    NilTyp = ss [] ;
    ConsTyp = cc2 ;

    NilExp = ss [] ;
    OneExp _ e = e ;
    ConsExp _ _ = cc2 ;
}
