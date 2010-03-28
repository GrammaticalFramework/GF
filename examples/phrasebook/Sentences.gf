abstract Sentences = Numeral ** {

  cat
    Phrase ;
    Sentence ; Question ; Object ; Item ; Kind ; Quality ; 
    Place ; PlaceKind ; Currency ; Price ;

  fun
    -- these phrases are formed here, not in Phrasebook, as they are functorial
    PObject   : Object   -> Phrase ;
    PKind     : Kind     -> Phrase ;
    PQuality  : Quality  -> Phrase ;
    PNumeral  : Numeral  -> Phrase ;
    PPlace    : Place    -> Phrase ;
    PPlaceKind: PlaceKind-> Phrase ;
    PCurrency : Currency -> Phrase ;
    PPrice    : Price    -> Phrase ;

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
