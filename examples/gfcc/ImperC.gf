concrete ImperC of Imper = open ResImper in {
  flags lexer=codevars ; unlexer=code ; startcat=Stm ;

  lincat
    Exp = PrecExp ;
    Body = {s,s2 : Str ; size : Size} ;
    ListExp = {s    : Str ; size : Size} ;

  lin
    Empty = ss [] ;
    Funct args val body cont = ss (
      val.s ++ cont.$0 ++ paren body.s2 ++ "{" ++ 
      body.s ++ "}" ++ ";" ++ cont.s) ;

    BodyNil stm = stm ** {s2 = [] ; size = Zero} ;
    BodyCons typ _ body = {
      s  = body.s ; 
      s2 = typ.s ++ body.$0 ++ separator "," body.size ++ body.s2 ;
      size = nextSize body.size
      } ;

    Decl  typ cont = continues (typ.s ++ cont.$0) cont ;
    Assign _ x exp = continues (x.s ++ "=" ++ ex exp) ;
    Return _ exp   = statement ("return" ++ ex exp) ;
    While exp loop = continue  ("while" ++ paren (ex exp) ++ loop.s) ;
    IfElse exp t f = continue  ("if" ++ paren (ex exp) ++ t.s ++ "else" ++ f.s) ;
    Block stm      = continue  ("{" ++ stm.s ++ "}") ;
    End            = ss [] ;
 
    EVar  _ x    = constant x.s ;
    EInt    n    = constant n.s ;
    EFloat a b   = constant (a.s ++ "." ++ b.s) ;
    EMulI, EMulF = infixL P2 "*" ;
    EAddI, EAddF = infixL P1 "+" ;
    ESubI, ESubF = infixL P1 "-" ;
    ELtI,  ELtF  = infixN P0 "<" ;

    EApp args val f exps = constant (f.s ++ paren exps.s) ;

    TInt    = ss "int" ;
    TFloat  = ss "float" ;
    NilTyp  = ss [] ;
    ConsTyp = cc2 ;

    NilExp = ss [] ** {size = Zero} ;
    ConsExp _ _ e es = {
      s = ex e ++ separator "," es.size ++ es.s ;
      size = nextSize es.size
      } ;
}
