concrete AdjectiveBul of Adjective = CatBul ** open ResBul, Prelude in {
  lin
    PositA  a = {
      s = \\aform => a.s ! aform ;
      isPre = True
      } ;

    ComparA a np = {
      s = \\aform => "по" ++ "-" ++ a.s ! aform ++ "от" ++ np.s ! Nom ; 
      isPre = True
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 a np = {
      s = \\aform => a.s ! aform ++ a.c2 ++ np.s ! Acc ; 
      isPre = True
      } ;

    ReflA2 a = {
      s = \\aform => a.s ! aform ++ a.c2 ++ ["себе си"] ; 
      isPre = False
      } ;

    SentAP ap sc = {
      s = \\a => ap.s ! a ++ sc.s ; 
      isPre = False
      } ;

    AdAP ada ap = {
      s = \\a => ada.s ++ ap.s ! a ;
      isPre = ap.isPre
      } ;

    UseA2 a = a ;
}
