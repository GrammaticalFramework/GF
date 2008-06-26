concrete AdjectiveGer of Adjective = CatGer ** open ResGer, Prelude in {

  flags optimize=all_subs ;

  lin

    PositA  a = {
      s = a.s ! Posit ;
      isPre = True
      } ;
    ComparA a np = {
      s = \\af => a.s ! Compar ! af ++ conjThan ++ np.s ! Nom ;
      isPre = True
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 a np = {
      s = \\af => a.s ! Posit ! af ++ appPrep a.c2 np.s ; 
      isPre = True
      } ;

    ReflA2 a = {
      s = \\af => a.s ! Posit ! APred ++ appPrep a.c2 (reflPron ! agrP3 Sg) ; --- agr 
      isPre = True
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
