--1 The Ontology of the Phrasebook

--2 Syntactic Structures of the Phrasebook

-- This module contains phrases that can be defined by a functor over the
-- resource grammar API. The phrases that are likely to have different implementations
-- are in the module Words. But the distinction is not quite sharp; thus it may happen
-- that the functor instantiations make exceptions.

abstract Sentences = Numeral ** {

-- The ontology of the phrasebook is defined by the following types. The commented ones
-- are defined in other modules.

  cat
    Phrase ;      -- complete phrase, the unit of translation  e.g. "Where are you?"
    Sentence ;    -- declarative sentence                      e.g. "I am in the bar"
    Question ;    -- question, either yes/no or wh             e.g. "where are you"
    -- Greeting ; -- idiomatic phrase, not inflected,          e.g. "hello"
    Proposition ; -- can be turned into sentence or question   e.g. "this pizza is good"
    Object ;      -- the object of wanting, ordering, etc      e.g. "three pizzas"
    Item ;        -- a single entity                           e.g. "this pizza"
    Kind ;        -- a type of an item                         e.g. "pizza"
    Quality ;     -- qualification of an item, can be complex  e.g. "very good"
    Property ;    -- basic property of an item, one word       e.g. "good"
    Place ;       -- location                                  e.g. "the bar" 
    PlaceKind ;   -- type of location                          e.g. "bar" 
    Currency ;    -- currency unit                             e.g. "leu"  
    Price ;       -- number of currency units                  e.g. "eleven leu"
    Person ;      -- agent wanting or doing something          e.g. "you" 
    Action ;      -- proposition about a Person                e.g. "you are here"
    Nationality ; -- complex of language, property, country    e.g. "Swedish, Sweden"
    Language ;    -- language (can be without nationality)     e.g. "Flemish"
    Citizenship ; -- property (can be without language)        e.g. "Belgian"
    Country ;     -- country (can be without language)         e.g. "Belgium"
    Day ;         -- weekday type                              e.g. "Friday"
    Date ;        -- definite date                             e.g. "on Friday"
    Name ;        -- name of person                            e.g. "NN"
    Number ;      -- number expression 1 .. 999,999            e.g. "twenty"

-- Many of the categories are accessible as Phrases, i.e. as translation units.

  fun
    PSentence    : Sentence -> Phrase ;
    PQuestion    : Question -> Phrase ;

    PObject      : Object   -> Phrase ;
    PKind        : Kind     -> Phrase ;
    PQuality     : Quality  -> Phrase ;
    PNumber      : Number   -> Phrase ;
    PPlace       : Place    -> Phrase ;
    PPlaceKind   : PlaceKind-> Phrase ;
    PCurrency    : Currency -> Phrase ;
    PPrice       : Price    -> Phrase ;
    PLanguage    : Language -> Phrase ;
    PCitizenship : Citizenship -> Phrase ;
    PCountry     : Country -> Phrase ;
    PDay         : Day -> Phrase ;

    PYes, PNo : Phrase ;

-- This is the way to build propositions about inanimate items.

    Is       : Item -> Quality -> Proposition ;  -- this pizza is good

-- To use propositions on higher levels.

    SProp    : Proposition -> Sentence ;         -- this pizza is good
    SPropNot : Proposition -> Sentence ;         -- this pizza isn't good
    QProp    : Proposition -> Question ;         -- is this pizza good

    WherePlace  : Place  -> Question ;           -- where is the bar
    WherePerson : Person -> Question ;           -- where are you

-- This is the way to build propositions about persons.

    PropAction : Action -> Proposition ;         -- (you (are|aren't) | are you) Swedish

-- Here are some general syntactic constructions.

    ObjItem   : Item -> Object ;                 -- this pizza
    ObjNumber : Number -> Kind -> Object ;       -- five pizzas
    ObjIndef  : Kind -> Object ;                 -- a pizza
    
    SuchKind : Quality -> Kind -> Kind ;         -- Italian pizza
    Very : Property -> Quality ;                 -- very Italian
    Too  : Property -> Quality ;                 -- too Italian      
    PropQuality : Property -> Quality ;          -- Italian

-- Determiners.

    This, That, These, Those : Kind -> Item ;    -- this pizza,...,those pizzas
    The, Thes : Kind -> Item ;                   -- the pizza, the pizzas

    AmountCurrency : Number -> Currency -> Price ;  -- five euros

    ThePlace : PlaceKind -> Place ;                  -- the bar

    IMale, IFemale,                     -- I, said by man/woman (affects agreement)
    YouFamMale, YouFamFemale,           -- familiar you, said to man/woman (affects agreement)
    YouPolMale, YouPolFemale : Person ; -- polite you, said to man/woman (affects agreement)

    LangNat    : Nationality -> Language ;    -- Swedish
    CitiNat    : Nationality -> Citizenship ; -- Swedish
    CountryNat : Nationality -> Country ;     -- Sweden
    PropCit    : Citizenship -> Property ;    -- Swedish

    OnDay      : Day -> Date ;  -- on Friday
    Today      : Date ;         -- today

    PersonName : Name -> Person ;             -- person referred by name
    NameNN     : Name ;                       -- the name "NN"

----    NameString : String -> Name ; ---- creates ambiguities with all words --%

    NNumeral   : Numeral -> Number ;          -- numeral in words, e.g. "twenty"

-- Actions are typically language-dependent, not only lexically but also
-- structurally. However, these ones are mostly functorial.

    AHave    : Person -> Kind        -> Action ;  -- you have a pizza
    ACitizen : Person -> Citizenship -> Action ;  -- you are Swedish
    ABePlace : Person -> Place       -> Action ;  -- you are in the bar

}

