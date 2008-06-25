--# -path=.:multimodal:alltenses:prelude

concrete AgendaFin of Agenda = 
  DialogueFin, WeekdayFin ** open MultiFin, ParadigmsFin in {

  lin
    Day       = UseN (regN "p‰iv‰") ;
    Meeting   = UseN (regN "kokous") ;
    Add       = dirV3 (regV "lis‰t‰") translative ;
    Remove    = dirV2 (regV "poistaa") ;
    Interrupt = regV "keskeytt‰‰" ;
   
    day = UsePN ;

}
