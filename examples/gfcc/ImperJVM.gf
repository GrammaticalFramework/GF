--# -path=.:../prelude
concrete ImperJVM of Imper = open ResImper in {

flags lexer=codevars ; unlexer=code ; startcat=Stm ;

  lincat
    Rec = {s,s2,s3 : Str} ; -- code, storage for locals, continuation
    Typ = {s : Str ; t : TypIdent} ;
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
    Assign t x exp = instrc (exp.s ++ typInstr "store" t.t ++ x.s) ;
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
    Block stm  = instrc stm.s ;
    Printf t e = instrc (e.s ++ "runtime" ++ typInstr "printf" t.t ++ paren (t.s) ++ "V") ;
    Return t exp   = instr (exp.s ++ typInstr "return" t.t) ;
    Returnv        = instr "return" ;
    End            = ss [] ** {s2,s3 = []} ;

    EVar  t x  = instr (typInstr "load" t.t ++ x.s) ;
    EInt    n  = instr ("ldc" ++ n.s) ;
    EFloat a b = instr ("ldc" ++ a.s ++ "." ++ b.s) ;
    EAdd t _ = binopt "add" t.t ;
    ESub t _ = binopt "sub" t.t ;
    EMul t _ = binopt "mul" t.t ;
    ELt t _ = binop ("runtime" ++ typInstr "lt" t.t ++ paren (t.s ++ t.s) ++ "I") ;
    EAppNil val f = instr (
      "static" ++ f.s ++ paren [] ++ val.s
      ) ;
    EApp args val f exps = instr (
      exps.s ++
      "static" ++ f.s ++ paren args.s ++ val.s
      ) ;

    TInt   = {s = "I" ; t = TIInt} ;
    TFloat = {s = "F" ; t = TIFloat} ;
    NilTyp = ss [] ;
    ConsTyp = cc2 ;
    OneExp _ e = e ;
    ConsExp _ _ = cc2 ;
}
