
instance LexRestaurantEng of LexRestaurant = open SyntaxEng,GrammarEng,ParadigmsEng in {

	oper
		restaurant_N		= mkN "restaurant" ;
		food_N				= mkN "food" ;
		staff_N				= variants {mkN "staff" ; mkN "service"} ;
		wine_N				= mkN "wine" ;
		pizza_N				= mkN "pizza" ;
		cheese_N			= mkN "cheese" ;
		fish_N				= mkN "fish" "fish" ;
		dish_N				= mkN "dish" ;
		drink_N				= mkN "drink" ;
		dessert_N			= mkN "dessert" ;

		recommend_V2		= mkV2 (mkV "recommend") ;

		chinese_A			= mkA "chinese" ;
		french_A			= mkA "french" ;
		italian_A			= mkA "italian" ;
		japanese_A			= mkA "japanese" ;
		mexican_A			= mkA "mexican" ;
		thai_A				= mkA "thai" ;
		expensive_A			= mkA "expensive" ;
		cheap_A				= mkA "cheap" ;
		nice_A				= mkA "nice" ;
		clean_A				= mkA "clean" ;
		dirty_A				= mkA "dirty" ;
		fresh_A				= mkA "fresh" ;
		delicious_A			= variants {mkA "delicious"; mkA "exquisit"; mkA "tasty"} ;
		fatty_A				= mkA "fatty" ;
		tasteless_A			= variants {mkA "tasteless"; mkA "flavorless"; mkA "bland"} ;
		authentic_A			= mkA "authentic" ;
		efficient_A			= mkA "efficient" ;
		courteous_A			= mkA "courteous" ;
		helpful_A			= mkA "helpful" ;
		friendly_A			= mkA "friendly" ;
		personal_A			= mkA "personal" ;
		warm_A				= mkA "warm" ;
		prompt_A			= mkA "prompt" ;
		attentive_A			= mkA "attentive" ;
		inefficient_A		= variants {mkA "inefficient" ; mkA "incompetent"} ;
		rude_A				= variants {mkA "rude" ; mkA "discourteous"} ;
		impersonal_A		= variants {mkA "impersonal" ; mkA "cold"} ;
		slow_A				= mkA "slow" ;
		unattentive_A		= mkA "unattentive" ;
		good_A				= mkA "good" "better" "best" "well" ;
		great_A				= mkA "great" ;
		excellent_A			= mkA "excellent" ;
		bad_A				= mkA "bad" ;
		awful_A				= mkA "awful" ;
		horrible_A			= variants {mkA "horrible" ; mkA "dreadful"} ;
		disgusting_A		= variants {mkA "disgusting"; mkA "gross"} ;
		boring_A			= mkA "boring" ;
		diverse_A			= mkA "diverse" ;

		noAdv_AdV			= mkAdV "" ;
		strongly_AdV		= mkAdV "strongly" ;
		completely_AdV		= mkAdV (variants {"completely"; "totally"; "definitely"; "absolutely"}) ;
		certainly_AdV		= mkAdV "certainly" ;
		honestly_AdV		= mkAdV "honestly" ;
		really_AdV			= mkAdV (variants {"really"; "truly"}) ;
		reluctantly_AdV		= mkAdV "reluctantly" ;
		hardly_AdV			= mkAdV "hardly" ;

--		but_Conj			= ss "but" ** {n = Pl} ;

}
