-- (c) 2009 Aarne Ranta under LGPL

abstract Words = Sentences ** {
  fun
    Wine, Beer, Water, Coffee, Tea : Kind ; 
    Cheese, Fish, Pizza : Kind ;
    Fresh, Warm, 
      Expensive, Delicious, Boring, Good : Property ;

    Bar, Restaurant, Toilet, 
      Museum, Airport, Station, Hospital, Church : PlaceKind ;

    Euro, Dollar, Lei : Currency ;

    English, Finnish, French, Italian, Romanian, Swedish : Nationality ;
    Belgian : Citizenship ;
    Flemish : Language ;
    Belgium : Country ;

    Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday : Day ;

-- actions can be expressed by different structures in different languages

    AWant    : Person -> Object   -> Action ;
    ALike    : Person -> Item     -> Action ; 
    ASpeak   : Person -> Language -> Action ;
    ALove    : Person -> Person   -> Action ;
    AHungry  : Person -> Action ;
    AThirsty : Person -> Action ;
    ATired   : Person -> Action ;
    AIll     : Person -> Action ;
    AScared  : Person -> Action ;
    AUnderstand : Person -> Action ;
    AKnow    : Person -> Action ;
    AWantGo  : Person -> Place -> Action ;
    AHasName : Person -> Name -> Action ;
    ALive    : Person -> Country -> Action ;

    QWhatName : Person -> Question ;

    PropOpen       : Place -> Proposition ;
    PropClosed     : Place -> Proposition ;
    PropOpenDate   : Place -> Date -> Proposition ;
    PropClosedDate : Place -> Date -> Proposition ;
    PropOpenDay    : Place -> Day  -> Proposition ;
    PropClosedDay  : Place -> Day  -> Proposition ;

}
