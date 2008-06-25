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
    IRequest : Action -> Input ;
    IConfirm : Action -> Input ;
    IAnswer  : Proposition -> Input ;
    IIssue   : Question -> Input ;

    IYes     : Input ;
    INo      : Input ;
    IObject  : (k : Kind) -> Object k -> Input ;

    PAction  : Action -> Proposition ;

    QKind  : Kind -> Question ;

    AOper0 :                 Oper0                             -> Action ;
    AOper1 : (k   : Kind) -> Oper1 k   -> Object k             -> Action ;
    AOper2 : (k,m : Kind) -> Oper2 k m -> Object k -> Object m -> Action ;

    OAll   : (k : Kind) -> Object k ;
    OIndef : (k : Kind) -> Object k ;
    ODef   : (k : Kind) -> Object k ;

-- multimodality

  cat
    Click ;
    Input ;  -- multimodal asynchronous input
    Speech ; -- speech only
  fun
    OThis     : (k : Kind) -> Click -> Object k ;
    OThisKind : (k : Kind) -> Click -> Object k ;

    MInput : Input -> Move ;
    SInput : Input -> Speech ;

    MkClick : String -> Click ;
}
