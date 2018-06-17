concrete AdjectiveChi of Adjective = CatChi ** open ResChi, Prelude in {

  lin

    PositA  a = a ** {hasAdA = False} ;

    --ComparA a np = complexAP (a.s ++ than_s ++ np.s) ;
    ComparA a np = complexAP (than_s ++ np.s ++ a.s) ;

    UseComparA a = complexAP (geng_s ++ a.s) ;

    AdjOrd ord = complexAP ord.s ;

    -- CAdvAP ad ap np = complexAP (ap.s ++ ad.s ++ ad.p ++ np.s) ;
    CAdvAP ad ap np = complexAP (ad.s++ np.s++ad.p++ap.s ) ; --modified by ChenPeng 11.24

    ComplA2 a np = complexAP (appPrep a.c2 np.s ++ a.s) ;

    ReflA2 a = complexAP (a.s ++ appPrep a.c2 reflPron) ;

    SentAP ap sc = complexAP (ap.s ++ sc.s) ;

    AdAP ada ap = {s = ada.s ++ ap.s ; monoSyl = False ; hasAdA = True} ;

    UseA2 a = a ** {hasAdA = False} ;
   
    AdvAP ap adv = complexAP (adv.s ++ ap.s) ; ----

}
