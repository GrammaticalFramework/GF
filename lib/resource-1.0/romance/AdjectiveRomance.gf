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

{-
-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 a np = {
      s = \\ap => a.s ! AF (APosit ap) Nom ++ a.c2 ++ np.s ! accusative ; 
      isPre = False
      } ;

    ReflA2 a = {
      s = \\ap => a.s ! AF (APosit ap) Nom ++ a.c2 ++ 
                  reflPron (agrP3 Utr Sg) ; ---- 
      isPre = False
      } ;

    SentAP ap sc = {
      s = \\a => ap.s ! a ++ sc.s ; 
      isPre = False
      } ;
-}
    AdAP ada ap = {
      s = \\a => ada.s ++ ap.s ! a ;
      isPre = ap.isPre
      } ;

    UseA2 a = a ** {isPre = False} ;

}
