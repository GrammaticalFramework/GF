--# -path=.:../prelude

concrete ImperC of Imper = open Prelude, Precedence, ResImper in {

flags lexer=codevars ; unlexer=code ; startcat=Stm ;
  lincat
    Stm = SS ;
    Typ = SS ;
    Exp = {s : PrecTerm} ;
    Var = SS ;

  lin
    Decl  typ cont = continue  (typ.s ++ cont.$0) cont ;
    Assign _ x exp = statement (x.s ++ "=" ++ ex exp) ;
    Return _ exp   = statement ("return" ++ ex exp) ;
    While exp loop = statement ("while" ++ paren (ex exp) ++ loop.s) ;
    Block stm      = ss ("{" ++ stm.s ++ "}") ;
    None           = ss ";" ;
    Next stm cont  = ss (stm.s ++ cont.s) ;      

    EVar  _ x  = constant x.s ;
    EInt    n  = constant n.s ;
    EFloat a b = constant (a.s ++ "." ++ b.s) ;
    EAddI      = infixL p2 "+" ;
    EAddF      = infixL p2 "+" ;

    TInt       = ss "int" ;
    TFloat     = ss "float" ;
 
  lincat
    Program = SS ;
    Typs = SS ;
    Fun = SS ;
    Body = {s,s2 : Str} ;
    Exps = SS ;

  lin
    Empty = ss [] ;
    Funct args val body cont = ss (
      val.s ++ cont.$0 ++ paren body.s2 ++ "{" ++ 
        body.s ++ 
      "}" ++ ";" ++ 
      cont.s
      ) ;

    BodyNil stm = stm ** {s2 = []} ;
    BodyCons typ _ body = {s = body.s ; s2 = typ.s ++ body.$0 ++ "," ++ body.s2} ;

    EApp args val f exps = constant (f.s ++ paren exps.s) ;

    NilExp = ss [] ;
    ConsExp _ _ e es = ss (ex e ++ "," ++ es.s) ;

}
