abstract Sentences = Numeral ** {

  cat
    Sentence ; Question ; Object ; Item ; Kind ; Quality ; 
    Place ; PlaceKind ; Currency ; Price ;

  fun
    Is    : Item -> Quality -> Sentence ;
    IsNot : Item -> Quality -> Sentence ;

    IWant : Object -> Sentence ;
    ILike : Item -> Sentence ; 
    DoYouHave : Kind -> Question ;
    WhetherIs : Item -> Quality -> Question ;
    WhereIs : Place -> Question ;

    HowMuchCost : Item -> Question ;
    ItCost : Item -> Price -> Sentence ;
    AmountCurrency : Numeral -> Currency -> Price ;

    ObjItem : Item -> Object ;
    ObjNumber : Numeral -> Kind -> Object ;
    
    This, That, These, Those, The, Thes : Kind -> Item ;
    SuchKind : Quality -> Kind -> Kind ;
    Very : Quality -> Quality ;
    Too : Quality -> Quality ;

    ThePlace : PlaceKind -> Place ;

}
