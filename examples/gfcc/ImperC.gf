--# -path=.:../prelude

concrete ImperC of Imper = open Prelude, Precedence, ResImper in {

flags lexer=codevars ; unlexer=code ; startcat=Stm ;

-- code inside function bodies

  lincat
    Stm = SS ;
    Typ = SS ;
    Exp = PrecExp ;
    Var = SS ;

  lin
    Decl  typ cont = continue  (typ.s ++ cont.$0) cont ;
    Assign _ x exp = continue  (x.s ++ "=" ++ ex exp) ;
    Return _ exp   = statement ("return" ++ ex exp) ;
    While exp loop = continue  ("while" ++ paren (ex exp) ++ loop.s) ;
    Block stm      = continue  ("{" ++ stm.s ++ "}") ;
    End            = statement [] ;
 
    EVar  _ x  = constant x.s ;
    EInt    n  = constant n.s ;
    EFloat a b = constant (a.s ++ "." ++ b.s) ;
    EMulI      = infixL p3 "*" ;
    EMulF      = infixL p3 "*" ;
    EAddI      = infixL p2 "+" ;
    EAddF      = infixL p2 "+" ;
    ELtI       = infixN p1 "<" ;
    ELtF       = infixN p1 "<" ;

    TInt       = ss "int" ;
    TFloat     = ss "float" ;

-- top-level code consisting of function definitions
 
  lincat
    Program = SS ;
    Typs = SS ;
    Fun = SS ;
    Body = {s,s2 : Str ; size : Size} ;
    Exps = {s    : Str ; size : Size} ;

  lin
    Empty = ss [] ;
    Funct args val body cont = ss (
      val.s ++ cont.$0 ++ paren body.s2 ++ "{" ++ 
        body.s ++ 
      "}" ++ ";" ++ 
      cont.s
      ) ;

    NilTyp = ss [] ;
    ConsTyp = cc2 ;

    BodyNil stm = stm ** {s2 = [] ; size = Zero} ;
    BodyCons typ _ body = {
      s  = body.s ; 
      s2 = typ.s ++ body.$0 ++ separator "," body.size ++ body.s2 ;
      size = nextSize body.size
      } ;

    EApp args val f exps = constant (f.s ++ paren exps.s) ;

    NilExp = ss [] ** {size = Zero} ;
    ConsExp _ _ e es = {
      s = ex e ++ separator "," es.size ++ es.s ;
      size = nextSize es.size
      } ;
}
