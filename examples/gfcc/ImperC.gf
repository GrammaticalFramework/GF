--# -path=.:../prelude
concrete ImperC of Imper = open ResImper in {
  flags lexer=codevars ; unlexer=code ; startcat=Stm ;

  lincat
    Exp = PrecExp ;
    Body = {s,s2 : Str} ;

  lin
    Empty = ss [] ;
    Funct args val body cont = ss (
      val.s ++ cont.$0 ++ paren body.s2 ++ "{" ++ 
      body.s ++ "}" ++ ";" ++ cont.s) ;

    BodyNil stm = stm ** {s2 = []} ;
    BodyOne typ stm = stm ** {
      s2 = typ.s ++ stm.$0
      } ;
    BodyCons typ _ body = {
      s  = body.s ; 
      s2 = typ.s ++ body.$0 ++ "," ++ body.s2 ;
      } ;

    Decl  typ cont = continues (typ.s ++ cont.$0) cont ;
    Assign _ x exp = continues (x.s ++ "=" ++ ex exp) ;
    Return _ exp   = statement ("return" ++ ex exp) ;
    While exp loop = continue  ("while" ++ paren (ex exp) ++ loop.s) ;
    IfElse exp t f = continue  ("if" ++ paren (ex exp) ++ t.s ++ "else" ++ f.s) ;
    Block stm      = continue  ("{" ++ stm.s ++ "}") ;
    End            = ss [] ;
 
    EVar  _ x  = constant x.s ;
    EInt    n  = constant n.s ;
    EFloat a b = constant (a.s ++ "." ++ b.s) ;
    EMul _     = infixL P2 "*" ;
    EAdd _     = infixL P1 "+" ;
    ESub _     = infixL P1 "-" ;
    ELt _      = infixN P0 "<" ;

    EApp args val f exps = constant (f.s ++ paren exps.s) ;

    TNum t  = t ;
    TInt    = ss "int" ;
    TFloat  = ss "float" ;
    NilTyp  = ss [] ;
    ConsTyp = cc2 ;

    NilExp = ss [] ;
    OneExp _ e = ss (ex e) ;
    ConsExp _ _ e es = ss (ex e ++ "," ++ es.s) ;
}
