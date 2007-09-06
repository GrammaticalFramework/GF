incomplete concrete ExtFoodsI of ExtFoods = FoodsI ** open Syntax, LexFoods in {

  flags lexer=text ; unlexer=text ;

  lincat
    Move = Text ;
    Verb = V2 ;
    Guest = NP ;
    GuestKind = CN ;
  lin
    MAssert p = mkText (mkS p) ;
    MDeny p = mkText (mkS negativePol p) ;
    MAsk p = mkText (mkQS p) ;

    PVerb = mkCl ;
    PVerbWant guest verb item = mkCl guest want_VV (mkVP verb item) ;

    WhichVerb kind guest verb = 
      mkText (mkQS (mkQCl (mkIP whichSg_IDet kind) guest verb)) ;
    WhichVerbWant kind guest verb = 
      mkText (mkQS (mkQCl (mkIP whichSg_IDet kind) 
        (mkSlash guest want_VV verb))) ;
    WhichIs kind quality = 
      mkText (mkQS (mkQCl (mkIP whichSg_IDet kind) (mkVP quality))) ;

    Do verb item = 
      mkText 
        (mkPhr (mkUtt politeImpForm (mkImp verb item))) exclMarkPunct ;
    DoPlease verb item = 
      mkText 
        (mkPhr (mkUtt politeImpForm (mkImp verb item)) please_Voc) 
        exclMarkPunct ;

    I = mkNP i_Pron ;
    You = mkNP youPol_Pron ;
    We = mkNP we_Pron ;

    GThis = mkNP this_QuantSg ;
    GThat = mkNP that_QuantSg ;
    GThese = mkNP these_QuantPl ;
    GThose = mkNP those_QuantPl ;

    Eat = eat_V2 ;
    Drink = drink_V2 ;
    Pay = pay_V2 ;
    Lady = mkCN lady_N ;
    Gentleman = mkCN gentleman_N ;

}
