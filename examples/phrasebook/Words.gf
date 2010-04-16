--2 Words and idiomatic phrases of the Phrasebook


-- (c) 2009 Aarne Ranta under LGPL --%

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

-- Actions (which can be expressed by different structures in different languages).
-- Notice that also negations and questions can be formed from these.

    AHasAge     : Person -> Number -> Action ;    -- I am seventy years
    AHasChildren: Person -> Number -> Action ;    -- I have six children
    AHasName    : Person -> Name   -> Action ;    -- my name is Bond
    AHasRoom    : Person -> Number -> Action ;    -- you have a room for five persons
    AHasTable   : Person -> Number -> Action ;    -- you have a table for five persons
    AHungry     : Person -> Action ;              -- I am hungry
    AIll        : Person -> Action ;              -- I am ill
    AKnow       : Person -> Action ;              -- I (don't) know
    ALike       : Person -> Item     -> Action ;  -- I like this pizza
    ALive       : Person -> Country  -> Action ;  -- I live in Sweden
    ALove       : Person -> Person   -> Action ;  -- I love you
    AMarried    : Person -> Action ;              -- I am married
    AReady      : Person -> Action ;              -- I am ready
    AScared     : Person -> Action ;              -- I am scared
    ASpeak      : Person -> Language -> Action ;  -- I speak Finnish
    AThirsty    : Person -> Action ;              -- I am thirsty
    ATired      : Person -> Action ;              -- I am tired
    AUnderstand : Person -> Action ;              -- I (don't) understand
    AWant       : Person -> Object -> Action ;    -- I want two beers
    AWantGo     : Person -> Place -> Action ;     -- I want to go to the hospital

-- Miscellaneous phrases. Notice that also negations and questions can be formed from
-- propositions.

    QWhatAge       : Person -> Question ;            -- how old are you
    QWhatName      : Person -> Question ;            -- what is your name
    HowMuchCost    : Item -> Question ;              -- how much does the pizza cost
    ItCost         : Item -> Price -> Proposition ;  -- the pizza costs five euros

    PropOpen       : Place -> Proposition ;          -- the museum is open
    PropClosed     : Place -> Proposition ;          -- the museum is closed
    PropOpenDate   : Place -> Date -> Proposition ;  -- the museum is open today
    PropClosedDate : Place -> Date -> Proposition ;  -- the museum is closed today
    PropOpenDay    : Place -> Day  -> Proposition ;  -- the museum is open on Mondays
    PropClosedDay  : Place -> Day  -> Proposition ;  -- the museum is closed on Mondays

    PSeeYou      : Date -> Phrase ;           -- see you on Monday
    PSeeYouPlace : Place -> Date -> Phrase ;  -- see you in the bar on Monday

-- family relations

    Wife, Husband  : Person -> Person ;              -- my wife, your husband
    Son, Daughter  : Person -> Person ;              -- my son, your husband
    Children       : Person -> Person ;              -- my children 

-- week days

    Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday : Day ;

    Tomorrow : Date ;

}
