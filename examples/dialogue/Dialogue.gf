abstract Dialogue = {

  flags startcat=Move ;

  cat
    Move ;
    Action ;
    Proposition ;
    Question ;
    Kind ;
    Object Kind ;
    Oper0 ;
    Oper1 Kind ;
    Oper2 Kind Kind ;

  fun
    MRequest : Action -> Move ;
    MConfirm : Action -> Move ;
    MAnswer  : Proposition -> Move ;
    MIssue   : Question -> Move ;

    MYes     : Move ;
    MNo      : Move ;
    MObject  : (k : Kind) -> Object k -> Move ;

    PAction  : Action -> Proposition ;

    QKind  : Kind -> Question ;

    AOper0 :                 Oper0                             -> Action ;
    AOper1 : (k   : Kind) -> Oper1 k   -> Object k             -> Action ;
    AOper2 : (k,m : Kind) -> Oper2 k m -> Object k -> Object m -> Action ;

    OAll   : (k : Kind) -> Object k ;
    OIndef : (k : Kind) -> Object k ;
    ODef   : (k : Kind) -> Object k ;


}
