--2 Words and idiomatic phrases of the Phrasebook


-- (c) 2010 Aarne Ranta under LGPL --%

abstract Words = Sentences ** {

  fun

-- kinds of items (so far mostly food stuff)

    Apple : Kind ;
    Beer : DrinkKind ;
    Bread : MassKind ; 
    Cheese : MassKind ;
    Chicken : MassKind ; 
    Coffee : DrinkKind ; 
    Fish : MassKind ; 
    Meat : MassKind ;
    Milk : MassKind ; 
    Pizza : Kind ; 
    Salt : MassKind ;
    Tea : DrinkKind ; 
    Water : DrinkKind ; 
    Wine : DrinkKind ;

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
    AmusementPark : PlaceKind ;
    Bank : PlaceKind ;
    Bar : PlaceKind ;
    Cafeteria : PlaceKind ;
    Center : PlaceKind ;
    Cinema : PlaceKind ;
    Church : PlaceKind ;
    Disco : PlaceKind ;
    Hospital : PlaceKind ;
    Hotel : PlaceKind ;
    Museum : PlaceKind ;
    Park : PlaceKind ;
    Parking : PlaceKind ;
    Pharmacy : PlaceKind ;
    PostOffice : PlaceKind ;
    Pub : PlaceKind ;
    Restaurant : PlaceKind ;
    School : PlaceKind ;
    Shop : PlaceKind ;
    Station : PlaceKind ;
    Supermarket : PlaceKind ;
    Theatre : PlaceKind ; 
    Toilet : PlaceKind ; 
    University : PlaceKind ;
    Zoo : PlaceKind ;
   
    CitRestaurant : Citizenship -> PlaceKind ;

-- currency units

    DanishCrown : Currency ; 
    Dollar : Currency ; 
    Euro : Currency ; -- Germany, France, Italy, Finland, Spain, The Netherlands
    Lei : Currency ; -- Romania
    Leva : Currency ; -- Bulgaria
    NorwegianCrown : Currency ;
    Pound : Currency ; -- UK
    Rouble : Currency ; -- Russia
    Rupee : Currency ; -- India
    SwedishCrown : Currency ;
    Zloty : Currency ; -- Poland
    Yuan : Currency ; -- China

  
-- nationalities, countries, languages, citizenships

    Belgian : Citizenship ;
    Belgium : Country ;
    Bulgarian : Nationality ;
    Catalan : Nationality ;
    Chinese : Nationality ;
    Danish : Nationality ;
    Dutch : Nationality ;
    English : Nationality ;
    Finnish : Nationality ;
    Flemish : LAnguage ;
    French : Nationality ;
    German : Nationality ;
    Hindi : LAnguage ;
    India : Country ;
    Indian : Citizenship ;
    Italian : Nationality ;
    Norwegian : Nationality ;
    Polish : Nationality ;
    Romanian : Nationality ;
    Russian : Nationality ;
    Spanish : Nationality ;
    Swedish : Nationality ;

-- means of transportation 

    Bike : Transport ; 
    Bus : Transport ;
    Car : Transport ;
    Ferry : Transport ;
    Plane : Transport ;
    Subway : Transport ;
    Taxi : Transport ;
    Train : Transport ;
    Tram : Transport ;

    ByFoot : ByTransport ;


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
    ASpeak      : Person -> LAnguage -> Action ;  -- I speak Finnish
    AThirsty    : Person -> Action ;              -- I am thirsty
    ATired      : Person -> Action ;              -- I am tired
    AUnderstand : Person -> Action ;              -- I (don't) understand
    AWant       : Person -> Object -> Action ;    -- I want two apples
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

    PSeeYouPlaceDate : Place -> Date -> Greeting ;   -- see you in the bar on Monday
    PSeeYouPlace     : Place         -> Greeting ;   -- see you in the bar
    PSeeYouDate      :          Date -> Greeting ;   -- see you on Monday

-- family relations

    Wife, Husband  : Person -> Person ;              -- my wife, your husband
    Son, Daughter  : Person -> Person ;              -- my son, your husband
    Children       : Person -> Person ;              -- my children 

-- week days

    Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday : Day ;

    Tomorrow : Date ;

-- transports

    HowFar : Place -> Question ;                  -- how far is the zoo ?
    HowFarFrom : Place -> Place -> Question ;     -- how far is the center from the hotel ?
    HowFarFromBy : Place -> Place -> ByTransport -> Question ; 
                                            -- how far is the airport from the hotel by taxi ? 
    HowFarBy : Place -> ByTransport -> Question ;   -- how far is the museum by bus ?
                          
    WhichTranspPlace : Transport -> Place -> Question ;   -- which bus goes to the hotel
    IsTranspPlace    : Transport -> Place -> Question ;   -- is there a metro to the airport ?

-- modifiers of places

    TheBest : Superlative ;
    TheClosest : Superlative ;
    TheCheapest : Superlative ;
    TheMostExpensive : Superlative ;
    TheMostPopular : Superlative ;
    TheWorst : Superlative ;

    SuperlPlace : Superlative -> PlaceKind -> Place ; -- the best bar


--------------------------------------------------
-- New 30/11/2011 AR
--------------------------------------------------
{- 28/8/2012 still only available in Bul Eng Fin Swe Tha

  fun
    Thai : Nationality ;
    Baht : Currency ; -- Thailand

    Rice : MassKind ;
    Pork : MassKind ;
    Beef : MassKind ;
    Noodles : PlurKind ;
    Shrimps : PlurKind ;
    
    Chili : MassKind ;
    Garlic : MassKind ;

    Durian : Kind ;
    Mango : Kind ;
    Pineapple : Kind ;
    Egg : Kind ;

    Coke : DrinkKind ;
    IceCream : DrinkKind ; --- both mass and plural
    OrangeJuice : DrinkKind ;
    Lemonade : DrinkKind ;
    Salad : DrinkKind ;

    Beach : PlaceKind ;

    ItsRaining : Proposition ;
    ItsWindy : Proposition ;
    ItsWarm : Proposition ;
    ItsCold : Proposition ;
    SunShine : Proposition ;

    Smoke : VerbPhrase ;

    ADoctor : Person -> Action ;
    AProfessor : Person -> Action ;
    ALawyer : Person -> Action ;
    AEngineer : Person -> Action ;
    ATeacher : Person -> Action ;
    ACook : Person -> Action ;
    AStudent : Person -> Action ;
    ABusinessman : Person -> Action ;
-}

}
