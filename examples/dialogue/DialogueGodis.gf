--# -path=.:prelude

concrete DialogueGodis of Dialogue = open ResGodis, Prelude in {

  flags lexer=codelit ; unlexer=code ;

  lincat
    Move   = SS ;
    Action = SS ;
    Kind   = SS ;
    Object = SS ;
    Oper0  = SS ;
    Oper1  = SS ;
    Oper2  = SS ;

  lin
    MRequest a = a ;
    MAnswer  a = a ; --- ??

    MQuery k = ss (bracket (app1 "query" k.s)) ; ---

    AOper0 op         = ss (bracket (request op.s)) ;
    AOper1 k   op x   = ss (req_ans op.s k.s x.s) ; 
    AOper2 k m op x y = 
      ss (bracket (request op.s ++ "," ++ 
        answer (app1 k.s x.s) ++ "," ++ answer (app1 m.s y.s))) ;

    OAll = apps "all" ; 
    OIndef = apps "indef" ;
    ODef = apps "def" ;


}

