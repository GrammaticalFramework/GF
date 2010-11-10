concrete AdjectiveAmh of Adjective = CatAmh ** open ResAmh,ParamX, Prelude in {

 flags coding = utf8 ;
  lin
	PositA a = {

		s = \\g,n,s,c => a.s ! g ! n ! s ! c          
	};

	ComparA a np = {

		s = \\g,n,s,c => 
		
		case c of
	
		{
			Acc =>"ከ" ++ np.s ! Nom ++ "ይልቅ"++ a.s ! g ! n ! s ! c ; 
			_   =>  affix2 ("ከ")!c ++ np.s ! Nom ++ "ይልቅ"++ a.s ! g ! n ! s ! Nom 
		} 
	} ;

 --FIX  ada.s ? strange error : 
	{-
	AdAP ada ap = {
		
		s = \\g,n,s,c  => 
			case c of 
		{
			Acc => ada.s ++ ap.s ! g ! Sg ! Indef ! c;
			_   => affix2 ada.s !c ++ ap.s ! g ! Sg ! Indef ! Nom
		}
	} ;-}

	AdAP ada ap = {
		
		s = \\g,n,s,c  => ada.s ++ ap.s ! g ! Sg ! Indef ! c

		};

	UseComparA a = {
		
		s = \\g,n,s,c  => "በደምብ"  ++ a.s ! g ! Sg ! Indef ! Nom

		};
	
	AdjOrd ord = {
		
		s = \\g,n,s,c => 
		
		case c of
	
		{
			Acc =>"ከሁሉ" ++ ord.s!g!n!s!c ;
			_   =>  affix2 ("ከሁሉ")!c ++ ord.s ! g!n!s!Nom
		} 

	
		};

	--  CAdvAP  : CAdv -> AP -> NP -> AP ;  -- as cool as John


	 CAdvAP ad ap np = {

      			s = \\g,n,s,c =>   ad.s ++ ad.p ++ np.s ! Nom ++ ap.s ! g ! n ! s ! c ; 

     		 } ;

}
