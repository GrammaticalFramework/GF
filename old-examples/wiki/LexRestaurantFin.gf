
instance LexRestaurantFin of LexRestaurant = open SyntaxFin,GrammarFin,ParadigmsFin in {

	oper
		restaurant_N		= mkN "ravintola" ;
		food_N				= mkN "ruoka" ;
		staff_N				= mkN "henkilökunta" ;
		wine_N				= mkN "viini" ;
		pizza_N				= mkN "pizza" ;
		cheese_N			= mkN "juusto" ;
		fish_N				= mkN "kala" ;
		dish_N				= mkN "ruokalaji" ;
		drink_N				= mkN "juoma" ;
		dessert_N			= mkN "jälkiruoka" ;

		recommend_V2		= mkV2 (mkV "suositella") ;

		chinese_A			= mkA "kiinalainen" ;
		french_A			= mkA "ranskalainen" ;
		italian_A			= mkA "italialainen" ;
		japanese_A			= mkA "japanilainen" ;
		mexican_A			= mkA "meksikolainen" ;
		thai_A				= mkA "thaimaalainen" ;
		expensive_A			= mkA "kallis" ;
		cheap_A				= mkA "halpa" ;
		nice_A				= mkA "mukava" ;
		clean_A				= mkA "siisti" ;
		dirty_A				= mkA "likainen" ;
		fresh_A				= mkA "raikas" ;
		delicious_A			= mkA "herkullinen" ;
		fatty_A				= mkA "rasvainen" ;
		tasteless_A			= mkA "mauton";
		authentic_A			= mkA "autenttinen" ;
		efficient_A			= mkA "tehokas" ;
		courteous_A			= mkA "kohtelias" ;
		helpful_A			= mkA "avulias" ;
		friendly_A			= mkA "ystävällinen" ;
		personal_A			= mkA "persoonallinen" ;
		warm_A				= mkA "lämmin" ;
		prompt_A			= mkA "nopea" ;
		attentive_A			= mkA "valpas" ;
		inefficient_A		= mkA "tehoton" ;
		rude_A				= mkA "tyly" ;
		impersonal_A		= mkA "persoonaton" ;
		slow_A				= mkA "hidas" ;
		unattentive_A		= mkA "unelias" ;
		good_A				= mkA "hyvä" ;
		great_A				= mkA "upea" ;
		excellent_A			= mkA "erinomainen" ;
		bad_A				= mkA "huono" ;
		awful_A				= mkA "kamala" ;
		horrible_A			= mkA "kauhea" ;
		disgusting_A		= mkA "vastenmielinen" ;
		boring_A			= mkA "tylsä" ;
		diverse_A			= mkA "erilainen" ;

		noAdv_AdV			= mkAdV "" ;
		strongly_AdV		= mkAdV "vahvasti" ;
		completely_AdV		= mkAdV "täysin";
		certainly_AdV		= mkAdV "varmasti" ;
		honestly_AdV		= mkAdV "vilpittömästi" ;
		really_AdV			= mkAdV "todella" ;
		reluctantly_AdV		= mkAdV "vastahakoisesti" ;
		hardly_AdV			= mkAdV "tuskin" ;

--		but_Conj			= ss "vaan" ** {n = Pl} ;

oper mkAdV : Str -> AdV = \s -> {s = s ; lock_AdV = <>} ;

}
