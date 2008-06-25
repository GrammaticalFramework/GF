abstract Agenda = Dialogue, Weekday ** {

  fun
    Day       : Kind ;
    Meeting   : Kind ;
    Add       : Oper2 Meeting Day ;
    Remove    : Oper1 Meeting ;
    Interrupt : Oper0 ;
   
    day : WDay -> Object Day ;

}
