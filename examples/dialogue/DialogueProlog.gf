--# -path=.:prelude

concrete DialogueProlog of Dialogue = open ResProlog, Prelude in {

  flags lexer=codelit ; unlexer=code ;

  lincat
    Move   = SS ;
    Action = SS ;
    Proposition = SS ;
    Question = SS ;
    Kind   = SS ;
    Object = SS ;
    Oper0  = SS ;
    Oper1  = {s, x : Str} ;
    Oper2  = {s, x, y : Str} ;

  lin
    MRequest a = a ;
    MConfirm a = a ; --- ??
    MAnswer  a = a ; --- ??
    MIssue   a = ss (bracket (app1 "ask" a.s)) ; --- ??

    MYes = ss (bracket (app1 "answer" "yes")) ;
    MNo  = ss (bracket (app1 "answer" "no")) ;
    MObject _ ob = ss (bracket (apps "answer" ob).s) ;

    QKind k = ss (app2 "q" "X" (app1 k.s "X")) ;

    AOper0 op          = ss (bracket (request op.s)) ;
    AOper1 _   op  x   = ss (req_ans op.s op.x x.s) ; 
    AOper2 _ _ op  x y =  
      ss (bracket (request op.s ++ "," ++ 
        answer (app1 op.x x.s) ++ "," ++ answer (app1 op.y y.s))) ;

    OAll = apps "all" ; 
    OIndef = apps "indef" ;
    ODef = apps "def" ;


}

