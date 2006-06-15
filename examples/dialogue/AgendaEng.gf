--# -path=.:multimodal:alltenses:prelude

concrete AgendaEng of Agenda = 
  DialogueEng, WeekdayEng ** open MultiEng, ParadigmsEng in {

  lin
    Day       = UseN (regN "day") ;
    Meeting   = UseN (regN "meeting") ;
    Add       = dirV3 (regV "add") (mkPrep "on") ;
    Remove    = dirV2 (regV "remove") ;
    Interrupt = regV "interrupt" ;
   
    day = UsePN ;

}
