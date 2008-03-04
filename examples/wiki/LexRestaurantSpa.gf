
instance LexRestaurantSpa of LexRestaurant = open SyntaxSpa,GrammarSpa,ParadigmsSpa in {

	flags encoding = utf8 ;

	oper
		restaurant_N		= mkN "restaurante" ;
		food_N				= mkN "comida" ;
		staff_N				= variants {mkN "personal" ; mkN "servicio"} ;
		wine_N				= mkN "vino" ;
		pizza_N				= mkN "pizza" ;
		cheese_N			= mkN "queso" ;
		fish_N				= mkN "pescado" ;
		dish_N				= mkN "platillo" ;
		drink_N				= mkN "bebida" ;
		dessert_N			= mkN "postre" ;

		recommend_V2		= mkV2 (mkV "recomendar" "recomiendo") ;

		chinese_A  			= mkA "chino" ;
		french_A    		= mkA "francés" "francesa" "franceses" "francesas" "francesamente";
		italian_A    		= mkA "italiano" ;
		japanese_A    		= mkA "japonés" ;
		mexican_A    		= mkA "mexicano" ;
		thai_A    			= mkA "tailandés" "tailandesa" "tailandeses" "tailandesas" "tailandesamente";
		expensive_A    		= mkA "caro" ;
		cheap_A    			= mkA "barato" ;
		nice_A				= mkA "agradable" ;
		clean_A				= mkA "limpio" ;
		dirty_A				= mkA "sucio" ;
		fresh_A				= mkA "fresco" ;
		delicious_A			= variants {mkA "delicioso"; mkA "exquisito"; mkA "sabroso"} ;
		fatty_A				= mkA "grasoso" ;
		tasteless_A			= variants {mkA "insípido"; mkA "insulso"} ;
		authentic_A			= mkA "auténtico" ;
		efficient_A			= mkA "eficiente" ;
		courteous_A			= mkA "cortés" ;
		helpful_A			= mkA "servicial" ;
		friendly_A			= mkA "amigable" ;
		personal_A			= mkA "personal" ;
		warm_A				= mkA "cálido" ;
		prompt_A			= mkA "rápido" ;
		attentive_A			= mkA "atento" ;
		inefficient_A		= variants {mkA "ineficiente" ; mkA "incompetente"} ;
		rude_A				= variants {mkA "grosero" ; mkA "descortés"} ;
		impersonal_A		= variants {mkA "impersonal" ; mkA "frío"} ;
		slow_A				= mkA "lento" ;
		unattentive_A		= mkA "desatento" ;
		good_A				= mkA "bueno" ;
		great_A				= mkA "magnífico" ;
		excellent_A			= mkA "excelente" ;
		bad_A				= mkA "malo" ;
		awful_A				= mkA "terrible" ;
		horrible_A			= variants {mkA "horrible" ; mkA "espantoso"} ;
		disgusting_A		= mkA "repugnante" ;
		boring_A			= mkA "aburrido" ;
		diverse_A			= mkA "variado" ;

		noAdv_AdV			= mkAdV "" ;
		strongly_AdV		= mkAdV "enfáticamente" ;
		completely_AdV		= mkAdV (variants {"completamente"; "totalmente"; "definitivamente"; "absolutamente"}) ;
		certainly_AdV		= mkAdV "ciertamente" ;
		honestly_AdV		= mkAdV "honestamente" ;
		really_AdV			= mkAdV (variants {"realmente"; "verdaderamente"}) ;
		reluctantly_AdV		= mkAdV ("a" ++ "regañadientes") ;
		hardly_AdV			= mkAdV "difícilmente" ;

}
