-- (c) 2009 Aarne Ranta under LGPL

abstract Words = Sentences ** {
  fun
    Wine, Beer, Water, Coffee, Tea : Kind ; 
    Cheese, Fish, Pizza : Kind ;
    Fresh, Warm, Italian, 
      Expensive, Delicious, Boring, Good : Property ;

    Bar, Restaurant, Toilet : PlaceKind ;

    Euro, Dollar, Lei : Currency ;

    English, Finnish, French, Romanian, Swedish : Language ;

-- actions can be expressed by different structures in different languages

    AWant  : Person -> Object   -> Action ;
    ALike  : Person -> Item     -> Action ; 
    AHave  : Person -> Kind     -> Action ;
    ASpeak : Person -> Language -> Action ;
    ALove  : Person -> Person   -> Action ;

    AHungry  : Person -> Action ;
    AThirsty : Person -> Action ;
    ATired   : Person -> Action ;
    AScared  : Person -> Action ;
    AUnderstand : Person -> Action ;

}
