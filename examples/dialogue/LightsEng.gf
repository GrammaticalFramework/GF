--# -path=.:multimodal:alltenses:prelude

concrete LightsEng of Lights = 
  DialogueEng ** open MultiEng, ParadigmsEng, AuxEng, Prelude in {

  lin
    Light       = UseN (regN "light") ;
    Room        = UseN (regN "room") ;
    SwitchOnIn  = dirV3 (partV (regV "switch") "on")  (mkPreposition "in") ;
    SwitchOffIn = dirV3 (partV (regV "switch") "off") (mkPreposition "in") ;
    SwitchOn    = dirV2 (partV (regV "switch") "on") ;
    SwitchOff   = dirV2 (partV (regV "switch") "off") ;

    LivingRoom  = defN (regN ["living-room"]) ;
    Kitchen     = defN (regN ["kitchen"]) ;

    MorningMode = mkMove (optStr "the" ++ ["morning mode"]) ;

}
