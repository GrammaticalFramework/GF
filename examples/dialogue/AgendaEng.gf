--# -path=.:present:prelude

concrete AgendaEng of Agenda = 
  DialogueEng, WeekdayEng ** open LangEng, ParadigmsEng in {

  lin
    Day       = UseN (regN "day") ;
    Meeting   = UseN (regN "meeting") ;
    Add       = dirV3 (regV "add") (mkPreposition "on") ;
    Remove    = dirV2 (regV "remove") ;
    Interrupt = regV "interrupt" ;
   
    day = UsePN ;

}
