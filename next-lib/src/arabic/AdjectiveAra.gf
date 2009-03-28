concrete AdjectiveAra of Adjective = CatAra ** open ResAra, Prelude in {

  lin


    PositA a = {
      s = \\h,g,n,d,c => case h of {
        Hum => a.s ! APosit g n d c;
        NoHum => case n of {
          Pl => a.s ! APosit Fem Sg d c ;
          _  => a.s ! APosit g n d c
          }
        } 
      };
---- guessed by AR
  ComparA a np = {
    s = \\sp,g,n,st,c => a.s ! AComp st c ++ "مِنْ" ++ np.s ! Gen ; 
    } ;
--
-- $SuperlA$ belongs to determiner syntax in $Noun$.
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
    AdAP ada ap = {
      s = \\sp,g,n,st,c => ada.s ++ ap.s ! sp ! g ! n ! st ! c
      } ;
--
--    UseA2 a = a ;
--
}
