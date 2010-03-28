incomplete concrete SentencesI of Sentences = Numeral ** 
  open
    DiffPhrasebook, 
    Syntax 
  in {
  lincat
    Phrase = Text ;
    Sentence = S ; 
    Question = QS ; 
    Item = NP ;
    Kind = CN ;
    Quality = AP ;
    Object = NP ;
    Place = NP ;
    PlaceKind = CN ;
    Currency = CN ;
    Price = NP ;
    Action = Cl ;
    Person = NP ;
    Language = NP ;
  lin
    PObject x = mkPhrase (mkUtt x) ;
    PKind x = mkPhrase (mkUtt x) ;
    PQuality x = mkPhrase (mkUtt x) ;
    PNumeral x = mkPhrase (mkUtt (mkCard (x ** {lock_Numeral = <>}))) ;
    PPlace x = mkPhrase (mkUtt x) ;
    PPlaceKind x = mkPhrase (mkUtt x) ;
    PCurrency x = mkPhrase (mkUtt x) ;
    PPrice x = mkPhrase (mkUtt x) ;
    PLanguage x = mkPhrase (mkUtt x) ;

    Is item quality = mkS (mkCl item quality) ;
    IsNot item quality = mkS negativePol (mkCl item quality) ;
    WhetherIs item quality = mkQS (mkQCl (mkCl item quality)) ;
    WhereIs place = mkQS (mkQCl where_IAdv place) ;

    SAction = mkS ;
    SNotAction = mkS negativePol ;
    QAction a = mkQS (mkQCl a) ;

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item cost_V)) ; 
    ItCost item price = mkS (mkCl item cost_V2 price) ; 
    AmountCurrency num curr = mkNP <lin Numeral num : Numeral> curr ;

    ObjItem i = i ;
    ObjNumber n k = mkNP <lin Numeral n : Numeral> k ;

    This kind = mkNP this_Quant kind ;
    That kind = mkNP that_Quant kind ;
    These kind = mkNP this_Quant plNum kind ;
    Those kind = mkNP that_Quant plNum kind ;
    The kind = mkNP the_Quant kind ;
    The kind = mkNP the_Quant kind ;
    Thes kind = mkNP the_Quant plNum kind ;
    SuchKind quality kind = mkCN quality kind ;
    Very quality = mkAP very_AdA quality ;
    Too quality = mkAP too_AdA quality ;
    ThePlace kind = mkNP the_Quant kind ;

    I = mkNP i_Pron ;
    You = mkNP youPol_Pron ;

oper 
  mkPhrase : Utt -> Text = \u -> lin Text u ; -- no punctuation

}
