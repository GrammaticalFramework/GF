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
    Word ;        -- word that could be used as phrase         e.g. "Monday"
    Message ;     -- sequence of phrases, longest unit         e.g. "Hello! Where are you?"
    Greeting ;    -- idiomatic greeting                        e.g. "hello"
    Sentence ;    -- declarative sentence                      e.g. "I am in the bar"
    Question ;    -- question, either yes/no or wh             e.g. "where are you"
    Proposition ; -- can be turned into sentence or question   e.g. "this pizza is good"
    Object ;      -- the object of wanting, ordering, etc      e.g. "three pizzas and a beer"
    PrimObject ;  -- single object of wanting, ordering, etc   e.g. "three pizzas"
    Item ;        -- a single entity                           e.g. "this pizza"
    Kind ;        -- a type of an item                         e.g. "pizza"
    MassKind ;    -- a type mass (uncountable)                 e.g. "water"
    PlurKind ;    -- a type usually only in plural             e.g. "noodles"
    DrinkKind ;   -- a drinkable, countable type               e.g. "beer"
    Quality ;     -- qualification of an item, can be complex  e.g. "very good"
    Property ;    -- basic property of an item, one word       e.g. "good"
    Place ;       -- location                                  e.g. "the bar" 
    PlaceKind ;   -- type of location                          e.g. "bar" 
    Currency ;    -- currency unit                             e.g. "leu"  
    Price ;       -- number of currency units                  e.g. "eleven leu"
    Person ;      -- agent wanting or doing something          e.g. "you" 
    Action ;      -- proposition about a Person                e.g. "you are here"
    Nationality ; -- complex of language, property, country    e.g. "Swedish, Sweden"
    LAnguage ;    -- language (can be without nationality)     e.g. "Flemish"
    Citizenship ; -- property (can be without language)        e.g. "Belgian"
    Country ;     -- country (can be without language)         e.g. "Belgium"
    Day ;         -- weekday type                              e.g. "Friday"
    Date ;        -- definite date                             e.g. "on Friday"
    Name ;        -- name of person                            e.g. "NN"
    Number ;      -- number expression 1 .. 999,999            e.g. "twenty"
    Transport ;   -- transportation device                     e.g. "car"
    ByTransport ; -- mean of transportation                    e.g. "by tram"
    Superlative ; -- superlative modifiers of places           e.g. "the best restaurant"


  fun 

-- To build a whole message

    MPhrase   : Phrase -> Message ;
    MContinue : Phrase -> Message -> Message ;

-- Many of the categories are accessible as Phrases, i.e. as translation units.
-- To regulate whether words appear on the top level, change their status between
-- Word and Phrase, or uncomment PWord,

    --    PWord : Word -> Phrase ;

    PGreetingMale   : Greeting -> Phrase ;  -- depends on speaker e.g. in Thai
    PGreetingFemale : Greeting -> Phrase ;
    PSentence       : Sentence -> Phrase ;
    PQuestion       : Question -> Phrase ;

    PNumber      : Number      -> Phrase ;
    PPrice       : Price       -> Phrase ;
    PObject      : Object      -> Word ;
    PKind        : Kind        -> Word ;
    PMassKind    : MassKind    -> Word ;
    PQuality     : Quality     -> Word ;
    PPlace       : Place       -> Word ;
    PPlaceKind   : PlaceKind   -> Word ;
    PCurrency    : Currency    -> Word ;
    PLanguage    : LAnguage    -> Word ;
    PCitizenship : Citizenship -> Word ;
    PCountry     : Country     -> Word ;
    PDay         : Day         -> Word ;
    PByTransport : ByTransport -> Word ;
    PTransport   : Transport   -> Word ;

    PYes, PNo, PYesToNo : Greeting ;  -- yes, no, si/doch (pos. answer to neg. question)

-- To order something.

    GObjectPlease : Object -> Greeting ;           -- a pizza and beer, please!

-- This is the way to build propositions about inanimate items.

    Is     : Item -> Quality -> Proposition ;      -- this pizza is good
    IsMass : MassKind -> Quality -> Proposition ;  -- Belgian beer is good

-- To use propositions on higher levels.

    SProp    : Proposition -> Sentence ;         -- this pizza is good
    SPropNot : Proposition -> Sentence ;         -- this pizza isn't good
    QProp    : Proposition -> Question ;         -- is this pizza good

    WherePlace  : Place  -> Question ;           -- where is the bar
    WherePerson : Person -> Question ;           -- where are you

-- This is the way to build propositions about persons.

    PropAction : Action -> Proposition ;         -- (you (are|aren't) | are you) Swedish

-- Here are some general syntactic constructions.

    ObjItem   : Item -> PrimObject ;             -- this pizza
    ObjNumber : Number -> Kind -> PrimObject ;   -- five pizzas
    ObjIndef  : Kind -> PrimObject ;             -- a pizza
    ObjPlural : Kind -> PrimObject ;             -- pizzas
    ObjPlur   : PlurKind -> PrimObject ;         -- noodles
    ObjMass   : MassKind -> PrimObject ;         -- water
    ObjAndObj : PrimObject -> Object -> Object ; -- this pizza and a beer
    OneObj    : PrimObject -> Object ;           -- this pizza
    
    SuchKind : Quality -> Kind -> Kind ;         -- Italian pizza
    SuchMassKind : Quality -> MassKind -> MassKind ; -- Italian water
    Very : Property -> Quality ;                 -- very Italian
    Too  : Property -> Quality ;                 -- too Italian      
    PropQuality : Property -> Quality ;          -- Italian

    MassDrink   : DrinkKind -> MassKind ;               -- beer
    DrinkNumber : Number -> DrinkKind -> PrimObject ;   -- five beers

-- Determiners.

    This, That, These, Those : Kind -> Item ;           -- this pizza,...,those pizzas
    The, Thes : Kind -> Item ;                          -- the pizza, the pizzas
    ThisMass, ThatMass, TheMass : MassKind -> Item ;    -- this/that/the water
    ThesePlur, ThosePlur, ThesPlur : PlurKind -> Item ; -- these/those/the potatoes

    AmountCurrency : Number -> Currency -> Price ;    -- five euros

    ThePlace : PlaceKind -> Place ;                   -- the bar
    APlace : PlaceKind -> Place ;                     -- a bar
   
    IMale, IFemale,                     -- I, said by man/woman (affects agreement)
    YouFamMale, YouFamFemale,           -- familiar you, said to man/woman (affects agreement)
    YouPolMale, YouPolFemale : Person ; -- polite you, said to man/woman (affects agreement)

    LangNat    : Nationality -> LAnguage ;    -- Swedish
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

    SHave       : Person -> Object      -> Sentence ;  -- you have beer
    SHaveNo     : Person -> Kind        -> Sentence ;  -- you have no apples
    SHaveNoMass : Person -> MassKind    -> Sentence ;  -- you have no beer
    QDoHave     : Person -> Object      -> Question ;  -- do you have beer

    AHaveCurr : Person -> Currency    -> Action ;  -- you have dollars
    ACitizen  : Person -> Citizenship -> Action ;  -- you are Swedish
    ABePlace  : Person -> Place       -> Action ;  -- you are in the bar

    ByTransp : Transport -> ByTransport ;          -- by bus

    AKnowSentence : Person -> Sentence -> Action ; -- you know that I am in the bar
    AKnowPerson   : Person -> Person   -> Action ; -- you know me
    AKnowQuestion : Person -> Question -> Action ; -- you know how far the bar is

------------------------------------------------------------------------------------------
-- New things added 30/11/2011 by AR
------------------------------------------------------------------------------------------

  cat
    VerbPhrase ;  -- things one does, can do, must do, wants to do, e.g. swim
    Modality ;    -- can, want, must
  fun
    ADoVerbPhrase       : Person -> VerbPhrase -> Action ;                       -- I swim
    AModVerbPhrase      : Modality -> Person -> VerbPhrase -> Action ;           -- I can swim
    ADoVerbPhrasePlace  : Person -> VerbPhrase -> Place -> Action ;              -- I swim in the hotel
    AModVerbPhrasePlace : Modality -> Person -> VerbPhrase -> Place -> Action ;  -- I can swim in the hotel

    QWhereDoVerbPhrase  : Person -> VerbPhrase -> Question ;                     -- where do you swim
    QWhereModVerbPhrase : Modality -> Person -> VerbPhrase -> Question ;         -- where can I swim

    MCan, MKnow, MMust, MWant : Modality ;
  
-- lexical items given in the resource Lexicon
    
    VPlay, VRun, VSit, VSleep, VSwim, VWalk : VerbPhrase ;
    VDrink, VEat, VRead, VWait, VWrite, VSit, VStop : VerbPhrase ;
    V2Buy, V2Drink, V2Eat : Object -> VerbPhrase ;
    V2Wait : Person -> VerbPhrase ;

    PImperativeFamPos,    -- eat
    PImperativeFamNeg,    -- don't eat
    PImperativePolPos,    -- essen Sie
    PImperativePolNeg,    -- essen Sie nicht
    PImperativePlurPos,   -- esst
    PImperativePlurNeg :  -- esst nicht
      VerbPhrase -> Phrase ;

-- other new things allowed by the resource

---    PBecause : Sentence -> Sentence -> Phrase ;  -- I want to swim because it is hot

    He, She,                                  -- he, she
    WeMale, WeFemale,                         -- we, said by men/women (affects agreement)
    YouPlurFamMale, YouPlurFamFemale,         -- plural familiar you, said to men/women (affects agreement)
    YouPlurPolMale, YouPlurPolFemale,         -- plural polite you, said to men/women (affects agreement)
    TheyMale, TheyFemale : Person ;           -- they, said of men/women (affects agreement)

}

