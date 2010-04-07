incomplete concrete SentencesI of Sentences = Numeral ** 
  open
    Syntax,
    Lexicon,
    Symbolic,  -- for names as strings
    Prelude
  in {
  lincat
    Phrase = Text ;
    Sentence = S ;
    Question = QS ;
    Proposition = Cl ;
    Item = NP ;
    Kind = CN ;
    Quality = AP ;
    Property = A ;
    Object = NP ;
    Place = {name : NP ; at : Adv ; to : Adv} ;
    PlaceKind = {name : CN ; at : Prep ; to : Prep} ;
    Currency = CN ;
    Price = NP ;
    Action = Cl ;
    Person = {name : NP ; isPron : Bool ; poss : Det} ;
    Nationality = {lang : NP ; prop : A ; country : NP} ; 
    Language = NP ;
    Citizenship = A ;
    Country = NP ;
    Day = {name : NP ; point : Adv ; habitual : Adv} ;
    Date = Adv ;
    Name = NP ;
  lin
    PSentence s = mkText s | lin Text (mkUtt s) ;  -- optional '.'
    PQuestion s = mkText s | lin Text (mkUtt s) ;  -- optional '?'

    PObject x = mkPhrase (mkUtt x) ;
    PKind x = mkPhrase (mkUtt x) ;
    PQuality x = mkPhrase (mkUtt x) ;
    PNumeral x = mkPhrase (mkUtt (mkCard (x ** {lock_Numeral = <>}))) ;
    PPlace x = mkPhrase (mkUtt x.name) ;
    PPlaceKind x = mkPhrase (mkUtt x.name) ;
    PCurrency x = mkPhrase (mkUtt x) ;
    PPrice x = mkPhrase (mkUtt x) ;
    PLanguage x = mkPhrase (mkUtt x) ;
    PCountry x = mkPhrase (mkUtt x) ;
    PCitizenship x = mkPhrase (mkUtt (mkAP x)) ;
    PDay d = mkPhrase (mkUtt d.name) ;
    
    PYes = mkPhrase yes_Utt ;
    PNo = mkPhrase no_Utt ;

    Is = mkCl ;

    SProp = mkS ;
    SPropNot = mkS negativePol ;
    QProp p = mkQS (mkQCl p) ;

    WherePlace place = mkQS (mkQCl where_IAdv place.name) ;
    WherePerson person = mkQS (mkQCl where_IAdv person.name) ;

    PropAction a = a ;

    AmountCurrency num curr = mkNP <lin Numeral num : Numeral> curr ;

    ObjItem i = i ;
    ObjNumber n k = mkNP <lin Numeral n : Numeral> k ;
    ObjIndef k = mkNP a_Quant k ;

    This kind = mkNP this_Quant kind ;
    That kind = mkNP that_Quant kind ;
    These kind = mkNP this_Quant plNum kind ;
    Those kind = mkNP that_Quant plNum kind ;
    The kind = mkNP the_Quant kind ;
    The kind = mkNP the_Quant kind ;
    Thes kind = mkNP the_Quant plNum kind ;
    SuchKind quality kind = mkCN quality kind ;
    Very property = mkAP very_AdA (mkAP property) ;
    Too property = mkAP too_AdA (mkAP property) ;
    PropQuality property = mkAP property ;
    ThePlace kind =
      let name : NP = mkNP the_Quant kind.name in {
        name = name ;
        at = mkAdv kind.at name ;
        to = mkAdv kind.to name
      } ;

    IMale, IFemale = mkPerson i_Pron ;
    YouFamMale, YouFamFemale = mkPerson youSg_Pron ;
    YouPolMale, YouPolFemale = mkPerson youPol_Pron ;

    LangNat n = n.lang ;
    CitiNat n = n.prop ;
    CountryNat n = n.country ;
    PropCit c = c ;

    OnDay d = d.point ;
    Today = today_Adv ;

    PersonName n = 
      {name = n ; isPron = False ; poss = mkDet he_Pron} ; -- poss not used
----    NameString s = symb s ;
    NameNN = symb "NN" ;

    AHave p kind = mkCl p.name have_V2 (mkNP kind) ;
    ACitizen p n = mkCl p.name n ;
    ABePlace p place = mkCl p.name place.at ;

oper 
  mkPhrase : Utt -> Text = \u -> lin Text u ; -- no punctuation

  mkPerson : Pron -> {name : NP ; isPron : Bool ; poss : Det} = \p -> 
    {name = mkNP p ; isPron = True ; poss = mkDet p} ;

}
