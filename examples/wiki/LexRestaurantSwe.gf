
instance LexRestaurantSwe of LexRestaurant = open SyntaxSwe,GrammarSwe,ParadigmsSwe in {

	flags encoding = utf8 ;

	oper
		restaurant_N		= mkN "restaurang" ;
		food_N				= mkN "mat" ;
		staff_N				= variants {mkN "personal" ; mkN "betjäning"} ;
		wine_N				= mkN "vin" "vinet" "viner" "vinerna" ;
		pizza_N				= mkN "pizza" ;
		cheese_N			= mkN "ost" ;
		fish_N				= mkN "fisk" ;
		dish_N				= mkN "rätt" "rätten" "rätter" "rätterna" ;
		drink_N				= mkN "dryck" "drycken" "drycker" "dryckerna" ;
		dessert_N			= mkN "dessert" "desserten" "desserter" "desserterna" ;

		recommend_V2		= mkV2 (mkV "rekommenderar") ;

		chinese_A			= mkA "kinesisk" ;
		french_A			= mkA "fransk" ;
		italian_A			= mkA "italiensk" ;
		japanese_A			= mkA "japansk" ;
		mexican_A			= mkA "mexikansk" ;
		thai_A				= mkA "thailändsk" ;
		expensive_A			= mkA "dyr" ;
		cheap_A				= mkA "billig" ;
		nice_A				= mkA "fin" ;
		clean_A				= mkA "ren" ;
		dirty_A				= mkA "smutsig" ;
		fresh_A				= mkA "färsk" ;
		delicious_A			= variants {mkA "läcker" "läckert" "läckra" "läckra" "läckrast" ; mkA "smaklig"} ;
		fatty_A				= mkA "fet" ;
		tasteless_A			= mkA "smaklös" ;
		authentic_A			= mkA "autentisk" ;
		efficient_A			= mkA "effektiv" ;
		courteous_A			= variants {mkA "artig"; mkA "hövlig"} ;
		helpful_A			= variants {mkA "hjälpsam" "hjälpsamt" "hjälpsamma" "" "" ; mkA "tjänstvillig"} ;
		friendly_A			= mkA "vänlig" ;
		personal_A			= mkA "personlig" ;
		warm_A				= mkA "varm" ;
		prompt_A			= mkA "snabb" ;
		attentive_A			= mkA "uppmärksam" "uppmärksamt" "uppmärksamma" "" "" ;
		inefficient_A		= variants {mkA "ineffektiv" ; mkA "inkompetent"} ;
		rude_A				= variants {mkA "oartig" "rått" ; mkA "otrevlig"} ;
		impersonal_A		= variants {mkA "opersonlig" ; mkA "kall"} ;
		slow_A				= mkA "långsam" "långsamt" "långsamma" "" "" ;
		unattentive_A		= mkA "oartig" ;
		good_A				= mkA "god" "gott" "goda" "bättre" "bäst" ;
		great_A				= mkA "fantastisk" ;
		excellent_A			= mkA "utmärkt" "utmärkt" ;
		bad_A				= mkA "dålig" ;
		awful_A				= mkA "hemsk" ;
		horrible_A			= mkA "hemsk" ;
		disgusting_A		= mkA "äcklig" ;
		boring_A			= mkA "tråkig" ;
		diverse_A			= mkA "varierad" "varierat" "varierade" "" "" ;

		noAdv_AdV			= mkAdV "" ;
		strongly_AdV		= mkAdV "absolut" ;
		completely_AdV		= mkAdV (variants {"helt"; "absolut"}) ;
		certainly_AdV		= mkAdV "definitivt" ;
		honestly_AdV		= mkAdV ["helt ärligt"] ;
		really_AdV			= mkAdV (variants {"verkligen"; "sannerligen"}) ;
		reluctantly_AdV		= mkAdV "motvilligt" ;
		hardly_AdV			= mkAdV "knappast" ;

}
