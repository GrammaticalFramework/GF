--# -path=.:prelude

concrete AgendaProlog of Agenda = 
  DialogueProlog, WeekdayProlog ** open ResProlog, Prelude in {

  lin
    Day       = ss "day" ;
    Meeting   = ss "meeting" ;
    Add       = op2 "add_event" "event_to_store" "date_to_store" ;
    Remove    = op1 "remove_event" "event_to_remove" ;
    Interrupt = ss "interrupt" ;
   
    day = apps "weekday" ;

}
