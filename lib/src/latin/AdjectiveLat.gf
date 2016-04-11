concrete AdjectiveLat of Adjective = CatLat ** open ResLat, Prelude in {


  lin

    PositA  a = -- A -> AP
      { 
	s = table { Ag g n c  => a.s ! Posit ! Ag g n c } ;
      };

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
    
--  AdAP    : AdA -> AP -> AP ; -- very warm
    AdAP ada ap = {
      s = \\agr => ada.s ++ ap.s ! agr ;
      } ;

--  UseA2 : A2 -> AP
    UseA2 a = -- A2 -> AP
      { 
	s = table { Ag g n c  => a.s ! Posit ! Ag g n c } ;
      } ;

}
