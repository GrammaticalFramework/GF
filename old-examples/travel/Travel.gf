abstract Travel = {

  flags startcat=Phrase ;

  cat
    Phrase ;

    Greeting ;
    Order ; 
    Question ;
    Sentence ;

    Object ;
    Kind ;
    Quality ;
    Number ;

    Speaker ;
    Hearer ;
    Gender ;
    Quantity ;

  fun
    PGreeting : Greeting -> Speaker -> Hearer -> Phrase ;
    POrder    : Order    -> Speaker -> Hearer -> Phrase ;
    PQuestion : Question -> Speaker -> Hearer -> Phrase ;
    PSentence : Sentence -> Speaker -> Hearer -> Phrase ;

    MkSpeaker : Gender -> Quantity -> Speaker ;
    MkHearer  : Gender -> Quantity -> Hearer ;

    Male, Female : Gender ;
    Single, Many : Quantity ;

    Hello : Greeting ;
    Thanks : Greeting ;

    IWant : Object -> Order ;
    
    DoYouHave : Kind -> Question ;
    IsIt : Object -> Quality -> Sentence ;

    ItIs : Object -> Quality -> Sentence ;
    
    Indef : Kind -> Object ;
    This  : Kind -> Object ;
    NumberObjects : Number -> Kind -> Object ;

    One, Two, Five, Ten : Number ;

    Mango : Kind ;
    Green : Quality ;

}
