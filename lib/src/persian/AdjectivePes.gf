concrete AdjectivePes of Adjective = CatPes ** open ResPes, Prelude in {

  flags coding = utf8;
  lin

    PositA a = a ;
 	UseComparA a = a;

    ComparA a np = {
        s =\\ez => a.s ! ez ++ "تر" ++ "از" ++ np.s ! NPC bEzafa  ;
	adv = a.adv
       } ;

---- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 a np = {
      s =\\ez => np.s ! NPC bEzafa ++ a.c2 ++ a.s  ! ez ;
      adv = a.adv
     } ;

    ReflA2 a = {
      s =\\ez =>  a.s ! ez ++ "" ; -- need to be fixed
      adv = a.adv
      } ;

    SentAP ap sc = {
      s =\\ez =>  ap.s! ez ++ sc.s ;
      adv = ap.adv
      } ;

    AdAP ada ap = {
      s =\\ez => ada.s ++ ap.s ! ez ;
      adv = ap.adv
      } ;

    UseA2 a = a ;
	
	CAdvAP  cadv ap np = {
	 s =\\ez =>  cadv.s ++  np.s ! NPC bEzafa ++ ap.s ! ez ;
	 adv = ap.adv
	 };
   
    AdjOrd ord =  { s =\\_ => ord.s ; adv = ""};
    
    

     AdvAP ap adv = {s =\\ez => ap.s ! ez ++ adv.s ; adv = ap.adv};
}
