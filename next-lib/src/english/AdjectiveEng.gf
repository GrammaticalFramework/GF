concrete AdjectiveEng of Adjective = CatEng ** open ResEng, Prelude in {

  lin

    PositA  a = {
      s = \\_ => a.s ! AAdj Posit ;
      isPre = True
      } ;
    ComparA a np = {
      s = \\_ => a.s ! AAdj Compar ++ "than" ++ np.s ! Nom ; 
      isPre = False
      } ;
    UseComparA a = {
      s = \\_ => a.s ! AAdj Compar ; 
      isPre = True
      } ;

    AdjOrd ord = {
      s = \\_ => ord.s ;
      isPre = True
      } ;

    CAdvAP ad ap np = {
      s = \\a => ad.s ++ ap.s ! a ++ ad.p ++ np.s ! Nom ; 
      isPre = False
      } ;

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

    AdAP ada ap = {
      s = \\a => ada.s ++ ap.s ! a ;
      isPre = ap.isPre
      } ;

    UseA2 a = {
      s = \\_ => a.s ! AAdj Posit ;
      isPre = True
      } ;

}
