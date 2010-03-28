-- (c) 2009 Aarne Ranta under LGPL

abstract Words = Sentences ** {
  fun
    Wine, Beer, Water, Coffee, Tea : Kind ; 
    Cheese, Fish, Pizza : Kind ;
    Fresh, Warm, Italian, 
      Expensive, Delicious, Boring : Quality ;

    Bar, Restaurant, Toilet : PlaceKind ;

    Euro, Dollar, Lei : Currency ;

}
