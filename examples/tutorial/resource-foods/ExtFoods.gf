abstract ExtFoods = Foods ** {

  flags startcat=Move ;

  cat
    Move ;      -- declarative, question, or imperative
    Verb ;      -- transitive verb
    Guest ;     -- guest in restaurant
    GuestKind ; -- type of guest

  fun
    MAssert : Phrase -> Move ;  -- This pizza is warm.
    MDeny : Phrase -> Move ;    -- This pizza isn't warm.
    MAsk : Phrase -> Move ;     -- Is this pizza warm?

    PVerb : Guest -> Verb -> Item -> Phrase ;     -- we eat this pizza
    PVerbWant : Guest -> Verb -> Item -> Phrase ; -- we want to eat this pizza

    WhichVerb : Kind -> Guest -> Verb -> Move ; -- Which pizza do you eat?
    WhichVerbWant : Kind -> Guest -> Verb -> Move ;
                                        -- Which pizza do you want to eat?
    WhichIs : Kind -> Quality -> Move ; -- Which wine is Italian? 

    Do : Verb -> Item -> Move ;       -- Pay this wine!
    DoPlease : Verb -> Item -> Move ; -- Pay this wine please!

    I, You, We : Guest ;

    GThis, GThat, GThese, GThose : GuestKind -> Guest ;
    
    Eat, Drink, Pay : Verb ;

    Lady, Gentleman : GuestKind ;
    
}
