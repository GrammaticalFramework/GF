concrete AdjectiveUrd of Adjective = CatUrd ** open ResUrd, Prelude in {

  lin

    PositA a = a ;
	UseComparA a = a;

    ComparA a np = {
        s = \\n,g,c,d => np.s ! NPC Obl ++ "sE" ++ a.s ! n ! g ! c ! d ;                       
--      isPre = False
       } ;

---- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 a np = {
      s = \\n,g,c,d => np.s ! NPC Obl ++ a.c2 ++ a.s ! n ! g ! c ! d ; 
--      isPre = False
      } ;

--    ReflA2 a = {
--      s = \\n,g,c,d => a.s ! n ! g ! c ! d  ++ reflPron ! ag ; 
--      isPre = False
--      } ;

    SentAP ap sc = {
      s = \\n,g,c,d => ap.s ! n ! g ! c ! d ++ sc.s ; 
--      isPre = False
      } ;

    AdAP ada ap = {
      s = \\n,g,c,d => ada.s ++ ap.s ! n ! g ! c ! d ;
--      isPre = ap.isPre
      } ;

    UseA2 a = a ;
	
	CAdvAP  cadv ap np = {
	 s = \\n,g,c,d => cadv.s ++ ap.s ! n ! g ! c ! d ++ cadv.p ++  np.s ! NPC Dir ;
	 };

}
