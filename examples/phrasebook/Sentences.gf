abstract Sentences = Numeral ** {

  cat
    Sentence ; Object ; Item ; Kind ; Quality ;

  fun
    Is    : Item -> Quality -> Sentence ;
    IsNot : Item -> Quality -> Sentence ;

    IWant : Object -> Sentence ;
    ILike : Item -> Sentence ; 
    DoYouHave : Kind -> Sentence ;
    WhetherIs : Item -> Quality -> Sentence ;
    ObjItem : Item -> Object ;
    ObjNumber : Numeral -> Kind -> Object ;
    
    This, That, These, Those : Kind -> Item ;
    SuchKind : Quality -> Kind -> Kind ;
    Very : Quality -> Quality ;

}
