--# -path=.:multimodal:alltenses:prelude

concrete LightsFin of Lights = 
  DialogueFin ** open MultiFin, ParadigmsFin, AuxFin in {

  lin
    Light       = UseN (regN "valo") ;
    Room        = UseN (regN "huone") ;
    SwitchOnIn  = dirV3 (regV "sytyttää")  inessive ;
    SwitchOffIn = dirV3 (regV "sammuttaa") inessive ;
    SwitchOn    = dirV2 (regV "sytyttää") ;
    SwitchOff   = dirV2 (regV "sammuttaa") ;

    LivingRoom  = defN (regN "olohuone") ;
    Kitchen     = defN (regN "keittiö") ;

    MorningMode = mkMove ["aamuvalaistus"] ;

}
