concrete AdjectiveSnd of Adjective = CatSnd ** open ResSnd, Prelude in {

  flags coding = utf8;
  lin

    PositA a = a ;
	UseComparA a = a;

    ComparA a np = {
--        s = \\n,g,c => np.s ! NPC Obl ++ "کان" ++ a.s ! n ! g ! c  ;
       s = \\n,g,c => np.s ! NPC Abl ++ "کان" ++ a.s ! n ! g ! c  ;                       
       } ;

---- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 a np = {
      s = \\n,g,c => np.s ! NPC Obl ++ a.c2 ++ a.s ! n ! g ! c  ; 
     } ;

    ReflA2 a = {
      s = \\n,g,c => a.s ! n ! g ! c   ++  RefPron ++ "سان" ; 
      } ;

    SentAP ap sc = {
      s = \\n,g,c => ap.s ! n ! g ! c ++ sc.s ; 
      } ;

    AdAP ada ap = {
      s = \\n,g,c => ada.s ++ ap.s ! n ! g ! c ;
      } ;

    UseA2 a = a ;
	
	CAdvAP  cadv ap np = {
	 s = \\n,g,c => cadv.s ++ ap.s ! n ! g ! c ++ cadv.p ++  np.s ! NPC Dir ;
	 };
    
 AdjOrd ord =  { s = \\_,_,_ => ord.s ; };

}
