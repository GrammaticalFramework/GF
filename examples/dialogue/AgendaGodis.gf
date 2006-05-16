--# -path=.:prelude

concrete AgendaGodis of Agenda = 
  DialogueGodis, WeekdayGodis ** open ResGodis, Prelude in {

  lin
    Day       = ss "day" ;
    Meeting   = ss "meeting" ;
    Add       = ss "add" ;
    Remove    = ss "remove" ;
    Interrupt = ss "interrupt" ;
   
    day = apps "weekday" ;

}
