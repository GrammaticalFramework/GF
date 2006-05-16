--# -path=.:present:prelude

concrete LightsSwe of Lights = 
  DialogueSwe ** open LangSwe, ParadigmsSwe, AuxSwe in {

  lin
    Light       = UseN (regN "lampa") ;
    Room        = UseN (mkN "rum" "rummet" "rum" "rummen") ;
    SwitchOnIn  = dirV3 (regV "tänder")  (mkPreposition "i") ;
    SwitchOffIn = dirV3 (regV "släcker") (mkPreposition "i") ;
    SwitchOn    = dirV2 (regV "tänder") ;
    SwitchOff   = dirV2 (regV "släcker") ;

    LivingRoom  = defN (mkN "vardagsrum" "vardagsrummet" "vardagsrum" "vardagsrummen") ;
    Kitchen     = defN (mk2N "kök" "kök") ;

    MorningMode = mkMove ["morgonläget"] ;

}
