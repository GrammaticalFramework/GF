-- (c) 2009 Aarne Ranta under LGPL

abstract Words = Sentences ** {

  fun

-- kinds of items (so far mostly food stuff)

    Apple : Kind ;
    Beer : Kind ;
    Bread : Kind ; 
    Cheese : Kind ;
    Chicken : Kind ; 
    Coffee : Kind ; 
    Fish : Kind ; 
    Meat : Kind ;
    Milk : Kind ; 
    Pizza : Kind ; 
    Salt : Kind ; 
    Tea : Kind ; 
    Water : Kind ; 
    Wine : Kind ;

-- properties of kinds (so far mostly of food)

    Bad : Property ;
    Boring : Property ;
    Cheap : Property ; 
    Cold : Property ; 
    Delicious : Property ;  
    Expensive : Property ; 
    Fresh : Property ; 
    Good : Property ;
    Suspect : Property ;
    Warm : Property ; 

-- kinds of places

    Airport : PlaceKind ;
    Bar : PlaceKind ;
    Cinema : PlaceKind ;
    Church : PlaceKind ;
    Hospital : PlaceKind ;
    Hotel : PlaceKind ;
    Museum : PlaceKind ;
    Park : PlaceKind ;
    Restaurant : PlaceKind ;
    School : PlaceKind ;
    Shop : PlaceKind ;
    Station : PlaceKind ;
    Theatre : PlaceKind ; 
    Toilet : PlaceKind ; 
    University : PlaceKind ;

-- currency units

    DanishCrown : Currency ;
    Dollar : Currency ; 
    Euro : Currency ;
    Lei : Currency ;
    SwedishCrown : Currency ;

-- nationalities, countries, languages, citizenships

    Belgian : Citizenship ;
    Belgium : Country ;
    English : Nationality ;
    Finnish : Nationality ;
    Flemish : Language ;
    French : Nationality ;
    Italian : Nationality ;
    Romanian : Nationality ;
    Swedish : Nationality ;

-- actions (which can be expressed by different structures in different languages)

    AHasName    : Person -> Name -> Action ;
    AHungry     : Person -> Action ;
    AIll        : Person -> Action ;
    AKnow       : Person -> Action ;
    ALike       : Person -> Item     -> Action ; 
    ALive       : Person -> Country -> Action ;
    ALove       : Person -> Person   -> Action ;
    AScared     : Person -> Action ;
    ASpeak      : Person -> Language -> Action ;
    AThirsty    : Person -> Action ;
    ATired      : Person -> Action ;
    AUnderstand : Person -> Action ;
    AWant       : Person -> Object   -> Action ;
    AWantGo     : Person -> Place -> Action ;

-- miscellaneous phrases

    QWhatName      : Person -> Question ;

    PropOpen       : Place -> Proposition ;
    PropClosed     : Place -> Proposition ;
    PropOpenDate   : Place -> Date -> Proposition ;
    PropClosedDate : Place -> Date -> Proposition ;
    PropOpenDay    : Place -> Day  -> Proposition ;
    PropClosedDay  : Place -> Day  -> Proposition ;

    HowMuchCost    : Item -> Question ;              -- how much does the pizza cost
    ItCost         : Item -> Price -> Proposition ;  -- the pizza costs five euros

-- week days

    Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday : Day ;

}
