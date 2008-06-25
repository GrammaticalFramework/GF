--# -path=.:multimodal:alltenses:prelude


concrete LightsSwe of Lights = 
  DialogueSwe ** open MultiSwe, ParadigmsSwe, AuxSwe in {

  lin
    Light       = UseN (regN "lampa") ;
    Room        = UseN (mkN "rum" "rummet" "rum" "rummen") ;
    SwitchOnIn  = dirV3 (regV "tänder")  (mkPrep "i") ;
    SwitchOffIn = dirV3 (regV "släcker") (mkPrep "i") ;
    SwitchOn    = dirV2 (regV "tänder") ;
    SwitchOff   = dirV2 (regV "släcker") ;

    LivingRoom  = defN (mkN "vardagsrum" "vardagsrummet" "vardagsrum" "vardagsrummen") ;
    Kitchen     = defN (mk2N "kök" "kök") ;

    MorningMode = mkMove ["morgonläget"] ;

}
