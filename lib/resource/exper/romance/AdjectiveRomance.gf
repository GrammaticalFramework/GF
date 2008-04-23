incomplete concrete AdjectiveRomance of Adjective = 
  CatRomance ** open CommonRomance, ResRomance, Prelude in {

  lin

    PositA  a = {
      s = a.s ! Posit ;
      isPre = a.isPre
      } ;
    ComparA a np = {
      s = \\af => a.s ! Compar ! af ++ conjThan ++ np.s ! Ton Nom ; 
      isPre = False
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 adj np = {
      s = \\af => adj.s ! Posit ! af ++ appCompl adj.c2 np.s ; 
      isPre = False
      } ;

    ReflA2 adj = {
      s = \\af => 
             adj.s ! Posit ! af ++ adj.c2.s ++ 
             adj.c2.s ++ prepCase adj.c2.c ++ reflPron Sg P3 Nom ; --- agr
      isPre = False
      } ;

    SentAP ap sc = {
      s = \\a => ap.s ! a ++ sc.s ; --- mood 
      isPre = False
      } ;

    AdAP ada ap = {
      s = \\a => ada.s ++ ap.s ! a ;
      isPre = ap.isPre
      } ;

    UseA2 a = a ** {isPre = False} ;

}
