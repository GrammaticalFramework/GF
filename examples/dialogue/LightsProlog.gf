--# -path=.:prelude

concrete LightsProlog of Lights = 
  DialogueProlog ** open ResProlog, Prelude in {

  lin
    Light       = ss "light" ;
    Room        = ss "room" ;
    SwitchOnIn  = ss "switch_on" ;
    SwitchOffIn = ss "switch_off" ;
    SwitchOn    = ss "switch_on" ;
    SwitchOff   = ss "switch_off" ;

    LivingRoom  = ss "living_room" ;
    Kitchen     = ss "kitchen" ;

    MorningMode = ss "morning_mode" ;

}

