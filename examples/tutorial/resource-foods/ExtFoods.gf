abstract ExtFoods = Foods ** {

  flags startcat=Move ;

  cat
    Move ;
    Verb ;
    Guest ;
    GuestKind ;

  fun
    MAssert : Phrase -> Move ;    
    MDeny : Phrase -> Move ;    
    MAsk : Phrase -> Move ;

    PVerb : Guest -> Verb -> Item -> Phrase ;
    PVerbWant : Guest -> Verb -> Item -> Phrase ;

    WhichVerb : Kind -> Guest -> Verb -> Move ;
    WhichVerbWant : Kind -> Guest -> Verb -> Move ;
    WhichIs : Kind -> Quality -> Move ;

    Do : Verb -> Item -> Move ;
    DoPlease : Verb -> Item -> Move ;

    I, You, We : Guest ;

    GThis, GThat, GThese, GThose : GuestKind -> Guest ;
    
    Eat, Drink, Pay : Verb ;

    Lady, Gentleman : GuestKind ;
    
}
