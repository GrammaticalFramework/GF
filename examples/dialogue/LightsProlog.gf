--# -path=.:prelude

concrete LightsProlog of Lights = 
  DialogueProlog ** open ResProlog, Prelude in {

  lin
    Light       = ss "light" ;
    Room        = ss "room" ;
    SwitchOnIn  = op2 "switch_on"  "switch_what" "switch_where" ;
    SwitchOffIn = op2 "switch_off" "switch_what" "switch_where" ;
    SwitchOn    = op1 "switch_on"  "switch_what" ;
    SwitchOff   = op1 "switch_off" "switch_what" ;

    LivingRoom  = ss "living_room" ;
    Kitchen     = ss "kitchen" ;

    MorningMode = ss "morning_mode" ;

}

