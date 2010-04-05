abstract Sentences = Numeral ** {

  cat
    Phrase ;
    Sentence ; Question ; Proposition ; 
    Object ; Item ; Kind ; Quality ; Property ;  
    Place ; PlaceKind ; Currency ; Price ; 
    Person ; Action ; 
    Nationality ; Language ; Citizenship ; Country ;
    Day ;   -- weekday type
    Date ;  -- definite date
    Name ;  
  fun
    -- these phrases are formed here, not in Phrasebook, as they are functorial
    PSentence : Sentence -> Phrase ;
    PQuestion : Question -> Phrase ;

    PObject   : Object   -> Phrase ;
    PKind     : Kind     -> Phrase ;
    PQuality  : Quality  -> Phrase ;
    PNumeral  : Numeral  -> Phrase ;
    PPlace    : Place    -> Phrase ;
    PPlaceKind: PlaceKind-> Phrase ;
    PCurrency : Currency -> Phrase ;
    PPrice    : Price    -> Phrase ;
    PLanguage : Language -> Phrase ;
    PCitizenship : Citizenship -> Phrase ;
    PCountry  : Country -> Phrase ;
    PDay      : Day -> Phrase ;

    Is       : Item -> Quality -> Proposition ;

    SProp    : Proposition -> Sentence ;
    SPropNot : Proposition -> Sentence ;
    QProp    : Proposition -> Question ;

    WhereIs : Place -> Question ;

    PropAction : Action -> Proposition ;

    HowMuchCost : Item -> Question ;
    ItCost : Item -> Price -> Proposition ;
    AmountCurrency : Numeral -> Currency -> Price ;

    ObjItem   : Item -> Object ;
    ObjNumber : Numeral -> Kind -> Object ;
    ObjIndef  : Kind -> Object ;
    
    This, That, These, Those, The, Thes : Kind -> Item ;
    SuchKind : Quality -> Kind -> Kind ;
    Very : Property -> Quality ;
    Too : Property -> Quality ;
    PropQuality : Property -> Quality ;

    ThePlace : PlaceKind -> Place ;

    IMale, IFemale, 
    YouFamMale, YouFamFemale, 
    YouPolMale, YouPolFemale : Person ;

    LangNat    : Nationality -> Language ;
    CitiNat    : Nationality -> Citizenship ;
    CountryNat : Nationality -> Country ;
    PropCit    : Citizenship -> Property ;

    OnDay : Day -> Date ;
    Today : Date ;

    PersonName : Name -> Person ;
----    NameString : String -> Name ; ---- creates ambiguities with all words
    NameNN : Name ; -- the name "NN"
}
