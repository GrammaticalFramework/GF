--# -path=.:prelude

concrete DialogueProlog of Dialogue = open ResProlog, Prelude in {

  flags lexer=codelit ; unlexer=code ;

  lincat
    Move   = SS ;
    Action = SS ;
    Kind   = SS ;
    Object = SS ;
    Oper0  = SS ;
    Oper1  = {s, x : Str} ;
    Oper2  = {s, x, y : Str} ;

  lin
    MRequest a = a ;
    MAnswer  a = a ; --- ??

    MQuery k = ss (bracket (app1 "query" k.s)) ; ---

    AOper0 op          = ss (bracket (request op.s)) ;
    AOper1 _   op  x   = ss (req_ans op.s op.x x.s) ; 
    AOper2 _ _ op  x y =  
      ss (bracket (request op.s ++ "," ++ 
        answer (app1 op.x x.s) ++ "," ++ answer (app1 op.y y.s))) ;

    OAll = apps "all" ; 
    OIndef = apps "indef" ;
    ODef = apps "def" ;


}

