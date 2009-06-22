concrete AdjectiveLat of Adjective = CatLat ** open ResLat, Prelude in {


  lin

    PositA  a = a ;

{-
    ComparA a np = {
      s = \\_ => a.s ! AAdj Compar ++ "than" ++ np.s ! Nom ; 
      isPre = False
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 a np = {
      s = \\_ => a.s ! AAdj Posit ++ a.c2 ++ np.s ! Acc ; 
      isPre = False
      } ;

    ReflA2 a = {
      s = \\ag => a.s ! AAdj Posit ++ a.c2 ++ reflPron ! ag ; 
      isPre = False
      } ;

    SentAP ap sc = {
      s = \\a => ap.s ! a ++ sc.s ; 
      isPre = False
      } ;
-}

    AdAP ada ap = {
      s = \\g,n,c => ada.s ++ ap.s ! g ! n ! c ;
      isPre = ap.isPre
      } ;

--    UseA2 a = a ;

}
