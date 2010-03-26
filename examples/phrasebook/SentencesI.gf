incomplete concrete SentencesI of Sentences = Numeral ** 
  open
    DiffPhrasebook, 
    Syntax 
  in {
  lincat
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
  lin
    Is item quality = mkS (mkCl item quality) ;
    IsNot item quality = mkS negativePol (mkCl item quality) ;
    WhetherIs item quality = mkQS (mkQCl (mkCl item quality)) ;
    WhereIs place = mkQS (mkQCl where_IAdv place) ;
    IWant obj = mkS (mkCl (mkNP i_Pron) want_V2 obj) ;
    ILike item = mkS (mkCl (mkNP i_Pron) like_V2 item) ;
    DoYouHave kind = 
      mkQS (mkQCl (mkCl (mkNP youPol_Pron) have_V2 (mkNP kind))) ;

    HowMuchCost item = mkQS (mkQCl how8much_IAdv (mkCl item cost_V)) ; 
    ItCost item price = mkS (mkCl item cost_V2 price) ; 
    AmountCurrency num curr = mkNP <num : Numeral> curr ;

    ObjItem i = i ;
    ObjNumber n k = mkNP <n : Numeral> k ;

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

}
