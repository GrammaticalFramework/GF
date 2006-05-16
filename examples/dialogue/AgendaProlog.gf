--# -path=.:prelude

concrete AgendaProlog of Agenda = 
  DialogueProlog, WeekdayProlog ** open ResProlog, Prelude in {

  lin
    Day       = ss "day" ;
    Meeting   = ss "meeting" ;
    Add       = ss "add" ;
    Remove    = ss "remove" ;
    Interrupt = ss "interrupt" ;
   
    day = apps "weekday" ;

}
