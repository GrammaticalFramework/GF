concrete AdjectiveDut of Adjective = CatDut ** open ResDut, Prelude in 
{


  flags optimize=all_subs ;

  lin

    PositA  a = {
      s = \\agr => a.s ! Posit ;
      isPre = True
      } ;
    ComparA a np = {
      s = \\agr,af => a.s ! Compar ! af ++ "dan" ++ np.s ! NPNom ;
      isPre = True
      } ;
    CAdvAP ad ap np = {
      s = \\agr,af => ad.s ++ ap.s ! agr ! af ++ ad.p ++ np.s ! NPNom ;
      isPre = False
      } ;
    UseComparA a = {
      s = \\agr => a.s ! Compar ;
      isPre = True
      } ;
    AdjOrd  a = {
      s = \\agr => a.s ;
      isPre = True
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 a np = {
      s = \\agr,af => a.s ! Posit ! af ++ appPrep a.c2 np ; 
      isPre = False
      } ;

    ReflA2 a = {
      s = \\agr,af => a.s ! Posit ! APred ++ 
                      appPrep a.c2 (npLite (\\_ => reflPron ! agr)) ; 

      isPre = True
      } ;

    SentAP ap sc = {
      s = \\agr,af => ap.s ! agr ! af ++ sc.s ; 
      isPre = False
      } ;

    AdAP ada ap = {
      s = \\agr,af => ada.s ++ ap.s ! agr ! af ;
      isPre = ap.isPre
      } ;

    UseA2 a = {
      s = \\agr => a.s ! Posit ;
      isPre = True
      } ;

}
