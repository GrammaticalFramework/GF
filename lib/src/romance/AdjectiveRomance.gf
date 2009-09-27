incomplete concrete AdjectiveRomance of Adjective = 
  CatRomance ** open CommonRomance, ResRomance, Prelude in {

  lin

    PositA  a = {
      s = a.s ! Posit ;
      isPre = a.isPre
      } ;
    ComparA a np = {
      s = \\af => a.s ! Compar ! af ++ conjThan ++ (np.s ! Nom).ton ; 
      isPre = False
      } ;
    CAdvAP ad ap np = {
      s = \\af => ad.s ++ ap.s ! af ++ ad.p ++ (np.s ! Nom).ton ; 
      isPre = False
      } ;
    UseComparA a = {
      s = \\af => a.s ! Compar ! af ;
      isPre = a.isPre
      } ;
    AdjOrd ord = {
      s = \\af => ord.s ! (case af of {
        AF g n => aagr g n ; 
        _ => aagr Masc Sg ----
        }) ;
      isPre = False ----
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 adj np = {
      s = \\af => adj.s ! Posit ! af ++ appCompl adj.c2 np ; 
      isPre = False
      } ;

    ReflA2 adj = {
      s = \\af => 
             adj.s ! Posit ! af ++
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

    UseA2 a = {
      s = a.s ! Posit ;
      isPre = False ---- A2 has no isPre
      } ;

}
