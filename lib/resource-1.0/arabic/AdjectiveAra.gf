concrete AdjectiveAra of Adjective = CatAra ** open ResAra, Prelude in {

  lin

    PositA a = {
      s = 
        table {
          Hum => a.s ;
          NoHum => \\g,n =>
            case n of {
              Pl => a.s ! Fem ! Sg  ;
              _  => a.s ! g ! n 
            }
        } 
      };
--    ComparA a np = {
--      s = \\_ => a.s ! AAdj Compar ++ "تهَن" ++ np.s ! Nom ; 
--      isPre = False
--      } ;
--
---- $SuperlA$ belongs to determiner syntax in $Noun$.
--
--    ComplA2 a np = {
--      s = \\_ => a.s ! AAdj Posit ++ a.c2 ++ np.s ! Acc ; 
--      isPre = False
--      } ;
--
--    ReflA2 a = {
--      s = \\ag => a.s ! AAdj Posit ++ a.c2 ++ reflPron ! ag ; 
--      isPre = False
--      } ;
--
--    SentAP ap sc = {
--      s = \\a => ap.s ! a ++ sc.s ; 
--      isPre = False
--      } ;
--
--    AdAP ada ap = {
--      s = \\a => ada.s ++ ap.s ! a ;
--      isPre = ap.isPre
--      } ;
--
--    UseA2 a = a ;
--
}
