abstract Lights = Dialogue ** {

  fun
    Light        : Kind ;
    Room         : Kind ;
    SwitchOnIn   : Oper2 Light Room ;
    SwitchOffIn  : Oper2 Light Room ;
    SwitchOn     : Oper1 Light ;
    SwitchOff    : Oper1 Light ;

    LivingRoom   : Object Room ;
    Kitchen      : Object Room ;

    MorningMode  : Move ;

}
