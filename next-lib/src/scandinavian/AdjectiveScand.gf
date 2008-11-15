incomplete concrete AdjectiveScand of Adjective = 
  CatScand ** open CommonScand, ResScand, Prelude in {

  lin

    PositA  a = {
      s = \\ap => a.s ! AF (APosit ap) Nom ;
      isPre = True
      } ;
    ComparA a np = {
      s = \\ap => case a.isComp of {
        True => compMore ++ a.s ! AF (APosit ap) Nom ;
        _    => a.s ! AF ACompar Nom
        }
        ++ conjThan ++ np.s ! nominative ; 
      isPre = False
      } ;
    UseComparA a = {
      s = \\ap => case a.isComp of {
        True => compMore ++ a.s ! AF (APosit ap) Nom ;
        _    => a.s ! AF ACompar Nom
        } ;
      isPre = False
      } ;

    CAdvAP ad ap np = {
      s = \\a => ad.s ++ ap.s ! a ++ ad.p ++ np.s ! nominative ; 
      isPre = False
      } ;

    AdjOrd ord = {
      s = \\_ => ord.s ;
      isPre = True
      } ;

    ComplA2 a np = {
      s = \\ap => a.s ! AF (APosit ap) Nom ++ a.c2.s ++ np.s ! accusative ; 
      isPre = False
      } ;

    ReflA2 a = {
      s = \\ap => a.s ! AF (APosit ap) Nom ++ a.c2.s ++ 
                  reflPron (agrP3 utrum Sg) ; ---- 
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
      s = \\ap => a.s ! AF (APosit ap) Nom ;
      isPre = True
      } ;

}
