concrete AdjectiveBul of Adjective = CatBul ** open ResBul, Prelude in {
  flags coding=cp1251 ;

  lin
    PositA  a = {
      s = \\aform => a.s ! aform ;
      adv = a.adv ;
      isPre = True
      } ;

    ComparA a np = {
      s = \\aform => "по" ++ "-" ++ a.s ! aform ++ "от" ++ np.s ! RObj Acc ; 
      adv = "по" ++ "-" ++ a.adv ++ "от" ++ np.s ! RObj Acc ;
      isPre = True
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 a np = {
      s = \\aform => a.s ! aform ++ a.c2 ++ np.s ! RObj Acc ; 
      adv = a.adv ++ a.c2 ++ np.s ! RObj Acc ; 
      isPre = True
      } ;

    ReflA2 a = {
      s = \\aform => a.s ! aform ++ a.c2 ++ ["себе си"] ; 
      adv = a.adv ++ a.c2 ++ ["себе си"] ; 
      isPre = False
      } ;

    SentAP ap sc = {
      s = \\a => ap.s ! a ++ sc.s ;
      adv = ap.adv ++ sc.s ;
      isPre = False
      } ;

    AdAP ada ap = {
      s = \\a => ada.s ++ ap.s ! a ;
      adv = ada.s ++ ap.adv ;
      isPre = ap.isPre
      } ;

    UseA2 a = a ;
}
